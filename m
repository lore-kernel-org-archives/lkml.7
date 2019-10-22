Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9669CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 05:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971E32184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 05:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab/j3x+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbfJVFPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 01:15:33 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45109 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfJVFPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 01:15:33 -0400
Received: by mail-oi1-f196.google.com with SMTP id o205so13080115oib.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 22:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6rY2Wjoe2GHPPcQrTvZ8onLLc/wPWzZXs6sWpQV54Tw=;
        b=ab/j3x+fg+cZiHLu3xqUGr4m5ASYRpmL96jgg7Cxv17KIdEo23ZnGKI5FtlQqPRQpZ
         OzRSyHfgpgCJjKr6yv/lGLqF5i0LyAgJCLvb9jCXPQAfYjSVM4iu7chEOKWAPUlS+oa1
         SI0W467DTaXUKR40SCcbPTUrSW4GsVpShEF9XHpChvQ03IpaHhOJa5xatrikIN0+doI1
         tX0p6uKLXKC15E8nD7CDyXuAFbupnjUyOLSmIdSp1QBOzrSTtEywmaZassw5HbgupmO1
         1XpvcQVWVhBGlsmtc3CGAF/TsmB51iR3XvgG1K6xcmp5KoceyMuAIqSfNaRPTBosJ5hF
         zXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6rY2Wjoe2GHPPcQrTvZ8onLLc/wPWzZXs6sWpQV54Tw=;
        b=XHQ4Lw6wtYfBdacxAxO4FIk3UqHvcK/FlRkoaUmwid+quHcgePAxy/mdO2nngCJtwQ
         HK4WKsH84GDBNNkofFm97quwTuQ6hg7cLMrpk0H7Sq5Wpyb7qXT5owTWSZBzmWSzF67c
         pPFmqSTnC3LBJUU4OIM+ZsNBROofJHvxhMk7IWCGLAcYZqVn9HSrtq/9L5r32YQVYj4I
         wGdTL0Fh8eRMF/lM3NZ4Mvl/aeycVRiDxP+1yPIk92AIvhxlFYfadQU/QwFdCJV6fzvI
         3mAJUGPN0gfGY3sMVJ6JdbSq8Ux17G7iXAa0v9F5bMbbXwoZWVLb6ckx1+jSPLXt+6fJ
         /pOQ==
X-Gm-Message-State: APjAAAUWKN3HW+Q90EftPKZ70PItgbgRrP9Ujh8ebpjBUyHt6oHPStJ2
        nu5SxMA1G/aDQ+R3Il8i06Y=
X-Google-Smtp-Source: APXvYqyysJTAcB6ZzJCttmbfooVDtrC7YfJzT5YfjPwTR2JyhMcoWVGSp/baLb+hkx/xq7ZFdm7Msg==
X-Received: by 2002:a05:6808:b07:: with SMTP id s7mr1288447oij.162.1571721331706;
        Mon, 21 Oct 2019 22:15:31 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id k93sm4869194otc.30.2019.10.21.22.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 22:15:31 -0700 (PDT)
Date:   Mon, 21 Oct 2019 22:15:29 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] powerpc/prom_init: Use -ffreestanding to avoid a
 reference to bcmp
Message-ID: <20191022051529.GA44041@ubuntu-m2-xlarge-x86>
References: <20190911182049.77853-1-natechancellor@gmail.com>
 <20191014025101.18567-1-natechancellor@gmail.com>
 <20191014025101.18567-4-natechancellor@gmail.com>
 <20191014093501.GE28442@gate.crashing.org>
 <CAKwvOdmcUT2A9FG0JD9jd0s=gAavRc_h+RLG6O3mBz4P1FfF8w@mail.gmail.com>
 <20191014191141.GK28442@gate.crashing.org>
 <20191018190022.GA1292@ubuntu-m2-xlarge-x86>
 <20191018200210.GR28442@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018200210.GR28442@gate.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 03:02:10PM -0500, Segher Boessenkool wrote:
> On Fri, Oct 18, 2019 at 12:00:22PM -0700, Nathan Chancellor wrote:
> > Just as an FYI, there was some more discussion around the availablity
> > and use of bcmp in this LLVM bug which spawned
> > commit 5f074f3e192f ("lib/string.c: implement a basic bcmp").
> > 
> > https://bugs.llvm.org/show_bug.cgi?id=41035#c13
> > 
> > I believe this is the proper solution but I am fine with whatever works,
> > I just want our CI to be green without any out of tree patches again...
> 
> I think the proper solution is for the kernel to *do* use -ffreestanding,
> and then somehow tell the kernel that memcpy etc. are the standard
> functions.  A freestanding GCC already requires memcpy, memmove, memset,
> memcmp, and sometimes abort to exist and do the standard thing; why cannot
> programs then also rely on it to be the standard functions.
> 
> What exact functions are the reason the kernel does not use -ffreestanding?
> Is it just memcpy?  Is more wanted?
> 
> 
> Segher

I think Linus summarized it pretty well here:

https://lore.kernel.org/lkml/CAHk-=wi-epJZfBHDbKKDZ64us7WkF=LpUfhvYBmZSteO8Q0RAg@mail.gmail.com/

Cheers,
Nathan
