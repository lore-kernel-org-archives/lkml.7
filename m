Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9211CC3A59E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 01:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F33520644
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 01:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zEk9eINn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730664AbfIEBvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 21:51:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40000 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfIEBvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 21:51:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id y10so473843pll.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 18:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RnN4Pl89tE4oGJrxfwKaqE/Zg00kWXDojSuymJXMutc=;
        b=zEk9eINnn51Q7ICigSrLK8Tbtgr58u5sDyfvvYPF87ng/z15AhrsLpjkRYZsQM8CWf
         akBNDrMziB7qOj0B+HJVwf2GvVjVGbgwH1nwpDrS8M50puPKO4C75JHQdXRX7PsOSX6G
         PCthEX6CFsA2aZkP0Sdy58f9TpvSuvvdAckfo/MsVHnboKRAxCU3QN9y1hjaozXyeqMA
         L+MayBoj3Cm6wc5SCeckhcjJ4Lm2XIU7M2c1IC3btw/V+//XB8UFtxEsYce6ROgEpu01
         J8uabifQbZ/MZlbruZxfCV+RvycWBMOE8UHrPVWn2w+GoIwGrtQv5nCn9SlIWfnSiWIq
         HWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RnN4Pl89tE4oGJrxfwKaqE/Zg00kWXDojSuymJXMutc=;
        b=dwIVwUgWCpbFQ8XP4KFFxX7dZfsyVO50/lLc2zPyDeU7YFXOc6v1Q/fVEKZ/VR3MBK
         FwosqknPOP0ljSHk5qstQ8KaDqBTSuTnddwZXR7YJaR5GfNqH1Ez8FqBawDlOH83EcHJ
         PpXEANBHMFa17oN8pJk+xfEF8cLL72Gya19um2NIPst6G04VkSpjDJzgl7NtbY1XkawT
         kzJor14ShMSMAVmFVL11rAH59ekAUvWaiLWMzSRUT7sJTaAZK4qx7E/e4qvCuJAsVFRf
         k/pfhXZvyybSX/KVAJtpTqqAi8QusbK9Lknbj29FQHsqaPm/dRosHAaqViwtgv1AOwwF
         Xevw==
X-Gm-Message-State: APjAAAW7x4IjgEVJQnywuKXFTsEruXMH62mvTPvAJmRMpB4kt9DW4Cc2
        IGOMNxHBcLvXT26g1qOG3TPqrg==
X-Google-Smtp-Source: APXvYqxXpDlN7EbgJ6HFf1hkGp5YqdJ7MjCJUR9KfoWroVajwGuDiTuhWUPcZ5UZUmfxRV1bFWFqBA==
X-Received: by 2002:a17:902:a418:: with SMTP id p24mr769701plq.259.1567648263049;
        Wed, 04 Sep 2019 18:51:03 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([240e:e0:f82b:586c:3108:a89c:3a26:34f3])
        by smtp.gmail.com with ESMTPSA id k14sm365167pfi.98.2019.09.04.18.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 18:51:02 -0700 (PDT)
Date:   Thu, 5 Sep 2019 09:50:32 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
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
Subject: Re: [PATCH v1 1/3] perf cs-etm: Refactor instruction size handling
Message-ID: <20190905015032.GA10141@leoy-ThinkPad-X240s>
References: <20190830062421.31275-1-leo.yan@linaro.org>
 <20190830062421.31275-2-leo.yan@linaro.org>
 <20190903222215.GD25787@xps15>
 <20190904091916.GB27922@leoy-ThinkPad-X240s>
 <CANLsYkwZXyzWqK1oiEg0hb99J89KfdNPsFOmS7G1XJ0xvoUc0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkwZXyzWqK1oiEg0hb99J89KfdNPsFOmS7G1XJ0xvoUc0Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Wed, Sep 04, 2019 at 11:06:10AM -0600, Mathieu Poirier wrote:
