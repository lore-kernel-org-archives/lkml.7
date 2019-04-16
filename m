Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8BCC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE67521B26
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="H5qrsVbO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfDPNzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:55:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56458 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbfDPNzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:55:14 -0400
Received: from zn.tnic (p200300EC2F0D690030B3A6530520175E.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6900:30b3:a653:520:175e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC4101EC014A;
        Tue, 16 Apr 2019 15:55:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555422912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=weQ1um983B4tDqVgPttRiVEupzuuaq5L/v9Mw9TnCIA=;
        b=H5qrsVbOlygyI8wNeR/EC4Ys5dXaO4SkG192cRNYrrUsQIwBuYRKByMOy1+uM5rDLfkmMW
        5iz/nGHZNr4aB3XiB4GVasq3ROa0Su1+WniA2jpcS3S7IezKzbsndlZvqUQdDMUQRpyh/6
        589LvEhkAqoBcd+JCtGirzojLuiRgL4=
Date:   Tue, 16 Apr 2019 15:55:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 4/6] x86/MCE: Make number of MCA banks per_cpu
Message-ID: <20190416135508.GG31772@zn.tnic>
References: <20190411201743.43195-1-Yazen.Ghannam@amd.com>
 <20190411201743.43195-5-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190411201743.43195-5-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 08:18:03PM +0000, Ghannam, Yazen wrote:
> @@ -1478,15 +1480,16 @@ EXPORT_SYMBOL_GPL(mce_notify_irq);
>  
>  static int __mcheck_cpu_mce_banks_init(void)
>  {
> +	u8 n_banks = this_cpu_read(mce_num_banks);
>  	int i;
>  
>  	per_cpu(mce_banks, smp_processor_id()) =
> -		kcalloc(MAX_NR_BANKS, sizeof(struct mce_bank), GFP_KERNEL);
> +		kcalloc(n_banks, sizeof(struct mce_bank), GFP_KERNEL);
>  
>  	if (!this_cpu_read(mce_banks))
>  		return -ENOMEM;
>  
> -	for (i = 0; i < MAX_NR_BANKS; i++) {
> +	for (i = 0; i < n_banks; i++) {
>  		struct mce_bank *b = &this_cpu_read(mce_banks)[i];
>  
>  		b->ctl = -1ULL;
> @@ -1507,10 +1510,15 @@ static int __mcheck_cpu_cap_init(void)
>  	rdmsrl(MSR_IA32_MCG_CAP, cap);
>  
>  	b = cap & MCG_BANKCNT_MASK;
> -	if (WARN_ON_ONCE(b > MAX_NR_BANKS))
> +	pr_debug("CPU%d supports %d MCE banks\n", smp_processor_id(), b);

What for?

You're removing the "Using" message because, yeah, it was worthless to
people. If anyone wants to count the banks:

$ ls /sys/devices/system/machinecheck/machinecheck0/bank* | wc -l
23

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
