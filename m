Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE859C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A249A2178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c640iA2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731827AbfKFN4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 08:56:48 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44801 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731661AbfKFN4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 08:56:48 -0500
Received: by mail-qk1-f196.google.com with SMTP id m16so24276111qki.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 05:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=48Z9m1+zJwu1OKLgLQ8pnYNLUMuYZRC1MbzHG2+760I=;
        b=c640iA2wZG1W4MWcgDwK9BqKpyA33NXdeWdkAHkjmY3g4FIitnzRFaBgsUApxOXGp9
         vc76yJLYgaHueeBuz0ed9OtjkSZLGI5HLFSVki4Xadz+dD0encx3bHnC9z+z0jqOm9zd
         Y7jbMQhV4YlcEsu1wcHMK4w2lbEWl5mRMI9NntSgkzELKJqvRB+nlIuVmna2iIg3Hou1
         MiY5uQN61bdb06k73PLI2EefbY5ucujS399dfkydJvHP3SPQnMKFBt3fZiWfHu6JYAuw
         obQTHMrID0/t7o9n9zzu1NPbDM6knRyEFZXuE5eJJjDY1jxCK9BU0BYhQSMHIqwBh8hE
         DA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=48Z9m1+zJwu1OKLgLQ8pnYNLUMuYZRC1MbzHG2+760I=;
        b=WFQQv4YAEocfuir6V263sfvHASjZuPpwGRJdF4onLNKNTTMXRIhNWmObRLmbqdxbDK
         YP0Rs52uxQWTUigbgRmL+8127s+PBZgcDxXA5CV5LyKURhoFFQwIH9kRAfRG8B74lU+I
         ws7aC8dxMRrsLtqft1SMQxKP8Q2Id9ecT2//0Hx06z/Z44GPeQ8Gd6n+Plz7Hw7OFLSt
         Xit/ZHFO5RMMLQINI/TDjZU21bo4NKYk3pbeZ5RjwuXKW5NVn7PhudUq+kVyiM8zOsme
         DpDsMs59d6Z/hMF3sbSnHSMDbnccV+Oc1HppE070z15qiE01e1a8XOus0fYu4YrLWE4P
         jJww==
X-Gm-Message-State: APjAAAXT/jKwpbfHc8CEXIjp1YacSy12P5AywDIeklQSG78fv+Hvp4zD
        0OceeVt/0pmOj4+YboxOTuk=
X-Google-Smtp-Source: APXvYqx/nW24CcXrKkmwr4QVtjFFZdOtbdOhfcFARcWqpsSLFuP9RRnVbdHS/ZLsW3FY5TNfcINnKQ==
X-Received: by 2002:ae9:ddc1:: with SMTP id r184mr2120459qkf.454.1573048606716;
        Wed, 06 Nov 2019 05:56:46 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id l124sm4315864qkf.122.2019.11.06.05.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 05:56:45 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E63A540B1D; Wed,  6 Nov 2019 10:56:43 -0300 (-03)
Date:   Wed, 6 Nov 2019 10:56:43 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf inject: Make --strip keep evsels
Message-ID: <20191106135643.GB3636@kernel.org>
References: <20191105100057.21465-1-adrian.hunter@intel.com>
 <20191106110352.GB30214@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106110352.GB30214@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 06, 2019 at 12:03:52PM +0100, Jiri Olsa escreveu:
> On Tue, Nov 05, 2019 at 12:00:57PM +0200, Adrian Hunter wrote:
> > create_gcov (refer to the autofdo example in
> > tools/perf/Documentation/intel-pt.txt) now needs the evsels to read the
> > perf.data file. So don't strip them.
> > 
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  tools/perf/builtin-inject.c | 54 -------------------------------------
> >  1 file changed, 54 deletions(-)
> 
> good stats ;-)

:-)
 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks, applied.
 
> thanks,
> jirka
> 
> > 
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index 372ecb3e2c06..1e5d28311e14 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -578,58 +578,6 @@ static void strip_init(struct perf_inject *inject)
> >  		evsel->handler = drop_sample;
> >  }
> >  
> > -static bool has_tracking(struct evsel *evsel)
> > -{
> > -	return evsel->core.attr.mmap || evsel->core.attr.mmap2 || evsel->core.attr.comm ||
> > -	       evsel->core.attr.task;
> > -}
> > -
> > -#define COMPAT_MASK (PERF_SAMPLE_ID | PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
> > -		     PERF_SAMPLE_ID | PERF_SAMPLE_CPU | PERF_SAMPLE_IDENTIFIER)
> > -
> > -/*
> > - * In order that the perf.data file is parsable, tracking events like MMAP need
> > - * their selected event to exist, except if there is only 1 selected event left
> > - * and it has a compatible sample type.
> > - */
> > -static bool ok_to_remove(struct evlist *evlist,
> > -			 struct evsel *evsel_to_remove)
> > -{
> > -	struct evsel *evsel;
> > -	int cnt = 0;
> > -	bool ok = false;
> > -
> > -	if (!has_tracking(evsel_to_remove))
> > -		return true;
> > -
> > -	evlist__for_each_entry(evlist, evsel) {
> > -		if (evsel->handler != drop_sample) {
> > -			cnt += 1;
> > -			if ((evsel->core.attr.sample_type & COMPAT_MASK) ==
> > -			    (evsel_to_remove->core.attr.sample_type & COMPAT_MASK))
> > -				ok = true;
> > -		}
> > -	}
> > -
> > -	return ok && cnt == 1;
> > -}
> > -
> > -static void strip_fini(struct perf_inject *inject)
> > -{
> > -	struct evlist *evlist = inject->session->evlist;
> > -	struct evsel *evsel, *tmp;
> > -
> > -	/* Remove non-synthesized evsels if possible */
> > -	evlist__for_each_entry_safe(evlist, tmp, evsel) {
> > -		if (evsel->handler == drop_sample &&
> > -		    ok_to_remove(evlist, evsel)) {
> > -			pr_debug("Deleting %s\n", perf_evsel__name(evsel));
> > -			evlist__remove(evlist, evsel);
> > -			evsel__delete(evsel);
> > -		}
> > -	}
> > -}
> > -
> >  static int __cmd_inject(struct perf_inject *inject)
> >  {
> >  	int ret = -EINVAL;
> > @@ -729,8 +677,6 @@ static int __cmd_inject(struct perf_inject *inject)
> >  				evlist__remove(session->evlist, evsel);
> >  				evsel__delete(evsel);
> >  			}
> > -			if (inject->strip)
> > -				strip_fini(inject);
> >  		}
> >  		session->header.data_offset = output_data_offset;
> >  		session->header.data_size = inject->bytes_written;
> > -- 
> > 2.17.1
> > 

-- 

- Arnaldo
