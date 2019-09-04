Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7492FC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2A821726
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HZ5faUwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbfIDRGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:06:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36793 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732017AbfIDRGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:06:22 -0400
Received: by mail-io1-f66.google.com with SMTP id b136so21711757iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 10:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWNb1KSAFEmmY5w8yG302PcIPe2SuoPdam4dGfCxDfE=;
        b=HZ5faUwJw7/wU/k3Y2Vgs7HiF9k1kgLeFCZBfQPDb/z1bH4CdhHbL+B+++R56yQMln
         hZm2C914OdEYTaurIXeLwyzL21qf4yKYY4lkCfZQo6Gggrv6eR9IPHzHEIaESFJ0D4fO
         id2035l3TqmpJSdTaQok2XyP0IdMHoUmtluz4tn4EVVW3Y4vZJSx0AGGGNuh1MjJ35MW
         3ZwPIE2pCe6Tpge+7uf4d0W9mXjzXa5A4JPxGH4K5cpCNUZYIdTut5vA8O4DEr9Zwydr
         hL2b0W54njHDP07K5B5cvAcnIzJ1Nb+T26wHEPi055ovCVIDnidVx8ZSeHA0cfYUXbRn
         WSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWNb1KSAFEmmY5w8yG302PcIPe2SuoPdam4dGfCxDfE=;
        b=kEZIVhVCrPvy1j6XFUI74buwt0SXovPaRc+7aTBPsDLYVZtYXuXJjv2Z8EKQd4XZ6e
         9QWG6+2GpJR3nYURoF+6UNGeSieyGJfHE4omSS+Rnq8ivlw8iW1ENfhPEigJ3/Z/9KGf
         k4GTJ5wlFoP1XYV2duCwim185RpHpzU0KVNPyFrHVvMFIr6WOIoYMOakmjWc3uUkaIld
         RgervKrqnWjM5uETV4O/EWjh7NsKvVSMXI3LUwIdLvhXPP/4KDNQ7aIwN4wf7tXckb9M
         leXocJSjvgZI+24nOsKmRxnhbZyKwmne1z2HnY1t7/VG/JF5qxjTLsbMx6VU30Qb9cK1
         scLA==
X-Gm-Message-State: APjAAAUTgXOlN0u2rvsVPv8TTQa9wwV019sZbK1Q0lAvtQWujNZow61t
        jsExrJhRqvsX2qhJniIVct1dNL+jlgNONp6ZSs8UeQ==
X-Google-Smtp-Source: APXvYqylPXYEynWMJWR9zE1N/P0arzr4mBEtHZmslWgue0DjdUKF4W8KhK02621IE5g896WCHwTX5Tg05io390ED0xY=
X-Received: by 2002:a6b:7a07:: with SMTP id h7mr10405442iom.57.1567616781826;
 Wed, 04 Sep 2019 10:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190830062421.31275-1-leo.yan@linaro.org> <20190830062421.31275-2-leo.yan@linaro.org>
 <20190903222215.GD25787@xps15> <20190904091916.GB27922@leoy-ThinkPad-X240s>
