Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE69BC76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 05:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E36218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 05:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="ct6X0qA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfGXFBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 01:01:08 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42781 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfGXFBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 01:01:08 -0400
Received: by mail-vs1-f67.google.com with SMTP id 190so30511596vsf.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 22:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MwZbVvyxm3PI+MouNfOXYHnz5VFLnB1AMhPNSWYl2+c=;
        b=ct6X0qA08bQF6QWHQzeKtcjUKYrb7O7huAAWPkMX0eTJkPb6b7frcH1oeg0W7R09DB
         w3F5THxqJlS+MU0uE0j6aaVKMWGWB4bJc1gBKZJlA1G4t90eUrVgseu8YQRsevSNNieF
         lTUHbs/2Q/5i/J4Ip5lJgT467azUxXiYYUSiaxUFW+8oF2PSUe1pFktoNiQ7MbBq0M7u
         b+cmxOWvxA/ZgG8Efyd8Xcd/UXF7dJAx/CL5IA8tFTyNkZt4nZnOqTqxs2GyCz7mT2xS
         FMZBJ8t4WufNl47qbxbdbA9TMA51Bs5PYk0GmuHlJ3Ujht7UbGc7MA3Ylqz3uT9mAa4g
         mSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MwZbVvyxm3PI+MouNfOXYHnz5VFLnB1AMhPNSWYl2+c=;
        b=UixVPz1ukTKtKK5ZoQRRhXVHj42u1kJIHGxVv9CN6Ja84IHESGtMo6W2f1rMS6YSvu
         r4WOqo3R6qPljv9dYB01J67EuAt24NIbFsKr8ykEhAxIGvbRR9pIbJxblDVDccZWCwl5
         bi3FDnZ8lmEN/ZQ3KIuYJzcMtE+y/LZkxNNL05tC9E6D834U0Va8i90dhvTTCUUAcHaE
         Ta3ZOM39sf0Q8GweLujZ6BevQtinCV9GbmJiMhbmr7jVDzDS3tvKmM13uZs0E5sKv7Xs
         Qcoj2RowRQSq44Gz8QmdAhFFLQReaZ1A7Wc+uY7/W4VrsWonw+njwF9cGm1hBEkN0hfP
         wvgw==
X-Gm-Message-State: APjAAAUSfp1J2hQ2CMxpbaTzkhjaUwsVY0wzVqnML8MJ7JVy5fDpl3gd
        JGd0g3JS8qKtp98g+uYSZM0mcxIccHHKnE94mpw=
X-Google-Smtp-Source: APXvYqzDfgoeYz/99kNuC9UX09QAW/OkLD2aDZBnfw+xJRRF04yHjb4iM3P/YyScPY9DnWqV3/sPpIpefel/c99irMc=
X-Received: by 2002:a67:f5c5:: with SMTP id t5mr21338731vso.27.1563944467386;
 Tue, 23 Jul 2019 22:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190724044906.12007-1-vkoul@kernel.org> <20190724044906.12007-2-vkoul@kernel.org>
In-Reply-To: <20190724044906.12007-2-vkoul@kernel.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 24 Jul 2019 10:30:56 +0530
Message-ID: <CAHLCerOkm+QM+=PDYwWwzYNT_inMHtnnmcZRGdJy_p6ozvkgTg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] arm64: dts: qcom: sdm845: Add unit name to soc node
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:20 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> We get a warning about missing unit name for soc node, so add it.
>
> arch/arm64/boot/dts/qcom/sdm845.dtsi:623.11-2814.4: Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>


Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 601cfb078bd5..e81f4a6d08ce 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -620,7 +620,7 @@
>                 method = "smc";
>         };
>
> -       soc: soc {
> +       soc: soc@0 {
>                 #address-cells = <2>;
>                 #size-cells = <2>;
>                 ranges = <0 0 0 0 0x10 0>;
> --
> 2.20.1
>
