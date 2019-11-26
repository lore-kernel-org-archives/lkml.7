Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBDEC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD8320722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sKDuA9BE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfKZOeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:34:13 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38517 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfKZOeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:34:13 -0500
Received: by mail-pl1-f193.google.com with SMTP id o8so3881175pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 06:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xYoGHjpKp+8s/nL6dlNazcq7lrq3Cxvj74Y8iazRXAQ=;
        b=sKDuA9BEOY58bMIKrLdUG7xjnk6WJ6HbTPB2WYN8ZSR4Yn+RFLAD7arzXOTiRXRwWQ
         Ea90ziHgangUL1ZpEwFLVXlhO7aBsVjuk+/64a6on+d/Y7GI8UtEeB3nFCgRdrJmGZgy
         HEC8aUtwB8gVoCWdPIItXsDCkTPqlsVjuXfuJ0GYHemiwdxkpnNg68yxmWqKI13+wONl
         gBVwQmP8O1QnB5t7Il2IXyx+AS/KRWkRMToF4ZZC2DN8JaH8Zv1D1egLevuISSanPulm
         eN9cf8gTmCenFP0JWA8cGVGfZC6WhQbNw4VgWPO/8jgy/spHHClr390QuKGVC/sgSn78
         OAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xYoGHjpKp+8s/nL6dlNazcq7lrq3Cxvj74Y8iazRXAQ=;
        b=bNHWSutsFUBtUyOVN9MuVjB33ULgZl0qQJVz03oG1Bv7JqENX3HCxUGUVoQmN3VF8U
         CozZZkw/jnHLGeMYRP7xPwMhEsJ5YDd+oePqtSOtvwRLXWjspwnaXLnA9ZwNUXqSZiYt
         8iLoeQjfhmgY9Pm6AaRuzfrpBypxGNmqxNsj/bFDJ0foNoI0v7ZkZ6aLnQg5rihPPgG2
         RsfAS9gj14tbxFixJhzSVcMqSA8KaC4edW2dAQxKENBGjUM3XSF03m67AO3YVh2j7CN5
         mb+JNzUDMLWzyu6ImUcqkdxvfu3p6rMlJuhFIrEhO4Kbu039X6SyuXgS2V4N1ZpKeVGi
         BdjA==
X-Gm-Message-State: APjAAAVCAFH5dsDkuJf3IWjLbEbGb45hhwxid+NkRDST/F38F+5UcmID
        u2bVPm3dOHusrRkFigBPwUQ=
X-Google-Smtp-Source: APXvYqxUrhKfe8agYEAltCsd/SecLGnCZiyOR7dc1IS6k3LicFTDvP/8wjF/lPTqH/0Lz6iFGw+isA==
X-Received: by 2002:a17:902:9f98:: with SMTP id g24mr29817984plq.325.1574778852812;
        Tue, 26 Nov 2019 06:34:12 -0800 (PST)
Received: from mail.google.com ([139.180.133.10])
        by smtp.gmail.com with ESMTPSA id v63sm12969454pfb.181.2019.11.26.06.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 06:34:12 -0800 (PST)
Date:   Tue, 26 Nov 2019 22:34:04 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] perf: support multiple debug options separated by
 ','
Message-ID: <20191126143402.yxb2djhlpm5tuahf@mail.google.com>
References: <20191125151446.10948-1-changbin.du@gmail.com>
 <20191125151446.10948-2-changbin.du@gmail.com>
 <20191126094508.GB32367@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126094508.GB32367@krava>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2019 at 10:45:08AM +0100, Jiri Olsa wrote:
> On Mon, Nov 25, 2019 at 11:14:45PM +0800, Changbin Du wrote:
> > This patch adds support for multiple debug options separated by ',' and
> > non-int values.
> > 	--debug verbose=2,stderr
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  tools/perf/Documentation/perf.txt | 13 +++--
> >  tools/perf/util/debug.c           | 89 ++++++++++++++++---------------
> >  2 files changed, 53 insertions(+), 49 deletions(-)
> > 
> > diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
> > index 3f37ded13f8c..fd8d790f68a7 100644
> > --- a/tools/perf/Documentation/perf.txt
> > +++ b/tools/perf/Documentation/perf.txt
> > @@ -19,13 +19,12 @@ OPTIONS
> >  	  --debug verbose=2 # sets verbose = 2
> >  
> >  	List of debug variables allowed to set:
> > -	  verbose          - general debug messages
> > -	  ordered-events   - ordered events object debug messages
> > -	  data-convert     - data convert command debug messages
> > -	  stderr           - write debug output (option -v) to stderr
> > -	                     in browser mode
> > -	  perf-event-open  - Print perf_event_open() arguments and
> > -			     return value
> > +	  verbose=level		- general debug messages
> > +	  ordered-events=level	- ordered events object debug messages
> > +	  data-convert=level	- data convert command debug messages
> > +	  stderr		- write debug output (option -v) to stderr
> > +	  perf-event-open	- Print perf_event_open() arguments and
> > +	                          return value in browser mode
> 
> it's just the list and the doc says user can use values
> there, so no need for the '=level' there
> 
> also we allow this:
>   perf --debug stderr=9 record ls
> 
> so I thinks we should keep it general in documentation,
> eventhough it will always mean just stderr=true for any
> value
>
I changed them as below. For stderr and perf_event_open, the value is ignored
even it is given.

--debug::
	Setup debug variable (see list below). The range of 'level' value
	is (0, 10). Use like:
	  --debug verbose   # sets verbose = 1
	  --debug verbose=2,file=~/perf.log
	                    # sets verbose = 2 and save log to file

	List of debug variables allowed to set:
	  verbose[=level]	- general debug messages
	  ordered-events[=level]- ordered events object debug messages
	  data-convert[=level]	- data convert command debug messages
	  stderr		- write debug output (option -v) to stderr
	                          in browser mode
	  perf-event-open	- Print perf_event_open() arguments and
	                          return value

> jirka
> 

-- 
Cheers,
Changbin Du
