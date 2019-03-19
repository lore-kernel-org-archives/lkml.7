Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B28C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7667520835
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuE54b7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfCSQyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:54:02 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39055 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfCSQyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:54:01 -0400
Received: by mail-qt1-f194.google.com with SMTP id t28so22948341qte.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YzAUO7LVnUugKZaOPcx1VJc0nz0jOvjrHkAcAwuRGmA=;
        b=iuE54b7ZPmA0dTCdFg9XuaI4tfzRB3RNpJ165Fada5NuckwXonTJh3QePk+BHp0LlZ
         vNdNQbpN1Sz8+tdD95BzCCsC+tzUwpU/awzsmoRxC/LK8VzHngqmU84Oa1HCxwKLBHGl
         BeEZewD9izD1o8q6STEVvA/RjWHAM3gNGx3a6BJqwFQ3sX8INpzCX4K1d1WvlUyP2Wj5
         vyvznm4zafK8Zk+nwbIAz3oXMUPbjfColqRvUZU4SHzYochq422wRwXGJ+k7ntLAO7+/
         kehdWwBUDkk8fRsb0ZIxNvnQ5Up3+XcEaopbBF4R+hL0Viq+cLMRgqjORXvN5tMbfiru
         grMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YzAUO7LVnUugKZaOPcx1VJc0nz0jOvjrHkAcAwuRGmA=;
        b=fL3Ehm1h0m/5cNeO4pLrZcRneZbQbIoITQTgWbcUAJmwUM7wBvUYHwdEHrHwHw9LMW
         eQme9vDbZV0xPBjOMlSdbccVLXo5MrB0Y6SgNNgSR/jrcJjPtArv098pT8PUFPqwfEpl
         Mp3UNvoM5CHNH8yi1Pm1DgEoxjYKHneGJTGHFt+1JVVdsfpGH62TUM2HlritFZ63w4oV
         6iet06dg7R88RdVbK2bkbGTO8I6olxkAPeutQyycwzq+TANNxkQmcfnsQnVVmr66hG7G
         5BaLAur0jNISGD4wCp72/OAHXsWoFtygJlu7p3f+Ih0USrxRCj4LymRSn2XtVPVQUeL2
         niFg==
X-Gm-Message-State: APjAAAVtE5ic2GZoiyDOmK2Rqp9e5Td22IlE2JEknCgqjAc/zYXyNxnh
        im1SP99FLZw8W7cl0BsJs2o=
X-Google-Smtp-Source: APXvYqzXVwvQy8kQ4ca++NzQeCfqN3BYNnIwnFqmsCyyx8g3bgXysvacDebdmjJO+C4UMFY15B5k2Q==
X-Received: by 2002:a0c:9319:: with SMTP id d25mr2659181qvd.99.1553014440254;
        Tue, 19 Mar 2019 09:54:00 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id a20sm3795586qth.88.2019.03.19.09.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 09:53:59 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A67CD4039C; Tue, 19 Mar 2019 13:53:56 -0300 (-03)
Date:   Tue, 19 Mar 2019 13:53:56 -0300
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Yue Haibing <yuehaibing@huawei.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] perf tools: return errcode in
 cs_etm__process_auxtrace_info
Message-ID: <20190319165356.GH3029@kernel.org>
References: <20190315022649.17848-1-yuehaibing@huawei.com>
 <20190318171518.GH22548@kernel.org>
 <CANLsYkzU25wAx0dMQqMVZ2asx+z-taOfffLO7DMd6mkDXc7D9A@mail.gmail.com>
 <20190319144631.GE3029@kernel.org>
 <20190319145525.GA7394@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319145525.GA7394@xps15>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 19, 2019 at 08:55:25AM -0600, Mathieu Poirier escreveu:
> On Tue, Mar 19, 2019 at 11:46:31AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Mar 19, 2019 at 08:38:32AM -0600, Mathieu Poirier escreveu:
> > > On Mon, 18 Mar 2019 at 11:15, Arnaldo Carvalho de Melo
> > > <arnaldo.melo@gmail.com> wrote:
> > > >
> > > > Em Fri, Mar 15, 2019 at 10:26:49AM +0800, Yue Haibing escreveu:
> > > > > From: YueHaibing <yuehaibing@huawei.com>
> > > > >
> > > > > 'err' is set in err path, but it's not returned to callers.
> > > > > Also fix a pass zero to PTR_ERR issue.
> > > >
> > > > Next time please submit two patches, one for the PTR_ERR and another for
> > > > not throwing away the err = -E!INVAL and returning just -EINVAL, I'm
> > > > doing it this time.
> > > >
> > > 
> > > Please hold off on that - I've asked for other modifications to be
> > > done on this patch.
> > 
> > Do you really think that it is necessary to hold? The fixes are trivial
> > and I already have them split and applied, see them below, I think
> > whatever other changes can be done in further patches, no?
> 
> Proceeding with the patches below would created two new bugs, hence asking Yue
> for modifications.

Ok, I'll take your word on it then, dropping the patches.

- Arnaldo
 
> Mathieu  
> 
> > 
> > - Arnaldo
> > 
> > From 6c5c248935a4da12a582b1518a38ec35044833ee Mon Sep 17 00:00:00 2001
> > From: YueHaibing <yuehaibing@huawei.com>
> > Date: Fri, 15 Mar 2019 10:26:49 +0800
> > Subject: [PATCH 24/42] perf cs-etm: return errcode in
> >  cs_etm__process_auxtrace_info()
> > 
> > 'err' is set in err path, but it's not returned to callers. Don't always return
> > -EINVAL, return err.
> > 
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Fixes: cd8bfd8c973e ("perf tools: Add processing of coresight metadata")
> > Link: http://lkml.kernel.org/r/20190315022649.17848-1-yuehaibing@huawei.com
> > [ split from a larger patch ]
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/cs-etm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 110804936fc3..2257ac4dbff2 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -2023,5 +2023,5 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >  err_free_hdr:
> >  	zfree(&hdr);
> >  
> > -	return -EINVAL;
> > +	return err;
> >  }
> > -- 
> > 2.20.1
> > 
> > From 4ab1e71e45a91220bdca7fc3b79c600df81d9234 Mon Sep 17 00:00:00 2001
> > From: YueHaibing <yuehaibing@huawei.com>
> > Date: Fri, 15 Mar 2019 10:26:49 +0800
> > Subject: [PATCH 25/42] perf cs-etm: Remove errnoeous ERR_PTR() usage in in
> >  cs_etm__process_auxtrace_info
> > 
> > intlist__findnew() doesn't uses ERR_PTR() as a return mechanism so its callers
> > shouldn't try to extract the error using PTR_ERR(ret-from-intlist__findnew()),
> > make cs_etm__process_auxtrace_info9) return -ENOMEM instead.
> > 
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Fixes: cd8bfd8c973e ("perf tools: Add processing of coresight metadata")
> > Link: http://lkml.kernel.org/r/20190315022649.17848-1-yuehaibing@huawei.com
> > [ split from a larger patch ]
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/cs-etm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 2257ac4dbff2..111f33cd1204 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -1908,7 +1908,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >  
> >  		/* Something went wrong, no need to continue */
> >  		if (!inode) {
> > -			err = PTR_ERR(inode);
> > +			err = -ENOMEM;
> >  			goto err_free_metadata;
> >  		}
> >  
> > -- 
> > 2.20.1
> > 

-- 

- Arnaldo
