Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621A2C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324192067C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENtro1j+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfLSVoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:44:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29237 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727105AbfLSVoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 16:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576791877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jb+1TKkOTFzUUbC+u4I7+JV/0cWuAZT7ftqKW8glD68=;
        b=ENtro1j+NpNo742tlcZUz6gPJtNjSOjjcduwmpTXF+6QZnnKRUrorV0x7N4n9HmRQhGsUD
        XqvpdTxk0yi0i7WFBBV1MEhkSiLeoFTkrK9JSrKX96SwMUCFXju6MRyTNoERiPBsrKq/xe
        7Zh9nf8ajoul/XtXDspKV2dlvRPcEpI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-FIegl3ayOfayCSpwsdyYbQ-1; Thu, 19 Dec 2019 16:44:34 -0500
X-MC-Unique: FIegl3ayOfayCSpwsdyYbQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B611100550E;
        Thu, 19 Dec 2019 21:44:32 +0000 (UTC)
Received: from krava (ovpn-204-20.brq.redhat.com [10.40.204.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 470ED6940B;
        Thu, 19 Dec 2019 21:44:27 +0000 (UTC)
Date:   Thu, 19 Dec 2019 22:44:24 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
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
Message-ID: <20191219214424.GB27481@krava>
References: <20191217144828.2460-1-acme@kernel.org>
 <20191217144828.2460-8-acme@kernel.org>
 <20191218080818.GD19062@krava>
 <20191218140831.GC13395@kernel.org>
 <20191218142321.GB15571@krava>
 <20191219172642.GB13699@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219172642.GB13699@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 02:26:42PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Dec 18, 2019 at 03:23:21PM +0100, Jiri Olsa escreveu:
> > On Wed, Dec 18, 2019 at 11:08:31AM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Wed, Dec 18, 2019 at 09:08:18AM +0100, Jiri Olsa escreveu:
> > > > On Tue, Dec 17, 2019 at 11:48:23AM -0300, Arnaldo Carvalho de Melo wrote:
> > > > > +	if (key)
> > > > > +		goto do_hotkey;
> > > > > +
> > > > >  	while (1) {
> > > > >  		key = ui_browser__run(&browser->b, delay_secs);
> > > > > -
> > > > > +do_hotkey:
> 
> > > > or we could switch the 'swtich' and ui_browser__run, and get rid of the goto, like:
> 
> > > > 	while (1) {
> > > >   		switch (key) {
> > > > 		...
> > > > 		}
> > > > 
> > > > 		key = ui_browser__run(&browser->b, delay_secs);
> > > > 	}
> 
> > > I think those are equivalent and having the test like I did is more
> > > clear, i.e. "has this key been provided" instead of going to the switch
> > > just to hit the default case for the zero in key and call
> > > ui_browser__run().
> 
> > sure, I just don't like goto other than for error handling,
> > looks too hacky to me ;-) but of course it's your call
> 
> How about the one below?

looks good, thanks

jirka

