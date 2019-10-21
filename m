Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12A5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956C12070B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nz7QVN+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbfJUUS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:18:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37849 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUUS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:18:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id g50so8987896qtb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 13:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xmghAy3Ay1dTvAkMGgpKZV4vCkfwTKsXzSv2vwfjq9c=;
        b=nz7QVN+VFohetmd+Pma7abG/tul3UG+toZlKhuDrG2UbbKGP/W+JZ3WBsi7pW+lJQ2
         ubcD3r+OwWndiv/ABeWbdvqWh43/mGquMQ6Yp1NbBTHAgrapcRdEDYA3sPFwSPVyysAW
         szvrDhPGbPQSCvX349VNQLV+2PIF1aLopERotCx4UmSXnEPHeuT93OSCJotSWV9BtilB
         9+bs0TEpJSW6AKMzmvAc3GNsaCFcHhTU37RKQegy/W6fTCK0u2M3FWOREOqovNB55XAX
         gnyiG9D8Mi1Mr5A/xgWeVDELiqFNDu75CXwjbY5rc80bzRbs/cF32hqrnmugvZZ9sD3Q
         2vyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xmghAy3Ay1dTvAkMGgpKZV4vCkfwTKsXzSv2vwfjq9c=;
        b=PBNHGKP5kVjTHbSxCmUp/+yEGyIlY23m/6QrWl8IBzV1CeTVnMueDqLXMhw5Ui/4IC
         wee9faNgMCBqqorWfY+ErVLQH3cdYnlyk02xT7eRkMg/1w4zUCE8HryjHFOEp2dl98Yc
         rJVGsT8qWeE4FfJDsIC8QYOXiph7VikfUw1NEutGMbK85qcJRpZTp4vvaxPGoSKnOrag
         rJLL1IbANIi8cNgGcYsioTPmilHhEczxJL3AObSt/AT+/2WSpzqrqGGXeqK0E2iwvjrU
         fggtG6kKYKnBpksNgzXENqDhG8RfYaV+zhguKBR7Oye5ycvjLaCGaw7o+7yq5Te4nDpk
         zf7g==
X-Gm-Message-State: APjAAAX16cbSkpociIbO7KKpBRYwXVIGcuAZk0T0GU07j8c98A1VDq/u
        qzqqsG0HjLoXG6wZ3pi/pWo=
X-Google-Smtp-Source: APXvYqwH2CdlzO8mPacN5T0FFaTrVIdLWxxNinibRKJ5x6dkvDidJcHexXCn3CpLUxnoEQy3e4S4Hw==
X-Received: by 2002:a0c:f90d:: with SMTP id v13mr24983431qvn.57.1571689105786;
        Mon, 21 Oct 2019 13:18:25 -0700 (PDT)
Received: from quaco.ghostprotocols.net (187-26-105-39.3g.claro.net.br. [187.26.105.39])
        by smtp.gmail.com with ESMTPSA id j16sm6072705qka.48.2019.10.21.13.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 13:18:25 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AF2704035B; Mon, 21 Oct 2019 17:18:19 -0300 (-03)
Date:   Mon, 21 Oct 2019 17:18:19 -0300
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH] perf cs-etm: Fix definition of macro TO_CS_QUEUE_NR
Message-ID: <20191021201819.GK1797@kernel.org>
References: <20191021074808.25795-1-leo.yan@linaro.org>
 <CANLsYkyvDKw4E7=+fsq7W41iS0P57Rau3fxJffrg8cEScyOOBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkyvDKw4E7=+fsq7W41iS0P57Rau3fxJffrg8cEScyOOBw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 21, 2019 at 11:42:21AM -0600, Mathieu Poirier escreveu:
> On Mon, 21 Oct 2019 at 01:48, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > Macro TO_CS_QUEUE_NR definition has a typo, which uses 'trace_id_chan'
> > as its parameter, this doesn't match with its definition body which uses
> > 'trace_chan_id'.  So renames the parameter to 'trace_chan_id'.
> >
> > It's luck to have a local variable 'trace_chan_id' in the function
> > cs_etm__setup_queue(), even we wrongly define the macro TO_CS_QUEUE_NR,
> > the local variable 'trace_chan_id' is used rather than the macro's
> > parameter 'trace_id_chan'; so the compiler doesn't complain for this
> > before.
> >
> > After renaming the parameter, it leads to a compiling error due
> > cs_etm__setup_queue() has no variable 'trace_id_chan'.  This patch uses
> > the variable 'trace_chan_id' for the macro so that fixes the compiling
> > error.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 4ba0f871f086..f5f855fff412 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -110,7 +110,7 @@ static int cs_etm__decode_data_block(struct cs_etm_queue *etmq);
> >   * encode the etm queue number as the upper 16 bit and the channel as
> >   * the lower 16 bit.
> >   */
> > -#define TO_CS_QUEUE_NR(queue_nr, trace_id_chan)        \
> > +#define TO_CS_QUEUE_NR(queue_nr, trace_chan_id)        \
> >                       (queue_nr << 16 | trace_chan_id)
> >  #define TO_QUEUE_NR(cs_queue_nr) (cs_queue_nr >> 16)
> >  #define TO_TRACE_CHAN_ID(cs_queue_nr) (cs_queue_nr & 0x0000ffff)
> > @@ -819,7 +819,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
> >          * Note that packets decoded above are still in the traceID's packet
> >          * queue and will be processed in cs_etm__process_queues().
> >          */
> > -       cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_id_chan);
> > +       cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
> >         ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, timestamp);
> >  out:
> >         return ret;
> 
> Really good catch - Arnaldo please consider.
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Thanks, applied.

- Arnaldo
