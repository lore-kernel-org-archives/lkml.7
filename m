Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD29C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09EE720866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjE/XPGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfFEIqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:46:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38871 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfFEIqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:46:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id v11so12016478pgl.5;
        Wed, 05 Jun 2019 01:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mk5FRq2HIkggKOYlb1t32JxfiDeZB3gniCUsPO6/xZI=;
        b=LjE/XPGqoSghQHXJWid6eAalCbvND2JpM7cZodepxdcu5sydDV4ALW4V1indIn2ve+
         ro/+9AV07szWsujI2k5OWOHpYoqn0Lko99MN4KhJfebhVda8dQB/jTSRvKY3rx/W7a7d
         jjJe+wLhb6zZNFg86ROAAr8Gb5Pr/pbUuEFY/nX+kkcB6gjGdRf15AQ56BiK0lOwD+mr
         96rMNUII2i3Vyhn5vvtspJXpfAR0wsn/a06F8E2irwekWWqqLjGSaI9HgCBVyESnIAZR
         xl5q0G6JW7XP8E5oeUqslpOF2xSz9hHeupjQK+x4VNpBkH0OfPyOzQG03MJ/B/1Ty3LP
         x0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mk5FRq2HIkggKOYlb1t32JxfiDeZB3gniCUsPO6/xZI=;
        b=ojuHtQHw4pNLcFV7joSo7rG16hfqBXaK0hVknpy6es4m5o0vHC0qcQLPPDcp9dyKCG
         AHChY/EnsgcRRI4aMGnUOajyCD1wjrxDiLgUOYfsxx88HY/kg8iofDZM7wqepm6e4GoJ
         fsxhbEiwo5Vl9TNGZdEP/ylzD8+tM60sEp373tDl6eiY9qcC4BxsEsTKQjdzJwVd9P0n
         WMBpcCyfOlVr3vYWctBZk/MloFXGxsZnjD93dDCICbbFllhpmJqBdWh+ylwq42xVa4VC
         0ql8Gt4vpZ1bk72gW5hkpY5Af8efi1BYvRNfxbUhbo2hJ6R9r455WwzNFXgbfmyaQMfi
         sP3Q==
X-Gm-Message-State: APjAAAXCyKAOV8bfyleAn/mowiX8AyNTuQXn+813vxvgmytC2/817RT6
        LwCVvY/uReyCaZ7z7e84Cjr296/SCorQvD5l0sQ=
X-Google-Smtp-Source: APXvYqz9Lj0yCfy+J+2j77hhw6XN27rcOlilHibyQ96byM7FluGi0by+4HbGwYHmbgTq02AfDgdKEa0nzroKSuiuPcs=
X-Received: by 2002:a17:90b:d8b:: with SMTP id bg11mr10737373pjb.30.1559724367061;
 Wed, 05 Jun 2019 01:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <1559115828-19146-1-git-send-email-chunfeng.yun@mediatek.com> <1559115828-19146-10-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1559115828-19146-10-git-send-email-chunfeng.yun@mediatek.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Jun 2019 11:45:55 +0300
Message-ID: <CAHp75VcbZwd0e6r38C2x7HLEHLr4oR7TjwdDXnDxRPRs3anwgA@mail.gmail.com>
Subject: Re: [PATCH v6 09/10] usb: roles: add USB Type-B GPIO connector driver
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Min Guo <min.guo@mediatek.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yu Chen <chenyu56@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 10:44 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> Due to the requirement of usb-connector.txt binding, the old way
> using extcon to support USB Dual-Role switch is now deprecated
> when use Type-B connector.
> This patch introduces a driver of Type-B connector which typically
> uses an input GPIO to detect USB ID pin, and try to replace the
> function provided by extcon-usb-gpio driver

> +static SIMPLE_DEV_PM_OPS(usb_conn_pm_ops,
> +                        usb_conn_suspend, usb_conn_resume);
> +
> +#define DEV_PMS_OPS (IS_ENABLED(CONFIG_PM_SLEEP) ? &usb_conn_pm_ops : NULL)

Why this macro is needed?

-- 
With Best Regards,
Andy Shevchenko
