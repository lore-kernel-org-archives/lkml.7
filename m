Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797BFC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4108C20830
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="FihTCBNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfDIUeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:34:24 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51338 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbfDIUeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:34:23 -0400
Received: from zn.tnic (p200300EC2F0F8500250718ACA0948A5F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:8500:2507:18ac:a094:8a5f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9F12E1EC00FF;
        Tue,  9 Apr 2019 22:34:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554842061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9pkiibSoE1UtncS1t4SALzcqhoYEOsusZM3elMz8lWU=;
        b=FihTCBNeWMvliyh2g7ngcgErRE+xcnI7X5F1Yig3UDVessMKky9GE5TwXRxMHd7IenWgru
        78WrokkV1PCoyKgldcCPALeNykPMpMrvtn4K1uuLeozh4zGSnclUMn51onRl4i5WfAYFcL
        Li2RUJCLAaBN3gKjI/rqI+Tsiuc3jck=
Date:   Tue, 9 Apr 2019 22:34:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RESEND 2/5] x86/MCE: Handle MCA controls in a per_cpu way
Message-ID: <20190409203412.GE6150@zn.tnic>
References: <20190408141205.12376-1-Yazen.Ghannam@amd.com>
 <20190408141205.12376-3-Yazen.Ghannam@amd.com>
 <20190408175142.GK15689@zn.tnic>
 <SN6PR12MB26397E000684890C92075985F82C0@SN6PR12MB2639.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SN6PR12MB26397E000684890C92075985F82C0@SN6PR12MB2639.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 06:55:59PM +0000, Ghannam, Yazen wrote:
> We already have the case where some banks are not initialized either
> due to quirks or because they are Read-as-Zero, but we don't try to
> skip creating their files. With this full set (see patch 5), an unused
> bank will return a control value of 0.

So set_bank() is changed to do:

@@ -2088,7 +2097,7 @@ static ssize_t set_bank(struct device *s, struct device_attribute *attr,
        if (kstrtou64(buf, 0, &new) < 0)
                return -EINVAL;

-       if (bank >= mca_cfg.banks)
+       if (bank >= per_cpu(num_banks, s->id))
                return -EINVAL;


How would that work if the disabled/not-present bank is in the middle?
The old example: bank3 on CPU5.

> Would that be sufficient to indicate that a bank is not used?

Well, it should not allow for any control bits to be set and it should
have the proper bank number.

> But I do have a couple of thoughts:

> 1) Will missing banks confuse users? As mentioned, we already have the
> case of unused/uninitialized banks today, but we don't skip their file
> creation. a) Will this affect any userspace tools?

I guess it would be easier if we keep creating all files but denote properly
which banks are disabled.

> 2) Is the added complexity for file creation/destruction worth it? As
> mentioned, the file will return 0 for unused/uninitialized banks.

Yeah.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
