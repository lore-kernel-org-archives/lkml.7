Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA6EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9D62086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POUp9Ap4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733108AbfHHN3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:29:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46155 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732882AbfHHN3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:29:37 -0400
Received: by mail-qt1-f195.google.com with SMTP id h21so92049521qtn.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 06:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iyc1YP6OFH2uDUA0k0oJuyk7GU8Aks6UEWf3is5LGJ0=;
        b=POUp9Ap4Y7t9JD1UUpV1y/2KLeRrgKlCLtA/UznM2RXtpDtPrNJi+egWYoetU+qlI1
         vJ8Luiu7UPBUE0Zv0Jj3S9dy+sLkgQrWFK0Y1zlehjDmQeqjuZyPHSvJ4SJDM0+JWpfa
         rI+tWSiy4H97vjPT43kOIyjUuKshki9iUVYEvaBMYxOtwLv5vUxe7jpeLw+IrkvsfaR6
         5gbbavYNlXsffEvga6gZx+Otqu0k1e44oixC3DSePiNMYJhuwIkd79GOK2evOJ0tvaRl
         cJpY2N2aTf9YW42b7P7WL5w8yO9z6QiM2NX6yTpLRGHzB+l4TbkqRzsop6pWopBpfiEd
         w04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iyc1YP6OFH2uDUA0k0oJuyk7GU8Aks6UEWf3is5LGJ0=;
        b=P8rbweKoVkStRWm6Iow3nOkeYz8fBp+RpjCIA7jjztiyFCJbupMOM0pYRS7uP5ltBq
         olZrE6PViC5+Rwh9Z15GkOdaSvmihVfZr7zqZvQn39RlRSD6ZsVFJmGKGXfKx7AAI2Hm
         CqzP6vCnROYBwW/T4GuorvSvHvmFL4IWDu4S++CCH3jd9s2tbjDdzogX6dvPnvwyAOrW
         a+VVLmf8EGQpjxEbahAC8Pmk56emIQAVca5/sdevfx0KqpjmGqoVVDwWxsh5NLjC7+Fw
         vOcmS9CFvX7CWJ6z32G2IX7sLtPPahWxufKvI4bmMB5cBY/C5uQssnFdMDIddrj6pbEk
         GquQ==
X-Gm-Message-State: APjAAAU1YT4LR8+JvA7k34YAq+UGWQn3D22Hu8QfPrrTsM9HpAE0ebvk
        F4iWXBZn+9QVYyiBs5kkvDILalmx
X-Google-Smtp-Source: APXvYqxK3q9cJAftPQfz762EBoTD9d2JUzisMr/GPxYSaDmHI6XfgryMNdp0tnCAQwCKwTcR0fH2oA==
X-Received: by 2002:a0c:9163:: with SMTP id q90mr13450522qvq.37.1565270976709;
        Thu, 08 Aug 2019 06:29:36 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id x206sm43235556qkb.127.2019.08.08.06.29.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 06:29:35 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3C0C640340; Thu,  8 Aug 2019 10:29:33 -0300 (-03)
Date:   Thu, 8 Aug 2019 10:29:33 -0300
To:     zhe.he@windriver.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, kan.liang@linux.intel.com, eranian@google.com,
        alexey.budankov@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf: Fix failure to set cpumask when only one cpu
Message-ID: <20190808132933.GB19444@kernel.org>
References: <1564734592-15624-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564734592-15624-1-git-send-email-zhe.he@windriver.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 02, 2019 at 04:29:51PM +0800, zhe.he@windriver.com escreveu:
> From: He Zhe <zhe.he@windriver.com>
> 
> The buffer containing string used to set cpumask is overwritten by end of
> string later in cpu_map__snprint_mask due to not enough memory space, when
> there is only one cpu. And thus causes the following failure.
> 
> $ perf ftrace ls
> failed to reset ftrace
> 
> This patch fixes the calculation of cpumask string size.

Please next time add this as well:

Fixes: dc23103278c5 ("perf ftrace: Add support for -a and -C option")

Applied,

- Arnaldo
 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  tools/perf/builtin-ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 66d5a66..0193128 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -173,7 +173,7 @@ static int set_tracing_cpumask(struct cpu_map *cpumap)
>  	int last_cpu;
>  
>  	last_cpu = cpu_map__cpu(cpumap, cpumap->nr - 1);
> -	mask_size = (last_cpu + 3) / 4 + 1;
> +	mask_size = last_cpu / 4 + 2; /* one more byte for EOS */
>  	mask_size += last_cpu / 32; /* ',' is needed for every 32th cpus */
>  
>  	cpumask = malloc(mask_size);
> -- 
> 2.7.4

-- 

- Arnaldo
