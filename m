Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FCACA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 05:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8149C20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 05:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d18epoJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbfJVFKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 01:10:33 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33790 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfJVFKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 01:10:33 -0400
Received: by mail-qt1-f196.google.com with SMTP id r5so24991998qtd.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 22:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+w/qzEw27aMbdNSzTHsuyi7AE3I1PGTPr3i5czPeWmY=;
        b=d18epoJOJ0/pv+lNYQywjIqfTmBcEV4Xe9ZM1R+1nkVFJ0k39xTxxsxkYvdimN1u8D
         wGdPIPRG6vg8TmeWT28uyJqs9P4kJKkzWrm9Lf1bhLFqtspGApUJsUHOeu/bHSxbKoQR
         FsB3F8RutqugqF0xleQHdXDJYvlYqjUVNuUIEA6BHdXkFFHCUpqfPeoFnWDOMF1UDdRu
         o2EgcCB1dGjn3jgIN33ra19bKI3mtq52W9jdEdB1pK1aTvcS+itAW8EmBTlQIKJG4KA2
         mRZWNZi+hDcDLcQPhJRVPCCVUtetWXz512HyX1AIo4968BWHUD5H0LIR2F6EkM7c4w5c
         WNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+w/qzEw27aMbdNSzTHsuyi7AE3I1PGTPr3i5czPeWmY=;
        b=th7NcgVLphAO9zMxLP5LzTDAN2BlCr6setVVDYEpKzx7M7t7OUAUuImNNxgabSqaKl
         eEcSEh0zzuCnOG2gIuIiAGQa3qNzPhQq8sTaFrOpjGxWr0WsO677hMMZwqplqc4fxJkL
         z/fuwGaC6YRhFtiiVgAmCfzOi32yI8Mm4W8Iqz18I3X6x2x28OJNiCbVQmyk37cOs5Z8
         rRRd15k9moXg/WE5E5JUP5/TLx8sBaYosc+KnQEFySMCVGZ3oxA9DnRRsgvrVdYPpMUy
         nWUMlbtY3ZXQgq42PweB6/VnOXandxT8ZZS5YPu6NFpbv7eSoSMl78YCEU6Rm1Kux6uQ
         8dAA==
X-Gm-Message-State: APjAAAUtqeYeMq972YYD8xfqpoCl0LAqCv+qJWyxmGieMF/dHtB/ZC9E
        ifSfBcntZKv09O3v5IGF0mXXEw==
X-Google-Smtp-Source: APXvYqwUVrs5nyGdBFsOdfVGQj0yuFetc/Nm7EOzMo+7I/93O+mEndLG3kY9gALAfx/Mv4QZVHGLfQ==
X-Received: by 2002:ac8:28c4:: with SMTP id j4mr1506947qtj.303.1571721031756;
        Mon, 21 Oct 2019 22:10:31 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li937-157.members.linode.com. [45.56.119.157])
        by smtp.gmail.com with ESMTPSA id z70sm5313857qkb.60.2019.10.21.22.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 22:10:29 -0700 (PDT)
Date:   Tue, 22 Oct 2019 13:10:20 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 1/6] perf cs-etm: Fix unsigned variable comparison to
 zero
Message-ID: <20191022051020.GC32731@leoy-ThinkPad-X240s>
References: <20191005091614.11635-1-leo.yan@linaro.org>
 <20191005091614.11635-2-leo.yan@linaro.org>
 <20191011201606.GC13688@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011201606.GC13688@xps15>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Fri, Oct 11, 2019 at 02:16:06PM -0600, Mathieu Poirier wrote:
> On Sat, Oct 05, 2019 at 05:16:09PM +0800, Leo Yan wrote:
> > If the u64 variable 'offset' is a negative integer, comparison it with
> > bigger than zero is always going to be true because it is unsigned.
> > Fix this by using s64 type for variable 'offset'.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 4ba0f871f086..4bc2d9709d4f 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -940,7 +940,7 @@ u64 cs_etm__last_executed_instr(const struct cs_etm_packet *packet)
> >  static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
> >  				     u64 trace_chan_id,
> >  				     const struct cs_etm_packet *packet,
> > -				     u64 offset)
> > +				     s64 offset)
> 
> In Suzuki's reply there was two choices, 1) move the while(offset > 0) to
> while (offset) or change the type of @offset to an s64.  Here we know offset
> can't be negative because of the 
>         tidq->period_instructions >= etm->instructions_sample_period 
> 
> in function cs_etm__sample().  As such I think option #1 is the right way to
> deal with this rather than changing the type of the variable.

I took sometime to use formulas to prove that 'offset' is possible to
be a negative value :)

Just paste the updated commit log at here for review:

  Pi: period_instructions
  Ie: instrs_executed
  Io: instrs_over
  Ip: instructions_sample_period

  Pi' = Pi + Ie   -> New period_instructions equals to the old
                     period_instructions + instrs_executed
  Io  = Pi' - Ip  -> period_instructions - instructions_sample_period

  offset = Ie - Io - 1
         = Ie - (Pi' - Ip) -1
	 = Ie - (Pi + Ie - Ip) -1
	 = Ip - Pi - 1

In theory, if Ip (instructions_sample_period) is small enough and Pi
(period_instructions) is bigger than Ip, then it will lead to the
negative value for 'offset'.

So let's see below command:

  perf inject --itrace=i1il128 -i perf.data -o perf.data.new

With this command, 'offset' is very easily to be a negative value when
handling packets; this is because if use the inject option 'i1', then
instructions_sample_period equals to 1; so:

  offset = 1 - Pi - 1
         = -Pi

Any Pi bigger than zero leads 'offset' to a negative value.

Thanks,
Leo Yan

> >  {
> >  	if (packet->isa == CS_ETM_ISA_T32) {
> >  		u64 addr = packet->start_addr;
> > @@ -1372,7 +1372,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
> >  		 * sample is reported as though instruction has just been
> >  		 * executed, but PC has not advanced to next instruction)
> >  		 */
> > -		u64 offset = (instrs_executed - instrs_over - 1);
> > +		s64 offset = (instrs_executed - instrs_over - 1);
> >  		u64 addr = cs_etm__instr_addr(etmq, trace_chan_id,
> >  					      tidq->packet, offset);
> >  
> > -- 
> > 2.17.1
> > 
