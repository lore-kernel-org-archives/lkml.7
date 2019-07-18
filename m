Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7850C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 20:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DCBD2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 20:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ2BA8p9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391447AbfGRU6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 16:58:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33335 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391300AbfGRU6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 16:58:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so30182451wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 13:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=waDGPuDc495cuYIwt7OLPbv+oH9HHc/900o6DR9ADGY=;
        b=TZ2BA8p9dp6ahrYZDIOihfG1N6/7zw845Wz1wZK0kIcMxF9/3zdVlU2aoopsdL2Czu
         zLx22pA0wAVvJ8YZ89/RByKxkLEZtWD8URKmh/vlV2o+b+W0vIeN8zQSNpACDPRz1zQ1
         vnCFCTTaFe+FRovCuZgM4PSj/urmHuSGCmDVkM8Tf4WVy/LKO8nMf9Uh5hJu1vNtfadx
         uEYV5GdnaAAofJZgdCMQSS/l9P0HDkJuiOleTxxpOVid8rorsGHHIIdtJKLrVt01kS64
         5iDrJyICmnEmdKjA3xyCVK1UIPTPJakM4Xh2nNaWsY0pD9K/ATe6LsJEEddUhqzJt7yA
         7SPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=waDGPuDc495cuYIwt7OLPbv+oH9HHc/900o6DR9ADGY=;
        b=KquDdURiItAHwaVihNMgZjMrqzWXT2HyDMPWEcBtyX3Gdd+OOIhUZD5CRNxViaIghr
         X9O+T3xYamjYsexRFwkoEk+wvC2TrLvnDKG0nY87IktYrl7vqHhGUhvLogIY/Jk/xSeB
         pew1IFMgZEhpVHeEQtKrWPncXvHPDhb5wE9NwAL1ksNwTnTsy7yDu4KiePGjPc7CxmZ4
         iIC3rtp4VlL4V0+gPaGf2xX29O8db+NWlZiSYx0Mi2+dujGYKZ96c7NOLm01HgeyNLBO
         wgPIvR6NJjQfweR+aen4XzAI3B0GvBllHlpdBm4Rndd7KoPvwAnT+UpkreYFkmUa9x0P
         SR+w==
X-Gm-Message-State: APjAAAW8EvDWJfwenlHCocfJ7ARB5IKBmwoZEZcFtu+A4HC0Y77Pf2I3
        BO04n2hL7TXoJRlxbxYSodo=
X-Google-Smtp-Source: APXvYqxx2qfdCdcPSE3UkC56s/GUwQ0Wkjkc+n/MFdmuSLDReFUSCcQi+t3jOuQJPHEqYB131EISFQ==
X-Received: by 2002:adf:91c2:: with SMTP id 60mr53973996wri.334.1563483521991;
        Thu, 18 Jul 2019 13:58:41 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id r14sm26376842wrx.57.2019.07.18.13.58.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 13:58:41 -0700 (PDT)
Date:   Thu, 18 Jul 2019 13:58:39 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Subject: Re: x86 - clang / objtool status
Message-ID: <20190718205839.GA40219@archlinux-threadripper>
References: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

I can't comment on the objtool stuff as it is a bit outside of my area
of expertise (probably going to be my next major learning project) but I
can comment on the other errors.

On Thu, Jul 18, 2019 at 10:40:09PM +0200, Thomas Gleixner wrote:
>  Build fails with:
> 
>   clang-10: error: unknown argument: '-mpreferred-stack-boundary=4'
>   make[5]: *** [linux/scripts/Makefile.build:279: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.o] Error 1

Arnd sent a patch for this which has been picked up:
https://lore.kernel.org/lkml/CADnq5_Mm=Fj4AkFtuo+W_295q8r6DY3Sumo7gTG-McUYY=CeVg@mail.gmail.com/

> 3) allmodconfig:
>  Build fails with:
> 
>   ERROR: "__compiletime_assert_2801" [drivers/net/wireless/intel/iwlwifi/iwlwifi.ko] undefined!
>   ERROR: "__compiletime_assert_2446" [drivers/net/wireless/intel/iwlwifi/iwlwifi.ko] undefined!
>   ERROR: "__compiletime_assert_2452" [drivers/net/wireless/intel/iwlwifi/iwlwifi.ko] undefined!
>   ERROR: "__compiletime_assert_2790" [drivers/net/wireless/intel/iwlwifi/iwlwifi.ko] undefined!

Being tracked here:
https://github.com/ClangBuiltLinux/linux/issues/580

It is a clang bug but has a kernel side fix. Nick sent one but it sounds
like Intel has another one pending:

https://lore.kernel.org/lkml/20190712001708.170259-1-ndesaulniers@google.com/

https://lore.kernel.org/lkml/da053a97d771eff0ad8db37e644108ed2fad25a3.camel@coelho.fi/

>  This also emits a boatload of warnings like this:
> 
>   linux/fs/nfs/dir.c:451:34: warning: variable 'wq' is uninitialized when used within its own initialization
>       [-Wuninitialized]
>         DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
>                                         ^~
>   linux/include/linux/wait.h:74:63: note: expanded from macro 'DECLARE_WAIT_QUEUE_HEAD_ONSTACK'
>         struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
>                                ~~~~                                  ^~~~
>   linux/include/linux/wait.h:72:33: note: expanded from macro '__WAIT_QUEUE_HEAD_INIT_ONSTACK'
>         ({ init_waitqueue_head(&name); name; })

Being tracked here:
https://github.com/ClangBuiltLinux/linux/issues/499

Has a kernel workaround patch posted but it should be fixed in clang:

https://lore.kernel.org/lkml/20190703081119.209976-1-arnd@arndb.de/

https://bugs.llvm.org/show_bug.cgi?id=42604

Thanks for continuing to test it and keeping us posted on the issues!
Nathan
