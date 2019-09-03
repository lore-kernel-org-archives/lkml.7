Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149B6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 22:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1322087E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 22:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LG3TxYvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfICWWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 18:22:19 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46315 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfICWWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 18:22:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id t1so313206plq.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 15:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v4D8nB92vDCp2Gu6/DC3WBi67V3T8X58MNnsX5mRdAo=;
        b=LG3TxYvV9qhgeMHFqVxsk5NsjUnYzE2kFjgNVnJpVkLEq0e1eLrXrf+fvBYCOY8Czx
         D9NkR73bqj6WPF17RfV9s1ZvaTwsYbLCFveVjSTVrR46DVplSqYN4yLEjs/Zux5PtX84
         BDvsnVXWvLQzwZJTEkbQe/Fw0lses2QKJkpAj25mSENKmsbzEMR761dbPCX6D1hm4rKq
         0vGr4qQLGtxcyCZU23v1jFDlKha89gcQbBZKwFKJKSIKI8E5XCIJetwjY0NSa2Ccw3mA
         roMaSJYg21Cjc0rEiNwBkdqeZK9c4xvG668v0iHzE9g6lXQA4QUhDiUxgGhKkertjlC8
         Rbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v4D8nB92vDCp2Gu6/DC3WBi67V3T8X58MNnsX5mRdAo=;
        b=JIThO5+ptR1MO+amKIwHeB/LxRRyLld9aNxL5k2ekLBzhWurSrmV2Tci8jyYr7y0U3
         RRjEeWABW0UH85FDvLA3roN0OL+7P5/D3/TnrcxBTLptlnq+7DFC4Fxu8QKou63sG0PJ
         Y3u1FU7w6sBXP5ShHKR12SbamuW9naRM7TYTry4V6jnctDfvOupacp1LIYAtra3TLUj0
         BXhxSBz8F4DX8VLYLr4O1bPuNKVwAARsDSutjdO+J45pT63pqnJtgNUzlG6i6kSAaiPs
         S7XPlF6Om4QZYigqOEvpSAlHuokGI4yauyChe8vjhvSuOm7NJAU385RgpnnEi7ByUT6H
         TPzQ==
X-Gm-Message-State: APjAAAUbYjN82mOTtQxs21u5q6ERn+tVLWlJp07k8FJarUnBGi4ECxiY
        obl/MyajE3EM2D04tDw/Ch/p1lpI+sA=
X-Google-Smtp-Source: APXvYqyn5DzKN1/Lwwg6UhF6U+SKJnKFnP10NW5sjtU6sjuAwoeuCDBEzngbRwIbXbX2lzathex4ZQ==
X-Received: by 2002:a17:902:e584:: with SMTP id cl4mr36593809plb.160.1567549338531;
        Tue, 03 Sep 2019 15:22:18 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r23sm554511pjo.22.2019.09.03.15.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Sep 2019 15:22:17 -0700 (PDT)
Date:   Tue, 3 Sep 2019 16:22:15 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
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
Message-ID: <20190903222215.GD25787@xps15>
References: <20190830062421.31275-1-leo.yan@linaro.org>
 <20190830062421.31275-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830062421.31275-2-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 02:24:19PM +0800, Leo Yan wrote:
> There has several code pieces need to know the instruction size, but
> now every place calculates the instruction size separately.
> 
> This patch refactors to create a new function cs_etm__instr_size() as
> a central place to analyze the instruction length based on ISA type
> and instruction value.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 44 +++++++++++++++++++++++++++-------------
>  1 file changed, 30 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index b3a5daaf1a8f..882a0718033d 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -914,6 +914,26 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
>  	return ((instrBytes[1] & 0xF8) >= 0xE8) ? 4 : 2;
>  }
>  
> +static inline int cs_etm__instr_size(struct cs_etm_queue *etmq,
> +				     u8 trace_chan_id,
> +				     enum cs_etm_isa isa,
> +				     u64 addr)
> +{
> +	int insn_len;
> +
> +	/*
> +	 * T32 instruction size might be 32-bit or 16-bit, decide by calling
> +	 * cs_etm__t32_instr_size().
> +	 */
> +	if (isa == CS_ETM_ISA_T32)
> +		insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id, addr);
> +	/* Otherwise, A64 and A32 instruction size are always 32-bit. */
> +	else
> +		insn_len = 4;
> +
> +	return insn_len;
> +}
> +
>  static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)
>  {
>  	/* Returns 0 for the CS_ETM_DISCONTINUITY packet */
> @@ -938,19 +958,23 @@ static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
>  				     const struct cs_etm_packet *packet,
>  				     u64 offset)
>  {
> +	int insn_len;
> +
>  	if (packet->isa == CS_ETM_ISA_T32) {
>  		u64 addr = packet->start_addr;
>  
>  		while (offset > 0) {
> -			addr += cs_etm__t32_instr_size(etmq,
> -						       trace_chan_id, addr);
> +			addr += cs_etm__instr_size(etmq, trace_chan_id,
> +						   packet->isa, addr);
>  			offset--;
>  		}
>  		return addr;
>  	}
>  
> -	/* Assume a 4 byte instruction size (A32/A64) */
> -	return packet->start_addr + offset * 4;
> +	/* Return instruction size for A32/A64 */
> +	insn_len = cs_etm__instr_size(etmq, trace_chan_id,
> +				      packet->isa, packet->start_addr);
> +	return packet->start_addr + offset * insn_len;

This patch will work but from where I stand it makes things difficult to
understand more than anything else.  It is also adding coupling between function
cs_etm__instr_addr() and cs_etm__instr_size(), meaning the code needs to be
carefully inspected in order to make changes to either one.

Last but not least function cs_etm__instr_size() isn't used in the upcoming
patches.  I really don't see what is gained here. 
 
Thanks,
Mathieu

>  }
>  
>  static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq,
> @@ -1090,16 +1114,8 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
>  		return;
>  	}
>  
> -	/*
> -	 * T32 instruction size might be 32-bit or 16-bit, decide by calling
> -	 * cs_etm__t32_instr_size().
> -	 */
> -	if (packet->isa == CS_ETM_ISA_T32)
> -		sample->insn_len = cs_etm__t32_instr_size(etmq, trace_chan_id,
> -							  sample->ip);
> -	/* Otherwise, A64 and A32 instruction size are always 32-bit. */
> -	else
> -		sample->insn_len = 4;
> +	sample->insn_len = cs_etm__instr_size(etmq, trace_chan_id,
> +					      packet->isa, sample->ip);
>  
>  	cs_etm__mem_access(etmq, trace_chan_id, sample->ip,
>  			   sample->insn_len, (void *)sample->insn);
> -- 
> 2.17.1
> 
