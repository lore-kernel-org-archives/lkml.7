Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D42CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7150A21E6F
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 13:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVwVowrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393714AbfJXNnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 09:43:31 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39348 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393656AbfJXNn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 09:43:29 -0400
Received: by mail-qk1-f194.google.com with SMTP id 4so23431889qki.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OcApvEga4pQ/hiufvVDblUpoC7Hup+MwXzzzVtEdKJs=;
        b=cVwVowrmtSnGY7X6icWn3ocdRMNwrWeJZv7wRZE8Dh9RXt/vLtQ0weXv6xX8Dk36cQ
         yhf6Pn5fLefJET71zSmnXF8D3y+uLiD2Mvs/+1y8z7PdtrdgtBkMAg1Qwp55RRr5XhOg
         yRQ9EDQb3+0/E7TOYpSjYiDHZ4On/eYPDhRpNBgGz76B2GuvaHQ9Z1+dVxDJ+1j+eUVE
         YFlaESlz3NbjCxWG2uUMCm7dQxbA/XdviZVEmeiEkU4w+edXyTfkFw7WP6645hZTEjR+
         qKNZHGSePJ9QCgzGODl0sjDLhqvuVn9+KRjHX9GmDvyyW4ApX03xcaR9BFiH5FgZgpVt
         2heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OcApvEga4pQ/hiufvVDblUpoC7Hup+MwXzzzVtEdKJs=;
        b=GelH5qRoeEluS3RU8SZsxqhezhCLguOe7sNxrawGyCKcquBC3eofFdG8bfKKDYJw0A
         TVbWmgJJaEqTkm99e31qO5B0BGKE/jz1k23apgB1ZY6AYfHwMqK4hRdHolPOHLLptQZQ
         x3l2dcS1jUFdZ54R1IdRWA+tVJGSuwm1tMzr3X/iN2SnBtG6PDzEyJtG4poI2YsMelPw
         qjqAi+CPqqqGO7uR1Rd5CUfuihGxR0Zphb505BRhymKkMbG1DKCnx4SeZ/hg+S6h9prG
         pt9OKu7LsE2McMcl98DUlpEK/E/b1+nQYGH+b73J0s2+/5FDrLu0L/0SdxuNspDKTArg
         EmYQ==
X-Gm-Message-State: APjAAAXh9XFUz4TK4A/kypRMWsLyrsR1mR/pz/CkaFfLSOXZQBFk/sba
        KDxBc9+jm8MzbIwWjRZfQ59pEU1U
X-Google-Smtp-Source: APXvYqxCfU5tjQVYt1vf1ozi/JhWh2WbPrMHcqRh6lRT4d7QKXWpC9WAt5CxOkqFD/JPJL4/G4J9hg==
X-Received: by 2002:a37:a2d1:: with SMTP id l200mr13373114qke.158.1571924608486;
        Thu, 24 Oct 2019 06:43:28 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id p7sm14380392qkc.21.2019.10.24.06.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 06:43:27 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1CFB04DDC9; Thu, 24 Oct 2019 10:43:25 -0300 (-03)
Date:   Thu, 24 Oct 2019 10:43:25 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH 0/3] perf/probe: Fix available line bugs
Message-ID: <20191024134325.GA1666@kernel.org>
References: <157190834681.1859.7399361844806238387.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157190834681.1859.7399361844806238387.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 24, 2019 at 06:12:27PM +0900, Masami Hiramatsu escreveu:
> Hi,
> 
> Here are some bugfixes related to showing available line (--line/-L)
> option. I found that gcc generated some subprogram DIE with only
> range attribute but no entry_pc or low_pc attributes.
> In that case, perf probe failed to show the available lines in that
> subprogram (function). To fix that, I introduced some bugfixes to
> handle such cases correctly.

Thanks, applied, next time please provide concrete examples for things
that don't work before and gets fixed with your patches, this way we can
more easily reproduce your steps.

- Arnaldo
 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (3):
>       perf/probe: Fix to find range-only function instance
>       perf/probe: Walk function lines in lexical blocks
>       perf/probe: Fix to show function entry line as probe-able
> 
> 
>  tools/perf/util/dwarf-aux.c |   44 ++++++++++++++++++++++++++++++++++++-------
>  tools/perf/util/dwarf-aux.h |    3 +++
>  2 files changed, 40 insertions(+), 7 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

-- 

- Arnaldo
