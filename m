Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEB4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93555206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="e06ZkOP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfDPKVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:21:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52196 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbfDPKVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:21:35 -0400
Received: from zn.tnic (p200300EC2F0D6900D0FA583685BBD9D6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6900:d0fa:5836:85bb:d9d6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 10D431EC05B8;
        Tue, 16 Apr 2019 12:21:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555410094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=twtafEGma0Y1kHnv3Dz1XbORQn9UB5SYl9Cz+oclGPk=;
        b=e06ZkOP5D2I5VB3VppNLBFsj2bzfNmd5gBxlmNDX50n4PKwMOQtiq3poFc3izhc+GO7e1g
        1QL7PjWDFGeXGEHoYkCeTiOU8g8wY4roAgj08URrK+WP7plu7H9CQyul7Lf58LszXJVA1Q
        YoUi+5H/TXpJOvSMgraL1JfckXcIM2c=
Date:   Tue, 16 Apr 2019 12:21:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 2/6] x86/MCE: Handle MCA controls in a per_cpu way
Message-ID: <20190416102130.GB31772@zn.tnic>
References: <20190411201743.43195-1-Yazen.Ghannam@amd.com>
 <20190411201743.43195-3-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190411201743.43195-3-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 08:18:01PM +0000, Ghannam, Yazen wrote:
>  arch/x86/kernel/cpu/mce/core.c | 77 ++++++++++++++++++++++------------
>  1 file changed, 51 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 8d0d1e8425db..aa41f41e5931 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -64,16 +64,21 @@ static DEFINE_MUTEX(mce_sysfs_mutex);
>  
>  DEFINE_PER_CPU(unsigned, mce_exception_count);
>  
> +struct mce_bank {
> +	u64	ctl;	/* subevents to enable */
> +	bool	init;	/* initialise bank? */
> +};

Pls keep original members alignment.

