Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CE5C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FB92077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="flsBnhRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfLKTno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:43:44 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:45216 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLKTnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:43:43 -0500
Received: by mail-il1-f194.google.com with SMTP id p8so20479957iln.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 11:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WEsvDQ4frWg0g6hsrfrPUpwL5OB0pB+03rAe/lqxJKs=;
        b=flsBnhRwZYV3x2jeRLaTFJggFGEUKvXMx7aFjFYS3tsR8jzvWNQoAoI6geow1bE3hH
         Sm1LHlGve7GLu+f76odVmRz0tXt8hYDqPTJrJRYFvL0aMIGYCHbglAf0y9IBgG5JZcf1
         BeLTAaE39MIUTOH4uRNWoLbPm1wDCHD8VhJPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WEsvDQ4frWg0g6hsrfrPUpwL5OB0pB+03rAe/lqxJKs=;
        b=oDEGWytN6lFk4iNRwX5+UCTNP2wp/NIj5SUAVzmJcpjtaN+J7zn6ATtmRb2psX2sv+
         pUIfqn5sBpE/J3JiCZev2U8Q3tNgbGTXIOP63vN4vy5xgMEIH5YeW+4RP1bpR6SOiQRr
         lBXtD0sYK08LT7c+rm94kuGyCOcGlbk0Hf+IvLRzVt+zBR5DyKlvbvxcVwIDY41yf4Xh
         2i5HxumyFmdtyfCY2buXZ1sbVlF6cT1h1srhSPQvK/Agf5rcKcll3oe6Y+0qx5vgMptN
         pycO+MOZDXelxEvVLv13wHuKZCdvqPXUm+8yR9W9uNh6WSRNDkuvXj5TtTWgfV9iFgVh
         2wWQ==
X-Gm-Message-State: APjAAAWNfzLDAue24i3fvF9Gf3brH7kkyRPSaqf3UrpkXG5sYRn/1w+U
        6fTPYeqNQKve1l2UHHd1qslEoPydC2s=
X-Google-Smtp-Source: APXvYqzaGzwiUElXRA7WQ2bQk5JJ2YSaKLjAVtGFLkLiNoStbNQJC+CGXy70TyIQyV9/aR+8bWG+KA==
X-Received: by 2002:a92:c0c7:: with SMTP id t7mr4966890ilf.113.1576093422151;
        Wed, 11 Dec 2019 11:43:42 -0800 (PST)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id o7sm978079ilo.58.2019.12.11.11.43.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 11:43:40 -0800 (PST)
Received: by mail-il1-f172.google.com with SMTP id r81so20548636ilk.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 11:43:40 -0800 (PST)
X-Received: by 2002:a92:d581:: with SMTP id a1mr4374504iln.218.1576093420076;
 Wed, 11 Dec 2019 11:43:40 -0800 (PST)
MIME-Version: 1.0
References: <1574940787-1004-1-git-send-email-sanm@codeaurora.org> <1574940787-1004-2-git-send-email-sanm@codeaurora.org>
In-Reply-To: <1574940787-1004-2-git-send-email-sanm@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 11 Dec 2019 11:43:28 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Uy6ryrbpzFg1sesJkWrgh05tLgvtozx0afJPF_u4-ESA@mail.gmail.com>
Message-ID: <CAD=FV=Uy6ryrbpzFg1sesJkWrgh05tLgvtozx0afJPF_u4-ESA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] usb: dwc3: Add support for SC7180 SOC
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 28, 2019 at 3:35 AM Sandeep Maheswaram <sanm@codeaurora.org> wrote:
>
> Add compatible for SC7180 SOC in USB DWC3 driver
>
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 261af9e..1df2372 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/* Copyright (c) 2018, The Linux Foundation. All rights reserved.
> +/* Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
>   *
>   * Inspired by dwc3-of-simple.c
>   */
> @@ -753,6 +753,7 @@ static const struct of_device_id dwc3_qcom_of_match[] = {
>         { .compatible = "qcom,dwc3" },
>         { .compatible = "qcom,msm8996-dwc3" },
>         { .compatible = "qcom,msm8998-dwc3" },
> +       { .compatible = "qcom,sc7180-dwc3" },
>         { .compatible = "qcom,sdm845-dwc3" },

It is, of course, up to Felipe.  ...but in my opinion this is the
wrong change and instead we should be deleting the SoC-specific
strings (msm8996, msm8998, sdm845) from this file because they don't
buy us anything.  To explain how it works:

1. Device tree should have both the "SoC-specific" and generic
"qcom,dwc3" strings.  Only the "qcom,dwc3" will actually be used but
the SoC-specific string is there so if we find a case later where we
need to handle a SoC-specific quirk then it'll already be there.

2. Bindings should have both the "SoC-specific" and generic
"qcom,dwc3" strings.  The binding is describing what's in the device
tree.

3. Until we have a SoC-specific quirk to handle, we _don't_ need to
add the SoC-specific string to the driver itself.


-Doug
