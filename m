Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAF5C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 16:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBD520838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 16:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDvnEZ/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfCBQBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 11:01:42 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38278 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfCBQBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 11:01:41 -0500
Received: by mail-pf1-f193.google.com with SMTP id n125so402912pfn.5;
        Sat, 02 Mar 2019 08:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=77ub38fIFJxl8yJ37/6ZpJoqvOE12BvpT17sf62gLQs=;
        b=CDvnEZ/4KXs2MJg1Hdqwdc1X5tGNmVW0er6TiAOc01XR3NB0ro2EzjDNSkYmQNf8ec
         vRBux7Dr9dCzQqIMoTnWpIuNiIqm2hWx4L8TtP4qiRkDJUq1j/Gs3lt3nctnoUPCoikL
         r3VHs/QAErnmeLXbxAZaDbMZeywraAdyChrCkJW9xr8pGkN1zu3JNuqGVP3lXBWDwVQc
         LRd+wY173SAbN2a9mib1QVynNQqeM1OZPXfcYmGxAbEjXu8TZR9Mj5oWpFJ+7W4A3SCp
         waIBUb9hK/lS9DMSzmqfM4s3yV3NsSkyi8wZYMH18xT6RsFQAebKWLywfEt/CdV9OTf3
         o6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77ub38fIFJxl8yJ37/6ZpJoqvOE12BvpT17sf62gLQs=;
        b=AM3f9KdvjqOwi19Ox06jQyV+GoTB3XTJFhwFjMVPYQ94I55Y3LV+LopxYPHntUC2mv
         I0ky5xtppZbR1ajiJ0khFEckj0n0Hydz2SgCrCXX94jepCauKFB72H1Z8pX5wc+ugoZT
         Ck+9EI0UID0RsT9L35YTWjnUzNQMebsCZ2v+NjbDW0k5uqNaXaRIvXNWIgZxsf9A0uJs
         3qY863xBOgWyuLtNsdWtRM4tCnj84Wt6uCeoU48+AdNA/PhzothZ4ddDCMZlSsy1Dam/
         DWqVTsCaNvZD6hCJABd7NUJ9j+GcKA3EQu2zREKZqFLv/f8SSGIrX70DnWVWMsl1gQ6r
         v96w==
X-Gm-Message-State: APjAAAUTRBfWfrHpp3LqUoQEZdmrqOFmv8V4F8on0Q3+X6fi6nVkl3kY
        EX4mzbkKiEq0M4rSDvfpPR5QNA4ESIcyn+r4UHo=
X-Google-Smtp-Source: APXvYqwCkbZexjNphJRke3BUIaOuyLZbDEj8nb3U79YwK46GAcKvNbe0d5phH9sVIvh6RQE4O62y6BOa4xbFBpz3FSU=
X-Received: by 2002:a63:1a25:: with SMTP id a37mr10642979pga.428.1551542500735;
 Sat, 02 Mar 2019 08:01:40 -0800 (PST)
MIME-Version: 1.0
References: <20190302090505.65542-1-chenyu56@huawei.com> <20190302090505.65542-11-chenyu56@huawei.com>
In-Reply-To: <20190302090505.65542-11-chenyu56@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 2 Mar 2019 18:01:29 +0200
Message-ID: <CAHp75VdaNn4OQAQt1cU8CZ+Cton90kxmwQSG5Du7KUzPR3hSCg@mail.gmail.com>
Subject: Re: [PATCH v3 10/12] hikey960: Support usb functionality of Hikey960
To:     Yu Chen <chenyu56@huawei.com>
Cc:     USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, liuyu712@hisilicon.com,
        wanghu17@hisilicon.com, butao@hisilicon.com,
        Yao Chen <chenyao11@huawei.com>, fangshengzhou@hisilicon.com,
        lipengcheng8@huawei.com, songxiaowei <songxiaowei@hisilicon.com>,
        xu yiping <xuyiping@hisilicon.com>, xuyoujun4@huawei.com,
        yudongbin@hisilicon.com, zangleigang@hisilicon.com,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 2, 2019 at 11:05 AM Yu Chen <chenyu56@huawei.com> wrote:
>
> This driver handles usb hub power on and typeC port event of HiKey960 board:
> 1)DP&DM switching between usb hub and typeC port base on typeC port
> state
> 2)Control power of usb hub on Hikey960
> 3)Control vbus of typeC port

> +config HISI_HIKEY_USB
> +       tristate "USB functionality of HiSilicon Hikey Platform"
> +       depends on OF && GPIOLIB
> +       help
> +         If you say yes here you get support for usb functionality of HiSilicon Hikey Platform.

> +#include <linux/of.h>

It's hard to see why this have
depends on OF followed by above header inclusion.

> +       hisi_hikey_usb->typec_vbus = devm_gpiod_get(dev, "typec-vbus",
> +                       GPIOD_OUT_LOW);

> +       if (!hisi_hikey_usb->typec_vbus)
> +               return -ENOENT;

Hmm... Is it possible to get NULL pointer from gpiod_get() at all?

> +       if (!hisi_hikey_usb->otg_switch)
> +               return -ENOENT;

Ditto.

> +       /* hub-vdd33-en is optional */
> +       hisi_hikey_usb->hub_vbus = devm_gpiod_get(dev, "hub-vdd33-en",
> +                       GPIOD_OUT_HIGH);

devm_gpio_get_optional() if it's indeed optional.

> +       hisi_hikey_usb->role_sw = usb_role_switch_get(dev);
> +       if (!hisi_hikey_usb->role_sw)
> +               return -EPROBE_DEFER;

> +       else if (IS_ERR(hisi_hikey_usb->role_sw))

Redundant 'else'

> +               return PTR_ERR(hisi_hikey_usb->role_sw);

> +static const struct of_device_id id_table_hisi_hikey_usb[] = {
> +       {.compatible = "hisilicon,gpio_hubv1"},
> +       {.compatible = "hisilicon,hikey960_usb"},
> +       {}
> +};

MODULE_DEVICE_TABLE()?

-- 
With Best Regards,
Andy Shevchenko
