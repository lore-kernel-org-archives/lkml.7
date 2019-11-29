Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA723C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 16:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD7A215A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 16:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu/PTTJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfK2QGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 11:06:37 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46762 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfK2QGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 11:06:37 -0500
Received: by mail-qk1-f193.google.com with SMTP id f5so7570449qkm.13;
        Fri, 29 Nov 2019 08:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lswTy8CDyXoHMJEPWDy2g5xoPSWC4ZeBNwS6aUi4On4=;
        b=lu/PTTJE8sUl2Dz8t5OG78DIkGuJQtLY3kZYFwh+Lm+rSy//GkiFQjS93ujLlMvKQo
         eKZTek8PEo4wgGYHBgv5+aX23fWkkehEzbDp0ka6lRdmDIE1qThsHEVt/7QFcJMHTmTc
         nV+riXxvCgL9h+pftPAYvLEzcn6VxJ/gJsJgujelN7yi2lVl9qvhOHB8l4l7Xzgdfshk
         I+OCvFWXqInsnfbCG7d4/xwVCD4K1OgTFmSd9OObAIUK7d/A0s/sGhgpySEIza4LTYEB
         ok1KCMp+rB3mTNFKwB1HTVGe0zNScmYJTbRFbNqhnKSZHdFEZVzAsjvmHCDgtWbDKTJr
         qzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lswTy8CDyXoHMJEPWDy2g5xoPSWC4ZeBNwS6aUi4On4=;
        b=BrkWaapBiOX8LMrAcd4sQMSXcswu/S2BXf5Zu7PaHD9wq6Hthj/FvFP8gckNQDampM
         cvticAzH2KDxvypriVYYhxLpccsVLGwSBreWS9QbgIepA8RuUnD0C2OaIvh/RCNmd+Ql
         W7W8EvueZawebjuzmaPwQVN00CPqzRbkTxiGkEAX5TyviBsxApUkaw3e3J1bYF20GKvn
         4NcpIYGGULUngcd2e41z46ICF/RNeWIrRlpxWtZXwummKVmKvuf7y3ca82xQ72jhev/X
         m4vFABSCsoceB2L5ARmuk+J6elnqEJzgzWg/1QTc91J1s1fHfvcCzd4kxXDci0/3ZJgq
         Xwsg==
X-Gm-Message-State: APjAAAXYPU1yI0YqxVvtoqp9BLYsiw5NQJSdmvWM6066qko1nzg//8dK
        gGac7f6RIoZUKxx4ew81DAQ=
X-Google-Smtp-Source: APXvYqwyK2uzu6UCjV840vIktSrWARLo905uWNPjHKV1eqheWngFMch3i3xeFGtL3v3/85oRpgke4g==
X-Received: by 2002:a37:e30b:: with SMTP id y11mr17288014qki.12.1575043594345;
        Fri, 29 Nov 2019 08:06:34 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id z7sm12038176qth.85.2019.11.29.08.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 08:06:33 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 45A3C405B6; Fri, 29 Nov 2019 13:06:31 -0300 (-03)
Date:   Fri, 29 Nov 2019 13:06:31 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 04/15] perf tools: Add map_groups to 'struct
 addr_location'
Message-ID: <20191129160631.GD26963@kernel.org>
References: <20191112183757.28660-1-acme@kernel.org>
 <20191112183757.28660-5-acme@kernel.org>
 <20191129134056.GE14169@krava>
 <20191129151733.GC26963@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129151733.GC26963@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 29, 2019 at 12:17:33PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Nov 29, 2019 at 02:40:56PM +0100, Jiri Olsa escreveu:
> > > +++ b/tools/perf/util/callchain.c
> > > @@ -1119,8 +1119,8 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
> > >  			goto out;
> > >  	}
> > >  
> > > -	if (al->map->groups == &al->machine->kmaps) {
> > > -		if (machine__is_host(al->machine)) {
> > > +	if (al->mg == &al->mg->machine->kmaps) {

> > heya, I'm getting segfault because of this change

> > perf record --call-graph dwarf ./ex

> > 	(gdb) r report --stdio
> > 	Program received signal SIGSEGV, Segmentation fault.
> > 	fill_callchain_info (al=0x7fffffffa1b0, node=0xcd2bd0, hide_unresolved=false) at util/callchain.c:1122
> > 	1122            if (al->maps == &al->maps->machine->kmaps) {
> > 	(gdb) p al->maps
> > 	$1 = (struct maps *) 0x0

> > I wish all those map changes would go through some review,
> > I have no idea how the code works now ;-)

> ouch, I did tons of tests, obviously some more, and reviewing, would
> catch these, my bad, will try and fix this...

> And yeah, I reproduced the problem, working on a fix.

Can you try with this one-liner?

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 416d174d223c..c8c5410315e8 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2446,6 +2446,7 @@ static int append_inlines(struct callchain_cursor *cursor, struct map_symbol *ms
 
 	list_for_each_entry(ilist, &inline_node->val, list) {
 		struct map_symbol ilist_ms = {
+			.maps = ms->maps,
 			.map = map,
 			.sym = ilist->symbol,
 		};
