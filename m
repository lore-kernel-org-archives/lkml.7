Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52589C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286D52064B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XIcQqioy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfLRTJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:09:46 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42480 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfLRTJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:09:45 -0500
Received: by mail-io1-f65.google.com with SMTP id n11so1603933iom.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 11:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MjSvp3Dx9u84GVaJpyyyeaGaP0H57BE7CyJr7SSOs5g=;
        b=XIcQqioy8tqWx8jv9ksRQ/fgieMfgKKKIp3ywAYh1a58vOSB2qEGoad6XCSce9DM6h
         EsI2IIF0ChjDxU/kKx/iDhsOw1cGnGjRLQYgj9YjFXigW2y1f4KshZQZ6ZfqF1Njpqcv
         lQfSIyPvo9TnNkabONpQoAmrkQZmQBPcm9K0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MjSvp3Dx9u84GVaJpyyyeaGaP0H57BE7CyJr7SSOs5g=;
        b=sQNWTnd0EE4UEOuTQEYOqRJdCNE5ZRxdyUn8g+AMgIDB4jhT/UIm6fsdNYzAcJqFvd
         tZgbdmSGjGFcapKcHSX0gtIqoNASMWMfcVTVmw0aX5aH9zbikfboQlfDAC8hHQ00CHmx
         +E0ddrWmTa1WApuAvn6r0ASmszfPauGioAwZ/VNrD0acau6zgrDG/RbiPejjLf0J/pvA
         UOQijLj38DoqWWbK8WbkRTES29+BlKjvdGJFgWYOyD45fiueY2XwUBeUHpWNAbh7xmcN
         xGb4HMXNY820SViVcgAf6OH0knD51Mo0A8Qvl7URW4Z5QBp35DheS9rpyyOeNDS+4iuU
         eMfQ==
X-Gm-Message-State: APjAAAWsMI5k2FOKU/aJr2Gs5Z2BPcplwNKW/6REW8Ki9y/aXf113WsJ
        /gJV2PcXPA/ZyyJdXh5AcGA1mymq54c=
X-Google-Smtp-Source: APXvYqxjVv/fcN57xZvPrQMkCDu/St3fM8jxDlzkxZrR8sbsrXMateLZemsebDJhTbFgtQrfh5pbaQ==
X-Received: by 2002:a6b:fc0b:: with SMTP id r11mr2833861ioh.251.1576696183956;
        Wed, 18 Dec 2019 11:09:43 -0800 (PST)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id e1sm931911ill.47.2019.12.18.11.09.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 11:09:43 -0800 (PST)
Received: by mail-il1-f170.google.com with SMTP id z12so2615489iln.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 11:09:42 -0800 (PST)
X-Received: by 2002:a92:1547:: with SMTP id v68mr3226767ilk.58.1576696182341;
 Wed, 18 Dec 2019 11:09:42 -0800 (PST)
MIME-Version: 1.0
References: <1575520881-31458-1-git-send-email-sanm@codeaurora.org> <1575520881-31458-4-git-send-email-sanm@codeaurora.org>
In-Reply-To: <1575520881-31458-4-git-send-email-sanm@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 18 Dec 2019 11:09:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V7SEqLWQh29eHh=a5q6Q2_bWwhMViyhFvWwGQN1p7fjw@mail.gmail.com>
Message-ID: <CAD=FV=V7SEqLWQh29eHh=a5q6Q2_bWwhMViyhFvWwGQN1p7fjw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: phy: qcom-qusb2: Add SC7180 QUSB2 phy support
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Manu Gautam <mgautam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 4, 2019 at 8:43 PM Sandeep Maheswaram <sanm@codeaurora.org> wrote:
>
> Add QUSB2 phy entries for SC7180 in device tree bindings.
>
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom-qusb2-phy.yaml | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.yaml
> index 3ef94bc..5eff9016 100644
> --- a/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom-qusb2-phy.yaml
> @@ -18,6 +18,7 @@ properties:
>      enum:
>        - qcom,msm8996-qusb2-phy
>        - qcom,msm8998-qusb2-phy
> +      - qcom,sc7180-qusb2-phy
>        - qcom,sdm845-qusb2-phy

I would propose that we add generic PHY v2 tagging here, like this:

properties:
  compatible:
    anyOf:
      - items:
        - const: qcom,msm8996-qusb2-phy
      - items:
        - const: qcom,msm8998-qusb2-phy
      - items:
        # Suggested to also add "qcom,qusb2-v2-phy" as below.
        - const: qcom,sdm845-qusb2-phy
      - items:
        - enum:
          - qcom,sc7180-qusb2-phy
          - qcom,sdm845-qusb2-phy
        - const: qcom,qusb2-v2-phy

Given that this PHY has a fairly linear versioning within Qualcomm
(right?) this should make sense and should make code / adding new
device trees easier.  This is probably better than what I suggested in
the driver review [1] where I suggested that the compatible for sc7180
should be:

  compatible: "qcom,sc7180-qusb2-phy", "qcom,sdm845-qusb2-phy"


>    reg:
> @@ -66,7 +67,7 @@ properties:
>          It is a 6 bit value that specifies offset to be
>          added to PHY refgen RESCODE via IMP_CTRL1 register. It is a PHY
>          tuning parameter that may vary for different boards of same SOC.
> -        This property is applicable to only QUSB2 v2 PHY (sdm845).
> +        This property is applicable to only QUSB2 v2 PHY (sc7180, sdm845).

If you add my tagging, change this and other similar to just remove sdm845.


[1] https://lore.kernel.org/r/CAD=FV=W_z=_j==DSFbtCmTihmSyRtH85VnKpw03E=gATcqJx2Q@mail.gmail.com

-Doug
