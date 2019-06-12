Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED279C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4892082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ndPBOFNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501860AbfFLPNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:13:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39984 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437534AbfFLPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:13:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so6934029wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 08:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qvLlJRBc4oWj7le48jMqR5nD8q7UHZLEVmWic0S6F14=;
        b=ndPBOFNN+gyPcsf4WlqjOx23BEc14iaH/0URb3oOjh7BaOyZDNwMeEAn8Gh7zMlBt/
         V5apnEgBiO2m7gVl6qQQQyLpjTJIyMf+MDrbiiHwq58j1VdZN5XjLPynFxNgvrl9X2/2
         zBbh4Nfh0TTDtMXDNWC+36vYxcIA2Nln75LOGXdviJ2DKgXShprE93Y153t10mNhXn9c
         jUV8YMccfiDBezXUtiLE+R/jAuGRBhMi+x8mU3GQ/9BbIn0qjpbaaW632KQ2m5093VK7
         MHfrqlNl2yK3lL6tsEh2iNKZh/8gjF813CT/u0rTxupVlmRHDMHAHpgGjejZvqh7RjnN
         AK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qvLlJRBc4oWj7le48jMqR5nD8q7UHZLEVmWic0S6F14=;
        b=S98EGM33p9wk0FYXGdTSbyDVIa/MoZOvqDJID9y69jicCc/JlwbG+CwIbL7iFzNKw0
         kPijX+5QDr/lfK43X+z49DLevoJnGHgiNiuXN9TVoaUWd/TgF5uiZg0nweVGZsacgh1f
         AhePp3Tv7ww+L7W8SCfKiU+YkZ80d+R1W56ud+C3zZEUeOOamX0NS8YOY9kopeSXH0Ll
         /jJ+JCpKFIV5vUMsIagSNyDbvM35YljBZ7P/TZkgDqQBwZNbDmRBNwzW+oQP9KXlEcJy
         L0x4rxhBVpitL4a71HmDCNWaLplz+9MpViktWdDNB5JFvYzQC8YGfUQmXiKQQx++PF9P
         5XmQ==
X-Gm-Message-State: APjAAAU3VAP3ttVE5rDUyN8yUpFhz31woi1ENIVD2mn7ChRYrgCO8JbZ
        /FQpIsz7PtbcNlvIt7b8Nf1ZUg==
X-Google-Smtp-Source: APXvYqxoE0Lrnngi6uetWv3d7I+/eoAyvVanGvq083F2ajNGamescK6jVQZdyKtPYMvWBL0hRrhx1g==
X-Received: by 2002:a7b:c001:: with SMTP id c1mr22830725wmb.49.1560352391884;
        Wed, 12 Jun 2019 08:13:11 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q7sm24295733wrs.65.2019.06.12.08.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 08:13:11 -0700 (PDT)
Subject: Re: [PATCH] usb: dwc3: meson-g12a: Add support for IRQ based OTG
 switching
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     balbi@kernel.org, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190611135842.8396-1-narmstrong@baylibre.com>
 <CAFBinCAkwjf9oDV6AGPi2PzzQ2KNTXXDHW6FTfN3kXpDT6cFpg@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <8950adde-0942-5f04-0ce6-922a9886c440@baylibre.com>
Date:   Wed, 12 Jun 2019 17:13:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCAkwjf9oDV6AGPi2PzzQ2KNTXXDHW6FTfN3kXpDT6cFpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2019 20:08, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Tue, Jun 11, 2019 at 3:58 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Add support for the OTG ID change interrupt to switch between Host
>> and Device mode.
>>
>> Tested on the Hardkernel Odroid-N2 board.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> with the three questions/comments below answered/addressed:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
>> ---
>>  drivers/usb/dwc3/dwc3-meson-g12a.c | 32 ++++++++++++++++++++++++++++--
>>  1 file changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
>> index 2aec31a2eacb..e5c5ad0d529e 100644
>> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
>> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> the comment block at the start of the driver file also contains a
> "TOFIX" which points to the missing IRQ handling
> can you please also drop that TOFIX comment in lines 15/16?

Indeed, thanks for pointing that !

> 
>> @@ -348,6 +348,22 @@ static enum usb_role dwc3_meson_g12a_role_get(struct device *dev)
>>                 USB_ROLE_HOST : USB_ROLE_DEVICE;
>>  }
>>
>> +static irqreturn_t dwc3_meson_g12a_irq_thread(int irq, void *data)
>> +{
>> +       struct dwc3_meson_g12a *priv = data;
>> +       enum phy_mode otg_id;
>> +
>> +       otg_id = dwc3_meson_g12a_get_id(priv);
>> +       if (otg_id != priv->otg_phy_mode) {
>> +               if (dwc3_meson_g12a_otg_mode_set(priv, otg_id))
>> +                       dev_warn(priv->dev, "Failed to switch OTG mode\n");
>> +       }
>> +
>> +       regmap_update_bits(priv->regmap, USB_R5, USB_R5_ID_DIG_IRQ, 0);
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>>  static struct device *dwc3_meson_g12_find_child(struct device *dev,
>>                                                 const char *compatible)
>>  {
>> @@ -374,7 +390,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
>>         void __iomem *base;
>>         struct resource *res;
>>         enum phy_mode otg_id;
>> -       int ret, i;
>> +       int ret, i, irq;
>>
>>         priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>         if (!priv)
>> @@ -436,6 +452,19 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
>>         /* Get dr_mode */
>>         priv->otg_mode = usb_get_dr_mode(dev);
>>
>> +       if (priv->otg_mode == USB_DR_MODE_OTG) {
>> +               /* Ack irq before registering */
>> +               regmap_update_bits(priv->regmap, USB_R5,
>> +                                  USB_R5_ID_DIG_IRQ, 0);
> I assume that either the IRQ line is:
> - always enabled
> - enabled when (USB_R5_ID_DIG_EN_0 | USB_R5_ID_DIG_EN_1 |
> USB_R5_ID_DIG_TH_MASK) are set (which we already do in
> dwc3_meson_g12a_usb_init)

Can't say... I suspect the (USB_R5_ID_DIG_EN_0 | USB_R5_ID_DIG_EN_1 |
> USB_R5_ID_DIG_TH_MASK) enables the detection.
The regmap_update_bits(USB_R5_ID_DIG_IRQ) is only here to make sure the "current"
irq event is masked, whatever the previous init.

Or I misunderstood question ?

> 
>> +               irq = platform_get_irq(pdev, 0);
> do we need to check the IRQ before trying to request it?
> drivers/gpu/drm/meson/meson_dw_hdmi.c and drivers/usb/dwc3/host.c for
> example error out if irq number is lower than 0

No, devm_request_threaded_irq() will fail if -1 is given, I've using this scheme
for a while now !

Neil

> 
> (it's great to see that this only required a small patch to make it work :))

yeah, I was impressed when I wrote it, I expected much more work

> 
> 
> Martin


Thanks,
Neil
> 

