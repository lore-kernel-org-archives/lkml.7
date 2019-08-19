Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00344C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CAD20651
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hZ0/K+8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfHSOgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:36:46 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41663 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfHSOgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:36:46 -0400
Received: by mail-io1-f66.google.com with SMTP id j5so4729752ioj.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 07:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iFql09aYcbuPzPRNNxnVYR/hsgoCVkgeaLnrJBlkInE=;
        b=hZ0/K+8mp3EUZ2oVc6YBrrwM+NY5lrxsoN/bHpXw9ccgPD0KXXZoiHJt2JSw+AA1UH
         RDw7F+gixHjtULxlpNnjMJ9cOwEYrN68BTFX4MbTNKrjpbr2Dvc+zLmPz075TrejNJPs
         8V86xo6hVlIeTK402ASR8wrBOlTk8W8MzI3+lagfQDzYWKjJcwqubdgGEmBSd06Q37B0
         h3G7WAn4oKLCR7Ij4+epGx+eirKb+ON4L+S6moIhGxSxEIeN/Y5SIriF/eSCL4bu5D9M
         az7QG2ELlpdcHvqRRl8MRbg31faL8wFJBGeMdBhhuIoxOiquxv6+6zwY/74E0nzCO6t/
         qtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iFql09aYcbuPzPRNNxnVYR/hsgoCVkgeaLnrJBlkInE=;
        b=Kx9dKd/+z+oSNOSmvqpqtajRdnnpikUG4cIWAsIMh7OWLR/9KXRG8jq1Axeel4zCbC
         SJ9wsKelLWFqcCdzZn3VZ+4UsBfOclLoK6AcnQhoPPbt7ibk5+LnrwV7AzAeO2rg7IWH
         ZcOC4hecS05smMvzS0ZEu9wnyXDGJHcE2HUtdJo6JejWkFaZx8tSPrRDt3yue4tH8BHG
         m5DzVSDoYg6gSSuzMyQVs8F85K/IO9z/4rzZM02b0UrscG4ZQ04DSfmAVOQSwPqBqDAk
         Fs4XlnqMTp/BV7pVOvgPzflsFhfWA1SFM0ff4XRggKYDKA9cr3qQfbEC57BsPxk0COp4
         MvjQ==
X-Gm-Message-State: APjAAAWb5vCBM31X5i50K1h713sYf8gy/JxNnvBN1W56zy1TXiZ98W9s
        AQryMlO2h1BJW76DbQT/nT3nlDKsGEyM4+oDWhZPpA==
X-Google-Smtp-Source: APXvYqy/JTSP8plWiptfa8XNpGVBvS6DSUqOTELVeUKcWKe8jXPOt+uLKCaayd0PFnIVLPBNJHs/fGqNCYjrSVaGp+s=
X-Received: by 2002:a5d:8854:: with SMTP id t20mr250833ios.50.1566225405381;
 Mon, 19 Aug 2019 07:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190815082854.18191-1-leo.yan@linaro.org> <20190819142321.GB29674@kernel.org>
In-Reply-To: <20190819142321.GB29674@kernel.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 19 Aug 2019 08:36:34 -0600
Message-ID: <CANLsYkxfhRRj4V29DGUq_LkiM7nDTOQnPd2saWTGvKt+Qr6M1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf cs-etm: Support sample flags 'insn' and 'insnlen'
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019 at 08:23, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Thu, Aug 15, 2019 at 04:28:54PM +0800, Leo Yan escreveu:
> > The synthetic branch and instruction samples are missed to set
> > instruction related info, thus perf tool fails to display samples with
> > flags '-F,+insn,+insnlen'.
> >
> > CoreSight trace decoder has provided sufficient information to decide
> > the instruction size based on the isa type: A64/A32 instruction are
> > 32-bit size, but one exception is the T32 instruction size, which might
> > be 32-bit or 16-bit.
> >
> > This patch handles for these cases and it reads the instruction values
> > from DSO file; thus can support flags '-F,+insn,+insnlen'.
>
> Mathieu, can I have your Acked-by/Reviewed-by?

