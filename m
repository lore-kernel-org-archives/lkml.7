Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F510C606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3400216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 21:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPEBr7Z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405212AbfGHV5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 17:57:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44283 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732609AbfGHV5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 17:57:42 -0400
Received: by mail-qt1-f195.google.com with SMTP id 44so15758998qtg.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 14:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cRr+V7DvslcvPopD8/4sPU5GgYY6W8gwxhNPdNZDYLM=;
        b=kPEBr7Z6kspFKIoGgC2pZEtR3YiFDm6jHopgrqEXJrbrYFcgbmDwbbOqhN5Gi1wGXW
         cpy750eg6g3/5SbCiy87z/xcmp9rD5Iiq2HgMWbXLQwxioi2WRpurSR9CtZz8PnpNqna
         gXQrQlr+YlZL6Rwdu7tNEYJw2tXAFa8wsKaiK5JkVFkbfUrBFHdMro9X2m5rNj2zcL3J
         vjmwT+Z4TO7SPt/3YZKvHKRiy2p5yD726eQuN1FC1aOnU/A6z5JiGOMFOwLgWMxMYJvh
         eAxmljVjM7O6bgS+2Nq7K9NKtXWbThZBvVyDNWFHWDYTkdUPaGfCyzSLH9fz8HZxPa4n
         akJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cRr+V7DvslcvPopD8/4sPU5GgYY6W8gwxhNPdNZDYLM=;
        b=Lxdo8HjMLKr7SwAP6/npZXA8qiqbD9th8Shf9nYu9Wv2cG+/wV6vlpQ7ulUuZm18Wd
         ILqQF9tWpEAaZa2JZ7T4RwEVrOh/TwFhJc9mWJnMSfCqfvghuFqF2whPFBgiwpR4iVCj
         xM0/HWmzSVYBho37gRVFBVHeAuleRziC6Oh8Os5l6tONfNKbJRQx7c3kWN66n6VWi1sC
         fU1Baq7famq4S68CkvcNL6j/Xzx8vfKhbFjNKSk/VDF8ZZlK3rAs3yN/kwD+foDGLTRT
         1goRiCGOxbnwZqk4N7cKav0X2Vn4ZFoo3LvTsqOiAl/ETOl/mNTfSR9di5ZazUDI0RpH
         TXGw==
X-Gm-Message-State: APjAAAVI2z9D1MRlKGvLvcvtedW6vxcZZqFw1BUovFu8UruahIv6PDp8
        QmKt/RE3bJHWCwMdNH4WrOg=
X-Google-Smtp-Source: APXvYqxHtwWle9/lnZGk+HDl0RHyir01Sh5RlMtKpdadwLq/Ys8rGiW1B5ioOOrksBrZBDovZWz+Bw==
X-Received: by 2002:ac8:32e8:: with SMTP id a37mr15960511qtb.231.1562623061523;
        Mon, 08 Jul 2019 14:57:41 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id d12sm6455916qtj.50.2019.07.08.14.57.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 14:57:40 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2081B40340; Mon,  8 Jul 2019 18:57:38 -0300 (-03)
Date:   Mon, 8 Jul 2019 18:57:38 -0300
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 4/4] perf cs-etm: Smatch: Fix potential NULL pointer
 dereference
Message-ID: <20190708215738.GC7455@kernel.org>
References: <20190708143937.7722-1-leo.yan@linaro.org>
 <20190708143937.7722-5-leo.yan@linaro.org>
 <CANLsYkwHMfVf-FUQ+wBkDfq9GnCihimFAhd+ybCsxMAt8d3HcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkwHMfVf-FUQ+wBkDfq9GnCihimFAhd+ybCsxMAt8d3HcA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 08, 2019 at 11:38:48AM -0600, Mathieu Poirier escreveu:
> On Mon, 8 Jul 2019 at 08:40, Leo Yan <leo.yan@linaro.org> wrote:
> >
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
> > 'session->itrace_synth_opts' is impossible to be a NULL pointer in
> > cs_etm__process_auxtrace_info(), thus this patch removes the NULL
> > test for 'session->itrace_synth_opts'.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index ad43a6e31827..ab578a06a790 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -2537,7 +2537,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >                 return 0;
> >         }
> >
> > -       if (session->itrace_synth_opts && session->itrace_synth_opts->set) {
> > +       if (session->itrace_synth_opts->set) {
> >                 etm->synth_opts = *session->itrace_synth_opts;
> >         } else {
> >                 itrace_synth_opts__set_default(&etm->synth_opts,
> 
> This is in accordance with what was previously discussed.
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks, applied.

- Arnaldo
