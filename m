Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBD8C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E112084F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YhjYxFjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbfIMMjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 08:39:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42950 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfIMMjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:39:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id y23so26933381lje.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 05:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8pSb7ipxDEbBBNYVFT9VmqMM2iZRGR+yb26FbUargVY=;
        b=YhjYxFjBqg+kG8mrU9/YmXPsS8hajlgFK3l9scWiFwopNjmhYW1Gpoa7g1nTliuW3o
         zCwMwBECsgn0FldeUKIVDrYPrme2jmYbyLIILUk2p+KGL2X833RHWZYfW5KYEtdIMoCi
         em1FI5GEzDzRzVXo+NDJjjkkZZc00VvallTjOY7+ifw/eZI54eXXfUiP/QfsGKUfySPE
         ++0HHZcYgbg7Or8g26dVFn0JzOHfqCEAfoW1b/Si20aQ7FVrTPR4vDEcTL88Oex9A5Kh
         DTDc1AGZLSFXs14Om5nO7DEQJq665Zk90lody6chSrUV93xuAWU3KmueptCtMb+lHY8Q
         +V7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8pSb7ipxDEbBBNYVFT9VmqMM2iZRGR+yb26FbUargVY=;
        b=tQu6YsqjUb0cIKUQrmsXMMBJMEVVMqtsx4rKZObB59kw4HTkyGV7w7A8jTxHu6Du7p
         ObDOC67gdlRYu0ulJ6EDrwH7d5pdbdiL2vMfX7coN7VKysImRR+VM4WhHzwRgD00ATDT
         4xSu/QAzzkyisTfuH6NDKyFBxqB5+6S/eEUUxThNow8pqruOVA8nqmt8XJBwmVC0VTem
         iT3bnPUHwo1lbsdt5Zuv8oRfLCXFgPt8PQSzIFYuFdNxMPGedFUNESJX60dTDljkZZlZ
         rtT4QmwVpm2xibvXDvJKtZTL6pbMQNrRMBcARxPOmG2IqNLquA8vtI7hXF6685IXOM+n
         DbHQ==
X-Gm-Message-State: APjAAAVhlDN1txULf8xWO6zi1MmvQx7x58Lan7YxLiXQB0VHPFXtn6oF
        vpvaAzmfJem0cVA7+sIkvxhQHMEjqZwkDOC6Foh4FQ==
X-Google-Smtp-Source: APXvYqx/xoS6+u0lk/Rz7dPREJGGhbLK5x/VIw77KG0tzs3ZyOV1ZNL4/NxFs8cMHh7WRsLPa+4qT2M/8yUlnTB3vi8=
X-Received: by 2002:a2e:7d15:: with SMTP id y21mr22856642ljc.28.1568378377447;
 Fri, 13 Sep 2019 05:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <1567662796-25508-1-git-send-email-light.hsieh@mediatek.com> <1567662796-25508-3-git-send-email-light.hsieh@mediatek.com>
In-Reply-To: <1567662796-25508-3-git-send-email-light.hsieh@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Sep 2019 14:39:26 +0200
Message-ID: <CACRpkdZnn2JdUjDO7518jBn_fLwH+89P6WTC1M9CpsxZ1CSgGA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] pinctrl: mediatek: Refine mtk_pinconf_get() and mtk_pinconf_set()
To:     Light Hsieh <light.hsieh@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 7:53 AM Light Hsieh <light.hsieh@mediatek.com> wrote:

> From: Light Hsieh <light.hsieh@mediatek.com>
>
> 1.Refine mtk_pinconf_get():
(...)
> 2.Refine mtk_pinconf_set():

This explodes on the build servers and it's because of this:

> @@ -78,93 +78,75 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
>  {
>         struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
>         u32 param = pinconf_to_config_param(*config);
> -       int val, val2, err, reg, ret = 1;
> +       int err, reg, ret = 1;

Deletes "val" and "val2"

>         case MTK_PIN_CONFIG_TDSEL:
>         case MTK_PIN_CONFIG_RDSEL:
>                 reg = (param == MTK_PIN_CONFIG_TDSEL) ?
>                        PINCTRL_PIN_REG_TDSEL : PINCTRL_PIN_REG_RDSEL;
> -
>                 err = mtk_hw_get_value(hw, desc, reg, &val);
> -               if (err)
> -                       return err;
> -
> -               ret = val;
> -

Updates a bit, but look on the reg = line:
"val" is still used.

This patch can not have been properly compile tested.

Please rebase on latest "devel" branch from pinctrl, fix up the problems
and resubmit the entire series after making sure it compiles and works.

Yours,
Linus Walleij
