Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2BBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AA72183F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEtsd40S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfCSOzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:55:33 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33214 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfCSOz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:55:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id b12so320556pgk.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AqRGEoPq/X3Km9cde8F/L1+ww2j2o9nFvXqHkiGpnsc=;
        b=VEtsd40SRz40xNTt94Z/F3mqizpInMc4NmCEVaAvSlkW/0H97nD88tVc2M4rRDecm6
         4oNeQpW1QK0QZMRAtrk4WM+Dvnw315Jc0hGKzGDOBjoQLOT0sO8hG0AB+GmqY7uJuWNY
         DNVtiSf/t1dojXdNoJrzf133YpPjYa9B6GMQ/rV6CZHCtfjr/35I19Lfa6FNXigOlvwW
         JXYSrEx27+53FrqmaABVDoWZtiM8mV8AqSHK28lwVVMzrZVPRrBC7Ra5gOgmeDoVADx5
         lubd/FT+iYxbWAtnsmjzTsyVNvnmzSECJpVAaunIH0esQNoxGKRoH1hgQaHnv2WURfPI
         HKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AqRGEoPq/X3Km9cde8F/L1+ww2j2o9nFvXqHkiGpnsc=;
        b=pYv0UqyJgTiwgqdCDGPo7e2s8RiILVpaAXR1BnQp6JN9kEYUg0bmmANDelSrXq/vYO
         KyRFGFKvSQvm57AjX8BxbrHcklfHZbhDBT1UkY0GnVHhE5qXdilcg2DDBP+7YQMU59Pl
         jniG4zU/ljeBZFc1PGZZhatyb9qfv1xo4gZpH/MyhagP7YkpWbc4bwTzyZGsavycHDX+
         k/KIsyRcsx9arvS8jzuyUyKdgiqKILsm1mdpGuXbuo2O4zgyQB/dLBr0LvJ28rlp75rW
         HCNZq6heTmwuX8do8c/8HnqNtd7e3tY/PoGgJ1cyK27iahZcuam1xt1K5OmnfZXsGIhF
         3iWw==
X-Gm-Message-State: APjAAAWrUjLaPBCTNxguy2wr/TAHyetdhtgjV0hSCK/GrqDT1CaFI5sz
        d3H33tD6iQNVu7Fg2dSejwSWjQ==
X-Google-Smtp-Source: APXvYqy3yGawH1CDoZGBVKhyCxArbbv50UsPvbHRTkcZw/F1DdXZ4YwNPw2U/TwKqsEJazAXYDAjkw==
X-Received: by 2002:a65:6497:: with SMTP id e23mr22690728pgv.21.1553007328782;
        Tue, 19 Mar 2019 07:55:28 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a13sm15285212pgw.91.2019.03.19.07.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 07:55:28 -0700 (PDT)
Date:   Tue, 19 Mar 2019 08:55:25 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Yue Haibing <yuehaibing@huawei.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] perf tools: return errcode in
 cs_etm__process_auxtrace_info
Message-ID: <20190319145525.GA7394@xps15>
References: <20190315022649.17848-1-yuehaibing@huawei.com>
 <20190318171518.GH22548@kernel.org>
 <CANLsYkzU25wAx0dMQqMVZ2asx+z-taOfffLO7DMd6mkDXc7D9A@mail.gmail.com>
 <20190319144631.GE3029@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319144631.GE3029@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 11:46:31AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 19, 2019 at 08:38:32AM -0600, Mathieu Poirier escreveu:
> > On Mon, 18 Mar 2019 at 11:15, Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Fri, Mar 15, 2019 at 10:26:49AM +0800, Yue Haibing escreveu:
> > > > From: YueHaibing <yuehaibing@huawei.com>
> > > >
> > > > 'err' is set in err path, but it's not returned to callers.
> > > > Also fix a pass zero to PTR_ERR issue.
> > >
> > > Next time please submit two patches, one for the PTR_ERR and another for
> > > not throwing away the err = -E!INVAL and returning just -EINVAL, I'm
> > > doing it this time.
> > >
> > 
> > Please hold off on that - I've asked for other modifications to be
> > done on this patch.
> 
> Do you really think that it is necessary to hold? The fixes are trivial
> and I already have them split and applied, see them below, I think
> whatever other changes can be done in further patches, no?

Proceeding with the patches below would created two new bugs, hence asking Yue
for modifications.

Mathieu  

> 
> - Arnaldo
> 
> From 6c5c248935a4da12a582b1518a38ec35044833ee Mon Sep 17 00:00:00 2001
> From: YueHaibing <yuehaibing@huawei.com>
> Date: Fri, 15 Mar 2019 10:26:49 +0800
> Subject: [PATCH 24/42] perf cs-etm: return errcode in
>  cs_etm__process_auxtrace_info()
> 
> 'err' is set in err path, but it's not returned to callers. Don't always return
> -EINVAL, return err.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Fixes: cd8bfd8c973e ("perf tools: Add processing of coresight metadata")
> Link: http://lkml.kernel.org/r/20190315022649.17848-1-yuehaibing@huawei.com
> [ split from a larger patch ]
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/cs-etm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 110804936fc3..2257ac4dbff2 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2023,5 +2023,5 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  err_free_hdr:
>  	zfree(&hdr);
>  
> -	return -EINVAL;
> +	return err;
>  }
> -- 
> 2.20.1
> 
> From 4ab1e71e45a91220bdca7fc3b79c600df81d9234 Mon Sep 17 00:00:00 2001
> From: YueHaibing <yuehaibing@huawei.com>
> Date: Fri, 15 Mar 2019 10:26:49 +0800
> Subject: [PATCH 25/42] perf cs-etm: Remove errnoeous ERR_PTR() usage in in
>  cs_etm__process_auxtrace_info
> 
> intlist__findnew() doesn't uses ERR_PTR() as a return mechanism so its callers
> shouldn't try to extract the error using PTR_ERR(ret-from-intlist__findnew()),
> make cs_etm__process_auxtrace_info9) return -ENOMEM instead.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Fixes: cd8bfd8c973e ("perf tools: Add processing of coresight metadata")
> Link: http://lkml.kernel.org/r/20190315022649.17848-1-yuehaibing@huawei.com
> [ split from a larger patch ]
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/cs-etm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 2257ac4dbff2..111f33cd1204 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1908,7 +1908,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  
>  		/* Something went wrong, no need to continue */
>  		if (!inode) {
> -			err = PTR_ERR(inode);
> +			err = -ENOMEM;
>  			goto err_free_metadata;
>  		}
>  
> -- 
> 2.20.1
> 
