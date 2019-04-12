Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D692DC10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985E3218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TsjlWIJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfDLAzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 20:55:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45981 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfDLAzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 20:55:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so9637616wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 17:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fx65PGs+hcTLW3v5Oxc17IQCXrFa7XQEHDSKo+zIjg=;
        b=TsjlWIJv+DW3+CPH6/AwmnLDzKKYSz2qaedQ4z4004P48t2r8voIdztozBT9E386a/
         5rc3Vr9fAhascrbg5ePHArL72NqgpsSWIBir2VCUou4q1kWw708b0EFVvXVgCbNFc1/9
         DmvaU/A42NIyQW2VCV9GCWxI9OQUM5SfS/OH+OfEr9XH+eLbj8T7VriJ9yCdv7leTUe8
         8uJTdVstjDmG7dXzwAVuzmdUpd9qFapAszN+dEMcWPEoodwUKvqAJPU/CJPpSns+1waA
         GfM6RDT5ZVa5VktjBTBjgHx9dpzo/J4ddOW5N3pGHU0LKriUrmFlTfZe1I7eUxtYe6SC
         Ve0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fx65PGs+hcTLW3v5Oxc17IQCXrFa7XQEHDSKo+zIjg=;
        b=oVeasZZdYUzHxECaVGF9DdzJeWO/y+Up823R5xXuXUDfkn3deqUvBin6gvXbGwjG3V
         2jMQhX/4fFpit4rzaK6dBzHJzbATav+dsahqJQ3zW+k2wxYRMQaD32Fg6U3OpI10wRnw
         sELT4rZCb8Qh84YPxQyfXm6LRtg68nKkv3DgAzSI6dBGtwdYD59wsB9bisSwOn8Iw/MA
         7LgfG1BqsctyinSW5R7sfOZRtqBqEtM9sCi60+bHi+oI9Vv59lMh9VRh48BojuAtBiF8
         Q1mm9dMJJXLIyEajF1Ukh8HkJRAfV/i9su4S1TvbYsR5Xyu6vcqwQdBxNk6cueKHdHsI
         KDiw==
X-Gm-Message-State: APjAAAVhMptsmjviZOXHt56P8F9WuR2DyDc7xD22Ksb6uHe0vodMTyWO
        WfFYIHr0p4rZ7/2kIZ1IloC9eD9JWZepGj60DnfNSg==
X-Google-Smtp-Source: APXvYqyTVKbY+rzszRq9p2dM0geGu5ZteEkp4ydnwlItURigbQOQ7cDwZKcWU7KZtCtyaCbRXo2CYivy92hIHs6jiJY=
X-Received: by 2002:adf:b612:: with SMTP id f18mr22392914wre.236.1555030544590;
 Thu, 11 Apr 2019 17:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190329041409.70138-1-chenyu56@huawei.com> <20190329041409.70138-12-chenyu56@huawei.com>
In-Reply-To: <20190329041409.70138-12-chenyu56@huawei.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 11 Apr 2019 17:55:32 -0700
Message-ID: <CALAqxLVjKNYbzqaYZ=L0NGgpDUzs+xU53Z4-3OFnJuHGCAZ2GA@mail.gmail.com>
Subject: Re: [PATCH v5 11/13] hikey960: Support usb functionality of Hikey960
To:     Yu Chen <chenyu56@huawei.com>
Cc:     Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>,
        "Liuyu (R)" <liuyu712@hisilicon.com>, wanghu17@hisilicon.com,
        butao <butao@hisilicon.com>, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com,
        Li Pengcheng <lipengcheng8@huawei.com>,
        songxiaowei@hisilicon.com, YiPing Xu <xuyiping@hisilicon.com>,
        xuyoujun4@huawei.com, Yudongbin <yudongbin@hisilicon.com>,
        Zang Leigang <zangleigang@hisilicon.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 9:14 PM Yu Chen <chenyu56@huawei.com> wrote:
>
> This driver handles usb hub power on and typeC port event of HiKey960 board:
> 1)DP&DM switching between usb hub and typeC port base on typeC port
> state
> 2)Control power of usb hub on Hikey960
> 3)Control vbus of typeC port

Hey Yu Chen!
  Wanted to say thanks again for sending these patches out so
persistently. I did catch an issue with this driver that I wanted to
let you know about.

