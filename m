Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEF0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75EF20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Zqa+O9Pk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfDDQ2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:28:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52264 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbfDDQ2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:28:02 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A4F61EC023E;
        Thu,  4 Apr 2019 18:27:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554395280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HhK9b3IB55KmRbXwgAvODYhEh8//8TI8o8tVfQ7+k0A=;
        b=Zqa+O9PkddBgn79wKCac9hCQyd+qfk7I4Q8vEe5OZr7DaxcyXqSgM7+5v7bsR3Sz0j7rQe
        gov8SkE35EgpGAhh7DA4wsQ+N3jKQuGhu636SYs+3kaxUh07MsKfLibdhiil50jnFbol5p
        14DkDbU2EZqIttwGwVQnUKKiTCTdlFc=
Date:   Thu, 4 Apr 2019 18:27:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH] x86/microcode: Refactor Intel microcode loading
Message-ID: <20190404162753.GG22539@zn.tnic>
References: <20190404111128.131157-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404111128.131157-1-jannh@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 01:11:28PM +0200, Jann Horn wrote:
> This changes generic_load_microcode() to use the iov_iter API instead of
> an open-coded version. This allows us to avoid explicitly casting between
> user and kernel pointers.
> 
> Because the iov_iter API makes it hard to read the same location twice, as
> a side effect, this also fixes a double-read of the microcode header (which
> could e.g. lead to out-of-bounds reads in microcode_sanity_check()).
> Not that it matters much, only root can do this anyway...
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> I have tested that with this patch applied, microcode loading still works
> both via "iucode-tool -k" and via
> /sys/devices/system/cpu/microcode/reload.

Yeah, this cannot have worked because I think I broke it recently and
you'd need this:

---
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 5260185cbf7b..8a4a7823451a 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -418,8 +418,9 @@ static int do_microcode_update(const void __user *buf, size_t size)
                if (ustate == UCODE_ERROR) {
                        error = -1;
                        break;
-               } else if (ustate == UCODE_OK)
+               } else if (ustate == UCODE_NEW) {
                        apply_microcode_on_target(cpu);
+               }
        }
 
        return error;
---

Regardless, I'll take care of it. Thanks a lot for doing this cleanup,
it looks really cool and nicely clean - exactly how I envisioned it. :-)

I'll test it more later with the above fix and apply it.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
