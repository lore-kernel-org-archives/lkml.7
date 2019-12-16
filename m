Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BA8C2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB98206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JsX0EOCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfLPImu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 03:42:50 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:33112 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfLPImu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:42:50 -0500
Received: by mail-vk1-f196.google.com with SMTP id i78so1401918vke.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 00:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQNp7WdEHGDcdwZTBmF8OW1IvH+A0vnK1qvS4gy4RD8=;
        b=JsX0EOCFQpEiBIgwEhl/g4zVsVoSKPn8iLymWZehHBj7Uh/VTJ/d9CbE4uZaVzuYTB
         w5IiJHE7A7gYMo/g4KF7Pdd0ps1VbhopQDceyQtlWz658JV3DoUwazIGmaalqKBeClks
         9eKbYBBWTK8ErCl1JUdJj0lXntSt0KYr6uM/E1GQEmBdOrZyB8OLDsSZwSaMk6jZUA7T
         Qq6LGIoXPlVOucLZRwpQbssKV9UwV6WlIVCsBIo4qxsR//2Yb0pICA8AcZ+5hzO1Dl5p
         m9d/UZs6y2o4WkL1RbA+eC+xLVvCJm1l0Sij8v+CmIBUf9C0wbpKckaU6IK2A3Bl221L
         m5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQNp7WdEHGDcdwZTBmF8OW1IvH+A0vnK1qvS4gy4RD8=;
        b=cQhufn9G979nIiELvGZSTTbPoMuVpMt0OisEDSVj1EZPlPuSIF/XCLyG6fdUaPCpE8
         3E5r8jhZLSSnTPOhAh+Y/Qs1Nued0wn4x3A3+o2ndJiCEmGfY2jM7szwSYgIjcfAECak
         G2HzEQuqEVMd6XPWQP8CI8i9mjFJ3DcZIOEOUkwN0ffkQOCRA3hKPBpeGzrTTB2uR5Jc
         3o2p6qVRx0OO4kpvusWc/GfzxIZVra1faw7ah7MGrGbyj3Y5MTO3M1G9B5ylgdBjIbfU
         Vi37rrmes1U7jQJSVizYGWzyMvzoaawNTnm/76coWoC1l1f84OsYaGRKt+2smtoy+sV9
         whJg==
X-Gm-Message-State: APjAAAUUd4aBXlIoSnBS1+omaoB/7AY8c6ypFwbSf3PP/PLW9Y17AovY
        er4fDhi1TFO3HztWFWSnD29PMlnSpdZknT7692tXPg==
X-Google-Smtp-Source: APXvYqxSMRUWCpLigSnJ2HhQ+kJiuwNEHl9riiOJPkbXcQ7uYPMpwtCI2iqMkQSBGgcfiIQqPNPOPnCHfjFza9NDkFk=
X-Received: by 2002:a1f:fe4e:: with SMTP id l75mr23648218vki.18.1576485768974;
 Mon, 16 Dec 2019 00:42:48 -0800 (PST)
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com> <20191211192742.95699-2-brendanhiggins@google.com>
In-Reply-To: <20191211192742.95699-2-brendanhiggins@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Dec 2019 09:42:37 +0100
Message-ID: <CACRpkdarwQT=6iSvjaTufSF9O7KcSkFxBwcvmchQ67xRddLs2g@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] pinctrl: equilibrium: add unspecified HAS_IOMEM dependency
To:     Brendan Higgins <brendanhiggins@google.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     jdike@addtoit.com, Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        davidgow@google.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 8:28 PM Brendan Higgins
<brendanhiggins@google.com> wrote:

> Currently CONFIG_PINCTRL_EQUILIBRIUM=y implicitly depends on
> CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> the following build error:
>
> ld: drivers/pinctrl/pinctrl-equilibrium.o: in function `eqbr_pinctrl_probe':
> drivers/pinctrl/pinctrl-equilibrium.c:908: undefined reference to `devm_platform_ioremap_resource'
> ld: drivers/pinctrl/pinctrl-equilibrium.c:223: undefined reference to `devm_ioremap_resource'
>
> Fix the build error by adding the CONFIG_HAS_IOMEM=y dependency.
>
> Reported-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

We recently fixed a compile error by adding
depends on OF
and I think OF implies HAS_IOMEM so this should be fixed
now.

Can you confirm?

Yours,
Linus Walleij
