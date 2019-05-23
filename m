Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2CDC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BE6204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 15:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N+mfa0zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbfEWPNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 11:13:41 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46972 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbfEWPNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 11:13:41 -0400
Received: by mail-ua1-f65.google.com with SMTP id a95so2283437uaa.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jJwXkGHAjsBuNVlpPqPHB/gqYdCj2Tmp+gapq3iY+ic=;
        b=N+mfa0zy+pExM2ZUNCDOd7EfDziYW2R2p9cEyDaLDTL8Z9/JY1U+JerG+cgLatDl1p
         o6kLElYFF/CJBn8MgO+e6Rk8EX9jnp0H83jEIX4QCp+O2YsWMMPtI8eIMQSHI7fVhK26
         YOUG49rWHjTZtvdyAwR9l6oZVOpxGvUQtXxvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJwXkGHAjsBuNVlpPqPHB/gqYdCj2Tmp+gapq3iY+ic=;
        b=Hy17gDhAO+6bEhO9+11l4E8CDlOy1qKrUisGr4rQ6svKZd/hXKek2uEFdKf2ycQcE3
         r/hM8rWHYJuGnvpVWaE1aszDhme9GTOku2pKRj3a+uMcsL1NcNEsnagi2WOBNVvY4+LW
         xdIMNDfDLDPmN5dyYuGbZYB/Bj8fJA9w9/wh/bIlynDY1Xbr2ip+lG2sqrei86pwJMPy
         PMBNj9y7k+bCXjgFEaKFHE+NWQCnw8hDEjGm1ZQTjqu5rY3uyaeFcseyakfM57xT5sXQ
         5EdkBF39ZPvbHpgA8HtcRtpJWNLrlDKQ5OwZKoapiUSV/McRIL0y1Wy1ZCq+g20naoyo
         Y8PQ==
X-Gm-Message-State: APjAAAXilpdR4RV1MMDHNMhZY6IPRbd6DMW4xa9K/ZaKrabYto0whGOE
        K8GJWXDRgjiLE2bEiqGQpAKfALR1sQw=
X-Google-Smtp-Source: APXvYqw/QEmwPjEKH1pM2uVeQ///EMDB1aZCq4FH4uAD9WpZsyyd9pMsR08ykd1K/246Jd7ELtG7UA==
X-Received: by 2002:ab0:806:: with SMTP id a6mr13737891uaf.10.1558624420395;
        Thu, 23 May 2019 08:13:40 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id p7sm4642485vsp.34.2019.05.23.08.13.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 08:13:26 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id z11so3798308vsq.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 08:13:11 -0700 (PDT)
X-Received: by 2002:a67:ebd6:: with SMTP id y22mr31596912vso.87.1558624390840;
 Thu, 23 May 2019 08:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190501043734.26706-1-bjorn.andersson@linaro.org> <20190501043734.26706-4-bjorn.andersson@linaro.org>
In-Reply-To: <20190501043734.26706-4-bjorn.andersson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 23 May 2019 08:12:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XTF5y9dhfq_QsFdbWLszj6EFzTH4NozDPu_7YVzQur3g@mail.gmail.com>
Message-ID: <CAD=FV=XTF5y9dhfq_QsFdbWLszj6EFzTH4NozDPu_7YVzQur3g@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] arm64: dts: qcom: Add AOSS QMP node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 30, 2019 at 9:37 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The AOSS QMP provides a number of power domains, used for QDSS and
> PIL, add the node for this.
>
> Tested-by: Sibi Sankar <sibis@codeaurora.org>
> Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> Changes since v6:
> - Added #clock-cells
>
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index fcb93300ca62..666bc88d3e81 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -14,6 +14,7 @@
>  #include <dt-bindings/interconnect/qcom,sdm845.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/phy/phy-qcom-qusb2.h>
> +#include <dt-bindings/power/qcom-aoss-qmp.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>  #include <dt-bindings/reset/qcom,sdm845-pdc.h>
> @@ -2142,6 +2143,15 @@

Please avoid editing patches by hand.  I needed to manually change the
"15" above to "16" to apply.

-Doug
