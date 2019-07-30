Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A7AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA68205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YjhiCDdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbfG3WRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:17:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35792 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfG3WRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:17:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so30578943pfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 15:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NH7v7hQGCDcrcHr7kXmnUcDiXKdZs1vThqRJQtWPV0Y=;
        b=YjhiCDdS++ckTk0XkYI2HEzbofEQ3uA16tqVKn5xFON/94wyuns1fYEvRgfld7vZeD
         Bl+yey9UFJbhBW6TVF85ULg8UkfSkISZJYkPMw0GVLiz8bhEm2h9BVVQD36i7vKZdZPb
         n0JNMtzrSg9WLQf+hQ9PQ6hUQ7InTJi8gDbm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NH7v7hQGCDcrcHr7kXmnUcDiXKdZs1vThqRJQtWPV0Y=;
        b=is+aLJG1cD571DkLKb6s1tXLWLBXwieF9QzFcP45B6iJF06zZPAC6Q4B4ZmCXTWLOu
         bK1O/hn536HdS98zH1+H9uI3EFqABbqd3kVR7xK/6LTPThrvv6qW4GhcUy7dgPpl5Lgl
         9kI6/sYV+Q/grrkEWHjTOs0ZxUkA/JWs8ZajeyhzcQBKtGvtkrPko8wzmU0FeO/DpTWL
         SS5eEtlAhBkp+sjcqSO3kGqJVTiBPAB1AIUd7HZUpzyDwAsELRA8qP93YGYMm+pj+xkO
         tUGMW8Y7yLtPMjpzIERFMp9FnB3cwHkqOeDICXN6PCh8k15BCvaipdl8ORICemF+IHlk
         xQpg==
X-Gm-Message-State: APjAAAWX9Wd2h8wvDORx7TUIJ5FjkCJooBkmDO06m0Aya8DWIkS/g9V0
        gMA2BQJ/db2mlZ4gMg8GpN8=
X-Google-Smtp-Source: APXvYqxbPCCPBMjUjr+mPF4OfTVJrWDC2ya3kxrss21RBQu4MHAaBdICZcE/jgDJipxXac1Rg/rAxw==
X-Received: by 2002:a63:5c07:: with SMTP id q7mr58436674pgb.436.1564525023627;
        Tue, 30 Jul 2019 15:17:03 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p7sm71355161pfp.131.2019.07.30.15.17.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 15:17:02 -0700 (PDT)
Date:   Tue, 30 Jul 2019 18:17:01 -0400
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
Message-ID: <20190730221701.GC254050@google.com>
References: <20190726180201.GE146401@google.com>
 <5826090bf29ec831df620b79d7fe60ef7a705795.1564167643.git.mchehab+samsung@kernel.org>
 <20190727141013.dpvjlcp3juja4see@penguin>
 <20190727123754.5d91d4a4@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727123754.5d91d4a4@coco.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 12:37:54PM -0300, Mauro Carvalho Chehab wrote:
> Em Sat, 27 Jul 2019 14:14:53 +0000
> Joel Fernandes <joel@joelfernandes.org> escreveu:
> 
> > On Fri, Jul 26, 2019 at 04:01:37PM -0300, Mauro Carvalho Chehab wrote:
> > > The books at tools/memory-model/Documentation are very well
> > > formatted. Congrats to the ones that wrote them!
> > > 
> > > The manual conversion to ReST is really trivial:
> > > 
> > > 	- Add document titles;
> > > 	- change the bullets on some lists;
> > > 	- mark code blocks.  
> > 
> > Thanks so much, some feedback:
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> > 
> > (1)
> > I could not find the table of contents appear in the HTML output for this.
> > Basically this list in the beginning doesn't render:
> >   1. INTRODUCTION
> >   2. BACKGROUND
> >   3. A SIMPLE EXAMPLE
> >   4. A SELECTION OF MEMORY MODELS
> >   5. ORDERING AND CYCLES
> 
> Yes. It is written as a comment, like:
> 
> 	.. foo  This is a comment block
> 
> 	   Everything on this block
> 
> 	   won't be parsed.
> 
> So it won't be parsed, but having a TOC like this isn't need, as
> Sphinx generates it automatically via "toctree" markup. 

Ok.

> > Could we add a proper TOC with sections? My motivation for ReST here would be
> > to make the sections jumpable since it is a large document.
> 
> Just change the toctree depth at index.rst to 2 and you'll see an index
> produced by Sphinx with both levels 1 (doc name) and level 2 (chapters):
> 
> 	.. toctree::
> 	   :maxdepth: 2

Admittedly, I don't have much time at the moment to do these experiments :(

> > Also could we make the different sections appear as a tree in the left
> > sidebar?
> 
> The sidebar follows the maxdepth too.
> 
> > 
> > (2) Arguably several function names in the document HTML output should appear
> > in monospace fonting and/or referring to the documentation for real function
> > names, but these can be fixed as we go, I guess.
> 
> If you want monospaced fonts, just use: ``monospaced_symbol_foo`` within
> any paragraph, or place the monospaced data inside a code-block:
> 
> 	::
> 
> 		This will be monospaced.
> 
> > 
> > (3) Things like smp_load_acquire() and spin_lock() should probably refer to
> > the documentation for those elsewhere..
> 
> Jon added an automarkup extension on Kernel 5.2. So, all functions that
> are defined elsewhere will automatically generate an hyperlink. For that to
> happen, you need to add the kernel-doc markup at the *.h or *.c file where
> the function is declared and use the kernel-doc markup somewhere within the
> Kernel Documentation/.
> 
> > 
> > (4) I would argue that every occurence of
> > A ->(some dependency) B should be replaced with fixed size font in the HTML
> > results.
> 
> Just place those with ``A -> (some dependency)``. This will make them use
> a fixed size font.

Ok, understood all these. I guess my point was all of these will need to be
done to make this document useful from a ReST conversion standpoint. Until
then it is probably just better off being plain text - since there are so
many of those ``A -> (dep) B`` things.

> > Arguably it is better IMO if the whole document is fixed size font in the
> > HTML output because so many things need to be fixed size, but that my just be
> > my opinion.
> 
> Just my 2 cents here, but having the entire document using a fixed size
> font makes it more boring to read. Having just the symbols with a fixed size
> is a common convention used on technical books, and helps to make easier
> to identify the symbols while reading the docs.
> 
> That's said, Sphinx doesn't have any tag to switch the font for the entire
> document. All it can be done is to define a CSS and apply it for the
> doc - or to place everything within a code-block, with will suppress all
> markup tags, including cross-references for functions.

Ok, got it.

> The problem with CSS is that you need to write both an html CSS file
> and add LaTeX macros associated to this "CSS style" (technically, LaTeX
> doesn't have a CSS concept, but Sphinx emulates it).

Yeah I don't think we want to do CSS here. So the correct thing to do would
be to place all fixed-width things within double backticks, if someone had
the time to do it. I am currently spending time understanding the document's
content itself..

thanks for the effort, it could probably serve as a good future reference,

 - Joel

