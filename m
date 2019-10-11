Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AAAEECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AEF218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jy+yz6cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfJKUQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:16:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33293 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729087AbfJKUQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:16:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so6732384pfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 13:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PR46YI2RMcoiv8IfiEatQgc8ZaD0QWUbng9pxbLKT2g=;
        b=Jy+yz6cspKP36E2xWln+kXX+hRDBKhLWAYgzxCz734kBlvsoc9VIusa25mAMklPTjM
         CGRVYpf1ioSv9f7+fT+hvhHdxgmGqXO2cPhAPSGNWvTKcevKLlnFxEh8pHT5m/v28oXj
         /n8h7fnbtr0/Y0NfSf5uIU8H6FWYq2NKn2mK9pg+fZ0e6fxC4taVdvdiMQrJb9NukCaL
         tEYoPdH7J8Pxtx9jcKLwf5U1f53BePopdUr8SwpV/rGTlKek88ROJ562DmbUKQ+E0qN2
         7X4+XA73UIIcxTJDul1+A5OjLyPlQsmc0g5IEuSz5U/v67gMJK4fVmS8DQa2p9JVKGot
         7F1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PR46YI2RMcoiv8IfiEatQgc8ZaD0QWUbng9pxbLKT2g=;
        b=gR0OL3D2GkOGnmTn3CKvalb6k7PvHUmldQrYDbQ5FPLzjPQKDcTAY7tVpeFexDLDxL
         zD/749hQrHjAkspH2EiZds+me4xfoNK7T+D3L43wdkevyrODCYtBFYBAHDid7nz6m9h/
         8mEUCH5mPOK4RZVP6MuSOhbLWdCEHO4oybAZ0/yd4SnehHWYQkUQXwcC0kRG4tAv7DSO
         AAaAmyfTSVyBg/GTBWNb8oQQ+JWFgUqgg9lKCnipf2WP3+71yVRn+ORTFKNIZxfwBi6y
         lp40QVlSZlISgfVKcw3rlbrmC6rL1fnep7LK164GOKReyI7RjzqFxhG3WR7MtUGRRV/x
         mjGw==
X-Gm-Message-State: APjAAAU9uL55U+4l5o5ql1DPUcWaZleDiiD0BQs65ONovJriML6tO+7r
        1pCTmikfvJjHSXW5TJ+pw0VriA==
X-Google-Smtp-Source: APXvYqwEyiiUYWnxVo/iZMPv/NTiwhPMmTvQy5U8FMYGFAVmjoSfpr6Hd/ZFZ7xV8nl12xFAS0bILA==
X-Received: by 2002:a17:90a:1aa9:: with SMTP id p38mr20418659pjp.142.1570824969192;
        Fri, 11 Oct 2019 13:16:09 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a13sm15525313pfg.10.2019.10.11.13.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Oct 2019 13:16:08 -0700 (PDT)
Date:   Fri, 11 Oct 2019 14:16:06 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
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
Message-ID: <20191011201606.GC13688@xps15>
References: <20191005091614.11635-1-leo.yan@linaro.org>
 <20191005091614.11635-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005091614.11635-2-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 05:16:09PM +0800, Leo Yan wrote:
> If the u64 variable 'offset' is a negative integer, comparison it with
> bigger than zero is always going to be true because it is unsigned.
> Fix this by using s64 type for variable 'offset'.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 4ba0f871f086..4bc2d9709d4f 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -940,7 +940,7 @@ u64 cs_etm__last_executed_instr(const struct cs_etm_packet *packet)
>  static inline u64 cs_etm__instr_addr(struct cs_etm_queue *etmq,
>  				     u64 trace_chan_id,
>  				     const struct cs_etm_packet *packet,
> -				     u64 offset)
> +				     s64 offset)

In Suzuki's reply there was two choices, 1) move the while(offset > 0) to
while (offset) or change the type of @offset to an s64.  Here we know offset
can't be negative because of the 
        tidq->period_instructions >= etm->instructions_sample_period 

in function cs_etm__sample().  As such I think option #1 is the right way to
deal with this rather than changing the type of the variable.

Mathieu

>  {
>  	if (packet->isa == CS_ETM_ISA_T32) {
>  		u64 addr = packet->start_addr;
> @@ -1372,7 +1372,7 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
>  		 * sample is reported as though instruction has just been
>  		 * executed, but PC has not advanced to next instruction)
>  		 */
> -		u64 offset = (instrs_executed - instrs_over - 1);
> +		s64 offset = (instrs_executed - instrs_over - 1);
>  		u64 addr = cs_etm__instr_addr(etmq, trace_chan_id,
>  					      tidq->packet, offset);
>  
> -- 
> 2.17.1
> 
