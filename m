Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C1AC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617082053B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkUpi6g/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbfHZOIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 10:08:00 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43997 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731206AbfHZOH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 10:07:59 -0400
Received: by mail-qt1-f196.google.com with SMTP id b11so17927314qtp.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 07:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=32F2PlmYkgb1muHslquiA4mPzLRCcQAuASi3sPwh5v0=;
        b=gkUpi6g/GHTJ2qBHj+K8LDoxhTHpFAawBxnxK1+UCsAYzzJU7OGVkI0x8aAIsFBqYb
         JJtjHf/2EZ0vMM4teA5PtUj1MnLdBdEvvXLnbCXyj8m3bjgi/Iux+8JNRQRggUOMfA0B
         A40+JuUvtI33L5kifRhjwhmroWSvzz+Ke1fInHPTRFrZTP4QYiabAzhCDqkQxLrMH6gX
         1MgjHb9wxPDCO424QFFMsU1HmzYeTZ3ez+VneFPaKzAjWpH5feqyJsltWgTDHggRXwAR
         uJ5kvngmIRzleuE1vZgrHZgMevAjL9XKi/0t8HStgV0VEzpmPbabOeIlwLB12+w82Mev
         0GwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=32F2PlmYkgb1muHslquiA4mPzLRCcQAuASi3sPwh5v0=;
        b=aMDdtzlmkl+2r4kjSAlZqpMfLLjtr9eH/LW8zVGcUga+JVSMKDC+5/a106bhlJVihK
         +wBbOhTC1T0prlaU7wnn47LL2t4Y+pE5DI8QpPXDipBXgwUdbOcKUCekZ0RHR4/g810H
         U7PF54GPr4yTpI48Vrd9DoKv3+f0QHrGgsXpviJpzvHJXerpwesbFzHExsmZXu0Kl+Jv
         t+CZdPx5eif8RvZB/lKkPvVag4XaCUHvzV8O7i5nZwM5ah1DlGe7AnsWf7WhtcWu0JXJ
         y8b1DEMJOQHeQ/uL7UQAXkjl7+M+PpUYVqXo0vfmifIHCO3AFCghae59o8IoEa7Y+H7q
         0UEQ==
X-Gm-Message-State: APjAAAXqyIEDuarBp+h+//5NW5ddnJwOlYxGMnKP2c1cJovY+YCHBDu5
        AldtJWHGyPefngoBCMlueTc=
X-Google-Smtp-Source: APXvYqx62m2TQO7FNqvvZeWblm0ug1xZHwhkCcAfeTpI2H/XE0rFw274QbMqbnicnl4hDD5PT3/qwg==
X-Received: by 2002:ac8:2914:: with SMTP id y20mr17916656qty.150.1566828478905;
        Mon, 26 Aug 2019 07:07:58 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id v7sm6306839qte.86.2019.08.26.07.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 07:07:57 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 33B3E40916; Mon, 26 Aug 2019 11:07:55 -0300 (-03)
Date:   Mon, 26 Aug 2019 11:07:55 -0300
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script: Fix memory leaks in list_scripts()
Message-ID: <20190826140755.GC24801@kernel.org>
References: <20190408162748.GA21008@embeddedor>
 <567a492a-08fd-7580-24fa-b07a1ebf532e@embeddedor.com>
 <da724a58-56f3-e68a-c1db-6e9cb1ee8155@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da724a58-56f3-e68a-c1db-6e9cb1ee8155@embeddedor.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Aug 25, 2019 at 11:06:25PM -0500, Gustavo A. R. Silva escreveu:
> Hi all,
> 
> Friendly ping (second one after 4 months):
> 
> Who can take this?

Sorry for the delay, finally applied, thanks!

- Arnaldo
 
> Thanks
> --
> Gustavo
> 
> On 4/22/19 10:14 AM, Gustavo A. R. Silva wrote:
> > Hi all,
> > 
> > Friendly ping:
> > 
> > Who can take this?
> > 
> > Thanks
> > 
> > On 4/8/19 11:27 AM, Gustavo A. R. Silva wrote:
> >> In case memory resources for *buf* and *paths* were allocated,
> >> jump to *out* and release them before return.
> >>
> >> Addresses-Coverity-ID: 1444328 ("Resource leak")
> >> Fixes: 6f3da20e151f ("perf report: Support builtin perf script in scripts menu")
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >> ---
> >>  tools/perf/ui/browsers/scripts.c | 6 ++++--
> >>  1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
> >> index 27cf3ab88d13..f4edb18f67ec 100644
> >> --- a/tools/perf/ui/browsers/scripts.c
> >> +++ b/tools/perf/ui/browsers/scripts.c
> >> @@ -131,8 +131,10 @@ static int list_scripts(char *script_name, bool *custom,
> >>  		int key = ui_browser__input_window("perf script command",
> >>  				"Enter perf script command line (without perf script prefix)",
> >>  				script_args, "", 0);
> >> -		if (key != K_ENTER)
> >> -			return -1;
> >> +		if (key != K_ENTER) {
> >> +			ret = -1;
> >> +			goto out;
> >> +		}
> >>  		sprintf(script_name, "%s script %s", perf, script_args);
> >>  	} else if (choice < num + max_std) {
> >>  		strcpy(script_name, paths[choice]);
> >>

-- 

- Arnaldo
