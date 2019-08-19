Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B58CC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3860A22CEC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CI98HHXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfHSSIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:08:39 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37857 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfHSSIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:08:38 -0400
Received: by mail-io1-f65.google.com with SMTP id q22so6325553iog.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 11:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4jVeMKqF0pwcZE17bYM4UMPdWdsEiK+mCc9lzyMLHMc=;
        b=CI98HHXVmd99fvPNsV4vYEp6ZKxKOep5wn4vOHu+t9xkOh/RcMtEVKx6lyvMgprZ5K
         1tgp7lyV+IFY0XMkrMfql1sNyPEBhxNko8dl4ppzriAMAG6iLAbq3wAFmUM1sIIfAOv2
         0W4Htk7pJC62PHt6wopwjz5uWLK/h2Sgb6StBcn4S5k8WzXe04SVLSqaJUOKJC717Yk3
         lmlpYPHnu4+BWKSS+75MAvuQrhhjbH9QbSkaF2BDqmeRA+ks04Gp8ihYjlJdiIX8EB28
         txwv6cUGhTMoPvqyg5sBWqyyKAX2fLtMkTHtKaAWVbFVVX4FE89agNfPIIVvkbA/YMQ8
         DIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4jVeMKqF0pwcZE17bYM4UMPdWdsEiK+mCc9lzyMLHMc=;
        b=mhLIP6BUdKKLt/19FHSNDWa835w3HW7zJJmAG/8BHK9fA5TVF057/4UzBlYRvb0saQ
         N4+DwrXOr09IC8HNsXJMw5XXXP4NtXRdaWtZ0EmKd2OZclYw6dsyJPP65QTY1uYb4tqY
         rzhWtV9GAqnTXDbuusqKcl+oa+MIXy05pf+7mhDmCDtSstTbk32/0q9xrzaBL3Nko2yM
         L2SDV7GoN2jiDYgLhMBh/Pn2Xh1Q3DX8gOI2n5qpL+8CJDynLe1+Ymv1lshVog9++oti
         dekCXEMnc2gq+7L2kK06U6p62d7lR1i9g4Tsgw8ArPXzj3XTEyD92EWyvNYWxzDDCHPh
         SuPw==
X-Gm-Message-State: APjAAAUWq+b/+wzI/R90UHwTx9/Wygt2PVLlbvEm+wFhZUiVerVdBm39
        /KB01uv1qr3vQFT9l6jHm445F3XvMANVlfsa5375JA==
X-Google-Smtp-Source: APXvYqyFMTtlksR8aUalyK9zQsKemFP6hrIJVv4IGARiucyP4wdZNbfsGwtF9VgTEul8wU16afchuEfGb2n8ppajG0k=
X-Received: by 2002:a02:8663:: with SMTP id e90mr21939784jai.98.1566238117387;
 Mon, 19 Aug 2019 11:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190815082854.18191-1-leo.yan@linaro.org>
In-Reply-To: <20190815082854.18191-1-leo.yan@linaro.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 19 Aug 2019 12:08:26 -0600
Message-ID: <CANLsYkx5TanDyztpceZvwf4pZSgoqRMOBgiHcdJxxpnGA9-h-Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf cs-etm: Support sample flags 'insn' and 'insnlen'
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Thu, 15 Aug 2019 at 02:30, Leo Yan <leo.yan@linaro.org> wrote:
>
> The synthetic branch and instruction samples are missed to set
> instruction related info, thus perf tool fails to display samples with
> flags '-F,+insn,+insnlen'.
>
> CoreSight trace decoder has provided sufficient information to decide
> the instruction size based on the isa type: A64/A32 instruction are
> 32-bit size, but one exception is the T32 instruction size, which might
> be 32-bit or 16-bit.
>
> This patch handles for these cases and it reads the instruction values
> from DSO file; thus can support flags '-F,+insn,+insnlen'.
>
> Before:
>
>   # perf script -F,insn,insnlen,ip,sym
>                 0 [unknown] ilen: 0
>      ffff97174044 _start ilen: 0
>      ffff97174938 _dl_start ilen: 0
>      ffff97174938 _dl_start ilen: 0
>      ffff97174938 _dl_start ilen: 0
>      ffff97174938 _dl_start ilen: 0
>      ffff97174938 _dl_start ilen: 0
>      ffff97174938 _dl_start ilen: 0
>      ffff97174938 _dl_start ilen: 0
>      ffff97174938 _dl_start ilen: 0
>
>   [...]
>
> After:
>
>   # perf script -F,insn,insnlen,ip,sym
>                 0 [unknown] ilen: 0
>      ffff97174044 _start ilen: 4 insn: 2f 02 00 94
>      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
>      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
>      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
>      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
>      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
>      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
>      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
>      ffff97174938 _dl_start ilen: 4 insn: c1 ff ff 54
>
>   [...]
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Robert Walker <robert.walker@arm.com>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index ed6f7fd5b90b..b3a5daaf1a8f 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1076,6 +1076,35 @@ bool cs_etm__etmq_is_timeless(struct cs_etm_queue *etmq)
>         return !!etmq->etm->timeless_decoding;
>  }
>
> +static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
> +                             u64 trace_chan_id,
> +                             const struct cs_etm_packet *packet,
> +                             struct perf_sample *sample)
> +{
> +       /*
> +        * It's pointless to read instructions for the CS_ETM_DISCONTINUITY
> +        * packet, so directly bail out with 'insn_len' = 0.
> +        */
> +       if (packet->sample_type == CS_ETM_DISCONTINUITY) {
> +               sample->insn_len = 0;
> +               return;
> +       }
> +
> +       /*
> +        * T32 instruction size might be 32-bit or 16-bit, decide by calling
> +        * cs_etm__t32_instr_size().
> +        */
> +       if (packet->isa == CS_ETM_ISA_T32)
> +               sample->insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id,
> +                                                         sample->ip);
> +       /* Otherwise, A64 and A32 instruction size are always 32-bit. */
> +       else
> +               sample->insn_len = 4;
> +
> +       cs_etm__mem_access(etmq, trace_chan_id, sample->ip,
> +                          sample->insn_len, (void *)sample->insn);
> +}
> +
>  static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>                                             struct cs_etm_traceid_queue *tidq,
>                                             u64 addr, u64 period)
> @@ -1097,9 +1126,10 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>         sample.period = period;
>         sample.cpu = tidq->packet->cpu;
>         sample.flags = tidq->prev_packet->flags;
> -       sample.insn_len = 1;
>         sample.cpumode = event->sample.header.misc;
>
> +       cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->packet, &sample);
> +
>         if (etm->synth_opts.last_branch) {
>                 cs_etm__copy_last_branch_rb(etmq, tidq);
>                 sample.branch_stack = tidq->last_branch;
> @@ -1159,6 +1189,9 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
>         sample.flags = tidq->prev_packet->flags;
>         sample.cpumode = event->sample.header.misc;
>
> +       cs_etm__copy_insn(etmq, tidq->trace_chan_id, tidq->prev_packet,
> +                         &sample);
> +

The code seems to be correct.  I have also tested this patch.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>         /*
>          * perf report cannot handle events without a branch stack
>          */
> --
> 2.17.1
>
