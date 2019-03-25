Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A9FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB7320811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDJjcI3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbfCYOxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:53:42 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33101 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCYOxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:53:41 -0400
Received: by mail-qk1-f195.google.com with SMTP id k189so5498740qkc.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WhPW7MuiAC3An0elJoO7dmm9e/eoDavIVBKMz9TnO18=;
        b=JDJjcI3Z9zIvHJQDs1Uj+uoK3Gbn6fAiS1Mq5WcztN+mC7dq2c0HUWBo1DtblSagpm
         ymOP2yKyqhtTfUpYxS28HbMyrO+KLyo+q9TWXCiPtHHUUJAcmGxmfx1TvEv2qCBSyJ4s
         jDQuO2GhaEO5GfvCr0aUuFYxrLyQ7IwIQMhptYM+bMO+LIVfHA3N7PLjORAD9QcKO6S6
         c2BIrZSxnyF9Y2eHi4s3poqt2GpYWcB+8pPiB10yyXshbJ9IZwwiKEqeVADw+zdhEdGY
         ON8lUwD5eWT2w2lbdGpkpgxLGBbBRpxaNM57F1PnWZyjkeI9Ksqp9G5uumrvN/j1Vz1j
         cPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WhPW7MuiAC3An0elJoO7dmm9e/eoDavIVBKMz9TnO18=;
        b=YlhzPY1xgYkTbEyO/XCP2er2H0yAODDeMikpYeTAFqWSxyfW1Z0JMgbLh1DULpvlWw
         KVOiySMDusOa+TtKkDI+dwbOGPKmBfAL7E82/Hw8swu4zJ/qkSSQClWYLnZcWYs2byBN
         Imf1yzrGfvnqZvjdo8FdJBagVzEn5o4a7bWBbSCxH47Q/dC/Xaq6HojfrQr7dAzDcmv8
         Wtv9LWhwJ8iscMa15LVCLBCxA8vYl5TXMEWgvSrkF2iJHCL2lnM+tljlD9qL+SkTBy9e
         KUFGYCIEVROVjkHLrC7Fu/ZXojMVjmPoVmxc690SBQfOVj9tPw8Fww7hQyFuuqzWOaEr
         +B0Q==
X-Gm-Message-State: APjAAAXAkbkernNIIMTYQDQnYPVzEvk8J6aE+fGowGRAjtOA5Bm8Z448
        5ItM3AjLTkgauojRFFKry/M=
X-Google-Smtp-Source: APXvYqz1xlO5Cz6YrDi8Xglq9wz6J1JYXdQL4R15/i0Hlq/97CD8bVYnUe3hcTDctCssG1+d7q+MFQ==
X-Received: by 2002:ae9:f30f:: with SMTP id p15mr5956483qkg.182.1553525620834;
        Mon, 25 Mar 2019 07:53:40 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id q16sm721733qtb.27.2019.03.25.07.53.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 07:53:39 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C7EBE4039C; Mon, 25 Mar 2019 11:53:33 -0300 (-03)
Date:   Mon, 25 Mar 2019 11:53:33 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH] perf tools: Move precise_ip detection into
 perf_evsel__open
Message-ID: <20190325145333.GA1486@kernel.org>
References: <20190305162854.GB4533@krava>
 <20190305164017.GD17272@tassilo.jf.intel.com>
 <20190307153500.GC29474@krava>
 <20190307165123.GE7535@tassilo.jf.intel.com>
 <20190314140124.GE4406@krava>
 <20190314154911.GE24002@tassilo.jf.intel.com>
 <20190315121546.GB1400@krava>
 <20190315143504.GA24482@kernel.org>
 <20190315145225.GC5200@krava>
 <20190323150422.GA22122@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190323150422.GA22122@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Mar 23, 2019 at 04:04:22PM +0100, Jiri Olsa escreveu:
> On Fri, Mar 15, 2019 at 03:52:25PM +0100, Jiri Olsa wrote:
> > On Fri, Mar 15, 2019 at 11:35:04AM -0300, Arnaldo Carvalho de Melo wrote:
> > > The perf_evsel__open() code is already complex with that fallback
> > > mechanism, this is just one more way of fallbacking when asking the
> > > kernel for something that may fail.

> > > In fact what happens if the precise_ip that is being asked _is_
> > > supported but sys_perf_event_open() fails because some other
> > > perf_event_attr attribute that is set is not supported? 

> > it's outside the scope of standard feature fallback code,
> > so we will try it for any possible fallback variant, so:

> > we will try all possible precise_ip (3,2,1,0) and they will
> > all fail because of the unsupported attribute - so we will
> > restore the precise_ip back and continue in standard fallback
> > code that will eventualy switch that attribute off
 
> > > I see, it gets it back restored to what the user asked so that the
> > > standard fallback is tried, ok, I'll apply with just the rename for this
> > > function,
 
> ping, there's rebased version in my perf/fixes branch

Thanks, applied.

- Arnaldo
