Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBC3C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CC22075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=balena-io.20150623.gappssmtp.com header.i=@balena-io.20150623.gappssmtp.com header.b="BdbpqF1T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfKRNai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:30:38 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43763 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfKRNah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 08:30:37 -0500
Received: by mail-lj1-f196.google.com with SMTP id y23so18913302ljh.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 05:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=balena-io.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YWOzP2XTenM698y14EYphcgxccBzKsjNSQkaqSk5HjQ=;
        b=BdbpqF1TbFIME6ic2c1pI6EjUkhk4ppM5wnWnOHASrhu6QWN0yAiKAQqfVdV3weoYh
         E+aG/V9h8RMwNjWvpSMnTK6PxDijeP2bVNPw7ux32TyPwh+I9m4sjB5yb382aY6WgKzN
         26dx0NQH7wNO+FqL+uAwkY4QrDtkJ2bSLGR5dakOnu4r0R3rAsFrYSkAeofZwyuNPZWl
         RCZ5lVeFQ3xCWHB1fAF7FHrf1HP/BcfQpQkQlhT7ft1oB2mKCynstvvgTMItB0f7i7Tw
         TsdjBIf/h82XprQdKawNYWAP8VNi8VQac5DlmkryiDbtFqdofGHHl1strZBZ2dyjM+pL
         x21Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YWOzP2XTenM698y14EYphcgxccBzKsjNSQkaqSk5HjQ=;
        b=e0tednvMONDdCIv6clDGkK9xMjqy88Dh4WPitu4dtIJJpdaiK+0pivjmTv5dqNkxQV
         tnwU53ZFB2yWCwpawU+qMaQLGnoa/dZadfFGafErdOiMabxeQt4xAkBejWWJxs8CIvXR
         KWIPwM0Bvnt/GWitZT2OdLg+qlZ6jzlmQGM/RiF9R2Eb0iyrpSTSL0QFHxOwNmoeLiKV
         Goce9SmxElR8MAnMAE5/AclHC43nO6RCAYJ2XEbD+xZCNRxmcs30zA5XgudXowT+7P4R
         ZUYyq93zPGgXrklhcnVtnqkK/3GUA0tyaGb5ifJgoP58nLBamogw/GbNWiLb7IhZek7i
         5yhQ==
X-Gm-Message-State: APjAAAVABIKXBU+GgiBPIBCJQ/H8YmfrOHogA31pVIeoLc18tU7dzUmA
        /HR03dkkov0FeQUYFg79UD5GIA==
X-Google-Smtp-Source: APXvYqx36+Ke1sYW/+DT6yKCb3mUj+gLbyKBBNpr/SipSyf6mcjc99F7a5wEo45HZms0zbj/oF6VcQ==
X-Received: by 2002:a2e:9ecf:: with SMTP id h15mr21341938ljk.173.1574083835375;
        Mon, 18 Nov 2019 05:30:35 -0800 (PST)
Received: from majorz.localdomain ([85.130.115.21])
        by smtp.gmail.com with ESMTPSA id s4sm3077313lfd.34.2019.11.18.05.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 05:30:34 -0800 (PST)
Date:   Mon, 18 Nov 2019 15:30:31 +0200
From:   Zahari Petkov <zahari@balena.io>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, Zahari Petkov <zahari@balena.io>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: pca963x: Fix open-drain initialization
Message-ID: <20191118133031.GA90092@majorz.localdomain>
References: <20191014123604.GA743117@majorz.localdomain>
 <20191103170327.GA32107@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103170327.GA32107@duo.ucw.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 10:09:53AM +0100, Pavel Machek wrote:
> On Mon 2019-10-14 15:36:04, Zahari Petkov wrote:
> > OUTDRV setting (bit 2) of Mode register 2 has a default value of 1.
> > During initialization when open-drain is used, instead of setting
> > OUTDRV to 0, the driver keeps it as 1. OUTDRV setting is now correctly
> > initialized to 0 when open-drain is used.
> > 
> > Additionally the BIT macro is used for improved readibility.
> 
> You change more than you describe in the changelog.

You are indeed correct. I will provide a more detailed and precise description.

> 
> > +++ b/drivers/leds/leds-pca963x.c
> > @@ -438,12 +438,12 @@ static int pca963x_probe(struct i2c_client *client,
> >  						    PCA963X_MODE2);
> >  		/* Configure output: open-drain or totem pole (push-pull) */
> >  		if (pdata->outdrv == PCA963X_OPEN_DRAIN)
> > -			mode2 |= 0x01;
> > +			mode2 &= ~BIT(2);
> 
> | 0 -> & ~0x04;
> 
> >  		else
> > -			mode2 |= 0x05;
> > +			mode2 |= BIT(2);
> 
> | 5 -> | 0x04;
> 
> Are you sure?

Yes, I need to explain this better in the updated description.

> 
> Additionaly, we already have defines for bits in mode2 register:
> 
> #define PCA963X_MODE2_DMBLNK    0x20    /* Enable blinking */
> 
> So if you care about readability, perhaps you should add defines for
> invert/ open drain there, and then use them?
> 
> Please keep using 0xab instead of BIT() for consistency with the rest
> of the driver.

I will update the code to use new defines instead of BIT().

Thanks a lot!
Zahari
