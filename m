Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39200C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F74420665
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7fyQeV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfE1PTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:19:43 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:42695 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfE1PTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:19:42 -0400
Received: by mail-qk1-f175.google.com with SMTP id b18so17244063qkc.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 08:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AgIhMjtQNDDLn24P5b2RW+PI0xzMqgCFH6A7C0wsOiI=;
        b=m7fyQeV7CZ6ZSShPV+qHLYPEyovT0Pf1jg9sUYkXEGGGuQHlUcqvStoublnPJRGznl
         f9N5qiUBxw3wM8fPfbs2QheWVQHb82/A0Yw7an8Xzpey7H3vb4si0MxsMA2oZT+vf+o0
         LOrWeyd60+5oofoNbhC60aUrvy9WnZ+FeygDKJ3zJI3mr6G58NFWSDLvGKQ2g777kEkD
         JShm/3o1wN4kV9AR2iCWi0e7ZwVAB60aNMii47BN/2PD5xvA2kAQEhYx6o/jocvPzxGm
         l7k+n9GkiT6wNe4/67lGFjx2FCuaw+gWzqyKY7xhnfw2vFMJgPK7R0qq8BuIJYTFeCXk
         +TMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AgIhMjtQNDDLn24P5b2RW+PI0xzMqgCFH6A7C0wsOiI=;
        b=SP/jOnVncow3W9tnsJv/itfWbEwSj5foQ09U63dqSoLCzUrMHtAkVJ1Gbmo+tBZY1U
         N3bduG3ndl8P6VUYm9HwkaiXWiWTjYI4zbKhp7Ne9X6L7v5HoRQC7IGJSb048vRFR3Fu
         8ADbn8DJy/PSQgIXll260pqfV3spsN+mCr4DU+ebcEQXZRsZirAm9jCuVCER3Rpcgznl
         5EzwhSqhWVPknQG43eFY4LNUkm8hiHSeORidDfscSZieA0mYlXr4KomI43R/Ut7Sf6L+
         RT8jmrbJTZqmgTuPytuZQKGITWusL2OuHIp5jkAJXAEiEvt8efxKzEFO+4tIfLFjMq45
         eSrg==
X-Gm-Message-State: APjAAAUXUD1OZKydLOfByafs/BvAM3YqQzsF2DZ4VZzLbzM7fTF92hFN
        rK3Tbk8fV8rMhQ9+mwyVoYU=
X-Google-Smtp-Source: APXvYqypvW8CIf8Szln6z6gT7Hd5MCneaucTQoe3QXTh/l4QZR2vPpDxb3LhXgbFxDXNuZpg696+0w==
X-Received: by 2002:ac8:4442:: with SMTP id m2mr8678987qtn.107.1559056781293;
        Tue, 28 May 2019 08:19:41 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id 39sm6552033qtx.71.2019.05.28.08.19.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 28 May 2019 08:19:40 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4491841149; Tue, 28 May 2019 12:19:38 -0300 (-03)
Date:   Tue, 28 May 2019 12:19:38 -0300
To:     Raphael Gault <raphael.gault@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, mark.rutland@arm.com
Subject: Re: [RFC 1/7] perf: arm64: Compile tests unconditionally
Message-ID: <20190528151938.GC13830@kernel.org>
References: <20190528150320.25953-1-raphael.gault@arm.com>
 <20190528150320.25953-2-raphael.gault@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528150320.25953-2-raphael.gault@arm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 28, 2019 at 04:03:14PM +0100, Raphael Gault escreveu:
> In order to subsequently add more tests for the arm64 architecture
> we compile the tests target for arm64 systematically.

Humm, the subject doesn't match the description? I.e. it _was_
unconditionally built, now it is only built if CONFIG_DWARF_UNWIND is
set to 'y'.

- Arnaldo
 
> Signed-off-by: Raphael Gault <raphael.gault@arm.com>
> ---
>  tools/perf/arch/arm64/Build       | 2 +-
>  tools/perf/arch/arm64/tests/Build | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/Build b/tools/perf/arch/arm64/Build
> index 36222e64bbf7..a7dd46a5b678 100644
> --- a/tools/perf/arch/arm64/Build
> +++ b/tools/perf/arch/arm64/Build
> @@ -1,2 +1,2 @@
>  perf-y += util/
> -perf-$(CONFIG_DWARF_UNWIND) += tests/
> +perf-y += tests/
> diff --git a/tools/perf/arch/arm64/tests/Build b/tools/perf/arch/arm64/tests/Build
> index 41707fea74b3..a61c06bdb757 100644
> --- a/tools/perf/arch/arm64/tests/Build
> +++ b/tools/perf/arch/arm64/tests/Build
> @@ -1,4 +1,4 @@
>  perf-y += regs_load.o
> -perf-y += dwarf-unwind.o
> +perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
>  
>  perf-y += arch-tests.o
> -- 
> 2.17.1

-- 

- Arnaldo
