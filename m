Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556BAC7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 14:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA1A2085A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 14:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LP1XT4pg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbfG0OO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 10:14:57 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38102 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387688AbfG0OO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 10:14:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id n11so55457348qtl.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 07:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tzpypz5828sRuyG//D8pIQ96msDV7cyUdi8Hka35Z/Q=;
        b=LP1XT4pguBIDSDh/lrOTbZ88jAANU4JhhwjmRSTIhmCxPRJM1VH/FyeIf7VNXkpPCT
         SPOLUHAK99jzy9+x0bha1MVmDirtX8TQC6+FUpHxwrUTAeD9J2od4c3shM5VyaqkTrP+
         HTFIinY14a4SXtG+yBQ98zbeDLKmZIM4V+Ws4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tzpypz5828sRuyG//D8pIQ96msDV7cyUdi8Hka35Z/Q=;
        b=ZykKesBRzChqqwSDM7lYTKRL28wdYoAJk4nVIDVU9Q4u05UlduZeAXf6lAcnwh77JV
         KP75jCkTyncOSVCasmnk8qUbUNYdHFcrdr3AyW8Zw64nGF/a4FgP3bCCeHGmnrn0a2nb
         vRIBbJR2+n2K09uOz4mHfkONwlozEzbu/b9UvUhMUsEr+GX/9xIqLqLbflY+LO+lQVqM
         OL+V5HcvfJ6p9a/lM7NG4DvDyChk/e82LY6uEsCoBr0hCylGlhf5n7qB4RGHxpssqpgt
         pnd8eBm9mLmmrRFWP4pusDr2kx/1UCD91zSfkegEuUNyNwHlRzY30Pp//xFAym4w/LoH
         TULg==
X-Gm-Message-State: APjAAAWJzDkFaU7C9Ucrcr2a+2DbvPqvRiy9bIvgHf9VcWEfCdXM3Op7
        DmF9+3ZqwTEBbaMrC5Ac7gA=
X-Google-Smtp-Source: APXvYqx8DlVRP1tJMKo0Kvvr5+WKBQGF8DwYfSar9xO8N+tLKvVRyyt/XJVd5RfweskC2177bCDZng==
X-Received: by 2002:ac8:2b62:: with SMTP id 31mr71367365qtv.140.1564236895563;
        Sat, 27 Jul 2019 07:14:55 -0700 (PDT)
Received: from localhost ([2601:5c2:201:936:f43e:2dbd:b941:ec40])
        by smtp.gmail.com with ESMTPSA id e125sm23434639qkd.120.2019.07.27.07.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jul 2019 07:14:54 -0700 (PDT)
Date:   Sat, 27 Jul 2019 14:14:53 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Ingo Molnar <mingo@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        SeongJae Park <sj38.park@gmail.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH] tools: memory-model: add it to the Documentation body
Message-ID: <20190727141013.dpvjlcp3juja4see@penguin>
References: <20190726180201.GE146401@google.com>
 <5826090bf29ec831df620b79d7fe60ef7a705795.1564167643.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5826090bf29ec831df620b79d7fe60ef7a705795.1564167643.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 04:01:37PM -0300, Mauro Carvalho Chehab wrote:
> The books at tools/memory-model/Documentation are very well
> formatted. Congrats to the ones that wrote them!
> 
> The manual conversion to ReST is really trivial:
> 
> 	- Add document titles;
> 	- change the bullets on some lists;
> 	- mark code blocks.

Thanks so much, some feedback:
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

(1)
I could not find the table of contents appear in the HTML output for this.
Basically this list in the beginning doesn't render:
  1. INTRODUCTION
  2. BACKGROUND
  3. A SIMPLE EXAMPLE
  4. A SELECTION OF MEMORY MODELS
  5. ORDERING AND CYCLES
 
Could we add a proper TOC with sections? My motivation for ReST here would be
to make the sections jumpable since it is a large document.

Also could we make the different sections appear as a tree in the left
sidebar?

(2) Arguably several function names in the document HTML output should appear
in monospace fonting and/or referring to the documentation for real function
names, but these can be fixed as we go, I guess.

(3) Things like smp_load_acquire() and spin_lock() should probably refer to
the documentation for those elsewhere..

(4) I would argue that every occurence of
A ->(some dependency) B should be replaced with fixed size font in the HTML
results.

Arguably it is better IMO if the whole document is fixed size font in the
HTML output because so many things need to be fixed size, but that my just be
my opinion.

thanks,

 - Joel


> ---
>  Documentation/core-api/refcount-vs-atomic.rst |   2 +-
>  Documentation/index.rst                       |   1 +
>  Documentation/tools/memory-model              |   1 +
>  .../memory-model/Documentation/cheatsheet.rst |  36 +++++
>  .../memory-model/Documentation/cheatsheet.txt |  30 ----
>  .../{explanation.txt => explanation.rst}      | 151 ++++++++++--------
>  tools/memory-model/Documentation/index.rst    |  20 +++
>  .../{recipes.txt => recipes.rst}              |  41 ++---
>  .../{references.txt => references.rst}        |  46 +++---
>  tools/memory-model/README                     |  10 +-
>  10 files changed, 192 insertions(+), 146 deletions(-)
>  create mode 120000 Documentation/tools/memory-model
>  create mode 100644 tools/memory-model/Documentation/cheatsheet.rst
>  delete mode 100644 tools/memory-model/Documentation/cheatsheet.txt
>  rename tools/memory-model/Documentation/{explanation.txt => explanation.rst} (97%)
>  create mode 100644 tools/memory-model/Documentation/index.rst
>  rename tools/memory-model/Documentation/{recipes.txt => recipes.rst} (96%)
>  rename tools/memory-model/Documentation/{references.txt => references.rst} (71%)
 
