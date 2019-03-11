Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F607C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB9F20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cP3bO08Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfCKP3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:29:23 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36965 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbfCKP3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:29:23 -0400
Received: by mail-oi1-f195.google.com with SMTP id w66so3965867oia.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 08:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yfbMBghI4tZX96YyI9DgNKGIR1RFPTrNGG9y/TgdjqQ=;
        b=cP3bO08ZQTd2NXT3R/uIxRhrlIOIe1jKrsGTT/Qj6QIDyyU0/4tGiNeVMZQvyzF6WE
         W6mezh9xYWF/cdpyxFeSdZu5ml/4a0y4NAUqGk5Mweq18mV7fhr0TXCpdY16p7ZqOaIl
         XxNcD9xWwqK8SiPmUxmCuqr9xC7xJdE9CPlqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfbMBghI4tZX96YyI9DgNKGIR1RFPTrNGG9y/TgdjqQ=;
        b=P99PDmUal0cFhhl6jPn2eM4JwzdnjnHCkN1vTYa+YeJjyDtCt63cXviehjHoAIwaGO
         yDWrPw4umHV/+P1bSqZs2dQmPWi3x93aMEs9ETWu2ied65kRzmKzrQzUK/ZiLINoSkre
         puETcAOZpfIjYET7qO5YDJOBFrr6KOuattg37PebppgMBeKW7fwgq8uGODcNAvIcz4vT
         HyQtYeo5GQpdw2zP5bwUSYgYjiu9bsKtMvsMgrt8J7P7jTg8WDEMpWvX5duiaLvxvBgp
         u81HEcDNJv2wjVaWCu82qCSx5h+m37AGa4eaL0tbcQImMZzZRwLJdfMwJ3odax0rMTqP
         8baQ==
X-Gm-Message-State: APjAAAXHqAz/ouGodXLT5jpCzZcTEZFryZxw6mjTfQSQ1n9T9hmNqXMq
        NyCFHbIwy/FB4UXNmRHwbGsO5NwxxNI=
X-Google-Smtp-Source: APXvYqz60GP9GOJjFmUenKBIgTJjfFoiPbgVTDyRGXcJufazs/RmP5Pe8vtXishm/2qsRh/q5letoA==
X-Received: by 2002:aca:bfc4:: with SMTP id p187mr192004oif.36.1552318160758;
        Mon, 11 Mar 2019 08:29:20 -0700 (PDT)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id a62sm3211992otb.72.2019.03.11.08.29.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 08:29:19 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id j10so3946288oij.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 08:29:18 -0700 (PDT)
X-Received: by 2002:aca:d803:: with SMTP id p3mr145429oig.111.1552318158344;
 Mon, 11 Mar 2019 08:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190308203801.57920-1-ncrews@chromium.org> <20190308210843.GA16125@amd>
In-Reply-To: <20190308210843.GA16125@amd>
From:   Nick Crews <ncrews@chromium.org>
Date:   Mon, 11 Mar 2019 09:29:06 -0600
X-Gmail-Original-Message-ID: <CAHX4x85=_76=Kyepf3Nw++4yVKOZujhLsonzaicZOnY5fi-Pfw@mail.gmail.com>
Message-ID: <CAHX4x85=_76=Kyepf3Nw++4yVKOZujhLsonzaicZOnY5fi-Pfw@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: Add Wilco EC keyboard backlight LEDs support
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Daniel Erat <derat@google.com>,
        Guenter Roeck <groeck@google.com>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for looking this over. I will fix most of your concerns, but
have one question.

On Fri, Mar 8, 2019 at 2:08 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Fri 2019-03-08 13:38:02, Nick Crews wrote:
> > This patch is meant to be applied on top of the for-next
> > branch of the platform/chrome repository, as it uses some of
> > the code staged there.
> >
> > The EC is in charge of controlling the keyboard backlight on
> > the Wilco platform. We expose a standard LED class device at
> > /sys/class/leds/wilco::kbd_backlight. This driver is modeled
> > after the standard Chrome OS keyboard backlight driver at
> > drivers/platform/chrome/cros_kbd_led_backlight.c
>
> Can you make it "platform::kbd_backlight"? We want some consistency
> there.

The analogous name in the standard driver
drivers/platform/chrome/cros_kbd_led_backlight.c is
"chromeos::kbd_backlight", and I thought "wilco" was a better
substitute for "chromeos" than "platform" would be. What other thing
are you saying "platform" would be consistent with?

>
> > Some Wilco devices do not support a keyboard backlight. This
> > is checked in probe(), and in this case the sysfs entry will
> > not appear, and everything will behave normally.
>
> Good.
>
> > When the EC is reset (loses all AC and battery power), it will
> > restart in some unpredictable state. The brightness on the
> > keyboard could be anything, and reading the brightness
> > from the EC is undefined behavior. Therefore, at startup the
> > brightness should be set, and then everything will work.
>
> Really? Undefined behavior?

By undefined I guess I meant "not conforming with the schema
that Chrome OS normally uses." The EC begins in non-PWM mode,
so while it may behave consistently, it doesn't behave as the rest of
Chrome OS expects. I think the solution is going to be to hard-code in
setting the brightness to 0 at probe(), and then everything should be
in a consistent state.

>
> > index e09e4cebe9b4..15b56f5ce090 100644
> > --- a/drivers/platform/chrome/wilco_ec/Kconfig
> > +++ b/drivers/platform/chrome/wilco_ec/Kconfig
> > @@ -18,3 +18,12 @@ config WILCO_EC_DEBUGFS
> >         manipulation and allow for testing arbitrary commands.  This
> >         interface is intended for debug only and will not be present
> >         on production devices.
> > +
> > +config WILCO_EC_KBD_BACKLIGHT
> > +     tristate "Enable keyboard led backlight control"
>
> Delete "led" or make it "LED".
>
> > +     depends on WILCO_EC
> > +     help
> > +       If you say Y here, you get support to set the keyboard backlight led
>
> Same here.
>
> > +#define DRV_NAME             "wilco-kbd-backlight"
> > +
> > +#define EC_COMMAND_KB_BKLIGHT        0x75
> > +#define KBBL_MSG_SIZE                16
> > +/* The EC can set the backlight brightness in several different modes.
> > +The mode we care about is PWM mode, where we separately supply a
> > +literal percentage to set the brightness to. We need to set the proper
> > +KBBL_PWM_MODE flag in the KBBL_MODE_INDEX-th byte in the message, and
> > +then supply the percentage within the KBBL_BRIGHTNESS_INDEX-th byte
> > +within the message. When we read the brightness, the percentage is
> > +returned in this same byte location. */
>
> Please use comment style specified in CodingStyle.
>
> Best regards,
>                                                                         Pavel

Cheers,
Nick
