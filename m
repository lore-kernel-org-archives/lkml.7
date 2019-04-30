Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB92C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E822147A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 01:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRuJvOfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbfD3BHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 21:07:46 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34871 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfD3BHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 21:07:45 -0400
Received: by mail-yw1-f67.google.com with SMTP id n188so2114864ywe.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 18:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ii5I8j9JBuiHdsFz4/aqjjOUNbjy8Zm8aunVEplypu0=;
        b=lRuJvOfXBmlqyKzC+YU6LdcihtX/VukOFtrX/XxNSvN8jB66ULMjIHrrU48WK4b6yp
         Zc9EtVBB3WdryrYCq8OQ5iyEy7WaVma8eQ8G+vu7s6VkGbep5ZOajC34s9mpM6yizVS9
         l95U/kl8uEDvieUoPU0h2UlibECMknJpC9dyxWJyp9VPNTp6ejvFKfY5us82Z7eh0A2M
         QPR+sFmFWT/gKdXTzIIU4veQAmGFZlaOr6WFlvMnQjtEXICnlL2R9l24HN2KO5huJlEy
         IICKtHuf5O+oUKgx7soqJTErkI32pWtu2xq+gNZ8B0pbuX9O/ZiqwUPdmt0zFTwDLwF4
         FGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ii5I8j9JBuiHdsFz4/aqjjOUNbjy8Zm8aunVEplypu0=;
        b=ryj5V0MhD6ofxr0v1U3PCgrqoOj8XNe4wLy60LaNVEV/Xgfp/+LmLDZre78FvGmAJF
         ZXknhR27KAal1LcPYnQ8j62Wx8HkEFAKuywfnGXvdE1ALUciuRjXPCWdb+6OJohI+wk0
         6c/6FEp5ouO31LVUjLzjN52lXQ/ETUKsnYH7DwqzsIXD5VzfmLlf1lB9/vteDnDNH8K5
         k8tAhSWYwr3u9at2Y6915on9nZkfWdkUWJ+3DAx/usxvXvj/kjq7r7Jr4CQQtsj/K7CB
         cGz75BTrIJcmi4qJzyKZ+xmF/nOtqWN5KnzeQC9YxB43aNKUQqb/6ufK83/9pewjBrZA
         yUhw==
X-Gm-Message-State: APjAAAUOdi4+jE4t0eo5zq83zksGXk9yEaa6gwfNDID88JmgdTEFa7c4
        r/z2lU/1th0b8s55kRoqnbSXIyU0
X-Google-Smtp-Source: APXvYqz4zg+voT11rsRed8BcaxDuR7U6rJC49t27bTwsIo8dgVs9KB40BI7cwPllz9d0IFiExsXz9Q==
X-Received: by 2002:a0d:c9c7:: with SMTP id l190mr54943974ywd.181.1556586464548;
        Mon, 29 Apr 2019 18:07:44 -0700 (PDT)
Received: from quaco.ghostprotocols.net (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id 205sm3988886ywm.98.2019.04.29.18.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 18:07:43 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 36DC44111F; Mon, 29 Apr 2019 21:07:42 -0400 (EDT)
Date:   Mon, 29 Apr 2019 21:07:42 -0400
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf cs-etm: Always allocate memory for
 cs_etm_queue::prev_packet
Message-ID: <20190430010742.GD7857@kernel.org>
References: <20190428083228.20246-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190428083228.20246-1-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Apr 28, 2019 at 04:32:27PM +0800, Leo Yan escreveu:
> Robert Walker reported a segmentation fault is observed when process
> CoreSight trace data; this issue can be easily reproduced by the
> command 'perf report --itrace=i1000i' for decoding tracing data.
> 
> If neither the 'b' flag (synthesize branches events) nor 'l' flag
> (synthesize last branch entries) are specified to option '--itrace',
> cs_etm_queue::prev_packet will not been initialised.  After merging
> the code to support exception packets and sample flags, there
> introduced a number of uses of cs_etm_queue::prev_packet without
> checking whether it is valid, for these cases any accessing to
> uninitialised prev_packet will cause crash.
> 
> As cs_etm_queue::prev_packet is used more widely now and it's already
> hard to follow which functions have been called in a context where the
> validity of cs_etm_queue::prev_packet has been checked, this patch
> always allocates memory for cs_etm_queue::prev_packet.
> 
> Reported-by: Robert Walker <robert.walker@arm.com>
> Suggested-by: Robert Walker <robert.walker@arm.com>
> Fixes: 7100b12cf474 ("perf cs-etm: Generate branch sample for exception packet")

Thanks, applied both to perf/urgent, testing them now in the containers.

- Arnaldo

> Fixes: 24fff5eb2b93 ("perf cs-etm: Avoid stale branch samples when flush packet")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 110804936fc3..054b480aab04 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -422,11 +422,9 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
>  	if (!etmq->packet)
>  		goto out_free;
>  
> -	if (etm->synth_opts.last_branch || etm->sample_branches) {
> -		etmq->prev_packet = zalloc(szp);
> -		if (!etmq->prev_packet)
> -			goto out_free;
> -	}
> +	etmq->prev_packet = zalloc(szp);
> +	if (!etmq->prev_packet)
> +		goto out_free;
>  
>  	if (etm->synth_opts.last_branch) {
>  		size_t sz = sizeof(struct branch_stack);
> -- 
> 2.17.1

-- 

- Arnaldo
