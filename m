Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47000C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1056320896
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mXnIzDFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbfCYSWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:22:35 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41747 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbfCYSWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:22:34 -0400
Received: by mail-ot1-f68.google.com with SMTP id 64so8948729otb.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=osyFoiAo6qP0rKdEOXh78fLmMKe2ZJ9vLJTKhpfj0/g=;
        b=mXnIzDFBchoW/aBj9WV34qGnJUWqLFyfFwGogQNJ0e0dP3/ySlmpdZhNxp0sq8DtBR
         LqkYIA/5uzPrsaWYHtO8NIZvRRxg/bQteNh3XdNKjJLxURcWLev2lKExLbrbi//1r7no
         +ii/SSM9OFbmkwVwTveQpZmsf4lt9YS+iimIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=osyFoiAo6qP0rKdEOXh78fLmMKe2ZJ9vLJTKhpfj0/g=;
        b=kKnUC6PsiyCaDstdlIN3uErsVWkuNdHpZecUj49bX6nkYAkdcqyyoPy8rWgH0/3xFQ
         bex+rMYqUwshyWv2le/5fvcNLyq631Q0HY8I3CYewpyfCqdwBOzERrP3wP0yWLGRNtXs
         Cm7OeB+dmUN9fFxnb/LL5XaZ7H4MPKD++ll1+r0Wo+QnPwTemlLzumhaH+pKEBh/BHbt
         ww1FFXUCVovJipIvl6HadWZEEGDoq1tAuET39joWYhNbbbHvRSe62K3CcvSodHWNuPsT
         lUSXksp0naC6FQaOw4q0L8ywGpKnxA6wPOIQ4OcjD5cNIrm/WS6UD4Hq63ic4dxZsa1c
         bw3g==
X-Gm-Message-State: APjAAAWcLonDtWtI7GEFbAO1vRyJ1lDHkvSTnOoC5Tpp1JWxLD59Xxhd
        VdNWcGXCER+XK/N15ZzEXG0NqmIQ+Jk=
X-Google-Smtp-Source: APXvYqymQgl7MioRwrEdU037BJ5F7TpXlGetRE3TKON3m4e5sPu7KScFHKT9vZOLQVoPmN1nZjFB1A==
X-Received: by 2002:a9d:67c4:: with SMTP id c4mr4427576otn.215.1553538153515;
        Mon, 25 Mar 2019 11:22:33 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id k60sm4335073otc.42.2019.03.25.11.22.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:22:32 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id d24so8935629otl.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:22:32 -0700 (PDT)
X-Received: by 2002:a05:6830:11d2:: with SMTP id v18mr18254077otq.368.1553538152020;
 Mon, 25 Mar 2019 11:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190321221334.240059-1-ncrews@chromium.org> <33e0da93-18aa-5ddc-5bdb-a73336392e2a@collabora.com>
In-Reply-To: <33e0da93-18aa-5ddc-5bdb-a73336392e2a@collabora.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Mon, 25 Mar 2019 12:22:20 -0600
X-Gmail-Original-Message-ID: <CAHX4x84LZFJvmcwbfRkAb6akj=sQtQkCQFtROFBdDh3R4AOqMg@mail.gmail.com>
Message-ID: <CAHX4x84LZFJvmcwbfRkAb6akj=sQtQkCQFtROFBdDh3R4AOqMg@mail.gmail.com>
Subject: Re: [PATCH 1/3] platform/chrome: wilco_ec: Split core and mailbox
 into separate modules
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, Pavel Machek <pavel@ucw.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Simon Glass <sjg@google.com>,
        Guenter Roeck <groeck@google.com>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 11:18 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Nick,
>
> Thanks for the patch, some comments below.
>
> On 21/3/19 23:13, Nick Crews wrote:
> > It was bad design to lump the mailbox interface to the Wilco EC into the
> > same module as the code module, which loads all the subdrivers:
>
> Typo: s/code/core/?
>
> > - This required the sub-drivers to depend on the core, which doesn't
> > really make sense, they should just depend on the mailbox interface.
> > - It caused problems with circular dependencies: An upcoming keyboard
> > backlight driver depends on the mailbox interface, which in the old
> > architecture makes it also depend on the core driver. However, the core
> > driver should be able to detect whether or not the keyboard
> > backlight is available, so the core module depends on the backlight
> > driver. This created a circular dependency.
> >
> > By splitting up the mailbox interface and core driver into separate
> > modules, it fixes both of these problems.
> >
> > Signed-off-by: Nick Crews <ncrews@chromium.org>
> > ---
> >  drivers/platform/chrome/wilco_ec/Makefile  | 6 ++++--
> >  drivers/platform/chrome/wilco_ec/core.c    | 2 +-
> >  drivers/platform/chrome/wilco_ec/mailbox.c | 6 ++++++
> >  3 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
> > index 063e7fb4ea17..9706aeb20ccb 100644
> > --- a/drivers/platform/chrome/wilco_ec/Makefile
> > +++ b/drivers/platform/chrome/wilco_ec/Makefile
> > @@ -1,6 +1,8 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> > -wilco_ec-objs                                := core.o mailbox.o
> > -obj-$(CONFIG_WILCO_EC)                       += wilco_ec.o
> > +wilco_ec_mailbox-objs                        := mailbox.o
> > +obj-$(CONFIG_WILCO_EC)                       += wilco_ec_mailbox.o
> > +wilco_ec_core-objs                   := core.o
> > +obj-$(CONFIG_WILCO_EC)                       += wilco_ec_core.o
>
> Odd, same config definition (CONFIG_WILCO_EC) for two different kernel modules?

The mailbox and core modules will always be wanted together, so I
figured just keep it
as one config option. I think it would be confusing to add unnecessary
config options.
Is there a good alternative?

>
> >  wilco_ec_debugfs-objs                        := debugfs.o
> >  obj-$(CONFIG_WILCO_EC_DEBUGFS)               += wilco_ec_debugfs.o
> > diff --git a/drivers/platform/chrome/wilco_ec/core.c b/drivers/platform/chrome/wilco_ec/core.c
> > index 05e1e2be1c91..ece30874f35f 100644
> > --- a/drivers/platform/chrome/wilco_ec/core.c
> > +++ b/drivers/platform/chrome/wilco_ec/core.c
> > @@ -20,7 +20,7 @@
> >
> >  #include "../cros_ec_lpc_mec.h"
> >
> > -#define DRV_NAME "wilco-ec"
> > +#define DRV_NAME "wilco-ec-core"
> >
> >  static struct resource *wilco_get_resource(struct platform_device *pdev,
> >                                          int index)
> > diff --git a/drivers/platform/chrome/wilco_ec/mailbox.c b/drivers/platform/chrome/wilco_ec/mailbox.c
> > index 14355668ddfa..ca6b92ce7e6d 100644
> > --- a/drivers/platform/chrome/wilco_ec/mailbox.c
> > +++ b/drivers/platform/chrome/wilco_ec/mailbox.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/io.h>
> > +#include <linux/module.h>
> >  #include <linux/platform_data/wilco-ec.h>
> >  #include <linux/platform_device.h>
> >
> > @@ -235,3 +236,8 @@ int wilco_ec_mailbox(struct wilco_ec_device *ec, struct wilco_ec_message *msg)
> >
> >  }
> >  EXPORT_SYMBOL_GPL(wilco_ec_mailbox);
> > +
> > +MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("ChromeOS Wilco Embedded Controller mailbox interface");
> > +MODULE_ALIAS("platform:wilco-ec-mailbox");
> >
>
> Thanks,
> - Enric
