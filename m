Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351EBC32771
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 22:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEC5222C4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 22:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578175310;
	bh=QAb3WwBRh8YfRR4KapHz3X/5kthUL4mmyhdgztQX2kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N2Xr10e+j+GkLDNMybMkvt9k6+5LLbz1jj7MdaxWby/272iHq0rFTB6pdff9DUuRi
	 mg55UpKNL5/tBFLBTFteDPBnBGBIR76A4QmNSi+Jc9RYwfSHMMZp3sFG3gWcojOBEB
	 f07qUMxI+r1WEwRWNhTfGfXJVWLaH3oaz/k6c76c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgADWBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 17:01:46 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46405 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgADWBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 17:01:46 -0500
Received: by mail-io1-f66.google.com with SMTP id t26so44799440ioi.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 14:01:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fnzuX2UXDHqVoWZIcnjy9706qM97ViaNzviNWp3fBBw=;
        b=hAbGG33+nMdK2SZmna+Px017IBxOGZU6ZY/zq/XpTxfxvVQfGEEXax38TnRSuxcBAx
         udDrL0t3LJ2TTRakXUetuWxWeiXfWwZKvbjUs4VuvVAA/WAlvvl3UzmNPsJVcSJQaUZN
         cRL8kG5xuMG+B7OUnuMuXlGJUfLFRgKg/Z8BjMHEnN4RIq4CxSAhXjQtaIylCT1qbAUC
         BUCJkeukb6BeW+NHk+m5adJCaGhTZ0MoS36+WQtN9pxweejpNi9/rI0/fpgLWB/nhmcz
         OII6ksbQHHuIibg0CsXgLPcqLxXN0RVO5x25YOvZ0C0xz3Gq/lbB0VXMrWS78xVCJPDu
         NrCA==
X-Gm-Message-State: APjAAAUglpgRsmiM/KcVcJQIWpguqOjKtk/IknEknlSAF69Oeuvcd5Kf
        qMYmeBV21DkyqiLuIq/0PzbKho8=
X-Google-Smtp-Source: APXvYqzzN5XT187y3wh5n7M5tjr1lz9Kh8loX7RXJ23xcA7NdAaWk2VhYMhLfgpTqxI4X6B+5q1w/Q==
X-Received: by 2002:a02:c4da:: with SMTP id h26mr75963570jaj.47.1578175305218;
        Sat, 04 Jan 2020 14:01:45 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id n5sm22215256ila.7.2020.01.04.14.01.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 14:01:44 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219b7
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Sat, 04 Jan 2020 15:01:42 -0700
Date:   Sat, 4 Jan 2020 15:01:42 -0700
From:   Rob Herring <robh@kernel.org>
To:     Odelu Kukatla <okukatla@codeaurora.org>
Cc:     georgi.djakov@linaro.org, daidavid1@codeaurora.org,
        bjorn.andersson@linaro.org, evgreen@google.com,
        Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, ilina@codeaurora.org, seansw@qti.qualcomm.com,
        elder@linaro.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [V2, 1/3] dt-bindings: interconnect: Add Qualcomm SC7180 DT
 bindings
Message-ID: <20200104220142.GA28701@bogus>
References: <1577782737-32068-1-git-send-email-okukatla@codeaurora.org>
 <1577782737-32068-2-git-send-email-okukatla@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577782737-32068-2-git-send-email-okukatla@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 02:28:55PM +0530, Odelu Kukatla wrote:
> The Qualcomm SC7180 platform has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---
>  .../bindings/interconnect/qcom,bcm-voter.yaml      |   1 +
>  .../bindings/interconnect/qcom,sc7180.yaml         | 155 ++++++++++++++++++++
>  include/dt-bindings/interconnect/qcom,sc7180.h     | 161 +++++++++++++++++++++
>  3 files changed, 317 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,sc7180.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
> index 74f0715..55c9f34 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
> @@ -19,6 +19,7 @@ description: |
>  properties:
>    compatible:
>      enum:
> +      - qcom,sc7180-bcm-voter
>        - qcom,sdm845-bcm-voter
>  
>  required:
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
> new file mode 100644
> index 0000000..487da5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sc7180.yaml
> @@ -0,0 +1,155 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
