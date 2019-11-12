Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732BEC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0432084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="UmGJ6da/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKLRt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:49:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50080 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbfKLRt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:49:59 -0500
Received: from zn.tnic (p200300EC2F0F7D008198F3F0B2113C87.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:7d00:8198:f3f0:b211:3c87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B392C1EC0CB2;
        Tue, 12 Nov 2019 18:49:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573580997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QwqQupYicDqj+KSPQHWw8AJsSBWO0Y8rmiBeQ2YH9aA=;
        b=UmGJ6da/MYJxh2iw+4JiYwXEFfnnUt/18F7b01YzPvJ0QIEX9QMkweNg5Qp/IjOS7eHW8I
        8jPI496s4rzYCra8zu3OuR8MV4EBJkewQi0e09HYCE+ap2HQYVWf7Ug4tAIy0EAKjmFHQz
        3/X7OlaZzVEG5XXEZLUbeMjT/Zc/7lc=
Date:   Tue, 12 Nov 2019 18:49:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>, zhangxiaoxu@huawei.com,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        tyhicks@canonical.com, colin.king@canonical.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] x86/mtrr: only administrator can read the configurations.
Message-ID: <20191112174956.GB32336@zn.tnic>
References: <20191105071714.27376-1-zhangxiaoxu5@huawei.com>
 <201911081236.57A127A@keescook>
 <20191108205031.GH4503@zn.tnic>
 <201911081320.5D3CD1A4CD@keescook>
 <20191108213307.GI4503@zn.tnic>
 <201911110934.AC5BA313@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201911110934.AC5BA313@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 09:56:16AM -0800, Kees Cook wrote:
> Some recap from being accidentally offlist:
> 
> - this patch should check capabilities at open time (or retain the
>   checks on the opener's permissions for later checks).
> 
> - changing the DAC permissions might break something that expects to
>   read mtrr when not uid 0.
> 
> - if we leave the DAC permissions alone and just move the capable check
>   to the opener, we should get the intent of the original patch. (i.e.
>   check against CAP_SYS_ADMIN not just the wider uid 0.)
> 
> - *this may still break things* if userspace expects to be able to
>   read other parts of the file as non-uid-0 and non-CAP_SYS_ADMIN.
>   If *that* is the case, then we need to censor the contents using
>   the opener's permissions (as done in other /proc cases).
> 
> I think the most cautious way forward is something like
> 51d7b120418e ("/proc/iomem: only expose physical resource addresses to
> privileged users"). Untested (and should likely be expanded to know
> about read vs write for lockdown interaction):

I'm back'n'forth on this.

So tglx and I agree that it doesn't make a whole lotta sense for
non-privileged luserspace to be able to read /proc/mtrr because it is a
small leak and normal users shouldn't care about the caching attributes
of memory regions in the first place.

So maybe we should do the second variant.

But then we're not supposed to break luserspace.

But then we can revert it if we do...

Ugh.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
