Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF02CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2418206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TzcCpgXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfCKSVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:21:08 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60134 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbfCKSVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:21:07 -0400
Received: from zn.tnic (unknown [IPv6:2003:ec:2f05:7900:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 789951EC02C1;
        Mon, 11 Mar 2019 19:21:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1552328465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nCyB05BEd3n9iI5SpjYNfRRDJmSVJsrRZdq9jkEBK1M=;
        b=TzcCpgXgp/zAGj0b7kVJYJlLz7fmp7LoYn3UU8h+I2IMubevZ9LRhUD07CcMPN7gibTiPj
        wCyYQkMfIVxlA+EH81UO/NGSkKgO9WEXUGggLUb9W43QmacnJYjItqkXMfmK+/h05gLtif
        ZcMB+klccD4VCDG/I9EhB61TfvH/Huw=
Date:   Mon, 11 Mar 2019 19:21:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafal@milecki.pl" <rafal@milecki.pl>,
        "clemej@gmail.com" <clemej@gmail.com>
Subject: Re: [PATCH 2/2] x86/MCE/AMD, EDAC/mce_amd: Don't report L1 BTB MCA
 errors on some Family 17h models
Message-ID: <20190311182104.GD7384@zn.tnic>
References: <20190307212552.8865-1-Yazen.Ghannam@amd.com>
 <20190307212552.8865-2-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190307212552.8865-2-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 09:26:04PM +0000, Ghannam, Yazen wrote:
> +static bool smca_filter_mce(struct mce *m)
> +{
> +	enum smca_bank_types bank_type = smca_get_bank_type(m->bank);
> +	struct cpuinfo_x86 *c = &boot_cpu_data;
> +	u8 xec = XEC(m->status, xec_mask);
> +
> +	/*
> +	 * Spurious errors of this type may be reported.
> +	 * See Family 17h Models 10h-2Fh Erratum #1114.
> +	 */
> +	if (c->x86 == 0x17 &&
> +	    (c->x86_model >= 0x10 && c->x86_model <= 0x2F) &&
> +	    bank_type == SMCA_IF && xec == 10)
> +		return true;

This is happening too late and we need it much earlier, from Rafal's dmesg:

[    1.070855] mce: [Hardware Error]: Machine check events logged
[    1.070860] mce: [Hardware Error]: CPU 2: Machine Check: 0 Bank 1: d8200000000a0151
[    1.070863] mce: [Hardware Error]: TSC 73fa0765c MISC d01b0fff00000000 SYND 4a000000 IPID 100b000000000
[    1.071065] mce: [Hardware Error]: PROCESSOR 2:810f10 TIME 1543481411 SOCKET 0 APIC 2 microcode 810100b

that's __print_mce() from the notifier.

So we'd need a filter function which is called in do_machine_check() and
machine_check_poll() right after we've collected enough info to be able
to filter out the MCE based on the signature. In this case the extended
error core and SMCA bank type suffices but we should put those functions
late enough so that they can be used for other filtering later.

Alternatively, if this error type has a special bit in the mask registers so
that you can disable it there ala

        if (c->x86_vendor == X86_VENDOR_AMD) {
                if (c->x86 == 15 && cfg->banks > 4) {
                        /*
                         * disable GART TBL walk error reporting, which
                         * trips off incorrectly with the IOMMU & 3ware
                         * & Cerberus:
                         */
                        clear_bit(10, (unsigned long *)&mce_banks[4].ctl);


that would be even better but I'd guess it doesn't have a special bit...

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
