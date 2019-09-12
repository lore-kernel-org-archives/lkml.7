Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A576C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFAF208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbtWGxCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbfILJa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:30:28 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44927 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730509AbfILJa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:30:27 -0400
Received: by mail-lf1-f65.google.com with SMTP id q11so3820005lfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 02:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wY56gDc8OIUpS5XMKHyPBmpKIt1MVxFJU2VGVM97FlQ=;
        b=JbtWGxCqQ3ESw7df2bOtubw1S8fdOq7zYqwxRvBkho2cKxOyGTDF1igln1v6Ql6SVc
         HO9Ms65nPMNbxPRMzflMFWoq6RoDrTJ11kO8Yv5fao41iM/O+rxdpuR+TxRE2cjyPJ5Q
         eXTQpLfaqo+CoakN6SFBN2YOqtcr9MSMluBXkFJI1GVY++1ff2IKm5fcSUxhUTM/Ag6i
         1psrMqwkE4cUM3oChkmoPFg+xAtg0LJBjJKblo3b0QSB5pYt6KjSFiU8SzntHy/T0U3n
         DnuJ+bB/FXfIwfbyyBqSjFL7Ga23Q6Y+3L6b/Ec7/AB2d8oZ2iURfA+YUdj9aKU/wNIl
         /h3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wY56gDc8OIUpS5XMKHyPBmpKIt1MVxFJU2VGVM97FlQ=;
        b=mqbgK76Xv5nFAbRqB7SDP8xgtv3qhLa8uUeBsET+ou7AXQvP/82i9/00/a9t4ckcDo
         7+4le6am3BDymKxU3ugwDwq8qgPbokU+mjlpRwbbtE1XBYctwe8x3TjWxCjThM6f8NyP
         mYe03SjYAFAowm1/sgjhsq4OEl9t5wrkuTleOnVh6A5TwXPLqSuzNnYJEJSc47Ev/g+W
         rcM93PQ5tC52EeyEI0IKK778fSDBTEo4Iyvpn2hK6RiMg/qB86qDVVKaloo7uG8LcfBu
         ngkWWfWyq3ApGyMtI2VOIm5uLdkB3lDgBLKx6hYnOLdpVTo3Bx7aJmFcMKcXjJanoRLL
         24EA==
X-Gm-Message-State: APjAAAWy32/hTE4xwZBaZgpKkW88LhrquEZEegokrJTcod1NLSPwCnxh
        +D5rG6ATLM+IbLCuKHPJ56owBdJ1BXo0B/dJHBhDjg==
X-Google-Smtp-Source: APXvYqyiao+eMBZfrh68YYjWcqPQZOfUp4Hfl+/y/Izw4/P7jzu2nzrjN/b/XPDf/ZvPVJFDD003WZ/LrClL6iRUdRQ=
X-Received: by 2002:a19:48c3:: with SMTP id v186mr27219187lfa.141.1568280624379;
 Thu, 12 Sep 2019 02:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190911075215.78047-1-dmitry.torokhov@gmail.com> <20190911075215.78047-2-dmitry.torokhov@gmail.com>
In-Reply-To: <20190911075215.78047-2-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Sep 2019 10:30:12 +0100
Message-ID: <CACRpkdbr=dBrr-m6uKhzKWbnz-OEB4uJE1nSsRd=ukztt-PFwQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] gpiolib: of: add a fallback for wlf,reset GPIO name
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 8:52 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> The old Arizona binding did not use -gpio or -gpios suffix, so
> devm_gpiod_get() does not work for it. As it is the one of a few users
> of devm_gpiod_get_from_of_node() API that I want to remove, I'd rather
> have a small quirk in the gpiolib OF handler, and switch Arizona
> driver to devm_gpiod_get().
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Patch applied, good to have this in and it is completely in line
with my idea to handle all these quirks inside the gpiolib-of.

Yours,
Linus Walleij