In-Reply-To: <20190904091916.GB27922@leoy-ThinkPad-X240s>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 4 Sep 2019 11:06:10 -0600
Message-ID: <CANLsYkwZXyzWqK1oiEg0hb99J89KfdNPsFOmS7G1XJ0xvoUc0Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] perf cs-etm: Refactor instruction size handling
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <Robert.Walker@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019 at 03:19, Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Mathieu,
>
> On Tue, Sep 03, 2019 at 04:22:15PM -0600, Mathieu Poirier wrote:
> > On Fri, Aug 30, 2019 at 02:24:19PM +0800, Leo Yan wrote:
> > > There has several code pieces need to know the instruction size, but
> > > now every place calculates the instruction size separately.
> > >
> > > This patch refactors to create a new function cs_etm__instr_size() as
> > > a central place to analyze the instruction length based on ISA type
> > > and instruction value.
> > >
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > ---
> > >  tools/perf/util/cs-etm.c | 44 +++++++++++++++++++++++++++-------------
> > >  1 file changed, 30 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > > index b3a5daaf1a8f..882a0718033d 100644
> > > --- a/tools/perf/util/cs-etm.c
> > > +++ b/tools/perf/util/cs-etm.c
> > > @@ -914,6 +914,26 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
> > >     return ((instrBytes[1] & 0xF8) >= 0xE8) ? 4 : 2;
> > >  }
> > >
> > > +static inline int cs_etm__instr_size(struct cs_etm_queue *etmq,
> > > +                                u8 trace_chan_id,
> > > +                                enum cs_etm_isa isa,
> > > +                                u64 addr)
> > > +{
> > > +   int insn_len;
> > > +
> > > +   /*
> > > +    * T32 instruction size might be 32-bit or 16-bit, decide by calling
> > > +    * cs_etm__t32_instr_size().
> > > +    */
> > > +   if (isa == CS_ETM_ISA_T32)
> > > +           insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id, addr);
> > > +   /* Otherwise, A64 and A32 instruction size are always 32-bit. */
> > > +   else
> > > +           insn_len = 4;
> > > +
> > > +   return insn_len;
> > > +}
> > > +
> > >  static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
> > >  {
> > >     /* Returns 0 for the CS_ETM_DISCONTINUITY packet */
> > > @@ -938,19 +958,23 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
> > >                                  const struct cs_etm_packet *packet,
> > >                                  u64 offset)
> > >  {
> > > +   int insn_len;
> > > +
> > >     if (packet->isa == CS_ETM_ISA_T32) {
> > >             u64 addr = packet->start_addr;
> > >
> > >             while (offset > 0) {
> > > -                   addr += cs_etm__t32_instr_size(etmq,
> > > -                                                  trace_chan_id, addr);
> > > +                   addr += cs_etm__instr_size(etmq, trace_chan_id,
> > > +                                              packet->isa, addr);
> > >                     offset--;
> > >             }
> > >             return addr;
> > >     }
> > >
> > > -   /* Assume a 4 byte instruction size (A32/A64) */
> > > -   return packet->start_addr + offset * 4;
> > > +   /* Return instruction size for A32/A64 */
> > > +   insn_len = cs_etm__instr_size(etmq, trace_chan_id,
> > > +                                 packet->isa, packet->start_addr);
> > > +   return packet->start_addr + offset * insn_len;
> >
> > This patch will work but from where I stand it makes things difficult to
> > understand more than anything else.  It is also adding coupling between function
> > cs_etm__instr_addr() and cs_etm__instr_size(), meaning the code needs to be
> > carefully inspected in order to make changes to either one.
>
> My purpose is to use a same place to calculate the instruction
> size, rather than to spread the duplicate codes in several different
> functions.
>
> > Last but not least function cs_etm__instr_size() isn't used in the upcoming
> > patches.  I really don't see what is gained here.
>
> Sorry that I forgot to commit my final change into patch 02.
>
> I planed to use cs_etm__instr_size() in patch 02; patch 02 has
> function cs_etm__add_stack_event(), which also needs to get the
> instruction size when it sends stack event.
>
> After apply patch 02, tools/perf/util/cs-etm.c will have below three
> functions to caculate instruction size; this is the main reason I want
> to refactor the code for instruction size.
>
>   cs_etm__instr_addr()
>   cs_etm__copy_insn()
>   cs_etm__add_stack_event()
>
> If this lets code more difficult to understand, will drop it.
>

I agree with the consolidation but for that to work function
cs_etm__instr_addr() needs to be refactored.  Since
cs_etm__instr_size() is already taking care of checking the ISA type
the while() loop in cs_etm__instr_addr() can be done regardless of the
operation mode.  That way cs_etm__instr_size() can be changed at will
without breaking anything.

The downside is that we are doing a few more iterations... Which isn't
that big a deal considering we are in user space.  We can think about
some optimisation if it is ever proven to be a bottleneck.

Let me know if you see a problem with that approach.

Regards,
Mathieu

> Thanks,
> Leo Yan
>
> > >  }
> > >
> > >  static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq,
> > > @@ -1090,16 +1114,8 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
> > >             return;
> > >     }
> > >
> > > -   /*
> > > -    * T32 instruction size might be 32-bit or 16-bit, decide by calling
> > > -    * cs_etm__t32_instr_size().
> > > -    */
> > > -   if (packet->isa == CS_ETM_ISA_T32)
> > > -           sample->insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id,
> > > -                                                     sample->ip);
> > > -   /* Otherwise, A64 and A32 instruction size are always 32-bit. */
> > > -   else
> > > -           sample->insn_len = 4;
> > > +   sample->insn_len = cs_etm__instr_size(etmq, trace_chan_id,
> > > +                                         packet->isa, sample->ip);
> > >
> > >     cs_etm__mem_access(etmq, trace_chan_id, sample->ip,
> > >                        sample->insn_len, (void *)sample->insn);
> > > --
> > > 2.17.1
> > >
