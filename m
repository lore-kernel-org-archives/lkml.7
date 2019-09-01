Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE3CC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 15:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7A621897
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 15:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfIAPqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 11:46:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728934AbfIAPqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 11:46:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7F8D10F23EF;
        Sun,  1 Sep 2019 15:46:20 +0000 (UTC)
Received: from krava (ovpn-204-35.brq.redhat.com [10.40.204.35])
        by smtp.corp.redhat.com (Postfix) with SMTP id DBCFE6012E;
        Sun,  1 Sep 2019 15:46:18 +0000 (UTC)
Date:   Sun, 1 Sep 2019 17:46:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 2/4] perf tests: Fix static build test
Message-ID: <20190901154618.GA10402@krava>
References: <20190901124822.10132-1-jolsa@kernel.org>
 <20190901124822.10132-3-jolsa@kernel.org>
 <20190901151528.GM28011@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901151528.GM28011@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Sun, 01 Sep 2019 15:46:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 01, 2019 at 12:15:28PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Sep 01, 2019 at 02:48:20PM +0200, Jiri Olsa escreveu:
> > Link: http://lkml.kernel.org/n/tip-ibdgg163291sx5m5xkojx5sq@git.kernel.org
> 
> 
> Can you explain why this is needed? Wat is the problem with building
> statically with those features? What happens when one tries to do it
> that way?
> 
> I.e. what is this fixing?

sry, I have to disable VDSO and JVMTI for static build,
because they are shared libraries and just won't pass
with -static in LDFLAGS.. I wanted to throw it out,
because I'm confused that the test is passing for you
just like it is right now ;-)

I'll send out version with changelog

jirka

> 
> - Arnaldo
> 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/tests/make | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> > index 70c48475896d..17ee3facfd4d 100644
> > --- a/tools/perf/tests/make
> > +++ b/tools/perf/tests/make
> > @@ -100,7 +100,7 @@ make_install_info   := install-info
> >  make_install_pdf    := install-pdf
> >  make_install_prefix       := install prefix=/tmp/krava
> >  make_install_prefix_slash := install prefix=/tmp/krava/
> > -make_static         := LDFLAGS=-static
> > +make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_JVMTI=1
> >  
> >  # all the NO_* variable combined
> >  make_minimal        := NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1
> > -- 
> > 2.21.0
> 
> -- 
> 
> - Arnaldo