> +static int hisi_hikey_role_switch(struct notifier_block *nb,
> +                       unsigned long state, void *data)
> +{
> +       struct hisi_hikey_usb *hisi_hikey_usb;
> +
> +       hisi_hikey_usb = container_of(nb, struct hisi_hikey_usb, nb);
> +
> +       switch (state) {
> +       case USB_ROLE_NONE:
> +               usb_typec_power_ctrl(hisi_hikey_usb, TYPEC_VBUS_POWER_OFF);
> +               usb_switch_ctrl(hisi_hikey_usb, USB_SWITCH_TO_HUB);
> +               hub_power_ctrl(hisi_hikey_usb, HUB_VBUS_POWER_ON);
> +               break;
> +       case USB_ROLE_HOST:
> +               usb_switch_ctrl(hisi_hikey_usb, USB_SWITCH_TO_TYPEC);
> +               usb_typec_power_ctrl(hisi_hikey_usb, TYPEC_VBUS_POWER_ON);
> +               break;
> +       case USB_ROLE_DEVICE:
> +               hub_power_ctrl(hisi_hikey_usb, HUB_VBUS_POWER_OFF);
> +               usb_typec_power_ctrl(hisi_hikey_usb, TYPEC_VBUS_POWER_OFF);
> +               usb_switch_ctrl(hisi_hikey_usb, USB_SWITCH_TO_TYPEC);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       return 0;
> +}
> +
> +static int hisi_hikey_usb_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct hisi_hikey_usb *hisi_hikey_usb;
> +       int ret;
> +
> +       hisi_hikey_usb = devm_kzalloc(dev, sizeof(*hisi_hikey_usb), GFP_KERNEL);
> +       if (!hisi_hikey_usb)
> +               return -ENOMEM;
> +
> +       hisi_hikey_usb->nb.notifier_call = hisi_hikey_role_switch;
> +
> +       hisi_hikey_usb->typec_vbus = devm_gpiod_get(dev, "typec-vbus",
> +                       GPIOD_OUT_LOW);
> +       if (IS_ERR(hisi_hikey_usb->typec_vbus))
> +               return PTR_ERR(hisi_hikey_usb->typec_vbus);
> +
> +       hisi_hikey_usb->otg_switch = devm_gpiod_get(dev, "otg-switch",
> +                       GPIOD_OUT_HIGH);
> +       if (IS_ERR(hisi_hikey_usb->otg_switch))
> +               return PTR_ERR(hisi_hikey_usb->otg_switch);
> +
> +       /* hub-vdd33-en is optional */
> +       hisi_hikey_usb->hub_vbus = devm_gpiod_get_optional(dev, "hub-vdd33-en",
> +                       GPIOD_OUT_HIGH);
> +       if (IS_ERR(hisi_hikey_usb->hub_vbus))
> +               return PTR_ERR(hisi_hikey_usb->hub_vbus);
> +
> +       hisi_hikey_usb->role_sw = usb_role_switch_get(dev);
> +       if (!hisi_hikey_usb->role_sw)
> +               return -EPROBE_DEFER;
> +       if (IS_ERR(hisi_hikey_usb->role_sw))
> +               return PTR_ERR(hisi_hikey_usb->role_sw);
> +
> +       ret = usb_role_switch_register_notifier(hisi_hikey_usb->role_sw,
> +                       &hisi_hikey_usb->nb);
> +       if (ret) {
> +               usb_role_switch_put(hisi_hikey_usb->role_sw);
> +               return ret;
> +       }
> +
> +       platform_set_drvdata(pdev, hisi_hikey_usb);
> +
> +       return 0;
> +}

The issue I found is that if due to module load order or other
randomization in bootup timing, this driver loads much later then the
other USB infrastructure, the usb_role_switch notifier that is
registered may be registered after any state initialization or change
has occurred that would trigger the notifier callbacks.

This means initially this driver could be out of sync with the core
usb_role_switch state.

I've tried doing something like the following on probe to force the
initialization:
   cur_role = usb_role_switch_get_role(hisi_hikey_usb->role_sw);
   usb_role_switch_set_role(hisi_hikey_usb->role_sw, cur_role);

But this is racy, as a state change can happen in between the call to
get_role and set_role, which would end up overwriting the proper
state.

I suspect a proper fix needs to happen in the
usb_role_switch_register_notifier(), where the callback gets called
with the initial state while holding the lock to avoid races.

I'll comment more in that patch.

thanks
-john
