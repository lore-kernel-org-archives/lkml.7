Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE0AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C562086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 20:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OI7KpgqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbfJCUqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 16:46:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40511 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfJCUqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 16:46:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id l3so4250862wru.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 13:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MLz52SXLm9tFNj7zfoyYuJlYYM4Yei855wkH/p9Zakw=;
        b=OI7KpgqTLJVOEWIraY+nfkO4ojeYBzUUEKSTH0kqkcpDLaXbhCsQsSoVcPVwkDtmpU
         nB2+/ZZmv9rvHsErgXDAlNcVkMb2ooESS+UmOT2X18o0r9PNmu5kvsDTBhmDOfQSIwol
         edy2cmcHt0XTNRUWcLCceoxqi+myrjQnnUN2SGogHFCUspjHFN0/lxD1Y+FjmMzh2gEJ
         UkY1C5gSxsqd7RzCIujmFF/eQhTif5fiFwq9YvpZczsEjBVsG+wRYp+yreQYR92ZkDNL
         bE0zfHiOFBsyS1chtZiRP4Hg79Bm01RfQs+kKZ7zgd5ia4ISeCnu/sQUR1tJOHp0F2xn
         gU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MLz52SXLm9tFNj7zfoyYuJlYYM4Yei855wkH/p9Zakw=;
        b=E+1zYpWXUAXOHO8pmho8UC1bBxr0fkE3dbqO3IFtoCz9V6aa3KTRjwY6RLoow7dLhF
         gh/WRLjMXAxlK2zFFye0MO+HoeB6RQHOo6ThAVwvct+WK1c3mTaWEyF/cjZE8l5T9MLX
         akdG1oVx5XkXVaghvdUBHMzc8U1K8NH7/9HJRjir2qOljLop+4p+dpMnBJ+eQfvWNEAz
         DGbUBCWBwpUxaAzlb5u6LjiB/O6UMavqlMbsH+P62fjlbH9gnsbaDtQNyy8GnLlwxIOc
         LNL0WgCgu26yj+iZTiESz/CXjMVtoyJyDVFd2nhiGkkeA+UFyUWAQZTY/cmmGCBkupEm
         yO8g==
X-Gm-Message-State: APjAAAUW0brQgR9QEX/FppEQ4VCqCfoKbNxeTv0Dvl3hZGRhvEtjfZih
        wze5lM5AWLs+zRqPIdHybjkPVQ916JMaBOrgP14xuw==
X-Google-Smtp-Source: APXvYqyxKVh9z28GFY7FV59xDlRJaJrO7fjRrA9KhCUrEN79DqqukGpApLp9fiWohyYRkWNA856Kq3W60N6EgVMi+d0=
X-Received: by 2002:a5d:638f:: with SMTP id p15mr8481403wru.169.1570135570974;
 Thu, 03 Oct 2019 13:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191002231617.3670-1-john.stultz@linaro.org> <20191002231617.3670-3-john.stultz@linaro.org>
 <20191003112618.GA2420393@kroah.com>
In-Reply-To: <20191003112618.GA2420393@kroah.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 3 Oct 2019 13:45:59 -0700
Message-ID: <CALAqxLWm_u3KsXHn4a6PdBCOKM1vs5k0xS3G5jY+M-=HBqUJag@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] usb: roles: Add usb role switch notifier.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 4:26 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Oct 02, 2019 at 11:16:16PM +0000, John Stultz wrote:
> > From: Yu Chen <chenyu56@huawei.com>
> >
> > This patch adds notifier for drivers want to be informed of the usb role
> > switch.
>
> Ick, I hate notifiers, they always come back to cause problems.
>
> What's just wrong with a "real" call to who ever needs to know this?
> And who does need to know this anyway?  Like Hans said, if we don't have
> a user for it, we should not add it.

So in this case, its used for interactions between the dwc3 driver and
the hikey960 integrated USB hub, which is controlled via gpio (which I
didn't submit here as I was trying to keep things short and
reviewable, but likely misjudged).

The HiKey960 has only one USB controller, but in order to support both
USB-C gadget/OTG and USB-A (host only) ports. When the USB-C
connection is attached, it powers down and disconnects the hub. When
the USB-C connection is detached, it powers the hub on and connects
the controller to the hub.

This is pretty HiKey960 specific, so I think the notifier is useful to
let the gpio hub logic tie into the role switching events.

Suggestions for alternative approaches?

thanks
-john
