Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15064C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C3420811
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbBwAzPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfCYOud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:50:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36579 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729273AbfCYOu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:50:27 -0400
Received: by mail-qt1-f193.google.com with SMTP id y36so10589672qtb.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eeX2FGRu0IMKLo1z4mtpqCiXxn6OktfznzkPx63ejRk=;
        b=sbBwAzPZq0IU6Zzk4XbJagNswHCk4sHkP9gMZkIWOsdthzdPbKlvhDLhkj1f/ElluO
         baDWXAFU/2UZEPYXxnqUztBhwh63feTxtbpazIfvt0iJAPoeeV+agdUB7MyUffO0ucjb
         N7z2y/F+pBNLdt+yiubr2opvfbXhIP7mU2SDv8x0xYqqx4SPENHckhbNzwpr33yd3dfv
         SxYrtesWWwIh87wcGFQvz29YHuHXZPEJ62gIGGyAumqlHru6JidT6ed0d97Do2skdixB
         nHx+I761ieitkrUlgqjkPGidKD8IG25N0yYtl6LrYuIa0vB3bC9bfyFTeJ/+tvp6+6z+
         YSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eeX2FGRu0IMKLo1z4mtpqCiXxn6OktfznzkPx63ejRk=;
        b=ju5AndwFNS0LUJj3SFt5nSCvEr/E3cGgITR/bvsiP27ozp732qRKXRZJGRi6azURf2
         uM35+p/j2RL8ZhPtklGgpNaDH2fSFf29aGEkvPk1iZ5LpqEDevgopY4GcAtfwJ/4xK6V
         eyhMejUnHzO4QNhyaZjxNNPsyuGPO2I4IRRb0Jrdz0Y2rFR1Rr7ohTzfNIWLzsEUg8Fh
         RdX8JNZWQap1iAGfO3LrehBODhZ0981I2ZnLK1050YGXpieNztBXQw84hZCn5O/cFL0r
         r9l39V/yhpYW/PEgJUV6MFIfH0BqlvUcjrigXNKtuZ9YybvqIoei1EnAAMdW53Orcb/V
         HZbw==
X-Gm-Message-State: APjAAAVkmjAj9iw/ImNJML+LcIS7eChB+V/WMs46kpmH22Vj7txI8nWo
        +4rBj9hDfPGvRvJLFvM4prcslx12
X-Google-Smtp-Source: APXvYqwaGd8MT5iHlTM3FPnHzcdhIVabDsgMKrZuGCPIgwTd4n14LtOBF2s1E8mVssJnrcaPOa2Xjg==
X-Received: by 2002:ac8:2d56:: with SMTP id o22mr21394021qta.321.1553525425560;
        Mon, 25 Mar 2019 07:50:25 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id t69sm8873879qke.38.2019.03.25.07.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 07:50:23 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9169E4039C; Mon, 25 Mar 2019 11:50:19 -0300 (-03)
Date:   Mon, 25 Mar 2019 11:50:19 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] perf intel-pt: Fix TSC slip
Message-ID: <20190325145019.GC6231@kernel.org>
References: <20190325135135.18348-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325135135.18348-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 25, 2019 at 03:51:35PM +0200, Adrian Hunter escreveu:
> A TSC packet can slip past MTC packets so that the timestamp appears to go
> backwards. One estimate is that can be up to about 40 CPU cycles, which is
> certainly less than 0x1000 TSC ticks, but accept slippage an order of
> magnitude more to be on the safe side.

thanks, applied to perf/urgent.

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Fixes: 79b58424b821c ("perf tools: Add Intel PT support for decoding MTC packets")
> Cc: stable@vger.kernel.org
> ---
>  .../util/intel-pt-decoder/intel-pt-decoder.c  | 20 ++++++++-----------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> index 6e03db142091..872fab163585 100644
> --- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> +++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
> @@ -251,19 +251,15 @@ struct intel_pt_decoder *intel_pt_decoder_new(struct intel_pt_params *params)
>  		if (!(decoder->tsc_ctc_ratio_n % decoder->tsc_ctc_ratio_d))
>  			decoder->tsc_ctc_mult = decoder->tsc_ctc_ratio_n /
>  						decoder->tsc_ctc_ratio_d;
> -
> -		/*
> -		 * Allow for timestamps appearing to backwards because a TSC
> -		 * packet has slipped past a MTC packet, so allow 2 MTC ticks
> -		 * or ...
> -		 */
> -		decoder->tsc_slip = multdiv(2 << decoder->mtc_shift,
> -					decoder->tsc_ctc_ratio_n,
> -					decoder->tsc_ctc_ratio_d);
>  	}
> -	/* ... or 0x100 paranoia */
> -	if (decoder->tsc_slip < 0x100)
> -		decoder->tsc_slip = 0x100;
> +
> +	/*
> +	 * A TSC packet can slip past MTC packets so that the timestamp appears
> +	 * to go backwards. One estimate is that can be up to about 40 CPU
> +	 * cycles, which is certainly less than 0x1000 TSC ticks, but accept
> +	 * slippage an order of magnitude more to be on the safe side.
> +	 */
> +	decoder->tsc_slip = 0x10000;
>  
>  	intel_pt_log("timestamp: mtc_shift %u\n", decoder->mtc_shift);
>  	intel_pt_log("timestamp: tsc_ctc_ratio_n %u\n", decoder->tsc_ctc_ratio_n);
> -- 
> 2.17.1

-- 

- Arnaldo
