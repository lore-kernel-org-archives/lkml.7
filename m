Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50962C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B13E21882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EIIpKwYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfGCUDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:03:04 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42096 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfGCUDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:03:04 -0400
Received: by mail-io1-f68.google.com with SMTP id u19so7796193ior.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 13:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UKh+fnCjeVqcQm0IwUHZUc5vltmZ8E0kqz9Ok6uJVI4=;
        b=EIIpKwYigj//ohw/Hx/d7USCLYQ6Yz7CE5EleU+SyrJULC2Fj/eLP/4fOYzc89xM75
         8ifdTZ2G88o7ItmphKYgUPbJB+abRou6TKyNi7KyE+2xJEXze5Lp4Z9e5BNv8RchqzQ9
         wEdy6vOTEm2EaFnEJxAfuww3pGtAweWtCXg3SkK4hTV3xFwZeQr3Sc/G5MBsWKrFSkLm
         xjrb1E3oqGmHMNVHWVZ8gxN3WOr6b/PsqLUhI9snTyH8Z9pnjPntS9aFwjJ6i6+P01xf
         iR1aDSllthbZYMqBxEdAPvCd592QwZ1nwWYrXyD1vmy2zvCAJODbOW4U/7pkPL5ePznv
         OK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UKh+fnCjeVqcQm0IwUHZUc5vltmZ8E0kqz9Ok6uJVI4=;
        b=rvFUk6ztCD3BTCxN286UClnocog+gKUF518LSZmykmwhcHcUBFwbr2T51qodiMnfah
         LMNU+0LAqYWslT439V3wNZ9TjAOFd0OufLxml9lv8YSik7uqCvpmtYTc9Duh67fypKpx
         NFeShz3BoIogzZuwe6gOU9sQlu7pW+drNWw4tbVMEiBX3HvN+ZY94MDLSmiWEq+ETUde
         QL1f94QCVzMjiCp10hTSADv6ztf7lyUyEv8UTC+6pf5/Vn/vRgKrLAmpduM3puE6DaZQ
         MtaKEH9UhvqcxBQOMkLovPRAK8cFIIQqTdw9GVULog8Ns6ninpHN3+DkKXHevBnV9mCr
         6sig==
X-Gm-Message-State: APjAAAWJGjcjg3blFufzvL78/iBZZNrBSlE5HJKEhRXOy947+UxUOjTY
        L3LqBMGE5WTLrBz6PQiOoy8XydoILNMDKwXeUe3+QQ==
X-Google-Smtp-Source: APXvYqwoE6c94VoRDisMNtWzyjcFI4tXdYpggqbejcxRg98CE8mWN8SWLgyCum0KXlMbwrRNVk/eX+bCnISJDGHcvbo=
X-Received: by 2002:a02:7642:: with SMTP id z63mr31807037jab.36.1562184183245;
 Wed, 03 Jul 2019 13:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561659046.git.saiprakash.ranjan@codeaurora.org> <2afedb941294af7ba0658496b4aca3759a4e43ff.1561659046.git.saiprakash.ranjan@codeaurora.org>
In-Reply-To: <2afedb941294af7ba0658496b4aca3759a4e43ff.1561659046.git.saiprakash.ranjan@codeaurora.org>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 3 Jul 2019 14:02:52 -0600
Message-ID: <CANLsYkxvh+qUDvqG45o7qh61Noq=a=BJ4-p68ipdzxYt6n5bNA@mail.gmail.com>
Subject: Re: [PATCHv5 1/2] dt-bindings: coresight: Change CPU phandle to
 required property
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, 27 Jun 2019 at 12:15, Sai Prakash Ranjan
<saiprakash.ranjan@codeaurora.org> wrote:
>
> Do not assume the affinity to CPU0 if cpu phandle is omitted.
> Update the DT binding rules to reflect the same by changing it
> to a required property.
>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

I'm all good with this patch - can you pick this up for the coming
merge window?  If not I'll simply keep it in my tree for 5.4.

Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
>  .../devicetree/bindings/arm/coresight-cpu-debug.txt       | 4 ++--
>  Documentation/devicetree/bindings/arm/coresight.txt       | 8 +++++---
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt b/Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
> index 298291211ea4..f1de3247c1b7 100644
> --- a/Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
> @@ -26,8 +26,8 @@ Required properties:
>                 processor core is clocked by the internal CPU clock, so it
>                 is enabled with CPU clock by default.
>
> -- cpu : the CPU phandle the debug module is affined to. When omitted
> -       the module is considered to belong to CPU0.
> +- cpu : the CPU phandle the debug module is affined to. Do not assume it
> +        to default to CPU0 if omitted.
>
>  Optional properties:
>
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index 8a88ddebc1a2..fcc3bacfd8bc 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -59,6 +59,11 @@ its hardware characteristcs.
>
>         * port or ports: see "Graph bindings for Coresight" below.
>
> +* Additional required property for Embedded Trace Macrocell (version 3.x and
> +  version 4.x):
> +       * cpu: the cpu phandle this ETM/PTM is affined to. Do not
> +         assume it to default to CPU0 if omitted.
> +
>  * Additional required properties for System Trace Macrocells (STM):
>         * reg: along with the physical base address and length of the register
>           set as described above, another entry is required to describe the
> @@ -87,9 +92,6 @@ its hardware characteristcs.
>         * arm,cp14: must be present if the system accesses ETM/PTM management
>           registers via co-processor 14.
>
> -       * cpu: the cpu phandle this ETM/PTM is affined to. When omitted the
> -         source is considered to belong to CPU0.
> -
>  * Optional property for TMC:
>
>         * arm,buffer-size: size of contiguous buffer space for TMC ETR
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
