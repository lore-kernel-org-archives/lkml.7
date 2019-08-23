Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BF8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 20:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58B921874
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 20:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="NO4fkVwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392531AbfHWUmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 16:42:51 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:40762 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388903AbfHWUmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 16:42:51 -0400
Received: by mail-qt1-f182.google.com with SMTP id g4so2645029qtq.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 13:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Gczk+EJ8LxiAJI5OXwLa8ocoZrZoy01MrH8K/Y4PQHo=;
        b=NO4fkVwyZOzQ/jSY0fP4yNcBFegJIfr7DOj3i3cPTHYzoRZTwyuWBpEa98d2K9BeU1
         w9TLAVPgZ67+NSAnmOobUyVFk4m5rb+6gmKOAmRXM4PC4hQ2D3uxHt3ndHkhZR62ZCLt
         K4EaZD22/3qIqn5pd3RsjcXmQRRWVDdHlyAa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Gczk+EJ8LxiAJI5OXwLa8ocoZrZoy01MrH8K/Y4PQHo=;
        b=UGUYPLJAHxlHJ6iW1QOuaKCiQJ4yvD2K7p5EQD3ur4waJ1C2cXrIkU1OTIyUO9zKN1
         Pxx2fDy4FEmXjDWcKRstAnf89Z7XKFjEf/We/y5RCucB2Vnq/rhvnBDAV5mBnFqIkT5Q
         A6cGEqXA5qH9qcB/joqsJvoPU/dgwqrshL9+nFQeRM5kX4fvKA+W64NUIczksC3xHtG2
         dM9gRrW3FoE0bjo5Eehr5EJlkIdUNOlTmvbAWNyR61ZGgZSKEROVkp2fxJ/+ZUPzve5k
         /1XIsozlIYhqdlbDp5OCVIMSyZT1z+Obte9/aVifeFlL9MY4P/2fYg2stsjX8IoxLUcl
         CrXA==
X-Gm-Message-State: APjAAAU8U23hFpyqtvNEdPOsNxCrhsq5OTeXBrZ9uSVF58eCilB39tww
        hROw9IDAZskEeZgje9LhXKzyOQ==
X-Google-Smtp-Source: APXvYqytAYNNbcRat+bBg8hwTH66h+K38k0PAtCbhOGXrxMnRHXuaSiJ+xe4YsFGfUxUv3X9Wkfv8g==
X-Received: by 2002:ac8:739a:: with SMTP id t26mr6718674qtp.65.1566592970244;
        Fri, 23 Aug 2019 13:42:50 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id e7sm1664614qtp.91.2019.08.23.13.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 13:42:49 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Fri, 23 Aug 2019 16:42:47 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
cc:     Vince Weaver <vincent.weaver@maine.edu>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [patch] perf tool buffer overflow in
 perf_header__read_build_ids
In-Reply-To: <20190726190541.GC20482@kernel.org>
Message-ID: <alpine.DEB.2.21.1908231641170.7106@macbook-air>
References: <alpine.DEB.2.21.1907231100440.14532@macbook-air> <alpine.DEB.2.21.1907231639120.14532@macbook-air> <20190726190541.GC20482@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019, Arnaldo Carvalho de Melo wrote:

> Em Tue, Jul 23, 2019 at 04:42:30PM -0400, Vince Weaver escreveu:
> > my perf_tool_fuzzer has found another issue, this one a buffer overflow
> > in perf_header__read_build_ids.  The build id filename is read in with a 
> > filename length read from the perf.data file, but this can be longer than
> > PATH_MAX which will smash the stack.
> > 
> > This might not be the right fix, not sure if filename should be NUL
> > terminated or not.
> > 
> > Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>
> > 
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index c24db7f4909c..9a893a26e678 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -2001,6 +2001,9 @@ static int perf_header__read_build_ids(struct perf_header *header,
> >  			perf_event_header__bswap(&bev.header);
> >  
> >  		len = bev.header.size - sizeof(bev);
> > +
> > +		if (len>PATH_MAX) len=PATH_MAX;
> > +
> 
> Humm, I wonder if we shouldn't just declare the whole file invalid like
> you did with the previous patch?
> 
> - Arnaldo
> 
> >  		if (readn(input, filename, len) != len)
> >  			goto out;
> >  		/*
 
did we ever decide how to fix this issue?  Or were you waiting on a 
followup patch from me?

This is actually an exploitable security bug if you can convince someone 
to run "perf" on an untrusted perf.data file.

Vince
