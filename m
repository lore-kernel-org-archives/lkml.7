Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FD1C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3222184E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 17:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYI6ER/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404222AbfHHRJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 13:09:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35170 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404096AbfHHRJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 13:09:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so3161170wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 10:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/RMqWJBZb+n91pADuicj3MI1Qevek2uTYFVfpzwwQYk=;
        b=mYI6ER/mImkFZNM1JZSRimjLCk1m9yKBp7MFo6R2vJElLd5RBgIbnfTTSaK0TgOWZk
         tgYU7T9y1cN2gH4spkcu8BdHVctmfrSUxPSubs2ouVJxh4yhBzYVE4QuOQRIz4f2RS/x
         OMLLuqDfuBtGtn6fzFkUBpxoJ5om4DHo2yaE+CzEuqgzkx19P05vWedXWUjM9zVXi6u0
         vTXFzlWiNpXP3UlRpIhE0a04ZajxbhGe14aCZV1VytgG2virlQL6fijO1C87nQiSDZ9H
         uNa3v/9DnsRi6yTQazWZxdTH90mjFg16NX4Vj3AhkCc08BjYwgsTRVgbyj7OXNZ85+ro
         fGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/RMqWJBZb+n91pADuicj3MI1Qevek2uTYFVfpzwwQYk=;
        b=dLUB0K9OIS54Y6dduC27dWx0iTftF6L41vlCe98angblx+jWNEIxz6XMmYxoSviw8Z
         ScflcCFRou3Vf3qsfgdJbDVMgSyMq7A4Nc702zPrO78LjUAibkqHouMCH+Lv7+v41sm7
         VDPVY9W6xBQi+5qdarJyQccAPOvV7JZsz9j+PLZEOY6sMgp85oaqE6DN7invTMYci4hR
         1TGVpPi5UGfrmxE1WcR9dQvetDPADsE5N4jc+UIuVyr3h34KlgimpmTSKAio96GMMqUw
         ztfe2bxCrHNim8x8wl/6s73Rpn6zYxU+PabXWzBbuXEDbTyIzrCHEUWYDGvDP/JQ9tVb
         Mxgg==
X-Gm-Message-State: APjAAAUqCCVTgz9D0oT3W65CPtHSB/mg1HwQMyafMJffxXHZ5kJQbCOv
        zsvFOHQ2eIEFU6q4+ezIkKJEW/EiSoJVNg==
X-Google-Smtp-Source: APXvYqzdP10PSpvSmqXcoaKhRQopyLLo13J5gwU1q/kfwSjlDon48+ds0qZsJzoRdvE4pJ2fwoicBA==
X-Received: by 2002:a1c:f116:: with SMTP id p22mr5413792wmh.70.1565284159335;
        Thu, 08 Aug 2019 10:09:19 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id c15sm22423803wrb.80.2019.08.08.10.09.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 10:09:18 -0700 (PDT)
Date:   Thu, 8 Aug 2019 10:09:16 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Qian Cai <cai@lca.pw>, will@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/cache: silence -Woverride-init warnings
Message-ID: <20190808170916.GA32668@archlinux-threadripper>
References: <20190808032916.879-1-cai@lca.pw>
 <20190808103808.GC46901@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808103808.GC46901@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 11:38:08AM +0100, Mark Rutland wrote:
> On Wed, Aug 07, 2019 at 11:29:16PM -0400, Qian Cai wrote:
> > The commit 155433cb365e ("arm64: cache: Remove support for ASID-tagged
> > VIVT I-caches") introduced some compiation warnings from GCC (and
> > Clang) with -Winitializer-overrides),
> > 
> > arch/arm64/kernel/cpuinfo.c:38:26: warning: initialized field
> > overwritten [-Woverride-init]
> > [ICACHE_POLICY_VIPT]  = "VIPT",
> >                         ^~~~~~
> > arch/arm64/kernel/cpuinfo.c:38:26: note: (near initialization for
> > 'icache_policy_str[2]')
> > arch/arm64/kernel/cpuinfo.c:39:26: warning: initialized field
> > overwritten [-Woverride-init]
> > [ICACHE_POLICY_PIPT]  = "PIPT",
> >                         ^~~~~~
> > arch/arm64/kernel/cpuinfo.c:39:26: note: (near initialization for
> > 'icache_policy_str[3]')
> > arch/arm64/kernel/cpuinfo.c:40:27: warning: initialized field
> > overwritten [-Woverride-init]
> > [ICACHE_POLICY_VPIPT]  = "VPIPT",
> >                          ^~~~~~~
> > arch/arm64/kernel/cpuinfo.c:40:27: note: (near initialization for
> > 'icache_policy_str[0]')
> > 
> > because it initializes icache_policy_str[0 ... 3] twice. Since
> > arm64 developers are keen to keep the style of initializing a static
> > array with a non-zero pattern first, just disable those warnings for
> > both GCC and Clang of this file.
> > 
> > Fixes: 155433cb365e ("arm64: cache: Remove support for ASID-tagged VIVT I-caches")
> > Signed-off-by: Qian Cai <cai@lca.pw>
> 
> This is _not_ a fix, and should not require backporting to stable trees.
> 
> What about all the other instances that we have in mainline?
> 
> I really don't think that we need to go down this road; we're just going
> to end up adding this to every file that happens to include a header
> using this scheme...
> 
> Please just turn this off by default for clang.
> 
> If we want to enable this, we need a mechanism to permit overridable
> assignments as we use range initializers for.
> 
> Thanks,
> Mark.
> 

For what it's worth, this is disabled by default for clang in the
kernel:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/Makefile.extrawarn?h=v5.3-rc3#n69

It only becomes visible with clang at W=1 because that section doesn't
get applied. It becomes visible with GCC at W=1 because of -Wextra.

Cheers,
Nathan
