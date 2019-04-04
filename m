Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9587C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7071A20693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PIubT/Fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbfDDQru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:47:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55856 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbfDDQrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:47:49 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 111471EC023E;
        Thu,  4 Apr 2019 18:47:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554396468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PjBYCqMP0eWRKkIJSc1mZeeQ2gQhfkyYnFXfTSHVnn0=;
        b=PIubT/FjQbh5G50OH4v06NezTggvk7Vzs/F/e+w2CRGO3xjAQjetQwIjbGh65w4CIOPa2h
        c8i/9YkZ3DUAqTQmkBNG19qDLGyiIH/3X7oGvjtUY9Zf8D29Hf2N9dPFiEQW+aPODNQ2i1
        a0k/J2Dqv+F2Pp6Yqrr4BzprnPRKtYE=
Date:   Thu, 4 Apr 2019 18:47:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH] x86/microcode: Refactor Intel microcode loading
Message-ID: <20190404164741.GH22539@zn.tnic>
References: <20190404111128.131157-1-jannh@google.com>
 <20190404162753.GG22539@zn.tnic>
 <CAG48ez1wPdCZE07SeK_=yL3gWRnekLm3+YP3rvyw2YL_3+uNJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez1wPdCZE07SeK_=yL3gWRnekLm3+YP3rvyw2YL_3+uNJw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 06:31:37PM +0200, Jann Horn wrote:
> Uuuh. I *definitely* tested this. I ran this yesterday evening on my
> home machine, on top of commit
> 14c741de93861749dfb60b4964028541f5c506ca from Linus' tree, plus two
> cherry-picked fixes for drm/ttm. I specifically made sure that I had
> the old microcode version before reloading these ways and I had the
> new version after reloading. And the verbose dmesg logs also looked
> okay.

How did you check the microcode revision before and after? /proc/cpuinfo?

Because that old method doesn't say anything in dmesg if there's no
debugging output, only the iucode_tool says something like the below if
you enable verbose output:

# iucode-tool -v --kernel=/dev/cpu/microcode /lib/firmware/intel-ucode/06-3a-09
iucode-tool: processed 1 valid microcode(s), 1 signature(s), 1 unique signature(s)
iucode-tool: selected 1 microcode(s), 1 signature(s)
iucode-tool: Uploading selected microcodes to: /dev/cpu/microcode
iucode-tool: /dev/cpu/microcode: 1 microcode entries uploaded, 13312 bytes

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
