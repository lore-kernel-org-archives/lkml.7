Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E602BC10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B504F21850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PtKcslHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfDLAsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 20:48:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38858 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfDLAsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 20:48:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so9673670wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 17:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EGa6ziXLYfRRM+NmivaW3Md44smSFk48FqpDI63b5lo=;
        b=PtKcslHDn2R6z6QcnKMR4NphY8jE54zbep/3cKh9aE+bR36cTRa2WXKbOLhqEHTm59
         h+8SpKz+XawyoWvTdrjazPnlxJ+5rPJ+5VEQZmk7J7kAVvAXWMyDXty1FrLfOvsuHoA7
         xbECveEa7lWMG5m19QG5fzhZEK7OTI5mkG7noKywPaR8zMkjhZEZzk3FUhtVeFYlCaZA
         GAICt8oQZvXimP0kemSmMkmDq3+bfz+Qk58ZQ8G6EzBAqfeDYSWJRQ0pL78MYI19u/wb
         gAibFC1M9hwK4YwwBVDBAdETKieknZqqlBTvt/w1Uc51nS+XEazejJFtbpZ9YNAy+edH
         w21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EGa6ziXLYfRRM+NmivaW3Md44smSFk48FqpDI63b5lo=;
        b=cSwjo4FoEANiSaPVtPUl0kvdTJ7w1yC4rGlSdjxv2DT7u8mx5u3fikww1ZTBtOoco+
         EeHFycQzFBXAV8SilUSsOxOyOBVr/zeerr+/kEWw40MC2F83BHOmybBfS7XOIXZYsrRY
         UG4311mw1pHncuBK73GvXF1e50hs5LX60/bWEk1mHA7A9MygA5GVEKTgvsd+pWPoBeV4
         M1oRJ5dkGb74zhdoa95PMmfQRDbO8P5G1T13HbsB/Nj3fd6Z96Z5gzA2zJzAEwJ2ximN
         OizGFkuKNP9eQZH5G7gyu2s4+ZlHQ/QDDotMIqefIoGzyKj4sXKgrcJyesCp8slw18NX
         r4Mw==
X-Gm-Message-State: APjAAAUuTdxzU4/Rn5X6wZqgX8lWDkgvuMA/ExrXJ/NbZw4BlSPJbEU5
        ohWmfmbYIngtpfgsACRxpDZtn1KOV6jZlIUWcTgktw==
X-Google-Smtp-Source: APXvYqzRFUlCHznqhQBumuCsyfdx/ROFSBWLjFLoML0kLKMa7ajlzmY0FuthJauK33a1w5Rq9vJ0A1gBGYQJfZmQEvE=
X-Received: by 2002:adf:ec87:: with SMTP id z7mr32359209wrn.44.1555030096320;
 Thu, 11 Apr 2019 17:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190329041409.70138-1-chenyu56@huawei.com> <20190329041409.70138-11-chenyu56@huawei.com>
In-Reply-To: <20190329041409.70138-11-chenyu56@huawei.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 11 Apr 2019 17:48:04 -0700
Message-ID: <CALAqxLVdrzNS2t1OYT=Pziu81VO+zWq5LYghHhMJO53cSvNNtQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/13] usb: dwc3: Registering a role switch in the DRD code.
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
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 9:14 PM Yu Chen <chenyu56@huawei.com> wrote:
>
> The Type-C drivers use USB role switch API to inform the
> system about the negotiated data role, so registering a role
> switch in the DRD code in order to support platforms with
> USB Type-C connectors.
>

Hey Yu Chen!
  Thanks so much for sending these patches out!  I have run into some
troubles on bootup where things aren't working properly at first, that
seem to be due to state initialization races.  In chasing those down,
I've found some other quirks I wanted to bring up.

> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -479,6 +479,43 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
>         return edev;
>  }
>
> +static int dwc3_usb_role_switch_set(struct device *dev, enum usb_role role)
> +{
> +       struct dwc3 *dwc = dev_get_drvdata(dev);
> +       u32 mode;
> +
> +       switch (role) {
> +       case USB_ROLE_HOST:
> +               mode = DWC3_GCTL_PRTCAP_HOST;
> +               break;
> +       case USB_ROLE_DEVICE:
> +               mode = DWC3_GCTL_PRTCAP_DEVICE;
> +               break;
> +       default:
> +               if (dwc->role_switch_default_mode == USB_DR_MODE_HOST)
> +                       mode = DWC3_GCTL_PRTCAP_HOST;
> +               else
> +                       mode = DWC3_GCTL_PRTCAP_DEVICE;
> +               break;
> +       }
> +
> +       dwc3_set_mode(dwc, mode);
> +       return 0;
> +}
> +
> +static enum usb_role dwc3_usb_role_switch_get(struct device *dev)
> +{
> +       struct dwc3 *dwc = dev_get_drvdata(dev);
> +       unsigned long flags;
> +       enum usb_role role;
> +
> +       spin_lock_irqsave(&dwc->lock, flags);
> +       role = dwc->current_otg_role;
> +       spin_unlock_irqrestore(&dwc->lock, flags);
> +
> +       return role;
> +}
> +

So the two functions above are a bit asymmetric.  The
dwc3_usb_role_switch_set() can put the device into host or device
mode, which eventually sets the current_dr_role value.  However on the
dwc3_usb_role_switch_get() we return the current_otg_role value.
current_otg_role isn't set unless current_dr_role is
DWC3_GCTL_PRTCAP_OTG, which doesn't seem to happen here.

I suspect in dwc3_usb_role_switch_get() we should return
current_dr_role, unless current_dr_role==DWC3_GCTL_PRTCAP_OTG, in
which case we'd want to return current_otg_role.

Does that make sense?

Nothing really actually use this dwc3_usb_role_switch_get() yet, so
this was easy to overlook, and I only caught it as I was trying to
debug some of the initialization races.

thanks
-john
