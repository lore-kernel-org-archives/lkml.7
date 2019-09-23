Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97720C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6018020820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rab4KjXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732957AbfIWRNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 13:13:30 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39241 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfIWRNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 13:13:30 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so8343117pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 10:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tfsTLDFY1ccam3FUWWjnqOYmfdpnpNmRoJABJz0j6Jw=;
        b=rab4KjXC1CDcjeIdsHH50MINA6B4H/cQqstbVol6cCKHf8vYra1z5ei7gFXzGhZ7EP
         8UDoshJz8VTK87htqLNecFQnuHN2Ros1upeW6VtbuQutaANFFrZeNKMAo2Mt9+iK13dy
         iB+LgWZOkjm70B6aiNKMch4exZwDrSmzHvw+3Rr9p3Xr8gDGSQYL3m6BDHsroTlcYXcV
         y+N8jGyOGGOPIpzuG2w2iOUZDCO/DgEBjv5thouZgICXauIz9IYxe8bsHD2wjU/ro0l/
         +hyx5B4MwnUTvBXhX7KZZspApVhXEdmo+laC4zAtkrQU8Mu8zGA8ltQVBrNQOUVVidx1
         hpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tfsTLDFY1ccam3FUWWjnqOYmfdpnpNmRoJABJz0j6Jw=;
        b=odkh0puWuDJySbYGJEpWg8A8ogSHuLHdSTqNyd7n4R62odNzMpPk660Ec1jc5x1Wrw
         wkoxnVSSiIuNCEBlFslo2uzhWmdnT/F+/HWDVjUeMKab7OI8K/STcfUxPDiCgIY9Izpj
         0i2yZUsIvO9/jW7M0S+4PgJ3YcJg+aJ6PCI//Isv6FopDmHt0xXxquU/C4ZaTBwOvZXV
         ZIOV/654SMNpq1OlE/b8xqm4vGgnUV8jUss03IIiCYG5FHTEBIosjLvM/+u9dJOO+/JY
         R0FmaYJ2+1AdI9+9RFPtCRPHuTgcy/O77oqwgIJ/LKWVJCH47znvm+xqNfD+MsBC2nGY
         T1Ig==
X-Gm-Message-State: APjAAAXNP7aeCA13JCmrXucCUPsBA9fjRSPStEAachDaUPnlD4OO8a9b
        j+BNZR1DDQ6MAzrAxadXF/BRMg==
X-Google-Smtp-Source: APXvYqy1QDC5+llAVuCG+6Lt9rco93xnDb1jqsxs2nUWrC/qkddy16J7Ri3SZxWDWN2mMuhNCaAgNg==
X-Received: by 2002:a63:f74a:: with SMTP id f10mr931166pgk.171.1569258808707;
        Mon, 23 Sep 2019 10:13:28 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([12.206.46.62])
        by smtp.gmail.com with ESMTPSA id k4sm11217132pjl.9.2019.09.23.10.13.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Sep 2019 10:13:27 -0700 (PDT)
Date:   Tue, 24 Sep 2019 01:13:25 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v2 1/5] perf cs-etm: Refactor instruction size handling
Message-ID: <20190923171325.GA29675@leoy-ThinkPad-X240s>
References: <20190923160759.14866-1-leo.yan@linaro.org>
 <20190923160759.14866-2-leo.yan@linaro.org>
 <2b675e24-8b06-fbd6-ab73-214a6afb2a07@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b675e24-8b06-fbd6-ab73-214a6afb2a07@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Mon, Sep 23, 2019 at 05:51:04PM +0100, Suzuki K Poulose wrote:
> Hi Leo,
> 
> On 23/09/2019 17:07, Leo Yan wrote:
> > In cs-etm.c there have several functions need to know instruction size
> > based on address, e.g. cs_etm__instr_addr() and cs_etm__copy_insn()
> > these two functions both calculate the instruction size separately.
> > Furthermore, if we consider to add new features later which also might
> > require to calculate instruction size.
> > 
> > For this reason, this patch refactors the code to introduce a new
> > function cs_etm__instr_size(), it will be a central place to calculate
> > the instruction size based on ISA type and instruction address.
> > 
> > For a neat implementation, cs_etm__instr_addr() will always execute the
> > loop without checking ISA type, this allows cs_etm__instr_size() and
> > cs_etm__instr_addr() have no any duplicate code with each other and both
> > functions can be changed independently later without breaking anything.
> > As a side effect, cs_etm__instr_addr() will do a few more iterations for
> > A32/A64 instructions, this would be fine if consider perf tool runs in
> > the user space.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Your changes look fine to me. However, please see my comment below.
> 
> > ---
> >   tools/perf/util/cs-etm.c | 48 +++++++++++++++++++++++-----------------
> >   1 file changed, 28 insertions(+), 20 deletions(-)
> > 
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index f87b9c1c9f9a..1de3f9361193 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -917,6 +917,26 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
> >   	return ((instrBytes[1] & 0xF8) >= 0xE8) ? 4 : 2;
> >   }
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
> >   static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
> >   {
> >   	/* Returns 0 for the CS_ETM_DISCONTINUITY packet */
> > @@ -941,19 +961,15 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
> >   				     const struct cs_etm_packet *packet,
> >   				     u64 offset)
> >   {
> > -	if (packet->isa == CS_ETM_ISA_T32) {
> > -		u64 addr = packet->start_addr;
> > +	u64 addr = packet->start_addr;
> > -		while (offset > 0) {
> > -			addr += cs_etm__t32_instr_size(etmq,
> > -						       trace_chan_id, addr);
> > -			offset--;
> > -		}
> > -		return addr;
> > +	while (offset > 0) {
> 
> Given that offset is u64, the check above is not appropriate. You could either
> change it to :
> 	while (offset) // if you are sure (s64)offset always is a postive
> integer and we always reduce it by 1.
> 
> Otherwise you may switch the offset to a signed type. I understand that this
> is not introduced by your changes. But you may fix that up in a separate patch.

Thanks a lot for the review.  Seems to me the reliable fix is to change
to a signed type.  Will add this fix in next spin.

Thanks,
Leo Yan
