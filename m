Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC421CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 795E920830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 14:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyXPbebg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389142AbfJ2OS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 10:18:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38516 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388871AbfJ2OS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 10:18:56 -0400
Received: by mail-qk1-f194.google.com with SMTP id e2so3810046qkn.5;
        Tue, 29 Oct 2019 07:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HZF6POe6RaoaXOWw9Y6fxEMSBHELwipZN7Yo0E0GaC8=;
        b=EyXPbebgIVaEue0GO/kJSVH2oPjM9EUjn2/GVILAA5RdqV+sfs5NxBWiAxWX2hRu7S
         TwrEBRm9f3KAGd3vIptDXqI7yzrIh7oKVKSaRHMrAbsNbpfGu/eepoXsH0fjkUrmLvUu
         f+W9Xo0ZQu/7c7AB1hq0clonxMSpWPiniea+5hPF+Sli8GBfTrQa9ifjqOokgYr+BZ5X
         dZsdGIitb3Z2aTsPe7ZMzqkq4GXRZgDdcU7HdHIg8Scr8ORxynUMj77vVj2chmdzrXZe
         KlxTGBJNHA5DkuAaIQj85Pp8OsWXe2QkvyFd/uTq++0JS5azV5RVKALBazxAo8oeNxnK
         vJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HZF6POe6RaoaXOWw9Y6fxEMSBHELwipZN7Yo0E0GaC8=;
        b=tg/xm0hybMqa6+TN7s6GVks6pabwqyk2UYzduXLBRHO4XqciuIbjmv/BSlAe/0HVZR
         OKjjFZ92+QU3ZPhIqpRyc2o5oea2t6k1IykHZQm/Ck61GPCIxKNgsLfBJzSgFaHG3M8x
         Zu5cGlQ4GDizHjLFtbAJli9ISeCbTQegrmvVa9C4fPNMAywJKxi0aU67opH8XgAmlegv
         FK2hJPXUUZjZfdXWh0DqNinPcmi6squOsjSdBdtci2zG+CPl+gAPpH4earzRmBJAViaQ
         lmKJe+pw/FRfgakZYq9AgXUbXVg2sY5VEYDT9/4/nETSVgV4i/JjzhVlcLqikITOOig+
         dT0A==
X-Gm-Message-State: APjAAAUpWnVDo1uTAANG5NnSw99eDvS59mzB2Wxv0MyjXLCjP/8aJTbA
        Eh7HVm5Aeh4iBLmMw9DbzVk=
X-Google-Smtp-Source: APXvYqzzIlfk7RNV3gbuSP42375zRf1ETGyV9HLh2eQJKV6tE7fxBlKRriZBOwosBUk2tvPNEME4ng==
X-Received: by 2002:a37:e10e:: with SMTP id c14mr22441788qkm.408.1572358735042;
        Tue, 29 Oct 2019 07:18:55 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id h2sm1568321qto.51.2019.10.29.07.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 07:18:54 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4870A40D5C; Tue, 29 Oct 2019 11:18:52 -0300 (-03)
Date:   Tue, 29 Oct 2019 11:18:52 -0300
To:     James Clark <James.Clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        nd <nd@arm.com>, Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] Fixes issue when debugging debug builds of Perf.
Message-ID: <20191029141852.GC4922@kernel.org>
References: <20191028113340.4282-1-james.clark@arm.com>
 <20191029140052.GB4922@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029140052.GB4922@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 29, 2019 at 11:00:52AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Oct 28, 2019 at 11:34:01AM +0000, James Clark escreveu:
> > When a 'make DEBUG=1' build is done, the command parser
> > is still built with -O6 and is hard to step through.
> > 
> > This change also moves EXTRA_WARNINGS and EXTRA_FLAGS to
> > the end of the compilation line, otherwise they cannot be
> > used to override the default values.
> 
> The patch came mangled, so I'm applying by hand, and separating it into
> two patches, the first for the first paragraph and the other for the
> second, ok?

So, this is what I mean by mangled:

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 5b2cd5e58df0..1c777a72bb39 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -19,8 +19,7 @@ MAKEFLAGS +=3D --no-print-directory
=20
 LIBFILE =3D $(OUTPUT)libsubcmd.a
=20
-CFLAGS :=3D $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
-CFLAGS +=3D -ggdb3 -Wall -Wextra -std=3Dgnu99 -fPIC
+CFLAGS :=3D -ggdb3 -Wall -Wextra -std=3Dgnu99 -fPIC
=20
 ifeq ($(DEBUG),0)
   ifeq ($(feature-fortify-source), 1)
@@ -28,7 +27,9 @@ ifeq ($(DEBUG),0)
   endif
 endif
=20
-ifeq ($(CC_NO_CLANG), 0)


--------------------

And here is the first patch out of your larger one, I changed the
subject line to reflect that this is not tools/perf specific, as
tools/objtool/ also uses libsubcmd, added Josh, objtool's maintainer so
that he is made aware.

Thanks,

- Arnaldo

commit a554275abf9f13054595d3155b835668dab74bf9
Author: James Clark <James.Clark@arm.com>
Date:   Mon Oct 28 11:34:01 2019 +0000

    libsubcmd: Move EXTRA_FLAGS to the end to allow overriding existing flags
    
    Move EXTRA_WARNINGS and EXTRA_FLAGS to the end of the compilation line,
    otherwise they cannot be used to override the default values.
    
    Signed-off-by: James Clark <james.clark@arm.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Ian Rogers <irogers@google.com>
    Cc: James Clark <james.clark@arm.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Josh Poimboeuf <jpoimboe@redhat.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: nd <nd@arm.com>
    Link: http://lore.kernel.org/lkml/20191028113340.4282-1-james.clark@arm.com
    [ split from a larger patch ]
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index 5b2cd5e58df0..352c6062deba 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -19,8 +19,7 @@ MAKEFLAGS += --no-print-directory
 
 LIBFILE = $(OUTPUT)libsubcmd.a
 
-CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
-CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -fPIC
+CFLAGS := -ggdb3 -Wall -Wextra -std=gnu99 -fPIC
 
 ifeq ($(DEBUG),0)
   ifeq ($(feature-fortify-source), 1)
@@ -43,6 +42,8 @@ CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
 
 CFLAGS += -I$(srctree)/tools/include/
 
+CFLAGS += $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
+
 SUBCMD_IN := $(OUTPUT)libsubcmd-in.o
 
 all:
