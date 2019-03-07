Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08088C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA8582064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 16:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="YIVLXneV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfCGQ5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 11:57:47 -0500
Received: from one.firstfloor.org ([193.170.194.197]:50030 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCGQ5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 11:57:47 -0500
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 8413A86862; Thu,  7 Mar 2019 17:57:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1551977865;
        bh=GVRsn4ZDA8IKDSiK9W8F4bMbrba09R26fN8V7lTmIDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YIVLXneVYxTIFZbmY+muGCDElCBnUn9B2F9O89RtWsgq/NoqMSpe5HpBkTyOdRLiK
         7npt+mbcGT5ySWj1fbNEqzOXMSHuOupvkpXOH75cnuuMW2omSZkmpmKyNPQeWqZ03+
         lTXMA/c1v4m3gbWmhsVL8aGNdJHKApUYYTEDNqpY=
Date:   Thu, 7 Mar 2019 08:57:45 -0800
From:   Andi Kleen <andi@firstfloor.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: Support sample context in perf report
Message-ID: <20190307165745.wtrhawl3mh2glyxu@two.firstfloor.org>
References: <20190305144758.12397-1-andi@firstfloor.org>
 <20190307105743.GA8979@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307105743.GA8979@krava>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 11:57:43AM +0100, Jiri Olsa wrote:
> On Tue, Mar 05, 2019 at 06:47:43AM -0800, Andi Kleen wrote:
> > [Changes: 
> > v4:
> > Address review comments. 
> > Fix --cpu filtering.
> > Fix a sampling bug.
> > Add support for configuring custom script menu entries in perfconfig.
> > Fix display of more samples than fit on screen.
> > Fix some buffer overruns in legacy code.
> > Add more tips
> 
> hi,
> getting gcc error on your branch, similar like last time:

Okay I figured out now why I'm not seeing this. It's because my perf
builds are with DEBUG=1, and Makefile.config has this insanity:

ifeq ($(DEBUG),0)
  ifeq ($(feature-fortify-source), 1)
      CFLAGS += -D_FORTIFY_SOURCE=2
  endif
endif

Anyways the warnings are false positives because the strings can never
be that big. In fact I think they're harmful because it discourages
adding safety margins to stack buffers.

Anyways you can use this patch as a workaround.

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 364f5c577d00..3e795bd1279d 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2554,7 +2554,7 @@ do_run_script(struct hist_browser *browser __maybe_unused,
 	}
 
 	if (act->time) {
-		char start[64], end[64];
+		char start[32], end[32];
 		unsigned long starttime = act->time;
 		unsigned long endtime = act->time + symbol_conf.time_quantum;
 
