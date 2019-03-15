Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88625C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD43218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYIpj78U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfCOSp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:45:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35278 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfCOSp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:45:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id j5so6962451pfa.2;
        Fri, 15 Mar 2019 11:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VK+LR0HkVqg+g+PEO6ILwoTxff4AKvWaTBsfdr3of4I=;
        b=iYIpj78Uow+epfVI2I4/DzbxPYJo+kPm8shi/mF9THDc2mHwDQ7+QfdOkqwWuWszJN
         5n6ZW891Z5JP0F38trCOPPevhIl38tHasEC+R5Om/hD0xMO7WfPKzBnoouFxgHySeD8a
         b2go/a1LrpojG1Jtjs23b4Z7jDVWNz/UXDobDx8CaIeU1C7xpawuRrHHfNNeXQK3EdAT
         KBAQytW9RdyH23f9LFb2QtaIEywM8onAMO5JsDPt5hLmWBexeKeyIWXNSwGt+UOUfsU7
         kDaPfOoUUpi9Os0AgqukbTED8SLsBS+Q8G39Qgh7tqgjLcaY8dJPw73fpWlu1Zbm8RVY
         lL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VK+LR0HkVqg+g+PEO6ILwoTxff4AKvWaTBsfdr3of4I=;
        b=N/sXrYj6aMS8K86X/KGuHSO5FJz3YhcDnEpCAZ5H8WKtsbysgdBD4O+A+s0B2QfpZw
         CZjLU1t6A5ncur2R4inT8ljK6cLKjBdpWPDBjF3pNzMlld6uKcxQOeu4KAVgDExZXMsF
         lrImxbov+jHJ8QCPvbsvf3ilLvnLhe7Lxyy52FSuw28l1UMgJYF0Lg0xIcpp/KXYzQeW
         LFYOQqwD3IzQ21g2c25Fte+ICpkt6d7+MDIAp0u8Pv+4TgdF+34ObNcbQlKERipMY0sr
         Nh7UK90QdFvrDMG6rOEWGzxqhERw8GKa7pO5lPJmLjT4ipyWuhpxYb87JTqU4W6BRvh/
         gA4Q==
X-Gm-Message-State: APjAAAU3XBr78NBvfX0AqaHVnufKYApTb4xas/vK0CRZNAK3RimFo1JR
        7XmQeyO9jOpNCXagnHmUlj0qz8H4EHJXIzyLtHY=
X-Google-Smtp-Source: APXvYqw3TaxggeBqtyecfcMSQvxbFW+vbW2qdzwAX7pBaJpkFDvdlCJlVOt04//Li6XBATgSfVeNl6ARjOea5LrZAvY=
X-Received: by 2002:a63:2907:: with SMTP id p7mr4803411pgp.161.1552675556399;
 Fri, 15 Mar 2019 11:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <CAHp75VeH9isvFkp+AECgsN8du__8tBBp_4zZEVXJ083BdFweeg@mail.gmail.com>
 <afc51d27-3312-cdf4-68a5-4486db1d006b@metux.net> <20190315181118.GF9224@smile.fi.intel.com>
 <d9ac8446-c7ff-6e57-5eaa-f1a09d549081@metux.net>
In-Reply-To: <d9ac8446-c7ff-6e57-5eaa-f1a09d549081@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Mar 2019 20:45:45 +0200
Message-ID: <CAHp75VdCy0vtk0wYKrCKFKzdGQXaXQkgL_zWfCZGKas5JO9HtA@mail.gmail.com>
Subject: Re: serial driver cleanups v2
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        macro@linux-mips.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>, slemieux.tyco@gmail.com,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, baohua@kernel.org,
        Peter Korsgaard <jacmet@sunsite.dk>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 8:44 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
> On 15.03.19 19:11, Andy Shevchenko wrote:


> OTOH, the name, IMHO, is a bit misleading. Any chance of ever changing
> it to a more clear name (eg. devm_request_and_ioremap_resource()) ?

Compare  iomap vs. ioREmap.

-- 
With Best Regards,
Andy Shevchenko
