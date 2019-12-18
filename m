Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CE6C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B472E21582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLfkBhvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfLROXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:23:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32846 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726856AbfLROXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:23:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576679010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F8DAOnka08/eWgaxUayF0MAJKUEDXSpMRv4M3rbs3l4=;
        b=bLfkBhvMsuS8sApzu+Uq6c4Fc5fTkD6blD4nYKcSyK0x0yjT0gZabv9mG3rAUOAmgUnpMo
        Uc0kQ8IwjehoTEgpNvoM31VlbKHIyZuXhpTx9FFUSHlDS+PzN85ZFXOajWpZ7gNJZcrnh6
        P5r7bS//q26ZyuCoM6vRKkIvFReeOC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-8mOqFvCoPRulkvAwBskqVg-1; Wed, 18 Dec 2019 09:23:28 -0500
X-MC-Unique: 8mOqFvCoPRulkvAwBskqVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E34B102312A;
        Wed, 18 Dec 2019 14:23:26 +0000 (UTC)
Received: from krava (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0833F6888E;
        Wed, 18 Dec 2019 14:23:23 +0000 (UTC)
Date:   Wed, 18 Dec 2019 15:23:21 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 07/12] perf hists browser: Allow passing an initial hotkey
Message-ID: <20191218142321.GB15571@krava>
References: <20191217144828.2460-1-acme@kernel.org>
 <20191217144828.2460-8-acme@kernel.org>
 <20191218080818.GD19062@krava>
 <20191218140831.GC13395@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218140831.GC13395@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 11:08:31AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Dec 18, 2019 at 09:08:18AM +0100, Jiri Olsa escreveu:
> > On Tue, Dec 17, 2019 at 11:48:23AM -0300, Arnaldo Carvalho de Melo wrote:
> > 
> > SNIP
> > 
> > > diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> > > index 6dfdd8d5a743..3b7af5a8d101 100644
> > > --- a/tools/perf/ui/browsers/hists.c
> > > +++ b/tools/perf/ui/browsers/hists.c
> > > @@ -673,9 +673,8 @@ static int hist_browser__title(struct hist_browser *browser, char *bf, size_t si
> > >  }
> > >  
> > >  int hist_browser__run(struct hist_browser *browser, const char *help,
> > > -		      bool warn_lost_event)
> > > +		      bool warn_lost_event, int key)
> > >  {
> > > -	int key;
> > >  	char title[160];
> > >  	struct hist_browser_timer *hbt = browser->hbt;
> > >  	int delay_secs = hbt ? hbt->refresh : 0;
> > > @@ -688,9 +687,12 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
> > >  	if (ui_browser__show(&browser->b, title, "%s", help) < 0)
> > >  		return -1;
> > >  
> > > +	if (key)
> > > +		goto do_hotkey;
> > > +
> > >  	while (1) {
> > >  		key = ui_browser__run(&browser->b, delay_secs);
> > > -
> > > +do_hotkey:
> > 
> > or we could switch the 'swtich' and ui_browser__run, and get rid of the goto, like:
> > 
> > 	while (1) {
> >   		switch (key) {
> > 		...
> > 		}
> > 
> > 		key = ui_browser__run(&browser->b, delay_secs);
> > 	}
> 
> I think those are equivalent and having the test like I did is more
> clear, i.e. "has this key been provided" instead of going to the switch
> just to hit the default case for the zero in key and call
> ui_browser__run().

sure, I just don't like goto other than for error handling,
looks too hacky to me ;-) but of course it's your call

jirka

