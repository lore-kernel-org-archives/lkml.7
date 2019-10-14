Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25683C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC908207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6JQT9lx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732379AbfJNOBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:01:42 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35771 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730477AbfJNOBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:01:42 -0400
Received: by mail-qk1-f194.google.com with SMTP id w2so15993238qkf.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 07:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wwNskThWX0Rg32SLCjk1C+65CwCG33vEO5AR8DBfLPg=;
        b=R6JQT9lxbfFg+cJ6oCkUvptYOIGuphlHRuAdg0MTNc52WMLPkcQTT2asckWEzKx2DL
         xwUVW9RGXOiFqWShHEfwUZaGEh6hRt8Wb0MBJ+PAk4CzeY6dkIo3Dm6Ttc9tksohTum7
         uE0S3Xgw2KDYPfLWsG1BFX+gmhc9yp/79cNNbwxQPTxN9xgWx0o8zVHNUQhS5NwlYuMF
         PsTsosvzE9Nt914Cd2QMgTuyD/3F+8gmsRs4s9qsFYjVCCggQ72gqivoO8NLmvwDXhbZ
         AeXfEHp8YjvSkDkl/Q9k0xanMJM+Mj4GrO3vZpWGDaPs6BuH49VzBNfAC3OyqmEvfmtp
         U8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wwNskThWX0Rg32SLCjk1C+65CwCG33vEO5AR8DBfLPg=;
        b=bO61mqWzBgC8sKN46CUjoTE4xZuFJQQVQBIcxwRh/7xVar/oXJ6JoJVCa03KxEt5Aq
         ZAG1/YJ6NalMrv14b9TyjjgC5/ObSvGe4lSpgaLcZobqqGgNjinCHjkYXtPVorg4n6W1
         nxqntwJUgqWrLE0blmtqgVMC5ssHwxcInLmQIr10zMzFRfKA4slrlBSrZHRSq+NzT3Ct
         EEyNYTDNJQ5ZYBIdXErd9PIwf3+RXgFq+F+CTxii4dBqlWF8WGANCKen5T6ic1pkEWar
         SZsWMtWHz3iyJXdSG5wj7IK2aOg5mihMgh/O6t9Zsy6zWXjulf2Zar2HLL4dsLtAPfta
         4KnA==
X-Gm-Message-State: APjAAAUVdZpw+JvmD1v2dOWtRTK2euP0y1WqMlSM7PGl5opC6nd3E7Qt
        6BdrlxlWBBOHidigwjZyGRk=
X-Google-Smtp-Source: APXvYqzbQNZyX4SWywgcvJL6SZav2qwVCKpDqxJy98zGUgyGABylAa50UD9Ocp38tFZQVOBmBSMIFg==
X-Received: by 2002:a37:4f4d:: with SMTP id d74mr30173443qkb.51.1571061701212;
        Mon, 14 Oct 2019 07:01:41 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id l23sm13952783qta.53.2019.10.14.07.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:01:40 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 41AA24DD66; Mon, 14 Oct 2019 11:01:37 -0300 (-03)
Date:   Mon, 14 Oct 2019 11:01:37 -0300
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 1/3] perf tools: Allow to build with -ltcmalloc
Message-ID: <20191014140137.GA19627@kernel.org>
References: <20191013151427.11941-1-jolsa@kernel.org>
 <20191013151427.11941-2-jolsa@kernel.org>
 <20191014013322.GI9933@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014013322.GI9933@tassilo.jf.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Oct 13, 2019 at 06:33:22PM -0700, Andi Kleen escreveu:
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index a099a8a89447..8f1ba986d3bf 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -114,6 +114,8 @@ include ../scripts/utilities.mak
> >  # Define NO_LIBZSTD if you do not want support of Zstandard based runtime
> >  # trace compression in record mode.
> >  #
> > +# Define TCMALLOC to enable tcmalloc heap profiling.
> 
> It might be useful for more than just profiling. I found that gcc runs a
> few percent faster with tcmalloc for some workloads. Maybe the same is
> true for perf too, as sometimes it does a lot of mallocs.

Thanks, applied. Waiting for the conclusion of the discussion about JIT,
etc to look at the rest.

- Arnaldo
