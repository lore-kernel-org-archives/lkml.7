Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E2CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C923320850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErFhOQzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfCTRLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:11:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33723 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfCTRLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:11:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id b12so2281368pgk.0;
        Wed, 20 Mar 2019 10:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6fxjmu2Aqm6K9TbLvpxrkqitzFTWvG/GeUBHTQd5nuA=;
        b=ErFhOQzTyUejwwhXHe2WX2Jif+UUq+ywaHtCcpypF5R0/ghx7s69YiJS9Lc61wIoLg
         VOg5BeF67b8LvyCziiL/rtM9M+Lv8vyLK0IFjz+f6Ppfupg94GYW12JYRjC+vAc9J1VR
         j4+Dx/yxowaIthI2y0w+VNRhyWV7D0yKn1EqFZ/QRQm6acBoCGfE6My/5UZJ4AjcoCRM
         43ceqSrf5+4FD8qinM0GUBdZMgI+Z61KNO1cLdtJaxeSyblQc+1nJ0oQyOmT44c5Pzc3
         6S3k5KuFge+bD7BsKjUgEOJ8CBWCn6UshFiUNtPzs9DpHbFd9PnYadZvEDe95Vi6rkbS
         agrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6fxjmu2Aqm6K9TbLvpxrkqitzFTWvG/GeUBHTQd5nuA=;
        b=bhV2fGp+8UM4vkzkuuVbdQQY5A1/oEhwZKLrEMDei2rXHscKnEgNgX2NtG6ovy1ZUr
         c+5DEdUfYLIIZzSuCY7R68CYoinTrZ6G9haRp50M0W5CjHuOn1ZxoDCI3+IChEpIhLy2
         1WdHBGnkU1yz8hLSH7eaTa82ECC8vWyAlZPkiVrKp8FxcB224b5AY6tWgf85dLpH/4Q2
         095qvSEegqQLXVIVoyaXljdItDIT6ypXD1MCyUVXTqFGR4vZRnOS1jHv4Gf3B5yA5f+/
         7iB1aEj9lRKdE7MLw6TNcDJnsWD2qdevnQb6qiCjvVx5vw+E4m4tQdrLUa4HdMQhH+d+
         L5Rg==
X-Gm-Message-State: APjAAAWfr7Je5TEGvBmEa+4CJD6WUQXU9TFLvth2YdWn50QNphDCNJEQ
        nPINvHrmdFVQgXGt5Uu5YCKjHAW8VH989AzWFI4=
X-Google-Smtp-Source: APXvYqxxY+XANZTUXi4XvTPndnW/dT4s36satB+ak1wjWqGWy/6R9t0CsVTpJ7yNdjx5zAV9nNVD+4Jee0dCm374YLE=
X-Received: by 2002:aa7:8c97:: with SMTP id p23mr8875312pfd.229.1553101880224;
 Wed, 20 Mar 2019 10:11:20 -0700 (PDT)
MIME-Version: 1.0
References: <LaQHUFs--3-1@tutanota.com> <CAO-hwJLGABHATo-fOc_jgc8uNeLDv7cemsHuQMj7zRJWmfyp4g@mail.gmail.com>
In-Reply-To: <CAO-hwJLGABHATo-fOc_jgc8uNeLDv7cemsHuQMj7zRJWmfyp4g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 20 Mar 2019 19:11:09 +0200
Message-ID: <CAHp75VeR2ojtEB1gGE6hPiv9gWfLPyop1rsok1NSV57jrVU9zg@mail.gmail.com>
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     hotwater438@tutanota.com, Jiri Kosina <jikos@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dmitry Torokhov <dtor@chromium.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 4:38 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> On Wed, Mar 20, 2019 at 2:28 PM <hotwater438@tutanota.com> wrote:

> > Patch is created by help of ELANTECH and RedHat guys (Hans De Goede <hdegoede@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, Andy Shevchenko <andy.shevchenko@gmail.com>) and me (Vladislav Dalechyn <hotwater438@tutanota.com>.
>
> Don't take it wrong, but that's not how we give credit in a patch.
> In your case, if you do not have any Elantech engineer who agreed to
> sign off the patch, you can definitively mention them this way.
> But the other guys (Hans, Andy and myself) are well known kernel
> developers in the input and HID subsystems, so we usually take the
> fame by adding our Reviewed-by or Signed-off-by tag at the end of the
> commit message. (Also note that Andy is working for Intel ;-P )
>
> If you feel that these persons have an equal participation in the
> creation of the patch, you should ask for their Signed-off-by in the
> patch. My gut feelings tell me they would gladly give a Reviewed-by
> because they helped you on the patch, but they are not the "author",
> so the Signed-off-by should be you only.

Just in case, we have Co-developed-by: tag and for my opinion Hans'
name should go under this category.

-- 
With Best Regards,
Andy Shevchenko
