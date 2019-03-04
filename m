Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A873C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4EA2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJcdJQWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfCDGux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 01:50:53 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38075 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCDGuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 01:50:52 -0500
Received: by mail-pg1-f195.google.com with SMTP id m2so2363506pgl.5;
        Sun, 03 Mar 2019 22:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=utd9FipREVw8GzeDY94dAXqZI7jNESLDQpsdA3+E4UM=;
        b=hJcdJQWuszHaZGu5m70osy8T0thtRfp3RvMgMqKqjliE5wkNrkyApy8BZMX1/K8OB5
         hVisv+HXbkpWWvAPC7nuk6olsPezSdOTqrrHnM5FVuc6O6pnNSHf9J5CAO5xDpMTZv1z
         y4efP602usZE3+qsXDLwMdIUPLIzkQ/y8FjZu/cXuhzOfXelGUZTxnBC82LdqGOshczf
         F33M76Q2achduRwyJnXNe7T7/byeBY5nNzTQqN0T9ok1+UQQUkAH3G5dJCxMZ1+jbwu/
         54ric/fONZsLbGbUyVkyd2/Z4/WilBJcHNYvTnJuV/09q7mpW6BvGMjB5EHN+Im8NISS
         R9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utd9FipREVw8GzeDY94dAXqZI7jNESLDQpsdA3+E4UM=;
        b=FlCVvUXFmo5l5DXssJE0Sm6tGBc4kayepRxWCYeAEetO51pEhOhaP7vu7MBAWJNKtt
         86MqVzQhjBxk7hUQUfU1GIKf8EvhsNsPNQ2ldcnHGbL6MXrC+YS7ygqz0CIsAqlUboOC
         FwFGdY8qyjkBdj6sbs3L7zlbBeITbBaLSFs6byHVJYJdNQ/ZCF2hsLUm2ErYfn2vyVAb
         yaReADM9nQZ0Rb8IKIkAKzIoxf3+p1oW0qBCJsIDCZZUWj2V1lql+37NmIEUhu+bvO0u
         zLglBQg4puZ3hQFIyVXmuD0IoFdO4WmONYrvHN5ziNVxPR9DwuMGkdWSpqWDn56HcxQq
         1ILQ==
X-Gm-Message-State: APjAAAVwOaqK6GZLTrx3EotCwbHzAR4G7xPUJT51QtQEvx31PvnzDUIK
        hrax96ekHf702CXR0gD0FHnDI7ZM9W7JGdPFoWg=
X-Google-Smtp-Source: APXvYqxr7TQKjPsmi5d29EUl+vQlUTDMZfkXHdUCKElqAcnxAGcPsYbvqnHSOwq8By9rVE4RyhVivJqDrr2iJCFs+jM=
X-Received: by 2002:a63:1a25:: with SMTP id a37mr17688632pga.428.1551682251687;
 Sun, 03 Mar 2019 22:50:51 -0800 (PST)
MIME-Version: 1.0
References: <20190302090505.65542-1-chenyu56@huawei.com> <20190302090505.65542-11-chenyu56@huawei.com>
 <1551664069.2210.64.camel@mhfsdcap03>
In-Reply-To: <1551664069.2210.64.camel@mhfsdcap03>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Mar 2019 08:50:39 +0200
Message-ID: <CAHp75Vdkp40e5-Bv+LnLBxgPkTDJ0FA1ooq+C4-do=4k5prTiQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/12] hikey960: Support usb functionality of Hikey960
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Yu Chen <chenyu56@huawei.com>, USB <linux-usb@vger.kernel.org>,
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
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 3:47 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> On Sat, 2019-03-02 at 17:05 +0800, Yu Chen wrote:

> > +     hisi_hikey_usb->role_sw = usb_role_switch_get(dev);
> > +     if (!hisi_hikey_usb->role_sw)
> > +             return -EPROBE_DEFER;
> Here return EPROBE_DEFFER means the related device_connection is
> registered after this probe is called, right?
> if not, use IS_ERR_OR_NULL then return PTR_ERR is enough

How enough? If return value is NULL it would be transformered to 0,
which is success return code from the ->probe() which means we will
have ->probed() and not functional device.

Am I missing something?

-- 
With Best Regards,
Andy Shevchenko
