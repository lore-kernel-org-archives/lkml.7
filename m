Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49066C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9C22173E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jze2cgdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfGQVF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 17:05:57 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42348 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfGQVF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 17:05:57 -0400
Received: by mail-qt1-f196.google.com with SMTP id h18so24887691qtm.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 14:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TdNCjtIZoEvzk7CFQvtZTCtYl6pPEGqJ5p+G7wRu/MI=;
        b=Jze2cgdcy5662fomC3fE57fj/VYZwcaxgnH9hmOhncVx4UAjEyZZPiPq34XrND4P7K
         4qhjOibmnZmFm5bExhEYi4xo7rRaTLEloEx6ypQX6+1WZdl9zIzPW85zVQ/96cNqXtBE
         niPQ1iHeX8AvFQFPhf46FslMxz3OdM/YjSpczde0WTZJNHuK+NxOCyjRX+/r4E3H5JxE
         4eU+C4RXHTaSlgkerXKGq3e4VDlEsstFTyFz391mLzcTHA3/Um0pskGJM9xlBW1dPnNW
         1Fql4Lwi8aiFGl9Wh7zqh7U7qJERcnGfoYZ12M5uQ9NfR4aD1IBUKFfsnkk5e5/zkrNp
         rK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TdNCjtIZoEvzk7CFQvtZTCtYl6pPEGqJ5p+G7wRu/MI=;
        b=IhiN3ySORf33k756zD75cgotO3ZlLmkmT8Mo2WMufTruMaj/HjD9FeGTuIYf51tRGY
         /qp4Jf96p6QUHvI8U2ulC5csbfs75WPx0eARdveghU3nUe+p+ksjmlStEs+E56TGVa6N
         ITPV0KmaLo2qT5A4qzHy0sYPdDzL+NpT/Xz1LwqXIwpP+UMdzjH+AwSh5PM3Tsncr5VT
         s9siCub/IXbMaH2kr7fJg2ic8G4bIR1f7uHS4ugHFtb3MmNRHIGWF17oJA2kV5fsCx76
         Xw26iTZTpvV4V5O3Rvg4dRs36Sv1hNb8Yrya1UOqWu9N7/4EbAwKHLnhxMEXP0NZ5Ek0
         rP5g==
X-Gm-Message-State: APjAAAVOQOBdFBXGomJ45uwwYygLT+gFTdOUCr8I4z5LegTGLfNG7i4f
        Y+g9tddKEif2EHiV4vibV6E=
X-Google-Smtp-Source: APXvYqwmPFj36H1UaqpWKrAjunpVi5dB8uju+jNSB77TCPoSq0HlMtFYx1VXFSiSw6WxfxozBf+9TQ==
X-Received: by 2002:aed:3667:: with SMTP id e94mr24038666qtb.382.1563397556262;
        Wed, 17 Jul 2019 14:05:56 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.182.6.211])
        by smtp.gmail.com with ESMTPSA id o18sm15127109qtb.53.2019.07.17.14.05.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 14:05:55 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 10C2240340; Wed, 17 Jul 2019 18:05:51 -0300 (-03)
Date:   Wed, 17 Jul 2019 18:05:51 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Igor Lubashev <ilubashe@akamai.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        James Morris <jmorris@namei.org>
Subject: Re: [PATCH 1/3] perf: Add capability-related utilities
Message-ID: <20190717210551.GI3624@kernel.org>
References: <1562112605-6235-1-git-send-email-ilubashe@akamai.com>
 <1562112605-6235-2-git-send-email-ilubashe@akamai.com>
 <20190716084643.GA22317@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716084643.GA22317@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 16, 2019 at 10:46:43AM +0200, Jiri Olsa escreveu:
> On Tue, Jul 02, 2019 at 08:10:03PM -0400, Igor Lubashev wrote:
> > Add utilities to help checking capabilities of the running process.
> > Make perf link with libcap.
> > 
> > Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
> > ---
> >  tools/perf/Makefile.config         |  2 +-
> >  tools/perf/util/Build              |  1 +
> >  tools/perf/util/cap.c              | 24 ++++++++++++++++++++++++
> >  tools/perf/util/cap.h              | 10 ++++++++++
> >  tools/perf/util/event.h            |  1 +
> >  tools/perf/util/python-ext-sources |  1 +
> >  tools/perf/util/util.c             |  9 +++++++++
> >  7 files changed, 47 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/perf/util/cap.c
> >  create mode 100644 tools/perf/util/cap.h
> > 
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 85fbcd265351..21470a50ed39 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -259,7 +259,7 @@ CXXFLAGS += -Wno-strict-aliasing
> >  # adding assembler files missing the .GNU-stack linker note.
> >  LDFLAGS += -Wl,-z,noexecstack
> >  
> > -EXTLIBS = -lpthread -lrt -lm -ldl
> > +EXTLIBS = -lpthread -lrt -lm -ldl -lcap
> 
> I wonder we should detect libcap or it's everywhere.. Arnaldo's compile test suite might tell

I'll add this tentatively and try to build it in my test suite.

- Arnaldo
