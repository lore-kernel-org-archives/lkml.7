Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF60DC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8FE206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cHdSLiwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406967AbfFKSIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:08:44 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35556 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406685AbfFKSIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:08:43 -0400
Received: by mail-ot1-f67.google.com with SMTP id j19so12824335otq.2;
        Tue, 11 Jun 2019 11:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O89jlWqoEX7q/G6CiVxiDDmlI/FOM0sB6BHEXW+0fFM=;
        b=cHdSLiwdTyZbPGVz/qYnZJJCYplwKEbE0QdVdYmjqez+GGasa8TA9GEaZeZf+/Q/yc
         8TIaqOiIijHlpQPN+b0BBZvmxtMd47x/uYK7Vk5XPD8mYxbl+yUPaIuF7vI0M7QzRtm0
         HNeafuVGHu/sa/BCqZcATKXmtS7Eag+BS6pOHP7N3/7dY0uWHKLKUSLT34TY6AzMuvGD
         Nr42TPWl2pxEfX5qbCwSGwJadJSQJ9gNcRUKKGUG7vKQZCsm/m8sJ9YWSh2bYRWL5CwC
         TqB5iiaGNo0Yp7KTmdwXVV/+fDhjaVwXeP064+XZo1StqFJ682mO7SEdwmnKHz22qWhC
         eMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O89jlWqoEX7q/G6CiVxiDDmlI/FOM0sB6BHEXW+0fFM=;
        b=VaYzh+rozdbOrVD40m3Udl774Bu1PnUio0GMtKQJveIg/k7Fka3tIiD8hRng1TeFPV
         G0fJcU4XvCbdqaItEhjSzfyNO5CMzL9OH7wreiX1baW6jMHNxN13OZiQ8pyJaD54AQ03
         3CoK5KsXTPfXP6iYOyskBylqma3iV4qABmS6MaOcVCKN7lfQV9I+wwE77f1p+4Wuqb1T
         pZgmnWbuwL627zCNGilzqKanShPo2jEKGF/YMU5gDpnOTx74PTvVLR7fM5xRx9euZrUs
         h5UtxUPUfawn2YWyhri/3AzAYYyG+Z5RIwRax1RLYAoVPmSTdt770oB7Ha6Xmrra4wov
         cDWw==
X-Gm-Message-State: APjAAAUvq3/opwI7sGMhDp1iUQui+g/X70Ma5DTjVz0tN1PT1jRKMJaq
        sRJaMxZdagKzWYxTE0N9RFHvorBT9CKV6Xa5ork=
X-Google-Smtp-Source: APXvYqx6SoLuddvsSFbGwWXlHsKKnRFjZOzVnVqvxNNOkTK4cQ1P337c36bckWzk3tAMnUuN46R+aOyOVrxZcNZhBbc=
X-Received: by 2002:a9d:32a6:: with SMTP id u35mr36300662otb.81.1560276522291;
 Tue, 11 Jun 2019 11:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190611135842.8396-1-narmstrong@baylibre.com>
In-Reply-To: <20190611135842.8396-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 11 Jun 2019 20:08:31 +0200
Message-ID: <CAFBinCAkwjf9oDV6AGPi2PzzQ2KNTXXDHW6FTfN3kXpDT6cFpg@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: meson-g12a: Add support for IRQ based OTG switching
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     balbi@kernel.org, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, Jun 11, 2019 at 3:58 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add support for the OTG ID change interrupt to switch between Host
> and Device mode.
>
> Tested on the Hardkernel Odroid-N2 board.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
with the three questions/comments below answered/addressed:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

> ---
>  drivers/usb/dwc3/dwc3-meson-g12a.c | 32 ++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
> index 2aec31a2eacb..e5c5ad0d529e 100644
> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
the comment block at the start of the driver file also contains a
"TOFIX" which points to the missing IRQ handling
can you please also drop that TOFIX comment in lines 15/16?

> @@ -348,6 +348,22 @@ static enum usb_role dwc3_meson_g12a_role_get(struct device *dev)
>                 USB_ROLE_HOST : USB_ROLE_DEVICE;
>  }
>
> +static irqreturn_t dwc3_meson_g12a_irq_thread(int irq, void *data)
> +{
> +       struct dwc3_meson_g12a *priv = data;
> +       enum phy_mode otg_id;
> +
> +       otg_id = dwc3_meson_g12a_get_id(priv);
> +       if (otg_id != priv->otg_phy_mode) {
> +               if (dwc3_meson_g12a_otg_mode_set(priv, otg_id))
> +                       dev_warn(priv->dev, "Failed to switch OTG mode\n");
> +       }
> +
> +       regmap_update_bits(priv->regmap, USB_R5, USB_R5_ID_DIG_IRQ, 0);
> +
> +       return IRQ_HANDLED;
> +}
> +
>  static struct device *dwc3_meson_g12_find_child(struct device *dev,
>                                                 const char *compatible)
>  {
> @@ -374,7 +390,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
>         void __iomem *base;
>         struct resource *res;
>         enum phy_mode otg_id;
> -       int ret, i;
> +       int ret, i, irq;
>
>         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
> @@ -436,6 +452,19 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
>         /* Get dr_mode */
>         priv->otg_mode = usb_get_dr_mode(dev);
>
> +       if (priv->otg_mode == USB_DR_MODE_OTG) {
> +               /* Ack irq before registering */
> +               regmap_update_bits(priv->regmap, USB_R5,
> +                                  USB_R5_ID_DIG_IRQ, 0);
I assume that either the IRQ line is:
- always enabled
- enabled when (USB_R5_ID_DIG_EN_0 | USB_R5_ID_DIG_EN_1 |
USB_R5_ID_DIG_TH_MASK) are set (which we already do in
dwc3_meson_g12a_usb_init)

> +               irq = platform_get_irq(pdev, 0);
do we need to check the IRQ before trying to request it?
drivers/gpu/drm/meson/meson_dw_hdmi.c and drivers/usb/dwc3/host.c for
example error out if irq number is lower than 0

(it's great to see that this only required a small patch to make it work :))


Martin