> On Wed, 4 Sep 2019 at 03:19, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > Hi Mathieu,
> >
> > On Tue, Sep 03, 2019 at 04:22:15PM -0600, Mathieu Poirier wrote:
> > > On Fri, Aug 30, 2019 at 02:24:19PM +0800, Leo Yan wrote:
> > > > There has several code pieces need to know the instruction size, but
> > > > now every place calculates the instruction size separately.
> > > >
> > > > This patch refactors to create a new function cs_etm__instr_size() as
> > > > a central place to analyze the instruction length based on ISA type
> > > > and instruction value.
> > > >
> > > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > > > ---
> > > >  tools/perf/util/cs-etm.c | 44 +++++++++++++++++++++++++++-------------
> > > >  1 file changed, 30 insertions(+), 14 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > > > index b3a5daaf1a8f..882a0718033d 100644
> > > > --- a/tools/perf/util/cs-etm.c
> > > > +++ b/tools/perf/util/cs-etm.c
> > > > @@ -914,6 +914,26 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
> > > >     return ((instrBytes[1] & 0xF8) >= 0xE8) ? 4 : 2;
> > > >  }
> > > >
> > > > +static inline int cs_etm__instr_size(struct cs_etm_queue *etmq,
> > > > +                                u8 trace_chan_id,
> > > > +                                enum cs_etm_isa isa,
> > > > +                                u64 addr)
> > > > +{
> > > > +   int insn_len;
> > > > +
> > > > +   /*
> > > > +    * T32 instruction size might be 32-bit or 16-bit, decide by calling
> > > > +    * cs_etm__t32_instr_size().
> > > > +    */
> > > > +   if (isa == CS_ETM_ISA_T32)
> > > > +           insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id, addr);
> > > > +   /* Otherwise, A64 and A32 instruction size are always 32-bit. */
> > > > +   else
> > > > +           insn_len = 4;
> > > > +
> > > > +   return insn_len;
> > > > +}
> > > > +
> > > >  static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
> > > >  {
> > > >     /* Returns 0 for the CS_ETM_DISCONTINUITY packet */
> > > > @@ -938,19 +958,23 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
> > > >                                  const struct cs_etm_packet *packet,
> > > >                                  u64 offset)
> > > >  {
> > > > +   int insn_len;
> > > > +
> > > >     if (packet->isa == CS_ETM_ISA_T32) {
> > > >             u64 addr = packet->start_addr;
> > > >
> > > >             while (offset > 0) {
> > > > -                   addr += cs_etm__t32_instr_size(etmq,
> > > > -                                                  trace_chan_id, addr);
> > > > +                   addr += cs_etm__instr_size(etmq, trace_chan_id,
> > > > +                                              packet->isa, addr);
> > > >                     offset--;
> > > >             }
> > > >             return addr;
> > > >     }
> > > >
> > > > -   /* Assume a 4 byte instruction size (A32/A64) */
> > > > -   return packet->start_addr + offset * 4;
> > > > +   /* Return instruction size for A32/A64 */
> > > > +   insn_len = cs_etm__instr_size(etmq, trace_chan_id,
> > > > +                                 packet->isa, packet->start_addr);
> > > > +   return packet->start_addr + offset * insn_len;
> > >
> > > This patch will work but from where I stand it makes things difficult to
> > > understand more than anything else.  It is also adding coupling between function
> > > cs_etm__instr_addr() and cs_etm__instr_size(), meaning the code needs to be
> > > carefully inspected in order to make changes to either one.
> >
> > My purpose is to use a same place to calculate the instruction
> > size, rather than to spread the duplicate codes in several different
> > functions.
> >
> > > Last but not least function cs_etm__instr_size() isn't used in the upcoming
> > > patches.  I really don't see what is gained here.
> >
> > Sorry that I forgot to commit my final change into patch 02.
> >
> > I planed to use cs_etm__instr_size() in patch 02; patch 02 has
> > function cs_etm__add_stack_event(), which also needs to get the
> > instruction size when it sends stack event.
> >
> > After apply patch 02, tools/perf/util/cs-etm.c will have below three
> > functions to caculate instruction size; this is the main reason I want
> > to refactor the code for instruction size.
> >
> >   cs_etm__instr_addr()
> >   cs_etm__copy_insn()
> >   cs_etm__add_stack_event()
> >
> > If this lets code more difficult to understand, will drop it.
> >
> 
> I agree with the consolidation but for that to work function
> cs_etm__instr_addr() needs to be refactored.  Since
> cs_etm__instr_size() is already taking care of checking the ISA type
> the while() loop in cs_etm__instr_addr() can be done regardless of the
> operation mode.  That way cs_etm__instr_size() can be changed at will
> without breaking anything.
> 
> The downside is that we are doing a few more iterations... Which isn't
> that big a deal considering we are in user space.  We can think about
> some optimisation if it is ever proven to be a bottleneck.
> 
> Let me know if you see a problem with that approach.

Yes, your approach is neat; I will try it in next patch version.

Thanks a lot for suggestion!

[...]
