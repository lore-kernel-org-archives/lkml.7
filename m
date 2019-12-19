Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E51EC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 08:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA6A21D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 08:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJZ/DNtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfLSI25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 03:28:57 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37517 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfLSI24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 03:28:56 -0500
Received: by mail-lf1-f66.google.com with SMTP id b15so3711792lfc.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 00:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EYVpTAvfKwHHKmlAPuGRsZ3iezpd785NjyR9OVcUj6E=;
        b=MJZ/DNtFXAxxKUZKDxH+hao28YTyE5NOXtuQ0Z3/ibWy8zpn9idcT5fZSA3qlJswY1
         Yijm5VvGd/xFqGL1v6NZGRxBXBKHV016m5JvvGWQlY0M4LINXT2A+VMv/c7K+z0FglYN
         FkcONe7Byj4YXGeofGkBJBC9L9BYhWz0U/7T5uj+m7cWbGsUIxhMxvZYjxq9RmDbTAeo
         5FOeLkOvfmFeFbQ9FneVOLbyy+1qTeqa2lenupHqbbfkraaI8ywbs0EUp3VJNPMnGg4z
         8lysTRj1vQ/4vBUWcuSX068OiI8cXcTJLEVHZYJzOCkkKrvNMEEtnJ4J5TdoqJk3xzfJ
         RFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYVpTAvfKwHHKmlAPuGRsZ3iezpd785NjyR9OVcUj6E=;
        b=nRRDtS2AeYDjAwLUKgK6VH3OjLCXyYParph6pcltZQk8gotV3VQdFyI5U7E8B22Cpc
         Cpg3y5/OmPku/eZmhjSnzGTyOysjmqWjJpM9hCOuKZjLLyS6qhc+IO+fOK/IOGIst/ZX
         0asEMLE0DLvVibLFyi97kS/HlLUSpNsTwGmR8IKstolOxEJnQGT9yN9GZkbwm2DYw4G0
         Yw5yvdLwsfR9kIQrlKKc0HgC8CMfTSdPQh6wXoWvhQ8Ww/3XlXhvuDIvkAVVFZH8SenV
         XdUEJepwJh296Q2nj7Iu9r07JNqhRzYdTb53ZiCydf7Ht9L83q7hK7QZeeI0rk4zcbFi
         6Dxw==
X-Gm-Message-State: APjAAAVvshUC6i2hmPxNDTMI9sDnIS1TyCyetuAd05beOdGFfLniE9iv
        2mmG4uQy+OEMEICd6IcIWCyoZgSXgO95XipB03BnaA==
X-Google-Smtp-Source: APXvYqynTJm9GoZtkT/ox5Ee2KtmtUCBm2Ol3fEci7a1RBI4FjyF3QqGMde1dsSwXQ7lWCCv/YG69H6YPlbklmRCDWQ=
X-Received: by 2002:a19:8a41:: with SMTP id m62mr4543898lfd.5.1576744133697;
 Thu, 19 Dec 2019 00:28:53 -0800 (PST)
MIME-Version: 1.0
References: <20191213124221.25775-1-tbogendoerfer@suse.de> <20191213124221.25775-3-tbogendoerfer@suse.de>
In-Reply-To: <20191213124221.25775-3-tbogendoerfer@suse.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 Dec 2019 09:28:42 +0100
Message-ID: <CACRpkdY+2Z90n6zNZbQpmGCWYAH4PzEOv8puOkwbrcxCk_Eq2A@mail.gmail.com>
Subject: Re: [PATCH v11 net-next 2/2] mfd: ioc3: Add driver for SGI IOC3 chip
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-mips@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-rtc@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 1:43 PM Thomas Bogendoerfer
<tbogendoerfer@suse.de> wrote:

> SGI IOC3 chip has integrated ethernet, keyboard and mouse interface.
> It also supports connecting a SuperIO chip for serial and parallel
> interfaces. IOC3 is used inside various SGI systemboards and add-on
> cards with different equipped external interfaces.
>
> Support for ethernet and serial interfaces were implemented inside
> the network driver. This patchset moves out the not network related
> parts to a new MFD driver, which takes care of card detection,
> setup of platform devices and interrupt distribution for the subdevices.
>
> Serial portion: Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
>
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

This makes the kernel a better place:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Will there be a GPIO driver arriving later?

Yours,
Linus Walleij