> +static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank *, mce_banks);
> +
>  #define ATTR_LEN               16
>  /* One object for each MCE bank, shared by all CPUs */
> -struct mce_bank {
> -	u64			ctl;			/* subevents to enable */
> -	bool			init;			/* initialise bank? */
> +struct mce_bank_dev {
>  	struct device_attribute	attr;			/* device attribute */
>  	char			attrname[ATTR_LEN];	/* attribute name */
> +	u8			bank;			/* bank number */
>  };
> +static struct mce_bank_dev mce_bank_devs[MAX_NR_BANKS];
>  
> -static struct mce_bank *mce_banks __read_mostly;
>  struct mce_vendor_flags mce_flags __read_mostly;
>  
>  struct mca_config mca_cfg __read_mostly = {
> @@ -695,7 +700,7 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
>  		m.tsc = rdtsc();
>  
>  	for (i = 0; i < mca_cfg.banks; i++) {
> -		if (!mce_banks[i].ctl || !test_bit(i, *b))
> +		if (!this_cpu_read(mce_banks)[i].ctl || !test_bit(i, *b))
>  			continue;
>  
>  		m.misc = 0;
> @@ -1138,7 +1143,7 @@ static void __mc_scan_banks(struct mce *m, struct mce *final,
>  		if (!test_bit(i, valid_banks))
>  			continue;
>  
> -		if (!mce_banks[i].ctl)
> +		if (!this_cpu_read(mce_banks)[i].ctl)
>  			continue;
>  
>  		m->misc = 0;
> @@ -1475,16 +1480,19 @@ static int __mcheck_cpu_mce_banks_init(void)
>  {
>  	int i;
>  
> -	mce_banks = kcalloc(MAX_NR_BANKS, sizeof(struct mce_bank), GFP_KERNEL);
> -	if (!mce_banks)
> +	per_cpu(mce_banks, smp_processor_id()) =
> +		kcalloc(MAX_NR_BANKS, sizeof(struct mce_bank), GFP_KERNEL);
> +
> +	if (!this_cpu_read(mce_banks))
>  		return -ENOMEM;
>  
>  	for (i = 0; i < MAX_NR_BANKS; i++) {
> -		struct mce_bank *b = &mce_banks[i];
> +		struct mce_bank *b = &this_cpu_read(mce_banks)[i];
>  
>  		b->ctl = -1ULL;
>  		b->init = 1;
>  	}
> +
>  	return 0;
>  }

Instead of doing all those per-CPU accesses in the function, you can use
a local pointer and assign it once in the end, before returning.

Also, fix the similar situation where you have multiple per-CPU accesses
in a single function - assign to a local pointer instead and do all the
accesses through it.

> @@ -1504,7 +1512,7 @@ static int __mcheck_cpu_cap_init(void)
>  
>  	mca_cfg.banks = max(mca_cfg.banks, b);
>  
> -	if (!mce_banks) {
> +	if (!this_cpu_read(mce_banks)) {
>  		int err = __mcheck_cpu_mce_banks_init();
>  		if (err)
>  			return err;
> @@ -1547,7 +1555,7 @@ static void __mcheck_cpu_init_clear_banks(void)
>  	int i;
>  
>  	for (i = 0; i < mca_cfg.banks; i++) {
> -		struct mce_bank *b = &mce_banks[i];
> +		struct mce_bank *b = &this_cpu_read(mce_banks)[i];
>  
>  		if (!b->init)
>  			continue;
> @@ -1602,7 +1610,7 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
>  			 * trips off incorrectly with the IOMMU & 3ware
>  			 * & Cerberus:
>  			 */
> -			clear_bit(10, (unsigned long *)&mce_banks[4].ctl);
> +			clear_bit(10, (unsigned long *)&this_cpu_read(mce_banks)[4].ctl);
>  		}
>  		if (c->x86 < 0x11 && cfg->bootlog < 0) {
>  			/*
> @@ -1616,7 +1624,7 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
>  		 * by default.
>  		 */
>  		if (c->x86 == 6 && cfg->banks > 0)
> -			mce_banks[0].ctl = 0;
> +			this_cpu_read(mce_banks)[0].ctl = 0;
>  
>  		/*
>  		 * overflow_recov is supported for F15h Models 00h-0fh
> @@ -1638,7 +1646,7 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
>  		 */
>  
>  		if (c->x86 == 6 && c->x86_model < 0x1A && cfg->banks > 0)
> -			mce_banks[0].init = 0;
> +			this_cpu_read(mce_banks)[0].init = 0;
>  
>  		/*
>  		 * All newer Intel systems support MCE broadcasting. Enable
> @@ -1952,7 +1960,7 @@ static void mce_disable_error_reporting(void)
>  	int i;
>  
>  	for (i = 0; i < mca_cfg.banks; i++) {
> -		struct mce_bank *b = &mce_banks[i];
> +		struct mce_bank *b = &this_cpu_read(mce_banks)[i];
>  
>  		if (b->init)
>  			wrmsrl(msr_ops.ctl(i), 0);
> @@ -2051,26 +2059,41 @@ static struct bus_type mce_subsys = {
>  
>  DEFINE_PER_CPU(struct device *, mce_device);
>  
> -static inline struct mce_bank *attr_to_bank(struct device_attribute *attr)
> +static inline struct mce_bank_dev *attr_to_bank(struct device_attribute *attr)
>  {
> -	return container_of(attr, struct mce_bank, attr);
> +	return container_of(attr, struct mce_bank_dev, attr);
>  }
>  
>  static ssize_t show_bank(struct device *s, struct device_attribute *attr,
>  			 char *buf)
>  {
> -	return sprintf(buf, "%llx\n", attr_to_bank(attr)->ctl);
> +	struct mce_bank *b;
> +	u8 bank = attr_to_bank(attr)->bank;

Please sort function local variables declaration in a reverse christmas
tree order:

	<type A> longest_variable_name;
	<type B> shorter_var_name;
	<type C> even_shorter;
	<type D> i;

> +
> +	if (bank >= mca_cfg.banks)
> +		return -EINVAL;
> +
> +	b = &per_cpu(mce_banks, s->id)[bank];
> +
> +	return sprintf(buf, "%llx\n", b->ctl);
>  }
>  
>  static ssize_t set_bank(struct device *s, struct device_attribute *attr,
>  			const char *buf, size_t size)
>  {
>  	u64 new;
> +	struct mce_bank *b;
> +	u8 bank = attr_to_bank(attr)->bank;

Ditto.

>  	if (kstrtou64(buf, 0, &new) < 0)
>  		return -EINVAL;
>  
> -	attr_to_bank(attr)->ctl = new;
> +	if (bank >= mca_cfg.banks)
> +		return -EINVAL;
> +
> +	b = &per_cpu(mce_banks, s->id)[bank];
> +
> +	b->ctl = new;
>  	mce_restart();
>  
>  	return size;
> @@ -2185,7 +2208,7 @@ static void mce_device_release(struct device *dev)
>  	kfree(dev);
>  }
>  
> -/* Per cpu device init. All of the cpus still share the same ctrl bank: */
> +/* Per cpu device init. All of the cpus still share the same bank device: */

s/cpu/CPU/g, while at it.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
