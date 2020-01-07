Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DA8C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 05:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC93220678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 05:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MtqDiXAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgAGF2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 00:28:39 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39265 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgAGF2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 00:28:37 -0500
Received: by mail-qv1-f67.google.com with SMTP id y8so20059603qvk.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 21:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LrovKwm+jPRAKOqa0FyTlwwhDmCZ3Mza1hSSAiPcdyE=;
        b=MtqDiXAL12AeJPWBUKa0PuyE6cxZyNgdZBT8RetZ3anpcZjnYU2Z/vlfeOkWLoxQiW
         s5ydKbF6FWq0p3Z/mPVk5BBZEpn/k8brjogMHnHSJdOeb5wfGTFxl/hXoALIr1zXYI2n
         +NWOJ13qjrWEslS+XaPx44uskG7aNyUS8sU18GukZii808jjkdkv0hYtJl68/hQPK6/X
         9pijLCY6VczH3XtThl47JFuGuihn5YLowK8kOOxc2kMDItOOMM2Ec9HJPkX+rX65Ndor
         r6exxXB9Sh9o4RFpji5U0KYFoZPZb0CwQFXPJYYUy5gbVW4o1V3OHvsD3+BcLgEfGTep
         GppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrovKwm+jPRAKOqa0FyTlwwhDmCZ3Mza1hSSAiPcdyE=;
        b=R9wB0yo+3M0zUMkA+mTiCZDK2jkl3cMORLVxWXgeiyAhqMfdyVRhpkYmMi1Cjl5hk+
         kbp8tB/meWsoeyhQUpFwCcBnnWwPJqurowxI5F3IBwjdHsJtTnpDyd2W0n9mYd+KmDN4
         RiM372NsW51Xcjd8GTLiD0lgCCefhgLW7uGwQKD2UyFv55c3fsPFrdEF8lr8e+54NIKZ
         nUvleOrn+Q4H7fngiBPsprMG0T+/iTS0mVhG12bDB/SMWak3OgA2DZ7HYkpO86hRVpds
         EPEX9gtu7ZJZr17pv3cRs6rm36cWkDQCfGDr1bysvsO5X/vv1aos0B19sD8t4qSsdU+3
         soWA==
X-Gm-Message-State: APjAAAUd4oDCqsVfwFfjmY1H06qeHziviUxBeBT/CTp+fY6bALnXVT3G
        9TQAvoNLCqJ8/F8S2YNpx1giGh3R9nJWqA+jIyrzQQ==
X-Google-Smtp-Source: APXvYqyJn9I0DKa741yo+rZndYTlijoLIkHjVG5v1f6oc56h+ugdyOL9zZuDDOwzy2oaNgIKBCAKbWDGORgiOE17Noo=
X-Received: by 2002:a0c:fa4b:: with SMTP id k11mr81417595qvo.55.1578374916826;
 Mon, 06 Jan 2020 21:28:36 -0800 (PST)
MIME-Version: 1.0
References: <1578317369-16045-1-git-send-email-rkambl@codeaurora.org> <1578317369-16045-3-git-send-email-rkambl@codeaurora.org>
In-Reply-To: <1578317369-16045-3-git-send-email-rkambl@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 7 Jan 2020 10:58:25 +0530
Message-ID: <CAP245DVdrTyn_h=anra21Psfh5znxKSz-mGM5P72v4aJYTJUwA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: thermal: tsens: Add configuration in yaml
To:     Rajeshwari <rkambl@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sanm@codeaurora.org, sivaa@codeaurora.org, manaf@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 7:00 PM Rajeshwari <rkambl@codeaurora.org> wrote:
>
> Added configuration in dt-bindings for SC7180.
>
> Signed-off-by: Rajeshwari <rkambl@codeaurora.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> index eef13b9..c0ed030 100644
> --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> @@ -38,6 +38,7 @@ properties:
>            - enum:
>                - qcom,msm8996-tsens
>                - qcom,msm8998-tsens
> +              - qcom,sc7180-tsens
>                - qcom,sdm845-tsens
>            - const: qcom,tsens-v2
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
