Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C71C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACB020693
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRWbDVH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfDZT0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:26:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46313 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfDZT0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:26:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id w26so5325518qto.13;
        Fri, 26 Apr 2019 12:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mwowdy6RxcIfo5VZP17XmfCJbXzkjZk8D299ZkieanA=;
        b=JRWbDVH79miedIVZxyvu4165tlqAYsZdtcmoHRcch0RZo1B69SqP94rAl6yBUaOcqd
         /DBpfRaGzd6GofAa4K3fo6/WpHcxIfqRFz0vVJwBUvLeaTc+i3G1f9ML+HdZeu4p+fyC
         R2CnsKLjkgqqnGRUEDpdHSc51gf/POdQADHJkXWpj7mHmzE3ITKVZfrpj8cz9Sd3PUsI
         xzh5tbsJ2+MAmUC+ewgKrlr0hZYP4aAqWjFc4n9lmDAf7q+rvyPz6aRooRmoLSmtcG5D
         ucHMC2drzx+hlndz9GPtYRkFT59DMwiMRwi/6D/UGPtOCBkfv+oSZwQc12silPTi9gyS
         i8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mwowdy6RxcIfo5VZP17XmfCJbXzkjZk8D299ZkieanA=;
        b=udaD9QkD4o/NlG2cQG3W+8HWG3cj07rVVNAQKBWPxVyqXNUYSqy8udCSFprwYDteBh
         Ky8qR0vBQH4+EIsdkC5CQt2tym9R162N1a0HE8/hGRSnOetNS3KKosmUsjgqUQUymBIl
         WlNe3VMum4IwWFkRIxxQcB3WfcuEhBPXx6HFkI8LLZ7F+hufF9AySiAo23TesoAfOJo2
         vftkMhBDqC+/ulQxDb2GSHH00gwYNeCcVonqllHFY01I/HrQ/Q4VJ4nLT+p8DbZfR7H/
         qU1+4ThqL+T+g9gzQ/Pm3XIAHHvRUtxn+itZnS1o0sQ/m6K/D+gsE4eWA4B4SFnfmVc6
         6q1w==
X-Gm-Message-State: APjAAAV2aOZmK5ZiVM7thABJR7klNqjYJl8SX+wMVPc2iFzD6PQyXD0t
        m8pBl25L5TOmPeaoBltZhZP3/7wGY9T7WpfEm1I=
X-Google-Smtp-Source: APXvYqzcto34kuvbcbVPgl9KZdhvjQ0R/cZF18/6IpeFzaSiAJSkOuxtfrOAwgkgVIubjEFeeoCGimvtKEeev7ml/fw=
X-Received: by 2002:ac8:317b:: with SMTP id h56mr14227724qtb.22.1556306805534;
 Fri, 26 Apr 2019 12:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190426191025.16131-1-bjorn.andersson@linaro.org>
In-Reply-To: <20190426191025.16131-1-bjorn.andersson@linaro.org>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Fri, 26 Apr 2019 13:26:34 -0600
Message-ID: <CAOCk7NqmNYDzyTSXnMUdDyAcbzHjzL-aSO9r_+V-5o-8oOMPPg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-mtp: Make USB1 peripheral
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 1:10 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> The MTP is a "mobile reference device", as such the default operation is
> to use fastboot to boot/flash software onto it and the common case is
> thereby that we boot with a USB cable connected downstream from a PC or
> a hub.  And without support for the PMI8998 charger block VBUS will not
> be driven by the device.
>
> Switch to peripheral until we can enable OTG.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Makes sense to me.

Reviewed-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>

> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index 02b8357c8ce8..2e78638eb73b 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -404,8 +404,8 @@
>  };
>
>  &usb_1_dwc3 {
> -       /* Until we have Type C hooked up we'll force this as host. */
> -       dr_mode = "host";
> +       /* Until we have Type C hooked up we'll force this as peripheral. */
> +       dr_mode = "peripheral";
>  };
>
>  &usb_1_hsphy {
> --
> 2.18.0
>
