Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84658C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518342184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 12:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vaBOVtXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbfCTMAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 08:00:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36024 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCTMAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 08:00:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id p10so1792881pff.3;
        Wed, 20 Mar 2019 05:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tBULsVgVrdOlC+6qFNcSINVsrxq3oXp69L70mjSSd3w=;
        b=vaBOVtXES38vPsHi/sN0Pg0oaFAin/e7LVLduK+LyTiANlB0si/X1Myt55H+3gFCmY
         EPdyjNCXqGBosyAiPl15p/3KO51UlA5jn4qcDV1mP+YxMhKHjYuYAR3BHLbLlcmPQNI5
         NsuOZ4yQkpzQtlPfdTkxcirJMU3vBPAWr+n6byCwFDMHREj3Bl7N0McH6tLP7fOjkPu3
         MkmWTspiZzf5ThF6XxgH0dhbGp9tYYpqc25zsDTCLgp1z0g9/eqeupj/qn9ALRTqwW8U
         yUULVeghfk7ELUd7OCVNluYqbF/VN7+RHPuavvTM/Wl6ZE9mov0SkHWrVQ9DpAD/uSR3
         YBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tBULsVgVrdOlC+6qFNcSINVsrxq3oXp69L70mjSSd3w=;
        b=XFtWv2cdTsofPz/eGrOXKWFTUl6Ypxl6qHSxLc9uSFM+qeHylRuUzrtvrb2lR5plG8
         SBE6n8LyqOnMlAusa4MWzPTVrl6Cp+PEGyKJbMacTUZkrMOfAEtnr1qKOXsUuGIv8gt4
         yUvLkYJgfmRbIQhfFjy9npQDJVX5ZO/ufOjqAykqYRtLE7Y53r2kx6vt3LYa+4cCRtKN
         AZHPXZciX5hUM0YAR97jtxN+XGkbfRPNUL8ZtXLoCX6NtwOEBLLbK7f846qkhkhnGhXJ
         nmryE0HICtUI79nzfy7ey2iXwYA4uPV8bWBCNCF9nOJizC7Y6/Utx50bX6QHjdRviez7
         z47g==
X-Gm-Message-State: APjAAAXXfIYJRNZ4D4rqKuTSyXGGfQ4cXKQsyAaOq9V0KDSPVihOlQvP
        QMNdz+9fL3QbalJACP6YVBY=
X-Google-Smtp-Source: APXvYqzYaH4zAqCCGG6+678XvnM4Yqk0UPirzb19RHvnfKKSEf3PfNlJKZZplzj3+Orz4spn4Me1EA==
X-Received: by 2002:a17:902:407:: with SMTP id 7mr7579763ple.62.1553083213383;
        Wed, 20 Mar 2019 05:00:13 -0700 (PDT)
Received: from mail.google.com ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id 23sm2742854pfn.2.2019.03.20.05.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 05:00:13 -0700 (PDT)
Date:   Wed, 20 Mar 2019 12:00:11 +0000
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 01/16] perf: add doc for how to build perf with Asan and
 UBSan
Message-ID: <20190320120011.xmvqv2yjnmuzz4v5@mail.google.com>
References: <20190316080556.3075-1-changbin.du@gmail.com>
 <20190316080556.3075-2-changbin.du@gmail.com>
 <20190318100758.GA28556@krava>
 <20190318200814.GD3967@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318200814.GD3967@kernel.org>
User-Agent: NeoMutt/20180716-508-7c9a6d
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 05:08:14PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Mar 18, 2019 at 11:07:58AM +0100, Jiri Olsa escreveu:
> > On Sat, Mar 16, 2019 at 04:05:41PM +0800, Changbin Du wrote:
> > > AddressSanitizer (or ASan) and UndefinedBehaviorSanitizer (or UBSan) are
> > > very useful tools to detect program bugs.
> > >  o AddressSanitizer (or ASan) is a GCC feature that detects memory
> > >    corruption bugs such as buffer overflows or memory leaks.
> > >  o UndefinedBehaviorSanitizer (or UBSan) is a fast undefined behavior
> > >    detector supprted by GCC. UBSan detect undefined behavior of programs
> > >    at runtime.
> > > 
> > > This patch adds doc for how to use them on perf. Later patches will fix
> > > some of the issues disclosed by them.
> > > 
> > > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > > ---
> > >  tools/perf/Documentation/Build.txt | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > > 
> > > diff --git a/tools/perf/Documentation/Build.txt b/tools/perf/Documentation/Build.txt
> > > index f6fc6507ba55..cae6e1d9b901 100644
> > > --- a/tools/perf/Documentation/Build.txt
> > > +++ b/tools/perf/Documentation/Build.txt
> > > @@ -47,3 +47,23 @@ Those objects are then used in final linking:
> > >  
> > >  NOTE this description is omitting other libraries involved, only
> > >       focusing on build framework outcomes
> > 
> > thanks for adding doc, one nit:
> > 
> > > +
> > > +3) buld and install perf
> > 
> > there's already:
> >  2) perf build
> >  =============
> > 
> > please use something like 
> > 
> >  3) perf build for ASan/UBSan
> >  ============================
> > 
> > > +  $ cd tools/perf
> > > +  $ make DESTDIR=/usr
> > > +  $ make DESTDIR=/usr install
> > > +
> > > +4) build with ASan or UBSan
> > 
> > no need for this label
> 
> Did this and appart from the evsel->counts one that I fixed up, all
> applied as-is, I added all the Fixes: tags, please consider doing it
> next time.
> 
> Please take a look after I push it to my perf/core branch.
>
ok, no problem.

> Thanks,
> 
> - Arnaldo

-- 
Cheers,
Changbin Du
