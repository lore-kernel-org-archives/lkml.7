Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFC1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3047E218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N8V6zDZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfCUIUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:20:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45456 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfCUIUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:20:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so650779wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 01:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BGbfVbtgv+XC+5W7MKRmcuvP1lcC0VAQHZYdqQn85VQ=;
        b=N8V6zDZVYXPXiHJNdv5iwKwO/vtFfW3j4/Y/Y7Ufah8F5BR32H/t5+cSVRaCA6I11T
         UgJeG9JveO5JYKbYGfKj9mCLPkuQ0Ps7GBhkP878CV+rXz6LEQFXcS62n8QRU40leaGl
         JKLKUIo43a6OQ5qfgEiBL0dFzy2CwYK7d/Ne6ITLD7XGfwN4YBSUUbjM9QKtYkABk5yw
         5XyJlHxUtKEdG8xFm7D2bG+AYNklnL8mCr1k+lqBC8GDg/HFr+4ZubX6OHuU4tJrLjcu
         mMSFSBSn8uohqznfb9KKmdxtcdpQVYeF/I7VSrZLx8zxpcaoVDIrNY6BmDjFF/4Wb78N
         tqqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BGbfVbtgv+XC+5W7MKRmcuvP1lcC0VAQHZYdqQn85VQ=;
        b=IIyK9TeAUFP0KUDsuGT5mWsJzxdr3SNILFfjQ+8V1pBvWJm575LgD9NRd0Tse5cSGo
         EhM8s0ku+tOwPogPQlazj+3Iqt9NI8DQeDUVsrLxHbiiTLiN2N4mXlJlAo5ZSSUL02Mx
         9Dx0Ui7Cpiah+vitWMTxvccO5C1YQH4YEMlhVESGATxV5TPWLX1bs2u52FnGnWNSaqD1
         cUdCKEmXrlyzLIH4x+XjXNAoEAV2t9/QjaiXTeP1JWo8o298B8oTemfKxmB0rkvry4Tu
         f0g1nsiaogQs2hzQaG48O2tE9MtE6vpFBrwnZoRLNs8xmNqLICQqlv8jtfr2lQQindfO
         EXYg==
X-Gm-Message-State: APjAAAU8MX8GjyVwM3gqjYJm5wxKTYR8uL4cugXUHszAuJifL7yi7cTu
        Yxg/WWQ57fwfy3rCtW6Cyvxj1LBsAZQ=
X-Google-Smtp-Source: APXvYqyC1nxIMmfTReF+4oThrSNSuWx/8QVlBZy5EhfnE3pC0oTm0DltfVtlBeaU5osXlm68NgZdXA==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr1510977wrr.275.1553156437021;
        Thu, 21 Mar 2019 01:20:37 -0700 (PDT)
Received: from dell ([2.27.167.37])
        by smtp.gmail.com with ESMTPSA id h14sm6495664wre.90.2019.03.21.01.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 01:20:36 -0700 (PDT)
Date:   Thu, 21 Mar 2019 08:20:34 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz,
        tony@atomide.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v4 4/4] leds: lm3532: Introduce the lm3532 LED driver
Message-ID: <20190321082034.GR4731@dell>
References: <20190313123249.17258-1-dmurphy@ti.com>
 <20190313123249.17258-4-dmurphy@ti.com>
 <a7ee025e-361e-90b8-e38d-53546a542102@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7ee025e-361e-90b8-e38d-53546a542102@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019, Jacek Anaszewski wrote:

> Hi Dan,
> 
> I have one minor issue below.
> 
> On 3/13/19 1:32 PM, Dan Murphy wrote:
> > Introduce the Texas Instruments LM3532 White LED driver.
> > The driver supports ALS configurability or manual brightness
> > control.
> > 
> > The driver also supports associating LED strings with specific
> > control banks in a group or as individually controlled strings.
> > 
> > Signed-off-by: Dan Murphy <dmurphy@ti.com>
> > ---
> > 
> > v4 - Updated code to DT doc changes appending "ti," to TI specific properties -
> > https://lore.kernel.org/patchwork/patch/1050124/
> > 
> > v3 - Removed switch case for register setting in favor of an algorithim (v1 comment),
> > https://lore.kernel.org/patchwork/patch/1049024/
> > v2 - Added look up tables for als_avg, als_imp and ramp times, fixed brightness
> > control when ALS is in control, added property value checks to ensure the values
> > are not out of bounds - https://lore.kernel.org/patchwork/patch/1048807/
> > 
> >   drivers/leds/Kconfig       |  10 +
> >   drivers/leds/Makefile      |   1 +
> >   drivers/leds/leds-lm3532.c | 681 +++++++++++++++++++++++++++++++++++++
> >   3 files changed, 692 insertions(+)
> >   create mode 100644 drivers/leds/leds-lm3532.c

[snip]

> > diff --git a/drivers/leds/leds-lm3532.c b/drivers/leds/leds-lm3532.c
> > new file mode 100644
> > index 000000000000..e8a614d71469
> > --- /dev/null
> > +++ b/drivers/leds/leds-lm3532.c

[snip 700 lines of churn]

Jacek could you please trim your replies please?  It took way to long
to locate your one line comment in this 700 line patch.

> > +static int lm3532_remove(struct i2c_client *client)
> > +{
> > +	struct lm3532_data *drvdata = i2c_get_clientdata(client);
> mutex_destroy(&drvdata->lock);

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
