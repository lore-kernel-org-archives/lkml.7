Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97900C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6481821874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PSbZPlRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfCUQ1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:27:08 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41975 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfCUQ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:27:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id k11so4531111pgb.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=DD1eYKJWyKLJ94L1PCQWbhNv/JYGYxBOA+soWcMaAAA=;
        b=PSbZPlRGUqs60g+Z3oXwAga1DaTcpSzZHCgKimPRMNiDvtTURgkDqHopQbhmWW2OSz
         y8K6BsjzL4/4LfpyQ9XOCT3A/Xuz+EXqL2WVOYGkjF+zWYqo6DBa9PPMOdVlzCfiDGL3
         hQzku95Ls6mn7PryTu7TINonlASuaP4ny9M2nEdit9G0VaaSQJNghTMgC5wqwzCqKmKD
         mLvgAlz7gyYQu8WwAZesK24yEbOfLzzPfkhpKTiqO3itqZjcd5p8kLtCVy2d9KYa4ad4
         mX7mWo+32uhYhsIOJ2gbV4TZZ6/E6qCjZ86pVnxOG3cMAiWr7DGqBFnLraxUZbBlsVKL
         JJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DD1eYKJWyKLJ94L1PCQWbhNv/JYGYxBOA+soWcMaAAA=;
        b=Ij0+KJZb2k/txIfUfpEsGaoDccHUeb/5QuCaOgF853t0c1ViSzXcrArRJRu8B+A+OF
         7Iz2DpYY5nBO9T4Sp4/NJboNPEFKtl+WiGaz+8+iZjqFadrW/dRO1YhY/y6kQddqFvwk
         x7tYsnFtZmvDYNpN//hxsH8oGYLdS/p+MfhiN5TQXWW8CgWpvHYRH4UHgwwnSNWAhHDf
         +9qzStrCf/9j/ZVN7SSCz8qD9yZ3ZC8m7HKEcb40QYDskjzJX1e64f3tge48pUdDuK3E
         Xu9EIAPVriyhK4rraCsQwV+f/jp/KGhgydi63H92+DrMk9PNqi3+rhkDeofm4u90pIR0
         8nhQ==
X-Gm-Message-State: APjAAAV7FlRnUyZR9T9ffREe5ttTJQJNCMOOzbVSrAcWCayJD1aS7wHQ
        RqfoF3TTceMpL0WsRWTbzgZQcA==
X-Google-Smtp-Source: APXvYqyHwHRz/M3M1UGb2a5Ede5+FnJ9B1fc3/p5/0fIJ7XB/rTTjPRXpIM0tvn5XjOmKX+IaAAr0Q==
X-Received: by 2002:a17:902:b43:: with SMTP id 61mr4392967plq.83.1553185625327;
        Thu, 21 Mar 2019 09:27:05 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q207sm7189518pgq.88.2019.03.21.09.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 09:27:04 -0700 (PDT)
Date:   Thu, 21 Mar 2019 10:27:02 -0600
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
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "robert.walker@arm.com" <robert.walker@arm.com>,
        "acme@redhat.com" <acme@redhat.com>
Subject: Re: [PATCH v4] perf tools: Add missing case value
Message-ID: <20190321162702.GA24451@xps15>
References: <iXDQnAbT-yValKlLnwDyoyBCwymrdxjykuMsgI4Cxau_e2ib9QYVroNDbJgZz3kuxTTaPJnyzRWmEY0TpEZDVQBSdElz9K9R0tAz79Qkp2s=@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <iXDQnAbT-yValKlLnwDyoyBCwymrdxjykuMsgI4Cxau_e2ib9QYVroNDbJgZz3kuxTTaPJnyzRWmEY0TpEZDVQBSdElz9K9R0tAz79Qkp2s=@protonmail.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 01:29:11AM +0000, Solomon Tan wrote:
> The following error was thrown when compiling `tools/perf` using OpenCSD
> v0.11.1. This patch fixes said error.
> ```
>   CC       util/intel-pt-decoder/intel-pt-log.o
>   CC       util/cs-etm-decoder/cs-etm-decoder.o
> util/cs-etm-decoder/cs-etm-decoder.c: In function
> ‘cs_etm_decoder__buffer_range’:
> util/cs-etm-decoder/cs-etm-decoder.c:370:2: error: enumeration value ‘OCSD_INSTR_WFI_WFE’ not handled in switch [-Werror=switch-enum]
>   switch (elem->last_i_type) {
>   ^~~~~~
>   CC       util/intel-pt-decoder/intel-pt-decoder.o
> cc1: all warnings being treated as errors
> ```
> 
> Because `OCSD_INSTR_WFI_WFE` case was added only in v0.11.0, the minimum
> required OpenCSD library version for this patch is no longer v0.10.0.
> 
> Signed-off-by: Solomon Tan <solomonbstoner@protonmail.ch>
> ---
>  tools/build/feature/test-libopencsd.c           | 4 ++--
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
> index d68eb4fb40cc..2b0e02c38870 100644
> --- a/tools/build/feature/test-libopencsd.c
> +++ b/tools/build/feature/test-libopencsd.c
> @@ -4,9 +4,9 @@
>  /*
>   * Check OpenCSD library version is sufficient to provide required features
>   */
> -#define OCSD_MIN_VER ((0 << 16) | (10 << 8) | (0))
> +#define OCSD_MIN_VER ((0 << 16) | (11 << 8) | (0))
>  #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
> -#error "OpenCSD >= 0.10.0 is required"
> +#error "OpenCSD >= 0.11.0 is required"
>  #endif
> 
>  int main(void)
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index ba4c623cd8de..39fe21e1cf93 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -387,6 +387,7 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
>                 break;
>         case OCSD_INSTR_ISB:
>         case OCSD_INSTR_DSB_DMB:
> +       case OCSD_INSTR_WFI_WFE:
>         case OCSD_INSTR_OTHER:
>         default:
>                 packet->last_instr_taken_branch = false;
> --
> 2.19.1

On my side this patch is no different from V3, i.e it doesn't pass checkpatch
and it doesn't apply on my next tree.

Mathieu

> 

pub   RSA 2048/C88289A6 2018-05-09 solomonbstoner@protonmail.ch <solomonbstoner@protonmail.ch>
> sub   RSA 2048/7C5E8D6D 2018-05-09
> 


