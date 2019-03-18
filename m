Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AA1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C306720872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhLGJfu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfCRUIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:08:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45545 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfCRUIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:08:19 -0400
Received: by mail-qt1-f195.google.com with SMTP id v20so19510374qtv.12;
        Mon, 18 Mar 2019 13:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ia36LD3bZfC9hmzTwGqx9+Mb5Jx8fVZmBcI2d4uY9ak=;
        b=nhLGJfu9eZ4gjz2WMb4+0foBcVZdyJ5Bv29AhHJFGyUZAmImQ1IHW4g0pltxtDJKdM
         ZEF15hshXGoDiStzbHRFiACbNyYHdSKQ0Jg2H+NmH8MYCyteVh5UMlb2GF2SScnuXKto
         iNKzQ2CeRBH6K+S9bQfZ62koPSvUR2N5gdpTZicX/0PzZnRxpDu1CcLzF0+7Lb/voIKP
         PDhdjVwEQZ32kKJFAUm8Mp9gZXsE3xxEL1AmLJ/Uaas0Y+z1IuHgl5Y4BLgAUkvZjgDo
         TNCDqqeWH94kvfCvrFtu9AtCDosO93DwasOAccmoo9E4JNl2WlPMnOS+QBTD1/8qXlwP
         pTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ia36LD3bZfC9hmzTwGqx9+Mb5Jx8fVZmBcI2d4uY9ak=;
        b=lT9iXfAEHeAqjCXpl/scy2S+scRvOJ70ikXJkI1a0tAA4GtLgI76/2S6EnOzOgLBz3
         SzPT+X7I3ZiiDBREuB/FmBipnvk7qusvQissGpeshUDbsmCz5i07h1hUu7U+WwXnUjvQ
         9YR4XSnRIS9uLbOqUBQ0gPG7hFbQRec8tAdlG2nzNn5DoXv7++87eqdQGTsdOC9gFedd
         FFnqTBg7fwkVDuRNBu8ZdnlwU5z3+ceWy+SojSHSYYwNIlSm+0g3wPLy40PPUlsX19FK
         a3ZZzh+eLWBLagGK4UuhBJuJ3PeFQ8h2HPqIrpMNABK5RPRfYsA7J+gqS6xvFSTS2vjP
         8V9Q==
X-Gm-Message-State: APjAAAUYeW2tZKCKdGUuzE6xToOJ9JELUMDTkMGHPgRoLimICkirYsBm
        gswykvL2TFFVstSxKImPpEfuMjAY
X-Google-Smtp-Source: APXvYqyosVeAPBmJFMhEAsr7+U2jMcwAFl/u4TpGwWiqIW6oQzDtKy+JMlZrLVCxC9jBHtpgZLp2WQ==
X-Received: by 2002:a0c:89a3:: with SMTP id 32mr2570162qvr.116.1552939698655;
        Mon, 18 Mar 2019 13:08:18 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([2804:1b1:210a:504f:5027:31fa:e70e:3668])
        by smtp.gmail.com with ESMTPSA id i65sm15067250qki.32.2019.03.18.13.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 13:08:17 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BD8FA4039C; Mon, 18 Mar 2019 17:08:14 -0300 (-03)
Date:   Mon, 18 Mar 2019 17:08:14 -0300
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 01/16] perf: add doc for how to build perf with Asan and
 UBSan
Message-ID: <20190318200814.GD3967@kernel.org>
References: <20190316080556.3075-1-changbin.du@gmail.com>
 <20190316080556.3075-2-changbin.du@gmail.com>
 <20190318100758.GA28556@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318100758.GA28556@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 18, 2019 at 11:07:58AM +0100, Jiri Olsa escreveu:
> On Sat, Mar 16, 2019 at 04:05:41PM +0800, Changbin Du wrote:
> > AddressSanitizer (or ASan) and UndefinedBehaviorSanitizer (or UBSan) are
> > very useful tools to detect program bugs.
> >  o AddressSanitizer (or ASan) is a GCC feature that detects memory
> >    corruption bugs such as buffer overflows or memory leaks.
> >  o UndefinedBehaviorSanitizer (or UBSan) is a fast undefined behavior
> >    detector supprted by GCC. UBSan detect undefined behavior of programs
> >    at runtime.
> > 
> > This patch adds doc for how to use them on perf. Later patches will fix
> > some of the issues disclosed by them.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/Documentation/Build.txt | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/tools/perf/Documentation/Build.txt b/tools/perf/Documentation/Build.txt
> > index f6fc6507ba55..cae6e1d9b901 100644
> > --- a/tools/perf/Documentation/Build.txt
> > +++ b/tools/perf/Documentation/Build.txt
> > @@ -47,3 +47,23 @@ Those objects are then used in final linking:
> >  
> >  NOTE this description is omitting other libraries involved, only
> >       focusing on build framework outcomes
> 
> thanks for adding doc, one nit:
> 
> > +
> > +3) buld and install perf
> 
> there's already:
>  2) perf build
>  =============
> 
> please use something like 
> 
>  3) perf build for ASan/UBSan
>  ============================
> 
> > +  $ cd tools/perf
> > +  $ make DESTDIR=/usr
> > +  $ make DESTDIR=/usr install
> > +
> > +4) build with ASan or UBSan
> 
> no need for this label

Did this and appart from the evsel->counts one that I fixed up, all
applied as-is, I added all the Fixes: tags, please consider doing it
next time.

Please take a look after I push it to my perf/core branch.

Thanks,

- Arnaldo
