Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E765C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE6323402
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 09:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="unXN/Rre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbfIDJT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:19:26 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38452 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfIDJTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 05:19:25 -0400
Received: by mail-yw1-f65.google.com with SMTP id f187so7032662ywa.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OPjd5RoXO1B0dvJpxf2pMwsgeferMb+CMB+0Se3R+aw=;
        b=unXN/RreWEWxBaEhGFvnUFZekaDtmpmXJg5Q42kLwiPiVSkfsYin0dYhw4tnjEfHd+
         MysHc5qx2xwiDUaOlHzMTEsGAVFXGnB5KbCeRFPW3I2xjkoG1876UQxAmBewrq5ZeV6C
         KMgQPXqudZvzCh40y12n3CDnd1nBZxDGRQ+eZ81n9F6DWLCu0c6KPrHep5/z60OkaT8G
         tYBjCn+TelwAn8Z6miw2wcJRwKpgkgeIadifxyHOpwgXFpQT3/3kQ2hDrTZtRIXJQ0rb
         jEGZi34qxTlKdE2izWAGxbwiu2UuysDrmPBatAagJkPKpWu6DhdKyOHFsEnMJ8QzSUAJ
         72yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OPjd5RoXO1B0dvJpxf2pMwsgeferMb+CMB+0Se3R+aw=;
        b=jJ/OARyM7WCoas9jOuBaBnOsXfIR9OWlPUA4TVcW7lrv0lwtQWU3zS3RLf1OXgPzkp
         KlkPx3qWsXmVoPsILcgGgwAEkhXtzqtEnDoSUkvhg9E30CBjEiiIo0ha2LzLwpbhxVAa
         WcEAkOluHYTCEztmW7GivBhQesp3wH0c/egpJ/E1rsjOQ/uNnS+C/cS06IMySPKtyGEG
         v1RKpX2cTCeVjZzPoWfhTfFNdqanf46IxVTziG+SFt4iVWmA0SS8qqr7MFv1n1ubGkSp
         d9DzeWQ+q5sUYTSK01rl/DM8jSD4vzwc4KAURm3OMis7brCix2Wr9DUQMSJ3ctpiwDkX
         M5Vg==
X-Gm-Message-State: APjAAAUeNpomCldfkXts4wQgVim7GUgdpgkriz4YVDMtSUX+4vaglxtO
        8W767+ZsqHx6YOdMxy5/l4obzA==
X-Google-Smtp-Source: APXvYqz47cWxK4IGcklYRoE1hotXBCyaLIhAESacqRHHAXJkXrQyR3CVeim/mz6R+LKakgY02qLGtA==
X-Received: by 2002:a81:1c0c:: with SMTP id c12mr25444005ywc.262.1567588764397;
        Wed, 04 Sep 2019 02:19:24 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1320-244.members.linode.com. [45.79.221.244])
        by smtp.gmail.com with ESMTPSA id 10sm2038410ywf.60.2019.09.04.02.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 02:19:23 -0700 (PDT)
Date:   Wed, 4 Sep 2019 17:19:16 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <Robert.Walker@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1 1/3] perf cs-etm: Refactor instruction size handling
Message-ID: <20190904091916.GB27922@leoy-ThinkPad-X240s>
References: <20190830062421.31275-1-leo.yan@linaro.org>
 <20190830062421.31275-2-leo.yan@linaro.org>
 <20190903222215.GD25787@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903222215.GD25787@xps15>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On Tue, Sep 03, 2019 at 04:22:15PM -0600, Mathieu Poirier wrote:
