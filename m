Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EAFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D6F2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 17:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Yx/D6BVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbfDJRZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:25:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41230 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbfDJRZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 13:25:47 -0400
Received: from zn.tnic (p200300EC2F0CAE00295B1FE58D6681B0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:ae00:295b:1fe5:8d66:81b0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 588461EC0104;
        Wed, 10 Apr 2019 19:25:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554917145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XcAeVmm3JHcWiuNHD4dSqbLHlPuiBy3ozgXMYTg4/oM=;
        b=Yx/D6BVnXY/KZiFicss72wboe1le6SCIZjYeeJZGLqzdvq0/STVREFCpbCG3SLM6SfZrIT
        76N3kNkmsAB7At6D0edukNGmZ8QM4HsEIlEcDxRrpsyh2vzk9+FpR5jc+vBR4rhcA2dhQP
        MrQZgP6mGNWiSHZCnDKzHrjglA6cRjc=
Date:   Wed, 10 Apr 2019 19:25:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RESEND 2/5] x86/MCE: Handle MCA controls in a per_cpu way
Message-ID: <20190410172539.GF26580@zn.tnic>
References: <20190408141205.12376-1-Yazen.Ghannam@amd.com>
 <20190408141205.12376-3-Yazen.Ghannam@amd.com>
 <20190408175142.GK15689@zn.tnic>
 <SN6PR12MB26397E000684890C92075985F82C0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190409203412.GE6150@zn.tnic>
 <SN6PR12MB2639C9B48E46DA6A8BA9DB3DF82E0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190410164036.GC26580@zn.tnic>
 <SN6PR12MB2639F37C634BC7F6D4B86194F82E0@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB2639F37C634BC7F6D4B86194F82E0@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 04:58:12PM +0000, Ghannam, Yazen wrote:
> Yes, unused banks in the middle are counted in the MCG_CAP[Count] value.

Good.

> Okay, so you're saying the sysfs access should fail if a bank is
> disabled. Is that correct?

Well, think about it. If a bank is not operational for whatever reason,
we should tell the user that.

> Does "disabled" mean one or both of these?
> Unused = RAZ/WI in hardware
> Uninitialized = Not initialized by kernel due to quirks, etc.
> 
> For an unused bank, it doesn't hurt to write MCA_CTL, but really
> there's no reason to do so and go through mce_restart().

Yes, but that bank is non-operational in some form. So we should prevent
all writes to it because, well, it is not going to do anything. And this
would be a good way to give feedback to the user that that is the case.

> For an uninitialized bank, should we prevent users from overriding the
> kernel's settings?

That all depends on the quirks. Whether we should allow them to be
overridden or not. I don't think we've ever thought about it, though.

Let's look at one:

        if (c->x86_vendor == X86_VENDOR_AMD) {
                if (c->x86 == 15 && cfg->banks > 4) {
                        /*
                         * disable GART TBL walk error reporting, which
                         * trips off incorrectly with the IOMMU & 3ware
                         * & Cerberus:
                         */
                        clear_bit(10, (unsigned long *)&mce_banks[4].ctl);


Yah, so if the user reenables those GART errors, then she/he will see a
lot of MCEs reported and will maybe complain about it. And then we'll
say, but why did you enable them then. And she/he'll say: uh, didn't
know. Or, I was just poking at sysfs and this happened.

Then we can say, well, don't do that then! :-)

So my current position is, meh, who cares. But then I'm looking at
another quirk:

        if (c->x86_vendor == X86_VENDOR_INTEL) {
                /*
                 * SDM documents that on family 6 bank 0 should not be written
                 * because it aliases to another special BIOS controlled
                 * register.
                 * But it's not aliased anymore on model 0x1a+
                 * Don't ignore bank 0 completely because there could be a
                 * valid event later, merely don't write CTL0.
                 */

                if (c->x86 == 6 && c->x86_model < 0x1A && cfg->banks > 0)
                        mce_banks[0].init = 0;


which basically prevents that bank from being reinitialized. So I guess
we have that functionality already - we simply need to pay attention to
w->init.

Right?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
