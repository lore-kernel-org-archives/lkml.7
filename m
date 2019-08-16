Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE1DC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FA02171F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="V1pG1doA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfHPGim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 02:38:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52106 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbfHPGik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:38:40 -0400
Received: from zn.tnic (p200300EC2F0A920041519BC41B2ACCA3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:9200:4151:9bc4:1b2a:cca3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C8E51EC0A91;
        Fri, 16 Aug 2019 08:38:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565937519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5Vqiu9wtaNx8kVRzHPBxlLz2F2d6oTzKG7AVaoCM5PU=;
        b=V1pG1doAqPi4XoqA2IBe8N40J5t74wL8WVTo6puCBmWddUU3k/Khf7QOat3LZ6FoCArSVX
        RUEzU4Ng1uH9iV7KWOckv85k2fnd8FJc5j+6mp5X1Va7mnWKkO3aa/DvZ6ylTFfWODEDq/
        J4RhIRXf3QR4LrTQAkdTqeyVY2LF2gU=
Date:   Fri, 16 Aug 2019 08:39:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhao Yakui <yakui.zhao@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [RFC PATCH 00/15] acrn: add the ACRN driver module
Message-ID: <20190816063925.GB18980@zn.tnic>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 10:25:41AM +0800, Zhao Yakui wrote:
> The first three patches are the changes under x86/acrn, which adds the
> required APIs for the driver and reports the X2APIC caps. 
> The remaining patches add the ACRN driver module, which accepts the ioctl
> from user-space and then communicate with the low-level ACRN hypervisor
> by using hypercall.

I have a problem with that: you're adding interfaces to arch/x86/ and
its users go into staging. Why? Why not directly put the driver where
it belongs, clean it up properly and submit it like everything else is
submitted?

I don't want to have stuff in arch/x86/ which is used solely by code in
staging and the latter is lingering there indefinitely because no one is
cleaning it up...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
