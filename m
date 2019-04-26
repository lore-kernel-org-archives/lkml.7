Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861FBC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0F32077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 22:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556318953;
	bh=S2WRYKQrUvNbolwdt8d4td3Z7kY9GYGlNxq8u7jae7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bQtCp0tS+aC9fJdl5FHNTcEepyhPyP/nCtXAAN1SuB2LSsicDAqEdyIU9zcnYw8+7
	 7tSkP0WkjdChaihN68wvBEbIdad9ArQrateDU/UynhL+3pZuulfmliCZPxrtVJVLXZ
	 IAwKO1UasARxYTk9bVtrQGINjtpWMR1g27Wx/uCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfDZWtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 18:49:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45448 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfDZWtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 18:49:11 -0400
Received: by mail-ot1-f65.google.com with SMTP id e5so3983446otk.12;
        Fri, 26 Apr 2019 15:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=euJSNuGz5ggDfWsuKGiYgWmJQ+FIZVsdPZl4jWO0XFM=;
        b=soVSf/K/JKafePpubs0g4ETlftU/7gC4+uKnJxw4mrp8Oi5HY1Kog8C5iRlM0EcEtE
         dgWBi++AMllsPP76H7Sjfmb3TPMsm32iAMVCHwRGM+O4ZHDtAwCgIRaVpePnwCKvhtwr
         HUDve+Mc4dQyhFb2bug69V6mCw0Phy0IHwmzqXZqQH9jUv6KXRfDY8pfxy5wPDdqoMQ3
         CiCTGU9F1h7ZvXfzMKIsnHRC4bviSMMC/IpH0qRBcfI+olCD3hGV7favo2VtMeDI3xhb
         8IqD7nckwL0PG7DEUKAG0TGTyAKAiZIosNFwxdrHCV12Cvv6IugeiZCFUBskSQXCjKsM
         lfiA==
X-Gm-Message-State: APjAAAVX4Mywvmt3l5IhF/KQk2DD4h5MqHfS8SpvLNDNzRE37sm8l+kd
        QeI33mPv9QQ2ENKTeh9cpA==
X-Google-Smtp-Source: APXvYqyOPR9ZKQ+9wEgt3Xb1SWjJnwcQzNfmeLpRDgZZSV2vvKrUiu+ayK2jEFg92+SIH5DtzgeIbA==
X-Received: by 2002:a9d:57c2:: with SMTP id q2mr11345037oti.313.1556318950626;
        Fri, 26 Apr 2019 15:49:10 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c136sm13295601oih.14.2019.04.26.15.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 15:49:09 -0700 (PDT)
Date:   Fri, 26 Apr 2019 17:49:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, mark.rutland@arm.com,
        Lee Jones <lee.jones@linaro.org>, bjorn.andersson@linaro.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>, agross@kernel.org,
        David Brown <david.brown@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: input: add Elan 400 combo
 keyboard/touchpad over i2c
Message-ID: <20190426224908.GA30389@bogus>
References: <20190415160915.16324-1-jeffrey.l.hugo@gmail.com>
 <20190415161055.16372-1-jeffrey.l.hugo@gmail.com>
 <CAO-hwJJ_BRRHL44yaZ=d_K-9iq1cyONn0rR+VW3ukW1M2Ma0ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO-hwJJ_BRRHL44yaZ=d_K-9iq1cyONn0rR+VW3ukW1M2Ma0ug@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 11:35:42AM +0200, Benjamin Tissoires wrote:
> On Mon, Apr 15, 2019 at 6:11 PM Jeffrey Hugo <jeffrey.l.hugo@gmail.com> wrote:
> >
> > The Elan 400 combo keyboard/touchpad over i2c device is a distinct device
> > from the Elan 400 standalone touchpad device.  The combo device has been
> > found in the Lenovo Miix 630 and HP Envy x2 laptops.
> >
> > Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> > ---
> 
> With my comments in 2/3, I wonder if you need this patch at all then.

I don't really follow the discussion in 2/3, but you should still have 
specific compatibles even if right now you don't need them.

> 
> Cheers,
> Benjamin
> 
> >  .../devicetree/bindings/input/elan,combo400-i2c.txt   | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/elan,combo400-i2c.txt
> >
> > diff --git a/Documentation/devicetree/bindings/input/elan,combo400-i2c.txt b/Documentation/devicetree/bindings/input/elan,combo400-i2c.txt
> > new file mode 100644
> > index 000000000000..fb700a29148d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/elan,combo400-i2c.txt
> > @@ -0,0 +1,11 @@
> > +Elantech 0400 I2C combination Keyboard/Touchpad
> > +
> > +This binding describes an Elan device with pid 0x0400, that is a combination
> > +keyboard + touchpad device.  This binding does not cover an Elan device with
> > +pid 0x0400 that is solely a standalone touchpad device.
> > +
> > +Required properties:
> > +- compatible: should be "elan,combo400-i2c"
> > +
> > +This binding is compatible with the HID over I2C binding, which is specified
> > +in hid-over-i2c.txt in this directory.

Separate is fine, but we've been adding compatibles to hid-over-i2c.txt.

Rob
