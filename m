Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743FFC282DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411B72146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqwAcBd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfDEUPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:15:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43255 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfDEUPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:15:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id c8so3855011pfd.10;
        Fri, 05 Apr 2019 13:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QW9mAbN3hAuEFgKURNXSsviVwfKLY+YqAv655b7PBfE=;
        b=ZqwAcBd5NX1n/GW2fzhqvYFl1/UXU+/i/5wXYF1TmU2SHKAvXinyFkgWGM/d/mhIv4
         KgwtYAM6R7Vdner9fb/7grCra1HGgGgOTu+nqTpkcLcIfy8qrLby0CP5V/424HN13nvi
         gbWy1voI4ZIMC0/mAr0c8X8nyUP6ASDFh3hsoi18VcrtwGMaYFeNnajezLKJkaA5qbS/
         8vGZZqcOAmGKP0diIMoGxKCaiQAHkObKPgLWTSqPb5TUVKWdRPo5uGRAUANOxyDSC0pN
         SFpu5Uvv8oxk7b08PmZ7lXA/M3OnURfH6dSJzc+W4gYkwxWmsgSjkoKSvaAg/U3qN0yg
         4S0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QW9mAbN3hAuEFgKURNXSsviVwfKLY+YqAv655b7PBfE=;
        b=DqyrhMA/C8ysIFbaydq+l+ThYpTKibFLCgW4h5/pFVxTMt2jJj0l6z4KQcahD0/bef
         wjC4jTjIigGbLw4h62qZstlXOxhwiKRlIRBSEk3T5UxFCdnYVz/vqG+eJwA1+MNi1znz
         Eot34bKWXdhPKq+v+kS/EZ8Tm8TjcsEjDaIcPNP2D/WA5/O8I2l+/LhuQUGgEumYYsL/
         F9RGyYe8BM+wavpvJUrqx9B8WT9K4kKiSUVokxv9KdD+4eO6B6uOtbXVmKMDAZtLu9tM
         V4aBHAhACeL2o2TwCNWE1574qDPuwgtfijcdRal5t4KFn+z75nan8DxjyNSoKWYEcRLb
         0tLQ==
X-Gm-Message-State: APjAAAWCYdH2iIbqbLJxcXQGwNUwEw7IMsqjpOwVypFzDvUw5jmsFgbZ
        t9z4bFNj7Z/BT8+o/yForHYFe+Kq
X-Google-Smtp-Source: APXvYqwF/WHq9MbD/opCjhvqJbNAX1Z15ZkIRA76vVGb8PTFSQrYPafdmohdpB6soGr+iKtUQkvSbQ==
X-Received: by 2002:aa7:9421:: with SMTP id y1mr14891894pfo.147.1554495336913;
        Fri, 05 Apr 2019 13:15:36 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h4sm24915865pgn.20.2019.04.05.13.15.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 13:15:35 -0700 (PDT)
Date:   Fri, 5 Apr 2019 13:15:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nick Crews <ncrews@chromium.org>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlaurie@chromium.org, sjg@google.com, groeck@google.com,
        dtor@google.com
Subject: Re: [PATCH v5 2/3] platform/chrome: Add Wilco EC keyboard backlight
 LEDs support
Message-ID: <20190405201534.GA4426@roeck-us.net>
References: <20190404171007.160878-1-ncrews@chromium.org>
 <20190404171007.160878-2-ncrews@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404171007.160878-2-ncrews@chromium.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 11:10:08AM -0600, Nick Crews wrote:
> The EC is in charge of controlling the keyboard backlight on
> the Wilco platform. We expose a standard LED class device at
> /sys/class/leds/platform::kbd_backlight. This driver is modeled
> after the standard Chrome OS keyboard backlight driver at
> drivers/platform/chrome/cros_kbd_led_backlight.c
> 
> Some Wilco devices do not support a keyboard backlight. This
> is checked via wilco_ec_keyboard_leds_exist() in the core driver,
> and a platform_device will only be registered by the core if
> a backlight is supported.
> 
> After an EC reset the backlight could be in a non-PWM mode.
> Earlier in the boot sequence the BIOS should send a command to
> the EC to set the brightness, so things **should** be set up,
> but we double check in probe() as we query the initial brightness.
> If not set up, then set the brightness to 0.
> 
> Since the EC will never change the backlight level of its own accord,
> we don't need to implement a brightness_get() method.
> 
> v5 changes:
> -Rename the LED device to "platform::kbd_backlight", to
> denote that this is the built-in system keyboard.
> 

NACK.

Per Documentation/leds/leds-class.txt, LED devices are named
	"devicename:colour:function"

This document also states "The naming scheme above leaves scope
for further attributes should they be needed". It does not permit,
however, to redefine one of the fields to mean "location", much less
the declaration that a devicename of "platform" shall refer to an
"internal" backlight, or that there shall be no more than one
"internal" backlight in a given system.

On top of that, with this naming scheme any system with more than
one internal backlight may result in duplicate sysfs attribute names.

If an attribute for "location" is desired or necessary as part of
the LED attribute name, such a change should be well defined, and
it should be documented, and it must not create the risk of
duplicate sysfs attribute names.

Thanks,
Guenter
