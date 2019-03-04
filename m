Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB30C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99402082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 06:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBjHGwYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfCDGzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 01:55:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45205 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCDGzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 01:55:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id 125so2131432pgc.12;
        Sun, 03 Mar 2019 22:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tZuf1lbW+kz5R8vQNe0TkXMBPcnYDG0ACfOAuClsJXQ=;
        b=YBjHGwYX2L6hZiDUkDeknZFg2I9QnOtHcfIb6ubZZ7F4kTtsTvsdr/Dz1TUo1fbEVX
         Ag3tSnYfIRDRqHaPEHhq2Plz2mQ80M7XIqX1YcUm5r2T8o0M499XazWbaykhDvXdFonw
         D2g+JDyFFF8wC8wJEhyawxqEVzd7YguSfUBloxwYJrd5HjFJgz6A26NNOMMlfj3+DHpY
         /XvoxIg1a/vP8MzoLoyOo9T/vEFBw+uQd9889Npt+viZwn3z1mfNQ/myHJyjnX6ybYG7
         4A/HJWCUdJVlW5qeIrKB65Z9YDdiMLoeTDyeVwP/BVDGqtdbBB3uU7uvxHTwi1dVlBml
         1Xgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZuf1lbW+kz5R8vQNe0TkXMBPcnYDG0ACfOAuClsJXQ=;
        b=gWiM4zV1tlBI2wxieh0PTDI82RXN9nGi4Fmsnn5XWIvrSavo5yjToP6xrZn07LJgn3
         9FuBqvmiFhGtanFxgPoWhKMpS8oV2Adcw7yuT+IUphGgEIGJv1wjH5jTNOKMsD7U3Mri
         2Tvt4utRwjFs0NsWFGAV5yKn3sg9PoTfXWJPcVKbxZcc6ETh86hHx8mq8wPi1X0iNilM
         E6fsw9DqIMMbPhUw2J0DYBM9IH/jIoWuFNYzY50VNdPbpmnkMnxSnttmGfOxGpJu6kiB
         j+zoeaaVkb6SgkBiziWPArwfypmWoCdoaUdILKsBtIlNeCjoGfk248iF272MOfio0iMy
         mRIA==
X-Gm-Message-State: AHQUAuYRUBcnEgl4hlNJAVKIsGwfyWxRFj1r7AdMl8kusEg9g5FcNNhR
        xhGQSKxyCKoURS+mcmHU0U95VpF0dRQk8ciSSK8=
X-Google-Smtp-Source: AHgI3IZEpLVXqm90vzNoemcKu5e32s5wFSFcc/9x3RxbdljacNqZOmgviOksul+XTYFh2zqMftbqIZS9fnt2/VdwkAI=
X-Received: by 2002:aa7:83ca:: with SMTP id j10mr18618449pfn.50.1551682541181;
 Sun, 03 Mar 2019 22:55:41 -0800 (PST)
MIME-Version: 1.0
References: <20190302090505.65542-1-chenyu56@huawei.com> <20190302090505.65542-11-chenyu56@huawei.com>
 <CAHp75VdaNn4OQAQt1cU8CZ+Cton90kxmwQSG5Du7KUzPR3hSCg@mail.gmail.com> <386ac0cf-cee7-bc1b-d22c-80dedff391cf@huawei.com>
In-Reply-To: <386ac0cf-cee7-bc1b-d22c-80dedff391cf@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Mar 2019 08:55:30 +0200
Message-ID: <CAHp75VcjQjBV8xsuJyZ1RBnNQAV_k8z9Hp-3S_JnYDRpJZ2UXw@mail.gmail.com>
Subject: Re: [PATCH v3 10/12] hikey960: Support usb functionality of Hikey960
To:     Chen Yu <chenyu56@huawei.com>
Cc:     liuyu712@hisilicon.com, USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, wanghu17@hisilicon.com,
        butao@hisilicon.com, Yao Chen <chenyao11@huawei.com>,
        fangshengzhou@hisilicon.com, lipengcheng8@huawei.com,
        songxiaowei <songxiaowei@hisilicon.com>,
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

On Mon, Mar 4, 2019 at 4:35 AM Chen Yu <chenyu56@huawei.com> wrote:
> On 2019/3/3 0:01, Andy Shevchenko wrote:
> > On Sat, Mar 2, 2019 at 11:05 AM Yu Chen <chenyu56@huawei.com> wrote:

> >> +config HISI_HIKEY_USB
> >> +       tristate "USB functionality of HiSilicon Hikey Platform"
> >> +       depends on OF && GPIOLIB
> >> +       help
> >> +         If you say yes here you get support for usb functionality of HiSilicon Hikey Platform.
> >
> >> +#include <linux/of.h>
> >
> > It's hard to see why this have
> > depends on OF followed by above header inclusion.
> >
> This driver depends on devicetree, so I add "depends on OF".
> But is seems that "#include <linux/of.h>" can be removed after "of_" API
> have been removed. Thanks for your reminder!

So, it means that technically there is no such dependency, rather
administratively.

> >> +       hisi_hikey_usb->typec_vbus = devm_gpiod_get(dev, "typec-vbus",
> >> +                       GPIOD_OUT_LOW);
> >
> >> +       if (!hisi_hikey_usb->typec_vbus)
> >> +               return -ENOENT;
> >
> > Hmm... Is it possible to get NULL pointer from gpiod_get() at all?
> >
> >> +       if (!hisi_hikey_usb->otg_switch)
> >> +               return -ENOENT;
> >
> > Ditto.
> >
> I check the comments of devm_gpio_get API, it will not return NULL pointer.
> But is it more safe to keep the NULL checking? What is your advice?

Why do we need dead code?

-- 
With Best Regards,
Andy Shevchenko
