Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FBDC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E9C206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pmsCMTkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfDZV1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:27:02 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:33484 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfDZV1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:27:01 -0400
Received: by mail-vk1-f196.google.com with SMTP id x194so1107630vke.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 14:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=eUaIM1Q0V5Ls2hO/pHdDiLWutmvy6eDkxuJ9bjnTpt8=;
        b=pmsCMTkvZeXRVB+ncee0yy8BbwP1naNLvBAusY+EQ9ZTTfvO4ugGaQUtotaf4F0G/a
         QsuwTkrzy4v62L1BFy4Icm60oXh+hJ2FVBIX7RYZpcJysEZmPqqb2JwhmnFQaGvJwB2B
         Vyf9Ix1pjSTYTetG2nrBunvzOck/IOiAwQvpf3Fgi5bUpACwN2h1ilShH5z8tVF5EtSK
         EDbDZcRc0PEdZdbrfpQSxQkOzt9P6uTI161yfK6H0y4P5t6J7thlfW4GoNuU9pQpQZHV
         R9AyOrUTdooemDl3YrwjreTjDac90EDae7dIfcuI/oIZSd9E05pP5fEGRXzHNLJqhX2B
         MUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=eUaIM1Q0V5Ls2hO/pHdDiLWutmvy6eDkxuJ9bjnTpt8=;
        b=q3MxsXXot3Ybclcw7BOp7bv4wMgz0Xtyt/fiobR8dRyFfnZlOzKp/zpCYGW7bF115k
         9HA80iQjDXrZ5w6TxKMfjltN+EWufgxoVrLcTJBNLvV00aCP7+Nm9s5zYSxvKhgLmk/I
         H3wRxL8lwZNpV8B67MlfgxoxgsFlDHdLcG4DT1rTqbsCioO0gHDwjYgrrhoTYqH5M+3+
         WJmWlw72Q2j23bqeK8YEajx69WG0UvYvewOnZOlPEQeK5RWFqPSQMQmnAJzpGcWTKxoY
         0hxcm3GduBGqcYEMtGIXMbVPunkUrVhpy1ApPETZhoFQsY8uEJvgZh26A6tW/qFZLSoZ
         4Dvg==
X-Gm-Message-State: APjAAAUamy+FQMdVSoH6vo8GB9uVML8/WwV8ClLXRuTWl4lBOAURZyr3
        H5MfYXU8yySobBPlXBzS2oyCwb8cf1Y/D+cYD62uvEAh
X-Google-Smtp-Source: APXvYqzVmF6sWIpDy9ei3EcZ9Je1jZNxBF+rO89yONNo8oLr05S40DnFTYGbwNlZ4rs8phjrcr4lnKlv+ZOrAQW0+v0=
X-Received: by 2002:a1f:812:: with SMTP id 18mr10568161vki.68.1556314020401;
 Fri, 26 Apr 2019 14:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553848972.git.amit.kucheria@linaro.org> <c89ce5c4e66de489bb089dd60cd8a26949501a59.1553848972.git.amit.kucheria@linaro.org>
In-Reply-To: <c89ce5c4e66de489bb089dd60cd8a26949501a59.1553848972.git.amit.kucheria@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Sat, 27 Apr 2019 02:56:49 +0530
Message-ID: <CAHLCerPCFPLMFMrsZJewmMZKBhd8N3d03C1ALv9+Q+7oPhYZtw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] MAINTAINERS: fix typo in file name
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 2:18 PM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> Commit e31f941cf977 ("MAINTAINERS: update list of qcom drivers") had a
> typo in the filename, replace the underscore with dash.

Ping!

> Fixes: e31f941cf977 ("MAINTAINERS: update list of qcom drivers")
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3e5a5d263f29..d2c5852a3c8d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2007,7 +2007,7 @@ F:        drivers/i2c/busses/i2c-qup.c
>  F:     drivers/i2c/busses/i2c-qcom-geni.c
>  F:     drivers/mfd/ssbi.c
>  F:     drivers/mmc/host/mmci_qcom*
> -F:     drivers/mmc/host/sdhci_msm.c
> +F:     drivers/mmc/host/sdhci-msm.c
>  F:     drivers/pci/controller/dwc/pcie-qcom.c
>  F:     drivers/phy/qualcomm/
>  F:     drivers/power/*/msm*
> --
> 2.17.1
>
