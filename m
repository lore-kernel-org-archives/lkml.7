Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD15BC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE08216C8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 19:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtwE3i/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfFZTAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 15:00:35 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45287 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZTAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 15:00:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id a14so4603366edv.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 12:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YkTKyAgOchwSgE2hnZzQced+CNVoJRfpIyg5duzJl3U=;
        b=RtwE3i/9/ZwjJPmNI83xcRjlnGXneW5ze0n9MCu0SOOubbMHjrEHjpDl+FfgcAmlSr
         lQT0hdZPHlnybiZG66W+9mtBV0wYvPfxjfmbYitzNxpyWpWWau2VW225ggWzgudj9vsA
         4qjBSe157aXOmev/oenk6RQMK5PiKrER8guNE4eS47iEz7vvUb/ZKlEXGqYdhpCdeJKS
         Y439kp+BpmMSjv5c+AAb4XRoX4J07n6Wcz2mQNAWU9LW23YcXxXFdyWsgIXkh17d2oIF
         SSycj2OFIKJ5Tr8OemClI/dgte5RWjbFJ+sd45KMY08R2QTpUPExDNTDj1h55fcX4plm
         +PDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YkTKyAgOchwSgE2hnZzQced+CNVoJRfpIyg5duzJl3U=;
        b=Zp9+pqijphWhN+Q5NxaA+Knv1eJIiRdJ/5uU2YXuQtfmddphNbHvaOmXDTrAsgsDHg
         5/oAGdEAnHagAXT8Av9VlMNpWvjoDfoJdlhQDDvLMrvDqGwjSaimf+gT0CbOqV1Te1ec
         xJobiXv+2IOjcutsaCf4kiw9WAGtu6Z+Y2hHJpHx56NHzNU34Z8JJ6DsChxuqIDwrDaj
         jpZc73kDhl1kBVRCJcgH9M0B8o06Ww5Z/n7XLQnKCamRSpo6a+dMLn+SGKtc2kuXt3mX
         1rU6UbB1O67TDnFWshxZOCqBjRYmvvo26chyGmCvSm80GbEejUx+dL8Tkw2LvksFqBY1
         5nLQ==
X-Gm-Message-State: APjAAAU0WO1QhmHz+d7byshDdVrAtPU9e7kYJ9bCzTM2qJU5rdKuPxiI
        b5Dbh9AM7DC1a+UEQwt89pQ=
X-Google-Smtp-Source: APXvYqwoEwYfzCgJrOJDbRWs1iWKyXokMyw/1l56GzHETwFNa9SZDp0HlY1D4ABBQRsFRAYNS+4wtA==
X-Received: by 2002:a17:906:2a94:: with SMTP id l20mr5562305eje.131.1561575632227;
        Wed, 26 Jun 2019 12:00:32 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id dc1sm3056666ejb.39.2019.06.26.12.00.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 12:00:31 -0700 (PDT)
Date:   Wed, 26 Jun 2019 12:00:28 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joe Perches <joe@perches.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Landden <shawn@git.icu>,
        clang-built-linux@googlegroups.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] perf/x86/intel: Mark expected switch fall-throughs
Message-ID: <20190626190028.GA14249@archlinux-epyc>
References: <3dc75cd4-9a8d-f454-b5fb-64c3e6d1f416@embeddedor.com>
 <CANiq72mMS6tHcP8MHW63YRmbdFrD3ZCWMbnQEeHUVN49v7wyXQ@mail.gmail.com>
 <20190625071846.GN3436@hirez.programming.kicks-ass.net>
 <201906251009.BCB7438@keescook>
 <20190625180525.GA119831@archlinux-epyc>
 <alpine.DEB.2.21.1906252127290.32342@nanos.tec.linutronix.de>
 <20190625202746.GA83499@archlinux-epyc>
 <alpine.DEB.2.21.1906252255440.32342@nanos.tec.linutronix.de>
 <20190626051035.GA114229@archlinux-epyc>
 <alpine.DEB.2.21.1906261711540.32342@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1906261711540.32342@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 05:18:37PM +0200, Thomas Gleixner wrote:
> tarball with log and the preprocessed source and run scripts:
> 
>     https://tglx.de/~tglx/tc-crash.tar.bz2
> 
> The machine runs up to date debian stretch which has backports enabled and
> I just used the install command from the github project page you linked
> to. Getting started section.
> 
> Thanks,
> 
> 	tglx

Great, thank you! It explodes during lowering, which is a backend issue
so that's fun :/

My guess is that this is a problem with -march=native on that version of
LLVM (since a newer one works). Could you try this patch that makes that
opt-in and see if that fixes it?

https://github.com/nathanchance/tc-build/commit/9f1ae41cd4246f9e4d011542f094aa0df2c069b4

Cheers,
Nathan
