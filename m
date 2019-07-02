Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413DEC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 153C92146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5MHYzvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfGBQBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:01:42 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40553 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfGBQBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:01:42 -0400
Received: by mail-qk1-f193.google.com with SMTP id c70so14538704qkg.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 09:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=t6Sq8VlsWfMYqpvKp7IaW+M3XXbNjuCkJCX7Z7BRYiM=;
        b=X5MHYzvzoOVPhATkU6PFr1lh3OWQs2kVmrJIck1jLUJxA/IO6LEjTimckdHFYFdzXR
         SgdiLYSxlVEQv6o+oXp3p1rvic7oxEazGgXsX/cw2s05UhNFiS6UJ8IjMKYpe/UCqoKa
         JOSVZFKR6JylGmL+/c7epIfkkNPjDsI19Ame1i4ctb7+mqMlU+nXgxuY7SjRTY+uKGsE
         6nP3CeGbBwHMCYG+d+PA6gGxCXXb1Ok5qL7NPrc9zGMb1lqZm6ucG41z2Ghnm/L3keLd
         ZuLWmQNCi1OICUQzSmKFkhBSGlbZUk/VvepkOiFEKK6K++QcgW28m/OisoPRTpM793sN
         PcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=t6Sq8VlsWfMYqpvKp7IaW+M3XXbNjuCkJCX7Z7BRYiM=;
        b=bDL4ZOl0pj3OWrZO6dwczFBoeUPZ9/7+EA3MaRC1SI5eKw1URwttTxeKZ8CiYQkFI0
         ydpQQbM45BDjRGQCVljSEFjIOhZNbUFF1JDw4W2aMBUgMyL5yiYeTwLsdr3Hkayz7O91
         OhDQ2XS7surR9PzipyGdu0X4RwMLHfkTFAOII9Bj1q6tcf/lTTKbbViI542lQ4lO2Zoq
         zGf5TO2tl8Be/wS8Zy0m4X9B6Oc9hzVKKuL/JUaxXSFHrjskdVGrmCT4WVlfkXBDSBsl
         hDHPDVwrVzXqipmbcq4Ic4mQ9GSVS2SJJ8JoP9+HPgPC7YSyCAiedIGCt6vDKyuzVWPH
         SUIg==
X-Gm-Message-State: APjAAAV7CM/Sg5Eb9DSR7eEunB7LuGMykuxgAK1pNRDkZKVtSmxDI3OY
        JstotIH/tyd4nq+dhnfzthE=
X-Google-Smtp-Source: APXvYqznzIMu+970vyDTiemPvodjeZo3AVygxlhjjX+83Zgkc59DtvvGrFrt6qUaD1MCU0N5RNuMuw==
X-Received: by 2002:a37:5f82:: with SMTP id t124mr23414604qkb.180.1562083301156;
        Tue, 02 Jul 2019 09:01:41 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id o5sm6347142qkf.10.2019.07.02.09.01.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 09:01:39 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CDA1F41153; Tue,  2 Jul 2019 13:01:37 -0300 (-03)
Date:   Tue, 2 Jul 2019 13:01:37 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf tools: Fix bison warnings for pure parser
Message-ID: <20190702160137.GI15462@kernel.org>
References: <20190627222021.14980-1-andi@firstfloor.org>
 <20190628080507.GB3427@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190628080507.GB3427@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 28, 2019 at 10:05:07AM +0200, Jiri Olsa escreveu:
> On Thu, Jun 27, 2019 at 03:20:21PM -0700, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > bison 3.4.1 complains during a perf build:
> > 
> > util/parse-events.y:1.1-12: warning: deprecated directive, use ‘%define api.pure’ [-Wdeprecated]
> >     1 | %pure-parser
> >       | ^~~~~~~~~~~~
> >   CC       /home/andi/lsrc/obj-perf/ui/browsers/map.o
> > util/parse-events.y: warning: fix-its can be applied.  Rerun with option '--update'. [-Wother]
> > 
> > util/expr.y:13.1-12: warning: deprecated directive, use ‘%define api.pure’ [-Wdeprecated]
> >    13 | %pure-parser
> >       | ^~~~~~~~~~~~
> > util/expr.y: warning: fix-its can be applied.  Rerun with option '--update'. [-Wother]
> > 
> > Change the declarations to %define api.pure
> > 
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> looks good, let's hope it'll pass Arnaldo's build test

starting the tests now...
 
> jirka
> 
> > ---
> >  tools/perf/util/expr.y         | 2 +-
> >  tools/perf/util/parse-events.y | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
> > index 432b8560cf51..803c0929c205 100644
> > --- a/tools/perf/util/expr.y
> > +++ b/tools/perf/util/expr.y
> > @@ -10,7 +10,7 @@
> >  #define MAXIDLEN 256
> >  %}
> >  
> > -%pure-parser
> > +%define api.pure
> >  %parse-param { double *final_val }
> >  %parse-param { struct parse_ctx *ctx }
> >  %parse-param { const char **pp }
> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> > index 6ad8d4914969..4eb10c27c30f 100644
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -1,4 +1,4 @@
> > -%pure-parser
> > +%define api.pure
> >  %parse-param {void *_parse_state}
> >  %parse-param {void *scanner}
> >  %lex-param {void* scanner}
> > -- 
> > 2.21.0
> > 

-- 

- Arnaldo
