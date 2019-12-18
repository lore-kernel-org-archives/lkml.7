Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D0DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A213227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 08:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GV5lPp0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfLRIIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 03:08:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29013 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725785AbfLRIIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 03:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576656510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kgdz98YZUzIua8aHMy/73rYhdQyi6vDcrXFzQmk+EDY=;
        b=GV5lPp0iz9bZuQN//Liv+sBnQ8JU9hBt7xlL1jdzVr59Fj0HI5cP/Zpej9SBfb2iwnZkQ8
        aSumOsb44vG9DYt24xYJ8QnxHG96Qu0To8YnDaOGgrjwpyUZ7KlI+2vzZJEqxIfSGgfCdU
        ymPNQ3e1QmD+2akhS9QaFbW2E1FwTQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-ZT2b0FKHMVehS5dyysqrow-1; Wed, 18 Dec 2019 03:08:26 -0500
X-MC-Unique: ZT2b0FKHMVehS5dyysqrow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7738107ACE6;
        Wed, 18 Dec 2019 08:08:24 +0000 (UTC)
Received: from krava (ovpn-204-177.brq.redhat.com [10.40.204.177])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19C015D9E5;
        Wed, 18 Dec 2019 08:08:20 +0000 (UTC)
Date:   Wed, 18 Dec 2019 09:08:18 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <20191218080818.GD19062@krava>
References: <20191217144828.2460-1-acme@kernel.org>
 <20191217144828.2460-8-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217144828.2460-8-acme@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:48:23AM -0300, Arnaldo Carvalho de Melo wrote:

SNIP

> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index 6dfdd8d5a743..3b7af5a8d101 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -673,9 +673,8 @@ static int hist_browser__title(struct hist_browser *browser, char *bf, size_t si
>  }
>  
>  int hist_browser__run(struct hist_browser *browser, const char *help,
> -		      bool warn_lost_event)
> +		      bool warn_lost_event, int key)
>  {
> -	int key;
>  	char title[160];
>  	struct hist_browser_timer *hbt = browser->hbt;
>  	int delay_secs = hbt ? hbt->refresh : 0;
> @@ -688,9 +687,12 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
>  	if (ui_browser__show(&browser->b, title, "%s", help) < 0)
>  		return -1;
>  
> +	if (key)
> +		goto do_hotkey;
> +
>  	while (1) {
>  		key = ui_browser__run(&browser->b, delay_secs);
> -
> +do_hotkey:

or we could switch the 'swtich' and ui_browser__run, and get rid of the goto, like:

	while (1) {
  		switch (key) {
		...
		}

		key = ui_browser__run(&browser->b, delay_secs);
	}

jirka

>  		switch (key) {
>  		case K_TIMER: {
>  			u64 nr_entries;
> @@ -2994,8 +2996,7 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
>  
>  		nr_options = 0;
>  
> -		key = hist_browser__run(browser, helpline,
> -					warn_lost_event);
> +		key = hist_browser__run(browser, helpline, warn_lost_event, 0);
>  
>  		if (browser->he_selection != NULL) {
>  			thread = hist_browser__selected_thread(browser);
> @@ -3573,7 +3574,7 @@ int block_hists_tui_browse(struct block_hist *bh, struct evsel *evsel,
>  	memset(&action, 0, sizeof(action));
>  
>  	while (1) {
> -		key = hist_browser__run(browser, "? - help", true);
> +		key = hist_browser__run(browser, "? - help", true, 0);
>  
>  		switch (key) {
>  		case 'q':
> diff --git a/tools/perf/ui/browsers/hists.h b/tools/perf/ui/browsers/hists.h
> index 078f2f2c7abd..1e938d9ffa5e 100644
> --- a/tools/perf/ui/browsers/hists.h
> +++ b/tools/perf/ui/browsers/hists.h
> @@ -34,7 +34,7 @@ struct hist_browser {
>  struct hist_browser *hist_browser__new(struct hists *hists);
>  void hist_browser__delete(struct hist_browser *browser);
>  int hist_browser__run(struct hist_browser *browser, const char *help,
> -		      bool warn_lost_event);
> +		      bool warn_lost_event, int key);
>  void hist_browser__init(struct hist_browser *browser,
>  			struct hists *hists);
>  #endif /* _PERF_UI_BROWSER_HISTS_H_ */
> -- 
> 2.21.0
> 

