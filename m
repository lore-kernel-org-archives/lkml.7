Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D63EC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5239721951
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsTHX61J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfGXPmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:42:07 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40815 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfGXPmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:42:07 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so45910591qtn.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 08:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vVyZTG8u3gaswKVijwL4UC2Gmmd6ViElRBT/CwEJHWs=;
        b=CsTHX61J1VqWOm3LtgLKci72XeuqSHm8DYkKn5FmDP52JsYVg46ssWOeh9wxkcOxuR
         zHkb2aAMqj05AaQx7CESFPDQodufHgtNcj2q2+nZfE+/fjwzEaurp0WBFNm7ul1BtuOx
         f3Umyq+5xRWvJ528Cm2bbcrESz7bDtOwYmLPwuTEcFIXKZbaVbV35yZgA3Cj1nSfxhW/
         Wjt4sLWO0rTLvcMQsNRl9n8ZnjoLI93jhOq8qmfQc/VmnvzYBjDXa1Q9z91vGXm4cJAW
         QHWASdQZwumQ1r1GhFJntNtDQDKp0Oue9xHTYSMfqqvVJK2H0dK+HhosnrA7e3jABxi5
         8Q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vVyZTG8u3gaswKVijwL4UC2Gmmd6ViElRBT/CwEJHWs=;
        b=F9fBf3nur6gF7y4d5yz0/PKVqgytdMU44uq790iJNwibKzV5br6pHdLw2yZ/DsNc8V
         UpGlecg3fVnabK7IKWtcDR4xn+2myiVhIDK/mMl5cTBdsXeAAWjHXa6aKGzCwjNMTtma
         W+9a+Eusb33N+WBa30Yn7AWjD3Kr5QMw8AYC5EBdh2pkmx6OTp+oIBqO2WXAJQK5Ofgr
         cI2K/AqqrtfWFAgcLHC6o0sG4uHtdjFXO8SJWl6C2NF/Pf0z/IVrnpoTIobws7UewuOt
         rf9B+9CHrg4sLrvtkUxBrBX3tnYuEf0eLD+rKZPYxRvAc6FTsI4VaChjBj7UXDFbbJQu
         VRMg==
X-Gm-Message-State: APjAAAXxYoeorFyEWpf4Hq6+vzaj5G5Qq+gcMFxFomGWJWYQhOZnUmwB
        +U0QcELhbodzDIcSN+Ht+pg=
X-Google-Smtp-Source: APXvYqwTr7SlrxkT6/pdY7vyb/4oZLjuZrnx8/WncwtFgKWL/QU18AgmouXt+jIc1vPsxbyRsDobVg==
X-Received: by 2002:a0c:bd1f:: with SMTP id m31mr59859553qvg.54.1563982926018;
        Wed, 24 Jul 2019 08:42:06 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id q3sm20872509qkq.133.2019.07.24.08.42.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 08:42:05 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 77A0740340; Wed, 24 Jul 2019 12:42:02 -0300 (-03)
Date:   Wed, 24 Jul 2019 12:42:02 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 47/79] libperf: Add perf_evlist__for_each_evsel macro
Message-ID: <20190724154202.GD5727@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <20190721112506.12306-48-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721112506.12306-48-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 21, 2019 at 01:24:34PM +0200, Jiri Olsa escreveu:
> Adding perf_evlist__for_each_evsel macro to iterate
> perf_evsel objects in evlist.
> 
> Adding perf_evlist__next function to do that.

Replaced the above line in the cset commit log with:

    Introduce the perf_evlist__next() function to do that without exposing
    'struct perf_evlist' internals.

 
> Link: http://lkml.kernel.org/n/tip-usi0zxyxmai1ld94nrbum43i@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/lib/evlist.c              | 20 ++++++++++++++++++++
>  tools/perf/lib/include/perf/evlist.h |  7 +++++++
>  tools/perf/lib/libperf.map           |  1 +
>  3 files changed, 28 insertions(+)
> 
> diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
> index 0517deb4cb1c..8c26ebf290f0 100644
> --- a/tools/perf/lib/evlist.c
> +++ b/tools/perf/lib/evlist.c
> @@ -34,3 +34,23 @@ struct perf_evlist *perf_evlist__new(void)
>  
>  	return evlist;
>  }
> +
> +struct perf_evsel*
> +perf_evlist__next(struct perf_evlist *evlist, struct perf_evsel *prev)
> +{
> +	struct perf_evsel *next;
> +
> +	if (!prev) {
> +		next = list_first_entry(&evlist->entries,
> +					struct perf_evsel,
> +					node);
> +	} else {
> +		next = list_next_entry(prev, node);
> +	}
> +
> +	/* Empty list is noticed here so don't need checking on entry. */
> +	if (&next->node == &evlist->entries)
> +		return NULL;
> +
> +	return next;
> +}
> diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
> index 7255a60869a1..5092b622935b 100644
> --- a/tools/perf/lib/include/perf/evlist.h
> +++ b/tools/perf/lib/include/perf/evlist.h
> @@ -13,5 +13,12 @@ LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
>  LIBPERF_API void perf_evlist__remove(struct perf_evlist *evlist,
>  				     struct perf_evsel *evsel);
>  LIBPERF_API struct perf_evlist *perf_evlist__new(void);
> +LIBPERF_API struct perf_evsel* perf_evlist__next(struct perf_evlist *evlist,
> +						 struct perf_evsel *evsel);
> +
> +#define perf_evlist__for_each_evsel(evlist, pos)	\
> +	for ((pos) = perf_evlist__next((evlist), NULL);	\
> +	     (pos) != NULL;				\
> +	     (pos) = perf_evlist__next((evlist), (pos)))
>  
>  #endif /* __LIBPERF_EVLIST_H */
> diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
> index e3eac9b60726..c0968226f7b6 100644
> --- a/tools/perf/lib/libperf.map
> +++ b/tools/perf/lib/libperf.map
> @@ -17,6 +17,7 @@ LIBPERF_0.0.1 {
>  		perf_evlist__init;
>  		perf_evlist__add;
>  		perf_evlist__remove;
> +		perf_evlist__next;
>  	local:
>  		*;
>  };
> -- 
> 2.21.0

-- 

- Arnaldo
