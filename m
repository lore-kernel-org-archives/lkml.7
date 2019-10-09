Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF9BC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5979C206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyC/2ZbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfJIIMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:12:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43431 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfJIIMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:12:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id i32so899547pgl.10;
        Wed, 09 Oct 2019 01:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=11B75nSfpkiHSUA7kLDSZM9qo28NOGIlqXnAmtJunQI=;
        b=hyC/2ZbDrDifzE37Wh14howiTcK3yRDDklHrqOsMBCUi4Gvz1fB5e1Qwg3mtSMqQb+
         ppKRaWCX2rOxI1qTJS0E49VuBxXP+2a4C2C86eBs993/2vt4lx1z20KvNcAEtBpMBv9H
         kDn36XlhsBDUA7szlV6MEMpKQVHx00bwVge8g6GssHCoVD6dVSxuSEa4e+sC/SyKsD/+
         QlL17FjMFZxgnCooLGAlZYjmZGXMOHvGOaEzQpekTRM2MdThx3/u3lVMY9nT9arxBRS1
         wWEsb6cL4u8RP2adDMpuxOHAQgF2jkv/sL3vO1qaE74ef8zOsotQXsDir8QYobskJ9UE
         dwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=11B75nSfpkiHSUA7kLDSZM9qo28NOGIlqXnAmtJunQI=;
        b=aGe1SpmByjFt77ZMz1zgIaoFosL8VU7en8HbiU/z+VfIcoAsxOBLZjMkNbNzKAYkJk
         COZjrghm3AIGO0oLTMfub9zi5W9ogiqAXSzCJVM0Zs0EFD9ovzkuT6HWNASRe7PfsYPJ
         4SmqmFu/0VxPMvEyTNT4i96ZyJv3KqoirkoJcL2M2eHHju9Xzt7VvSGxH0l8NpmBlScV
         mCGHg6c6QbmQa7Dn7PxuXKuawdtGznNyGf2miKY5eD+DMpTtlnJrFVCjV5nf5C456k6g
         7fHybInTCkw3fUUKofUcSR10cLxF+lifCqwz22fYPkAeGSm6vk21tASqVsxc++F9oEdk
         Y0jw==
X-Gm-Message-State: APjAAAXhZO+YJY76lZpUI4s/7RRtINxDILISr52i3B+iEhpptTcfk77d
        N15YkRvmffVmGhEjCG4wXZQx6whGxCCzh7w2hnI=
X-Google-Smtp-Source: APXvYqz78hCAKbdx1xRfKxNWl6+jG4BDO/bMlHunDvw7i8+a+54Q6DZDFb9iTjJNg/rruFkAAayzrzmIJTjd3c5K1Sk=
X-Received: by 2002:a65:5a08:: with SMTP id y8mr2996887pgs.4.1570608751808;
 Wed, 09 Oct 2019 01:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <1570601911-9162-1-git-send-email-Anson.Huang@nxp.com> <20191009065315.wgdvmkv6skteyul4@pengutronix.de>
In-Reply-To: <20191009065315.wgdvmkv6skteyul4@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Oct 2019 11:12:20 +0300
Message-ID: <CAHp75VcWXT+j5cfVzxPL+3YdgR+3uhFSb0qEDRr4YL+WenVKUQ@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: imx: Only get second/third IRQ when there is
 more than one IRQ
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <Linux-imx@nxp.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 9:53 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> The patch is fine given the changed behaviour of platform_get_irq. I
> wonder if it is sensible to introduce a variant of platform_get_irq (say
> platform_get_irq_nowarn) that behaves like __platform_get_irq does
> today. Then the imx driver would just call platform_get_irq_nowarn
> without having to check the number of available irqs first.

It's being discussed in parallel thread about
platform_get_irq_optional() which won't issue a warning.

--=20
With Best Regards,
Andy Shevchenko
