Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05E8C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C463C2189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bindf1ZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfGCIXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:23:09 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39996 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfGCIXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:23:08 -0400
Received: by mail-oi1-f193.google.com with SMTP id w196so1353293oie.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 01:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=59xd1lKzTm7Rgf6PBY/uVBKcWbMFs5zQzD0EjdvmWzk=;
        b=bindf1ZA6lXjnWIAj6gU/mMOzjIeC34kEuzIN9HG9ndu6frBFLAne/lS6eFkZbM7RN
         oodY/TdXzdO8LD0FjWlbcGnsS2KfNutRD2pOwpwjmBkX25Sx9UkBvlL4UWbr/NNxZUY/
         WGyNMAxaC4J1pyq+VWiEjgUPY420FoGnr9ORkAFCOumbUy2NMOubNWuz7J+/LnfZSdaX
         Af4ektvIX7IQuCI6o0Vz0WHCqPKz1g7wg1DWTekBIELTjU0laIk0qBU1iPI+pIn2PHXR
         EDtkj7J4YO2rBCiGy1R0hdOwKGfKDZ16pyL+9I3viqjM7T3YPVukWvH+W0cX58Gu6H+B
         c6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=59xd1lKzTm7Rgf6PBY/uVBKcWbMFs5zQzD0EjdvmWzk=;
        b=d8gKL6jvkcLbyDlP3AeBNoBJc2iYFZj5qd/YAo4pZ4gK6v8sIBRBKLNUMK+NivUF3u
         QXeHJqCGylnukGivSQtPedeQA1oHMO9OPfJuVKP/NQ7mpBBEiX6ju4nRDfZXPWtqq18q
         wFuBLDrz9D+VZpDvkbM4RFJUpoto8K6uMKC1kNY/3WI2RyqRONF5nBz9DVHJE2IeUDa6
         Ljn+29GWeYnGkEL5EyIRtVivPBGLcddxsv/wYAsG3uVrlMux3bYGLphRgY3k4BGmUmHF
         0PoMk5htNCYg+To0qYdEVTKoVYuUEGJNcRhU6XCgVi+oRegiwZUBUwL3HfbTTwdeSj8m
         k1nw==
X-Gm-Message-State: APjAAAWBjVCOUfQg9Dy8tDgoE51VlAQ3CEDcjzRNPwtFsEXIujyo1CFQ
        NsOj1qznVwQLhAGUBymrJDG1cw==
X-Google-Smtp-Source: APXvYqzdBVgLY85ufOO7r5DeopTWB5eKB5gQm+LyVUdJ4MJWWXGYkKamvI78vcqP759Q+MhWNNEzWA==
X-Received: by 2002:aca:d7d5:: with SMTP id o204mr6353477oig.16.1562142188072;
        Wed, 03 Jul 2019 01:23:08 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id h60sm636627otb.29.2019.07.03.01.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 01:23:07 -0700 (PDT)
Date:   Wed, 3 Jul 2019 16:22:55 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 11/11] perf cs-etm: Smatch: Fix potential NULL pointer
 dereference
Message-ID: <20190703082255.GE6852@leoy-ThinkPad-X240s>
References: <20190702103420.27540-1-leo.yan@linaro.org>
 <20190702103420.27540-12-leo.yan@linaro.org>
 <20190702170306.GA17808@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702170306.GA17808@xps15>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Tue, Jul 02, 2019 at 11:03:06AM -0600, Mathieu Poirier wrote:
> Hi Leo,
> 
> On Tue, Jul 02, 2019 at 06:34:20PM +0800, Leo Yan wrote:
> > Based on the following report from Smatch, fix the potential
> > NULL pointer dereference check.
> > 
> >   tools/perf/util/cs-etm.c:2545
> >   cs_etm__process_auxtrace_info() error: we previously assumed
> >   'session->itrace_synth_opts' could be null (see line 2541)
> > 
> > tools/perf/util/cs-etm.c
> > 2541         if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
> > 2542                 etm->synth_opts = *session->itrace_synth_opts;
> > 2543         } else {
> > 2544                 itrace_synth_opts__set_default(&etm->synth_opts,
> > 2545                                 session->itrace_synth_opts->default_no_sample);
> >                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 2546                 etm->synth_opts.callchain = false;
> > 2547         }
> > 
> > To dismiss the potential NULL pointer dereference, this patch validates
> > the pointer 'session->itrace_synth_opts' before access its elements.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 0c7776b51045..b79df56eb9df 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -2540,7 +2540,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >  
> >  	if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
> >  		etm->synth_opts = *session->itrace_synth_opts;
> > -	} else {
> > +	} else if (session->itrace_synth_opts) {
> 
> This will work but we end up checking session->itrace_synth_opts twice.  I
> suggest to check it once and then process with the if/else if valid:
> 
>         if (session->itrace_synth_opts) {
>                 if (session->itrace_synth_opts->set) {
>                         ...
>                 } else {
>                         ...
>                 }
>         }

Thanks for reviewing.

As discussed with Adrian in another email for intel-pt, it's safe to
remove NULL checking for session->itrace_synth_opts after I reviewed the
code for report/script/inject.  So I'm planning to apply the same change
for cs-etm code.

If you have concern for this, please let me know.

Thanks,
Leo Yan

> >  		itrace_synth_opts__set_default(&etm->synth_opts,
> >  				session->itrace_synth_opts->default_no_sample);
> >  		etm->synth_opts.callchain = false;
> > -- 
> > 2.17.1
> > 
