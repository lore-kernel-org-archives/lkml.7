Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96567ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8182089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W2e51Z68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439356AbfJQJEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:04:45 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:34786 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbfJQJEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:04:44 -0400
Received: by mail-vk1-f195.google.com with SMTP id d126so347808vkb.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 02:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3YEZ6kmrwj0jmNEINZ5DrxfXAkCY+f5snursTVbXw/Q=;
        b=W2e51Z687HKzqeEUxw8//AMcHGkkuFOP8XPRGjOfymWxiy5Zp1IsFw7JpdMcbsWu2b
         3XRp9hda4U35V3m4NBdsGLbwORsP7M6z6hcLgkBMeNdc6Kv9H54zl1XG8UyqG3oVaiRA
         uYXbj1yTpmGTc5+j3xXkUibu704TmnkPoO2sjQNeCRQIL58QuDsOIAezBG7b14OxBFv6
         5FbrylzIeAFhCyolzRmA8yt6ll3bpHI/fYR97EcEQ3jn9UGLTrm83xRCCHz8AS86pmze
         m1mdnFdbPnS0BElbdxvOVcKomZv+rfTKsUOZ1i3MKBNxnh2hdw7vJ49G7aVlAm37710n
         WkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3YEZ6kmrwj0jmNEINZ5DrxfXAkCY+f5snursTVbXw/Q=;
        b=J9uZPWmvwTkCh+IsFHbjLAhvRpcBJ6em5WTSgsGU0U4tcdP7I+T7RCuu3dEOKuPKfs
         plsYdjBdNvZbmNTwqL8omTu7Om8iyd+Ymx9cOZHhRNtPjK0ZsOWlZdGjEy5+1/xboUSz
         MxpHDTWfpZCwlovy+CzzEG3rzLQqr3mDrMxa7jSQhqKh0mVOIQYAIyB6MGtBScts3Cfy
         yRvlPCVdbP/6n/uH2lFeVk1JRPEjDk9qFPf6MYRbCqvN7ZayJiHLdKcDz3s+gl5zMinT
         VEGrBBhI5zW5TKt7f7M6aSr3Y4ZbNe+GNVwMlfjKRa/8rFvPVHXsNQmsJmqqdIP7kQW9
         lSSA==
X-Gm-Message-State: APjAAAUB5RappM1v7HBubBdzOsCB18JC9aQpf5q05GN872DTFEo6VlUm
        10stPznqqxkyHccjHCE9kaWZDO8IhOb0cZNwWP+EOg==
X-Google-Smtp-Source: APXvYqyt8CM8fHUNAOrVRVddOgQGQx8mRNb41o6lI3llgLFlyRzgA5YeS309L///NMZr8TxyMVq1MEKf6S7M8tbxb2E=
X-Received: by 2002:a1f:b202:: with SMTP id b2mr1313280vkf.59.1571303083600;
 Thu, 17 Oct 2019 02:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <1571254641-13626-1-git-send-email-thara.gopinath@linaro.org> <1571254641-13626-7-git-send-email-thara.gopinath@linaro.org>
In-Reply-To: <1571254641-13626-7-git-send-email-thara.gopinath@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Oct 2019 11:04:07 +0200
Message-ID: <CAPDyKFqcKfmnNJ7j4Jb+JH739FBcHg5NBD6aR4H_N=zWGwm1ww@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] dt-bindings: soc: qcom: Extend RPMh power
 controller binding to describe thermal warming device
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, amit.kucheria@verdurent.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019 at 21:37, Thara Gopinath <thara.gopinath@linaro.org> wrote:
>
> RPMh power controller hosts mx domain that can be used as thermal
> warming device. Add a sub-node to specify this.
>
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/qcom,rpmpd.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> index eb35b22..fff695d 100644
> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.txt
> @@ -18,6 +18,16 @@ Required Properties:
>  Refer to <dt-bindings/power/qcom-rpmpd.h> for the level values for
>  various OPPs for different platforms as well as Power domain indexes
>
> += SUBNODES
> +RPMh alsp hosts power domains that can behave as thermal warming device.
> +These are expressed as subnodes of the RPMh. The name of the node is used
> +to identify the power domain and must therefor be "mx".
> +
> +- #cooling-cells:
> +       Usage: optional
> +       Value type: <u32>
> +       Definition: must be 2
> +

Just wanted to express a minor thought about this. In general we use
subnodes of PM domain providers to represent the topology of PM
domains (subdomains), this is something different, which I guess is
fine.

I assume the #cooling-cells is here tells us this is not a PM domain
provider, but a "cooling device provider"?

Also, I wonder if it would be fine to specify "power-domains" here,
rather than using "name" as I think that is kind of awkward!?

>  Example: rpmh power domain controller and OPP table
>
>  #include <dt-bindings/power/qcom-rpmhpd.h>
> --
> 2.1.4
>

Kind regards
Uffe
