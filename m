Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABB2C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB512086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 21:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SU3vbsQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733161AbfJCVdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 17:33:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39727 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731694AbfJCVdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 17:33:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id v17so3598270wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 14:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WqLu0wakUs3wLW/I7o/nZ1HroZMOcAjOwf4CjhO+KeY=;
        b=SU3vbsQ6OHP3PG8vkkVhBcWke1RWVX76BBLoh371ZnNseL8IPXWuUGs8Aawlr7RpB1
         OhrN3ieOxkzztglV/yzpowrX4psibNxJXJlYePix7tD7J1IqNmVEkFQHpaImI+SJw+fL
         Qi+eFZDQbJZsRWvepgaLrxHz5iKcyph7k+468NLpj1+Xkc2829Qd76LtjKfibN9nNXLq
         SNFXX3G5dtcqpf/41ELgEut0HkWdZfSqF65GOSbmfjS+BlIId4xiH8HRfQclYS1FE5ay
         F0Vu/yPgPWokiZrw2+UdoNnU6d8v867EKDBCXwHsRUn0yTCFaPoNK5g1zBK6A1siE2rm
         3y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WqLu0wakUs3wLW/I7o/nZ1HroZMOcAjOwf4CjhO+KeY=;
        b=uRkL+FfD/EwyTsfy/mnD6lpF4P7yYxwLL+ONWPs12+gYwOR/hi+XevnWtle8r5T99b
         CCiTLegZEojombC33IDBiz7+NEuymLxKDyz+DIWMiJjGOQaBziUjQq4mo9EBmXXHihIx
         3Y6tVCg1bA8oUJKe7Cbd5hKiZVgAi4lOQww5XJqzvrVY4iQy4o7LRz+BTQBf6uMP2kvl
         MsvvbCrpewoNYPlldrguCeetYv0o/08QLnDfdeQISiomvagJKRHiDSo2gwLwMkPRx3LO
         6G4mJFb0kK54StC4eKTag5R7k39ieuqZz3UZV1WUH+gVIFI5A8Tl4bL2OYFPk06MEzjI
         DPKQ==
X-Gm-Message-State: APjAAAUYqwzdy1b3dFSAJ9TdJCY6AHQhxqJAaWxwBcUrMV50CNtCf9g/
        svdLHSf0ZY5TFV771QpaJXnhnixNHEL7peM7eQiLcw==
X-Google-Smtp-Source: APXvYqy0aDLcBSZThcU2euPdqUC7jbpYAO1vXBYibNhLeJuIpnrowDBFsgcoWmV4/OIiW/ottBpZY0dyuBAWgcYMMGw=
X-Received: by 2002:a05:600c:48b:: with SMTP id d11mr3500415wme.153.1570138431210;
 Thu, 03 Oct 2019 14:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191002231617.3670-1-john.stultz@linaro.org> <20191002231617.3670-3-john.stultz@linaro.org>
 <20191003112618.GA2420393@kroah.com> <CALAqxLWm_u3KsXHn4a6PdBCOKM1vs5k0xS3G5jY+M-=HBqUJag@mail.gmail.com>
 <9cfccb6a-fba1-61a3-3eb6-3009c2f5e747@redhat.com>
In-Reply-To: <9cfccb6a-fba1-61a3-3eb6-3009c2f5e747@redhat.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 3 Oct 2019 14:33:38 -0700
Message-ID: <CALAqxLX3uSJKvRwzcQznaF4WK52BcM5Bh+PNXHmfDe1aTSUL8Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] usb: roles: Add usb role switch notifier.
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Yu Chen <chenyu56@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
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

On Thu, Oct 3, 2019 at 1:56 PM Hans de Goede <hdegoede@redhat.com> wrote:
> On 03-10-2019 22:45, John Stultz wrote:
> > The HiKey960 has only one USB controller, but in order to support both
> > USB-C gadget/OTG and USB-A (host only) ports. When the USB-C
> > connection is attached, it powers down and disconnects the hub. When
> > the USB-C connection is detached, it powers the hub on and connects
> > the controller to the hub.
>
> When you say one controller, do you mean 1 host and 1 gadget controller,
> or is this one of these lovely devices where a gadget controller gets
> abused as / confused with a proper host controller?

I'm not totally sure myself, but I believe it's the latter, as the
host ports have to be disabled in order for the gadet/otg port to
function.

There was a similar situation w/ the original HiKey board (dwc2
controller) as well, though the switching was done fully in hardware
and we only needed some minor tweaks to the driver to keep the state
transitions straight.

> And since you are doing a usb-role-switch driver, I guess that the
> role-switch is integrated inside the SoC, so you only get one pair
> of USB datalines to the outside ?

I believe so, but again, I don't have a ton of knowledge about the SoC
details, Chen Yu would probably be the right person to answer, but I
don't know if he's doing upstreaming anymore.

> This does seem rather special, it might help if you can provide a diagram
> with both the relevant bits inside the SoC as well as what lives outside
> the Soc. even if it is in ASCII art...

There is a schematic pdf here:
https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_Schematics.pdf

The larger block diagram on page 3 might be helpful, but you can find
more details on the usb hub bits on page 17 and 18.

thanks
-john