Yes, as soon as I have the opportunity to test it.

>
> - Arnaldo
>
> > Before:
> >
> >   # perf script -F,insn,insnlen,ip,sym
> >                 0 [unknown] ilen: 0
> >      ffff97174044 _start ilen: 0
> >      ffff97174938 _dl_start ilen: 0
> >      ffff97174938 _dl_start ilen: 0
> >      ffff97174938 _dl_start ilen: 0
> >      ffff97174938 _dl_start ilen: 0
> >      ffff97174938 _dl_start ilen: 0
> >      ffff97174938 _dl_start ilen: 0
> >      ffff97174938 _dl_start ilen: 0
> >      ffff97174938 _dl_start ilen: 0
> >
> >   [...]
> >
> > After:
> >
> >   # perf script -F,insn,insnlen,ip,sym
> >                 0 [unknown] ilen: 0
> >      ffff97174044 _start ilen: 4 insn: 2f 02 00 94
> >      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
> >      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
> >      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
> >      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
> >      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
> >      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
> >      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
> >      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
> >
> >   [...]
> >
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
> > Cc: Mike Leach <mike.leach@linaro.org>
> > Cc: Robert Walker <robert.walker@arm.com>
> > Cc: coresight@lists.linaro.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm.c | 35 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index ed6f7fd5b90b..b3a5daaf1a8f 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -1076,6 +1076,35 @@ bool cs_etm__etmq_is_timeless(struct cs_etm_queue *etmq)
> >       return !!etmq->etm->timeless_decoding;
> >  }
> >
> > +static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
> > +                           u64 trace_chan_id,
> > +                           const struct cs_etm_packet *packet,
> > +                           struct perf_sample *sample)
> > +{
> > +     /*
> > +      * It's pointless to read instructions for the CS_ETM_DISCONTINUITY
> > +      * packet, so directly bail out with 'insn_len' = 0.
> > +      */
> > +     if (packet->sample_type == CS_ETM_DISCONTINUITY) {
> > +             sample->insn_len = 0;
> > +             return;
> > +     }
> > +
> > +     /*
> > +      * T32 instruction size might be 32-bit or 16-bit, decide by calling
> > +      * cs_etm__t32_instr_size().
> > +      */
> > +     if (packet->isa == CS_ETM_ISA_T32)
> > +             sample->insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id,
> > +                                                       sample->ip);
> > +     /* Otherwise, A64 and A32 instruction size are always 32-bit. */
> > +     else
> > +             sample->insn_len = 4;
> > +
> > +     cs_etm__mem_access(etmq, trace_chan_id, sample->ip,
> > +                        sample->insn_len, (void *)sample->insn);
> > +}
> > +
> >  static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
> >                                           struct cs_etm_traceid_queue *tidq,
> >                                           u64 addr, u64 period)
> > @@ -1097,9 +1126,10 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
> >       sample.period = period;
> >       sample.cpu = tidq->packet->cpu;
> >       sample.flags = tidq->prev_packet->flags;
> > -     sample.insn_len = 1;
> >       sample.cpumode = event->sample.header.misc;
> >
> > +     cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
> > +
> >       if (etm->synth_opts.last_branch) {
> >               cs_etm__copy_last_branch_rb(etmq, tidq);
> >               sample.branch_stack = tidq->last_branch;
> > @@ -1159,6 +1189,9 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
> >       sample.flags = tidq->prev_packet->flags;
> >       sample.cpumode = event->sample.header.misc;
> >
> > +     cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->prev_packet,
> > +                       &sample);
> > +
> >       /*
> >        * perf report cannot handle events without a branch stack
> >        */
> > --
> > 2.17.1
>
> --
>
> - Arnaldo
