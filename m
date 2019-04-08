Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1968C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C870421841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="GZLdhslm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfDHRvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:51:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44610 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729307AbfDHRvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:51:51 -0400
Received: from zn.tnic (p200300EC2F07270000CFE9C28C8FA671.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:2700:cf:e9c2:8c8f:a671])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8105E1EC082D;
        Mon,  8 Apr 2019 19:51:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554745909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GBTty3sKkWiOiGKI1Pwh07W4vTuREULqwVTX/qLAFNs=;
        b=GZLdhslmG/EwfVXWSByznKpmj79wjB4Ge/p2lMEBm2OaGQUpGOMgYF5xMuo4RKWD85Cp4B
        6Fh5fI4ux7m4IvGqm0DwUhBvEaV0hV72h3ArLqwUJUkDE+zovhQPaHAq9t6ika/RdLyu1i
        FCAcYoaBeTr73OBnFPR7KoXIVCNAiAE=
Date:   Mon, 8 Apr 2019 19:51:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RESEND 2/5] x86/MCE: Handle MCA controls in a per_cpu way
Message-ID: <20190408175142.GK15689@zn.tnic>
References: <20190408141205.12376-1-Yazen.Ghannam@amd.com>
 <20190408141205.12376-3-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190408141205.12376-3-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 02:12:16PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Current AMD systems have unique MCA banks per logical CPU even though
> the type of the banks may all align to the same bank number. Each CPU
> will have control of a set of MCA banks in the hardware and these are
> not shared with other CPUs.
> 
> For example, bank 0 may be the Load-Store Unit on every logical CPU, but
> each bank 0 is a unique structure in the hardware. In other words, there
> isn't a *single* Load-Store Unit at MCA bank 0 that all logical CPUs
> share.
> 
> This idea extends even to non-core MCA banks. For example, CPU0 and CPU4
> may see a Unified Memory Controller at bank 15, but each CPU is actually
> seeing a unique hardware structure that is not shared with other CPUs.
> 
> Because the MCA banks are all unique hardware structures, it would be
> good to control them in a more granular way. For example, if there is a
> known issue with the Floating Point Unit on CPU5 and a user wishes to
> disable an error type on the Floating Point Unit, then it would be good
> to do this only for CPU5 rather than all CPUs.
> 
> Also, future AMD systems may have heterogeneous MCA banks. Meaning the
> bank numbers may not necessarily represent the same types between CPUs.
> For example, bank 20 visible to CPU0 may be a Unified Memory Controller
> and bank 20 visible to CPU4 may be a Coherent Slave. So granular control
> will be even more necessary should the user wish to control specific MCA
> banks.
> 
> Split the device attributes from struct mce_bank leaving only the MCA
> bank control fields.
> 
> Make struct mce_banks[] per_cpu in order to have more granular control
> over individual MCA banks in the hardware.
> 
> Allocate the device attributes statically based on the maximum number of
> MCA banks supported. The sysfs interface will use as many as needed per
> CPU. Currently, this is set to mca_cfg.banks, but will be changed to a
> per_cpu bank count in a future patch.
> 
> Allocate the MCA control bits dynamically. Use the maximum number of MCA
> banks supported for now. This will be changed to a per_cpu bank count in
> a future patch.
> 
> Redo the sysfs store/show functions to handle the per_cpu mce_banks[].
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 77 ++++++++++++++++++++++------------
>  1 file changed, 51 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 8d0d1e8425db..14583c5c6e12 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -64,16 +64,21 @@ static DEFINE_MUTEX(mce_sysfs_mutex);
>  
>  DEFINE_PER_CPU(unsigned, mce_exception_count);
>  
> +struct mce_bank {
> +	u64	ctl;	/* subevents to enable */
> +	bool	init;	/* initialise bank? */

Keep that vertical alignment as of that of the members if mce_bank_dev
below.

> +};
> +static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank*, mce_banks);

Space between mce_bank and *.

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

What bothers me here is the connection between the mce_bank and the
mce_bank_dev: it is simply not there.

Why isn't there a

	struct mce_bank_dev *dev;

in struct mce_bank?

Because - and correct me if I'm wrong here - but I think if we do
per-CPU banks, then we need to selectively point from each mce_bank to
its corresponding mce_bank_dev descriptor so that you have the proper
names.

For example, if bank3 on CPU5 is not present/disabled/N/A/whatever, then
you need to not initialize the that sysfs file there and have:

/sys/devices/system/machinecheck/machinecheck5/
├── bank0
├── bank1
├── bank10
├── bank11
├── bank12
├── bank13
├── bank14
├── bank15
├── bank16
├── bank17
├── bank18
├── bank19
├── bank2
├── bank20
├── bank21
├── bank22
		<--- bank 3 is not there because unsupported.
├── bank4
├── bank5
├── bank6
├── bank7
├── bank8
├── bank9


Which means that mce_device_create() should learn to be able to create
non-contiguous per-CPU bank sysfs files so that you'll have to iterate
over the per-CPU struct mce_banks array and use only those mce_bank_dev
* pointers which represent present banks on this CPU only.

Yes, no, am I way off?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
