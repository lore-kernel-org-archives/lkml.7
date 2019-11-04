Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9EACA9EBB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 00:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5333421D71
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 00:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oAlES9Ui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfKDASo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 19:18:44 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43456 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbfKDASn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 19:18:43 -0500
Received: by mail-ua1-f66.google.com with SMTP id k11so1778255ual.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 16:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5L2eq9DWTqYID3ithkG+AoL6nhEs7tI6RGB4Dd8Zf4=;
        b=oAlES9Uid7iSYZ2y6NPfHWjyad0j5hCqs5prmtdgJ2mK997WAVlxzJG3ynZVmC7nVi
         mB54L2mfLf/Ymo2mr37VdY7P/VmPPDIkSj6dVPXoVoUbv4/bi0abmhjwnmb/FELUCiFe
         WUmE0cxKBRBV/GLK0T6OlpT++peIpQTvzfheDW+VYHwnVh2WMPfAGGv0Jll4lQ9KmdAX
         KUTaR0YLzT9+mGViBviY1QVrl63MXjbWJ1L7dXjYhxykfLjDCnezbRw37cjm6t8NlKrx
         vUEPiPlqJXQVEvz5N1BTYEZa2S6mllw04JXsrNQAwnirXTN3hH91Hd5eJcmUXVJGR71Z
         pSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5L2eq9DWTqYID3ithkG+AoL6nhEs7tI6RGB4Dd8Zf4=;
        b=NGr9iTQ4ofmLOc/ZI5Jj2EWb5wP5dPybT4AcHTvsU9mq1BaD/Xdlu7ZQco3NKt9hTo
         gsVfMt+d6Scl7OFhbc8/lICHOW07s+aHk6JBWx/xvXHtZISCWvXO0WkpUy/F54pSmeqN
         iiT1aYsgef7zKDyryBGGIBxjlf5dmoePRi9GeqL1yFKkmCuB6fAv31gX3eY62JV43KpR
         QOKJFOWCd2Cnk0tj3MhgEs1kAI/yPkssvq99IW1z8Z+IXcD8dz231dO75iJr7gwomG25
         7uyHdmb0ind410TROAXD9whG+rK2PFGaMb6T5tgwWane+VUMcqVdO/wwwnNdJZ8A7lE6
         hOmg==
X-Gm-Message-State: APjAAAWwm92CDE72wCZSSc6U56/NUZ5iQv+D6+Qjfh7qxde27bx/012P
        MNCi2pnLpmy67ac0hdUAVrzhfsrXnZg+NGNCH99Xyw==
X-Google-Smtp-Source: APXvYqxaDMOhPupmDshbsu4K1ddLDJNFp+Loev7XOmTsYtFTpgq7W/3FH8VrI3bEONc6DjxIfdtklet+o4Mib1wkwhc=
X-Received: by 2002:ab0:70a9:: with SMTP id q9mr4518172ual.84.1572826722501;
 Sun, 03 Nov 2019 16:18:42 -0800 (PST)
MIME-Version: 1.0
References: <20191017122640.22976-1-yuehaibing@huawei.com> <20191017122640.22976-2-yuehaibing@huawei.com>
In-Reply-To: <20191017122640.22976-2-yuehaibing@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Nov 2019 01:18:31 +0100
Message-ID: <CACRpkdb8D_zxHfzY=+ramnNjXVsN9MMO8Q-3=iZFLS2A_ZDQuw@mail.gmail.com>
Subject: Re: [PATCH -next 01/30] pinctrl: pxa25x: use devm_platform_ioremap_resource()
 to simplify code
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Lars Persson <lars.persson@axis.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@axis.com, linux-oxnas@groups.io,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>, linux-tegra@vger.kernel.org,
        Vladimir Zapolskiy <vz@mleia.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 2:48 PM YueHaibing <yuehaibing@huawei.com> wrote:

> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

These are too many patches changing too little.
One patch should be one technical step.

I'd say squash them all into one big patch and resend.

You can collect the ACKs you received, but don't put
too many people on CC, they will be annoyed.

Yours,
Linus Walleij
