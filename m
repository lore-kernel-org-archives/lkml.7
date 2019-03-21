Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD9CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D233721916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ooo3Rg35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfCUQjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:39:23 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45810 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbfCUQjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:39:22 -0400
Received: by mail-qt1-f194.google.com with SMTP id v20so7283409qtv.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EvJYP6Th87NC7DBukEZL7siMEprNA22crit+VNHzh24=;
        b=Ooo3Rg35RTwFxlhp8Rj4Isl7A1qbh6VkqR1wjIfoCga1t7gBT3My+GfXFnf7caZ4ij
         RRXYExah0zeMQefMTR6QS9WQdKQwo97gSLeDRkzw3BU/J4EDvV0VWUhdOiDPsXy7JYRo
         rGKg5GqDC8ZjY0IsoDkh0/ZhuSsaDjMNMZt6IIwmNgSyAzBaaUTFqWJ4knb7Wq3XJp6w
         cbL/Xpx0cZWAfiU8Vxv2cAPY6b7QVDkt9I2e9kfc+tun/dlHbclNVoB8aVUBdsPYJvB9
         NqE/lnwm11P+1z7WGNDnYpT9wG0YmzBTqk8SneoDiFY5UPTHj4GJXzGG415t6gDFMJ4a
         xouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EvJYP6Th87NC7DBukEZL7siMEprNA22crit+VNHzh24=;
        b=detTWCVcWOwqr71Z/rHmsCONHp5IKhAq50PaKr9gdDyWf7IvPiYvAe7F6D87ir2hho
         n9Ln6JLDx2wCBvsOuzHNhlPEIIPXQSrXtuEe9fYaeP1l/5rI/8dCg7678xPHybDKgY9Q
         ekWMJKkSWHtuoIDawRyjMn7+WPr3lddCvRuidrJZZ9r1iEuDf12MC7+tZlfAQzZ/TxMD
         6jxMOY6h4Fduf0GXWzU2F9W04qsSjKk5Upg3u+ly4eNADfuJVCgQhGqn+vIvI6L/G5iy
         epMDFoOyayy5i8mOXeOi1Ebj0mKokEGEvw3RL9znemvrvLL2wV8E7WsYv1h6HRN//Nhz
         NjYA==
X-Gm-Message-State: APjAAAU6uuS6njghEawm4ttHZPNN2Ti18x6NU2DP22ZQIh6f/cEO/v/t
        deP/IuBPLE8ZvWgRr3G4gh4=
X-Google-Smtp-Source: APXvYqwEA9Enw+H3ybuU6oeJvX0VmvJoDjOkrrDXDH8qCW8DQAp0cV3BLDf1u03gptGYiWNq8CxOpQ==
X-Received: by 2002:a0c:d483:: with SMTP id u3mr4014262qvh.54.1553186361535;
        Thu, 21 Mar 2019 09:39:21 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id g65sm2993130qkf.52.2019.03.21.09.39.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 09:39:20 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D52494039C; Thu, 21 Mar 2019 13:39:17 -0300 (-03)
Date:   Thu, 21 Mar 2019 13:39:17 -0300
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        linux-kernel@vger.kernel.org, patches@linaro.org
Subject: Re: [PATCH] perf arm64: Use local headers for target compiler
Message-ID: <20190321163917.GH3967@kernel.org>
References: <20190321161353.16198-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321161353.16198-1-daniel.thompson@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 21, 2019 at 04:13:53PM +0000, Daniel Thompson escreveu:
> Currently the set of available syscalls is generated from the
> target compilers default <asm-generic/unistd.h>
> (i.e. /usr/include/asm-generic/unistd.h on a self-hosted system).

It shouldn't, Kim?

> The numeric values are then generated by the host compiler using
> tools/include/uapi/asm/unistd.h .
> 
> This leads to some nasty version skew problems (including failed perf
> builds if you are running a bleeding edge distro and want to build an
> older version of perf for testing).
> 
> Let's make the target compiler use the local headers too.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> index c88fd32563eb..1aca6a839e4f 100755
> --- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> +++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
> @@ -56,7 +56,7 @@ create_table()
>  	echo "};"
>  }
> 
> -$gcc -E -dM -x c  $input	       \
> -	|sed -ne 's/^#define __NR_//p' \
> -	|sort -t' ' -k2 -nu	       \
> +$gcc -I $incpath/include/uapi -E -dM -x c  $input \
> +	|sed -ne 's/^#define __NR_//p'		  \
> +	|sort -t' ' -k2 -nu			  \
>  	|create_table
> --
> 2.20.1

-- 

- Arnaldo
