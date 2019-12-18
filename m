Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C398C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A372146E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcRYSrFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfLROIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:08:38 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43471 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfLROIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:08:37 -0500
Received: by mail-pf1-f195.google.com with SMTP id x6so190910pfo.10;
        Wed, 18 Dec 2019 06:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cxSdk9UJsEr3lAANbH2coKYFIZBC8JxUrWKkWgdn3kQ=;
        b=HcRYSrFMWc6OKi/4GDsCfUjcmQelKnE9b419wSEA4CtCLwKE/KR3Enjmz7V/rXj81+
         s9gh3SzmPClnn4VTGTehGVmdLoG88+g9WBSA3IcUC3I6d7nbHlMBqLcylHpEH9OPi7uw
         J/fsg1dnts0UgeFQurRmn914pIZxllHvYXZW6O5WN9PUEbnc0GyCT2D7d2oWEt3dtS2m
         XBiNs2UDix8vDNfysHl91x7IpS9u9LBQPRbz56qe9je1+4j+RtNRSwD38uB+ecx/FDVn
         QA4lFZZ5eEwHILWHHzaz/f0hIbxo5UAS2xOfcUBYXcY1/Tm+4ZAwoawNe0oscSoZJvhy
         rAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cxSdk9UJsEr3lAANbH2coKYFIZBC8JxUrWKkWgdn3kQ=;
        b=BTprwaNYzjbmy3086ngpEcCBtVu20UT6MeDMCYSc/i88KhDzK97QWEnHO2tMv/hGK9
         fOr3jpFP+YJon1Txef+JuyAC8ij5j8+REoEVz75ZdnkLeUC0/UhTMVbOXmeSh2017P4N
         tj6T8YJlw55AZywDMgKcijPad01RIMO+XCPU0BoFvFLztNvIB9wD5VuczMFjagf8Skzx
         FwzGQCooGnXOQ3qcEDt078+8BxvXyyi8lsSgxCwgpM3SlscTZ/0rQAc3Py8B0qPbFpxH
         CqFDhWami2cR3nIqOP/bZfUNnPGCXmcrAPV95wOD4DkbyUChhfBBOWHFrhA1VelYKpIM
         bMRg==
X-Gm-Message-State: APjAAAXzynhpz1n9h/dHMumvsYAe6FxVlfC3nzPxjWKq1DjVX+YJBYQz
        SElkSvlpuujQbNvnA+54D+k=
X-Google-Smtp-Source: APXvYqxpi3nApN665oMRs8YN9qLNLPkz3x3ANJyx3JwOmevY77s+kPTOnvW6D6kUqDKxBl9pWuQb2g==
X-Received: by 2002:a62:3892:: with SMTP id f140mr3177996pfa.190.1576678116268;
        Wed, 18 Dec 2019 06:08:36 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id f8sm3082032pjg.28.2019.12.18.06.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 06:08:34 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EE54040352; Wed, 18 Dec 2019 11:08:31 -0300 (-03)
Date:   Wed, 18 Dec 2019 11:08:31 -0300
To:     Jiri Olsa <jolsa@redhat.com>
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
Message-ID: <20191218140831.GC13395@kernel.org>
References: <20191217144828.2460-1-acme@kernel.org>
 <20191217144828.2460-8-acme@kernel.org>
 <20191218080818.GD19062@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218080818.GD19062@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 18, 2019 at 09:08:18AM +0100, Jiri Olsa escreveu:
> On Tue, Dec 17, 2019 at 11:48:23AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> > diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> > index 6dfdd8d5a743..3b7af5a8d101 100644
> > --- a/tools/perf/ui/browsers/hists.c
> > +++ b/tools/perf/ui/browsers/hists.c
> > @@ -673,9 +673,8 @@ static int hist_browser__title(struct hist_browser *browser, char *bf, size_t si
> >  }
> >  
> >  int hist_browser__run(struct hist_browser *browser, const char *help,
> > -		      bool warn_lost_event)
> > +		      bool warn_lost_event, int key)
> >  {
> > -	int key;
> >  	char title[160];
> >  	struct hist_browser_timer *hbt = browser->hbt;
> >  	int delay_secs = hbt ? hbt->refresh : 0;
> > @@ -688,9 +687,12 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
> >  	if (ui_browser__show(&browser->b, title, "%s", help) < 0)
> >  		return -1;
> >  
> > +	if (key)
> > +		goto do_hotkey;
> > +
> >  	while (1) {
> >  		key = ui_browser__run(&browser->b, delay_secs);
> > -
> > +do_hotkey:
> 
> or we could switch the 'swtich' and ui_browser__run, and get rid of the goto, like:
> 
> 	while (1) {
>   		switch (key) {
> 		...
> 		}
> 
> 		key = ui_browser__run(&browser->b, delay_secs);
> 	}

I think those are equivalent and having the test like I did is more
clear, i.e. "has this key been provided" instead of going to the switch
just to hit the default case for the zero in key and call
ui_browser__run().

- Arnaldo
 
> jirka
> 
> >  		switch (key) {
> >  		case K_TIMER: {
> >  			u64 nr_entries;
> > @@ -2994,8 +2996,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
> >  
> >  		nr_options = 0;
> >  
> > -		key = hist_browser__run(browser, helpline,
> > -					warn_lost_event);
> > +		key = hist_browser__run(browser, helpline, warn_lost_event, 0);
> >  
> >  		if (browser->he_selection != NULL) {
> >  			thread = hist_browser__selected_thread(browser);
> > @@ -3573,7 +3574,7 @@ int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
> >  	memset(&action, 0, sizeof(action));
> >  
> >  	while (1) {
> > -		key = hist_browser__run(browser, "? - help", true);
> > +		key = hist_browser__run(browser, "? - help", true, 0);
> >  
> >  		switch (key) {
> >  		case 'q':
> > diff --git a/tools/perf/ui/browsers/hists.h b/tools/perf/ui/browsers/hists.h
> > index 078f2f2c7abd..1e938d9ffa5e 100644
> > --- a/tools/perf/ui/browsers/hists.h
> > +++ b/tools/perf/ui/browsers/hists.h
> > @@ -34,7 +34,7 @@ struct hist_browser {
> >  struct hist_browser *hist_browser__new(struct hists *hists);
> >  void hist_browser__delete(struct hist_browser *browser);
> >  int hist_browser__run(struct hist_browser *browser, const char *help,
> > -		      bool warn_lost_event);
> > +		      bool warn_lost_event, int key);
> >  void hist_browser__init(struct hist_browser *browser,
> >  			struct hists *hists);
> >  #endif /* _PERF_UI_BROWSER_HISTS_H_ */
> > -- 
> > 2.21.0
> > 

-- 

- Arnaldo
