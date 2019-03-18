Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E96EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D50F20989
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBKzrEJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfCRRPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:15:25 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46601 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfCRRPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:15:24 -0400
Received: by mail-qk1-f194.google.com with SMTP id i5so10069922qkd.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dgaO6oHExQgqrDiT0LFdt8wcG/3033chQZa+K8pujnw=;
        b=RBKzrEJ50lp/R82I+jL0n3zSiIRX9JrZRraTrb81XTxRtIzgwJP/U3LWTGRyULbD4n
         VkxJcRaOUZ5Bv7k/h5Pso8esY/CFGb1OyZuR6RLwi4OxS0JdQcUidUvNBTrgbomXLjqO
         9BitbD+3uzSiRu/GeVMzxSn6XO/KJPSfWNOToymVAj92i1F17UH1L8yHspbQ0sWpXqxh
         PK4cQCFXR+TznumPvf/njCnOHd7+1oc51vKkAEFWHqkyvHY2+XkFRQp0fTXXJanAbatp
         zf7Fs5UtWu987YtRjFLfgNuwg8OraLTTDTMDydRl4eChumTuSoV48HXaWMU+SlGAPwxu
         JQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dgaO6oHExQgqrDiT0LFdt8wcG/3033chQZa+K8pujnw=;
        b=W5smvkc4kcxC4mzGP1LWShBWpvydbSMrsGmETBHGR5L3nm/SBM+8DNN0MJKtzcSeiX
         Up8WWHpvrL7P1lzpUXS3koxQcIuFgiZqtsT7lP9elCv01GdTO66wPMim0aJYcfhSRxwO
         qZX4Kw/esgq2zXp61kxMXb5nBKfCFBAkIFZpxEHlqY43/h2dHIVGrY2ltf9Eo9+s7GUH
         GxDYJMFsFcN+7R/8jqEU90Kx+eHNZnhpNi992W1wAN9SSZ/m82d4CaG7fQ7ACB/Nyxjm
         oE4vhnWHfw8WRjcf//H2WzMWE0rcIxsFO1jORhEjXVlOJYFVAEEeh1HWhIeUJI6XKery
         z0Ng==
X-Gm-Message-State: APjAAAUPSrK9WPxB4VFZvjP1K6FX9f/TER3V5qJ3etb/dr+IXP1RZ5Cs
        1A9pSkkxBnIM5Po3O8lQI2SLFm0y
X-Google-Smtp-Source: APXvYqw3VZT61bpyCZgr5xJmrzks4Cz21Yy6/11S7Oi66L66/ob945i2YhIgufPC33XgbtWkbJ+o1A==
X-Received: by 2002:a37:6042:: with SMTP id u63mr12864969qkb.289.1552929323317;
        Mon, 18 Mar 2019 10:15:23 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id w1sm6731574qtc.75.2019.03.18.10.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 10:15:22 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6EB634039C; Mon, 18 Mar 2019 14:15:18 -0300 (-03)
Date:   Mon, 18 Mar 2019 14:15:18 -0300
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf tools: return errcode in
 cs_etm__process_auxtrace_info
Message-ID: <20190318171518.GH22548@kernel.org>
References: <20190315022649.17848-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315022649.17848-1-yuehaibing@huawei.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 15, 2019 at 10:26:49AM +0800, Yue Haibing escreveu:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> 'err' is set in err path, but it's not returned to callers.
> Also fix a pass zero to PTR_ERR issue.

Next time please submit two patches, one for the PTR_ERR and another for
not throwing away the err = -E!INVAL and returning just -EINVAL, I'm
doing it this time.
 
 - Arnaldo

> Fixes: cd8bfd8c973e ("perf tools: Add processing of coresight metadata")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  tools/perf/util/cs-etm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 1108049..111f33c 100644
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
> @@ -2023,5 +2023,5 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  err_free_hdr:
>  	zfree(&hdr);
>  
> -	return -EINVAL;
> +	return err;
>  }
> -- 
> 2.7.0
> 

-- 

- Arnaldo
