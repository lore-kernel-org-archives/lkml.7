Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B67EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC70820674
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="gfRui7sC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbfH0Ty5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:54:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43082 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbfH0Ty5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:54:57 -0400
Received: from zn.tnic (p200300EC2F0CD00054E9B179BF3AF377.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:d000:54e9:b179:bf3a:f377])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 48BA51EC0C50;
        Tue, 27 Aug 2019 21:54:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566935696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AvgPkyYE9dIG4yEdjhJf3EOgp9ARV7huDlcbngwRfvA=;
        b=gfRui7sC0y3LTSHJ6PedLtrZy4DTvufZrPXSlOiiXeGEzDgteTJI4GhEfL1GUyHvwbZSZh
        7rwMoemF7UV4vHloiOGW96VIpOVFKEOQggDpiSamF9RY3zGFvWoGyMf+/rRurVCS8t8lQw
        bAtVHRMfBDBi/2GtPGRRY4EmsOAoiZk=
Date:   Tue, 27 Aug 2019 21:54:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        dri-devel@lists.freedesktop.org, Doug Covelli <dcovelli@vmware.com>
Subject: Re: [PATCH v2 2/4] x86/vmware: Add a header file for hypercall
 definitions
Message-ID: <20190827195456.GK29752@zn.tnic>
References: <20190823081316.28478-1-thomas_os@shipmail.org>
 <20190823081316.28478-3-thomas_os@shipmail.org>
 <20190827154422.GG29752@zn.tnic>
 <b82e190e-6887-b95a-a99a-176f22c57b7b@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b82e190e-6887-b95a-a99a-176f22c57b7b@shipmail.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 09:19:03PM +0200, Thomas Hellström (VMware) wrote:
> It should be correct. The flags VMWARE_HYPERVISOR_HB and
> VMWARE_HYPERVISOR_OUT are only valid for the vmcall / vmmcall versions.
> 
> For the legacy version, the direction is toggled by the instruction (in vs
> out) and LB vs HB is toggled by the port number (0x5658 vs 0x5659)
> 
> So in essence the low word definition of %edx is different in the two
> versions. I've chosen to use the new vmcall/vmmcall definition in the driver
> code.

Ah, ok, I see what you mean. The old method would overwrite the low word
of %edx but the new one would have the flags already prepared and *not*
overwrite them so all good.

Can you please document that more explicitly in the comment in
arch/x86/include/asm/vmware.h? Something like:

"... The new vmcall interface instead uses a set of flags to select
bandwidth mode and transfer direction. The set of flags is already
loaded into %edx by the macros which use VMWARE_HYPERCALL* and only when
the guest must use the old VMWARE_HYPERVISOR_PORT* method, the low word
is overwritten by the respective port number."

Anyway, something along those lines. We want to have the alternatives
code as clear and as transparent as possible because, well, of obvious
reasons. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