> On Fri, Aug 30, 2019 at 02:24:19PM +0800, Leo Yan wrote:
> > There has several code pieces need to know the instruction size, but
> > now every place calculates the instruction size separately.
> > 
> > This patch refactors to create a new function cs_etm__instr_size() as
> > a central place to analyze the instruction length based on ISA type
> > and instruction value.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm.c | 44 +++++++++++++++++++++++++++-------------
> >  1 file changed, 30 insertions(+), 14 deletions(-)
> > 
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index b3a5daaf1a8f..882a0718033d 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -914,6 +914,26 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
> >  	return ((instrBytes[1] & 0xF8) >= 0xE8) ? 4 : 2;
> >  }
> >  
> > +static inline int cs_etm__instr_size(struct cs_etm_queue *etmq,
> > +				     u8 trace_chan_id,
> > +				     enum cs_etm_isa isa,
> > +				     u64 addr)
> > +{
> > +	int insn_len;
> > +
> > +	/*
> > +	 * T32 instruction size might be 32-bit or 16-bit, decide by calling
> > +	 * cs_etm__t32_instr_size().
> > +	 */
> > +	if (isa == CS_ETM_ISA_T32)
> > +		insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id, addr);
> > +	/* Otherwise, A64 and A32 instruction size are always 32-bit. */
> > +	else
> > +		insn_len = 4;
> > +
> > +	return insn_len;
> > +}
> > +
> >  static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
> >  {
> >  	/* Returns 0 for the CS_ETM_DISCONTINUITY packet */
> > @@ -938,19 +958,23 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
> >  				     const struct cs_etm_packet *packet,
> >  				     u64 offset)
> >  {
> > +	int insn_len;
> > +
> >  	if (packet->isa == CS_ETM_ISA_T32) {
> >  		u64 addr = packet->start_addr;
> >  
> >  		while (offset > 0) {
> > -			addr += cs_etm__t32_instr_size(etmq,
> > -						       trace_chan_id, addr);
> > +			addr += cs_etm__instr_size(etmq, trace_chan_id,
> > +						   packet->isa, addr);
> >  			offset--;
> >  		}
> >  		return addr;
> >  	}
> >  
> > -	/* Assume a 4 byte instruction size (A32/A64) */
> > -	return packet->start_addr + offset * 4;
> > +	/* Return instruction size for A32/A64 */
> > +	insn_len = cs_etm__instr_size(etmq, trace_chan_id,
> > +				      packet->isa, packet->start_addr);
> > +	return packet->start_addr + offset * insn_len;
> 
> This patch will work but from where I stand it makes things difficult to
> understand more than anything else.  It is also adding coupling between function
> cs_etm__instr_addr() and cs_etm__instr_size(), meaning the code needs to be
> carefully inspected in order to make changes to either one.

My purpose is to use a same place to calculate the instruction
size, rather than to spread the duplicate codes in several different
functions.

> Last but not least function cs_etm__instr_size() isn't used in the upcoming
> patches.  I really don't see what is gained here. 

Sorry that I forgot to commit my final change into patch 02.

I planed to use cs_etm__instr_size() in patch 02; patch 02 has
function cs_etm__add_stack_event(), which also needs to get the
instruction size when it sends stack event.

After apply patch 02, tools/perf/util/cs-etm.c will have below three
functions to caculate instruction size; this is the main reason I want
to refactor the code for instruction size.

  cs_etm__instr_addr()
  cs_etm__copy_insn()
  cs_etm__add_stack_event()

If this lets code more difficult to understand, will drop it.

Thanks,
Leo Yan

> >  }
> >  
> >  static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq,
> > @@ -1090,16 +1114,8 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
> >  		return;
> >  	}
> >  
> > -	/*
> > -	 * T32 instruction size might be 32-bit or 16-bit, decide by calling
> > -	 * cs_etm__t32_instr_size().
> > -	 */
> > -	if (packet->isa == CS_ETM_ISA_T32)
> > -		sample->insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id,
> > -							  sample->ip);
> > -	/* Otherwise, A64 and A32 instruction size are always 32-bit. */
> > -	else
> > -		sample->insn_len = 4;
> > +	sample->insn_len = cs_etm__instr_size(etmq, trace_chan_id,
> > +					      packet->isa, sample->ip);
> >  
> >  	cs_etm__mem_access(etmq, trace_chan_id, sample->ip,
> >  			   sample->insn_len, (void *)sample->insn);
> > -- 
> > 2.17.1
> > 
