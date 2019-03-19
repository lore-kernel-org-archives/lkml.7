Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA77C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BF42077B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oLf3fEdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfCSWaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:30:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42319 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfCSWaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 18:30:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so191547pgh.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 15:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1ihOMB6tDzEVpgHcmcETXwu68mh/dUNctOqaps6UdPQ=;
        b=oLf3fEddkJv3m4cXDJyXbNexoEZnAZPnc0Y1dxXaKnfAbgeBxVA+IcE0KvEsBqHoLw
         W3z6XGjPMO2XzwUrqIuS9UhFHe7GyjE/WCTLjQnnUOfRIjGL2FtUf4uNze2wGI9icT4k
         Cwq12/W23/0YLmHTckgEtwg8wihBQu4IqSLkc7trVASKaQbEuHlxpvAhED9DHSZx01R7
         eQLaEbHQdbSwaNpfm5gcing69ezM50kcDU2DiBo09Dbe6TyzptizgEGoVjGudLnt7v5V
         Hi2Z6eRectmj5bWKW2TQpDoc9zwEf24uSuZoF4TOjMQgM7hvJNw+jym76KJDUj4nNmYM
         T6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1ihOMB6tDzEVpgHcmcETXwu68mh/dUNctOqaps6UdPQ=;
        b=L2hi+sPzlDPbzGKjABRu4fL6wFSU1lWiDrXMhC3yzcLYrwJl7Z5Jsx3AHGGDs1Z3IS
         o22eJ+yOvv0E4zrKAgWG2iY/YzfUgpcLHCZji4fOrQvrj/L+r0OSVr6vrECujzCv3Dst
         AneWeER4oAfgG0Cpyvlszwb8/pa2zJ9JorG0zEi+fskiJUYtmg918KMGLSO4MhF8+5s7
         v6QzViCAyBTVXwPrj/yEO96IoaYxbpXL+Rq0Uqm0dk4fMgKsIHnNEJ1SPzaEujuaID4d
         9YQE1MgLR1X/wdQxIoBarDGOgfDrdCFUxLXA/qV4R+9S9+J8iMwc5OktpeDPMpFvBdxq
         UfMg==
X-Gm-Message-State: APjAAAU2YDDw/RbfolGSeOpdZCX7VKfjpT5MzaDXnikz2Z9SqfD6wyeU
        XXxcfQMap4hVVv+h5XViROCA8g==
X-Google-Smtp-Source: APXvYqxUcbamGUbqDXKB5i6Nu6No79qCWq2b2Ukg75KJdTrYg4JfzfLZ7d6B/7ofMVhbtn/nDEysBg==
X-Received: by 2002:a65:6498:: with SMTP id e24mr4020537pgv.346.1553034616957;
        Tue, 19 Mar 2019 15:30:16 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l84sm103253pfb.113.2019.03.19.15.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 15:30:16 -0700 (PDT)
Date:   Tue, 19 Mar 2019 16:30:14 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Solomon Tan <solomonbstoner@protonmail.ch>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH] perf tools: Add missing case value
Message-ID: <20190319223014.GA22834@xps15>
References: <3nn0Oz_O4h6XtTJG1laQxwROZTgcDRxgu5Cq-bAgZNZsSDHYZzofDlIOMhBzkh1KAXok8Ekqk9Ev68umhEZPS7SyRgoJ-eA02GFC2QNbaLs=@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3nn0Oz_O4h6XtTJG1laQxwROZTgcDRxgu5Cq-bAgZNZsSDHYZzofDlIOMhBzkh1KAXok8Ekqk9Ev68umhEZPS7SyRgoJ-eA02GFC2QNbaLs=@protonmail.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Solomon,

On Tue, Mar 19, 2019 at 04:11:37PM +0000, Solomon Tan wrote:
> This patch fixes the following error message during compilation of `tools/perf`, as seen in https://github.com/Linaro/OpenCSD/issues/17.

The rule for changelogs is the same as it is for patches, i.e lines should be
wrapped at 80 characters.  Also it is not a good idea to reference a github
issue since it is bound to disappear over time.  Just mentioning you
encountered a compilation error will do just fine.

> 
> ```
>   CC       util/intel-pt-decoder/intel-pt-log.o
>   CC       util/cs-etm-decoder/cs-etm-decoder.o
> util/cs-etm-decoder/cs-etm-decoder.c: In function ‘cs_etm_decoder__buffer_range’:
> util/cs-etm-decoder/cs-etm-decoder.c:370:2: error: enumeration value ‘OCSD_INSTR_WFI_WFE’ not handled in switch [-Werror=switch-enum]
>   switch (elem->last_i_type) {
>   ^~~~~~

The above is over 80 characters but it should be kept that way because this is
what you got from the compiler.


>   CC       util/intel-pt-decoder/intel-pt-decoder.o
> cc1: all warnings being treated as errors
> ```
> 
> Signed-off-by: solomon-ubuntu <solomonbstoner@protonmail.ch>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 8c155575c6c5..2a8bf6b45a30 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -374,6 +374,7 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
>  		break;
>  	case OCSD_INSTR_ISB:
>  	case OCSD_INSTR_DSB_DMB:
> +	case OCSD_INSTR_WFI_WFE:

Perfect.

Because we are using an enumeration that can only be found in version 11 of the
library, compiling with version 10 will also give us an error.  As such we need
to bump the mandatory version number in "tools/build/feature/test-libopencsd.c".

Your next revision should read [PATCH v3], because it will be the third
iteration of it.

Mathieu

>  	case OCSD_INSTR_OTHER:
>  	default:
>  		packet->last_instr_taken_branch = false;
> -- 
> 
> 2.17.1



