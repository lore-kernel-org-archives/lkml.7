Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08D2C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89F020862
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 13:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbfEWNZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 09:25:31 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33615 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730081AbfEWNZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 09:25:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id z5so314871qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 06:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2nuwzHmizY+o20odC1jFzdFE/kDmytvOBO+cACtARhw=;
        b=O/N1O3GUk9ZtXsONn8fmYirU4lwaN5Fcsqa6X4VGnhUVwo8lEN3Hq5EQ8f0w/U9pD6
         XvKib6i0SiUv3LaDUbTfN0smI2LoHUmhX03fbqWKUo4MY2nWdfjHOKDPJVYytvvMse18
         ykRMI63Fnxp4tABXsHtqWD2P8YfUeuQ6KL+Xb9NGhsbCUOOrrmuw+XQS7EISWAozRUkm
         ON1cjq9vuf8IdETxVDXb7SXAE5ExcAdATcCjJaaWhiU056MzMHutgogL84wi/4xeydc5
         1aR9sTL5no4GfG2jxrE8gBpu8AgU01YhfkFOxxu1lqO47jIlzISa0UarMyaDtHxbBPLy
         PJ2A==
X-Gm-Message-State: APjAAAVTCHHgfX/+Cd8PQJgA0crygQTm3CBYsQvqrq8LDmrCWMEb2vHC
        GckpT/qgo3nfkl/HXuyNw7XyXNyi5La9gG6pgFBy9A==
X-Google-Smtp-Source: APXvYqwbD6xvKORdII03tFSjeKJhmeLaMCJVPKkXJhEt65oT1eF7ZVMCPLJ10jqF9duYv9fOwurnwnJBsPuhckP/hxc=
X-Received: by 2002:a0c:baa7:: with SMTP id x39mr32401995qvf.100.1558617930403;
 Thu, 23 May 2019 06:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190521132712.2818-1-benjamin.tissoires@redhat.com>
In-Reply-To: <20190521132712.2818-1-benjamin.tissoires@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 23 May 2019 15:25:19 +0200
Message-ID: <CAO-hwJ+BzfWKKMKtM0Q3+qMfCm99kQeUfEdA97oz5bg_Jp_SyA@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Fix Elan I2C touchpads in latest generation from Lenovo
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        KT Liao <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>,
        Aaron Ma <aaron.ma@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 21, 2019 at 3:27 PM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Hi,
>
> This is the v2 from https://lkml.org/lkml/2018/10/12/633
>
> So I initially thought it would be easy to integrate the suggested changes
> in the v1, but it turns our that the changes to have the touchscreen-width
> and height parameters were quite hard to do.
>
> I finally postponed the issue by blacklisting the 2 laptops we knew were
> not working and tried to devote more time to understand both drivers more.
>
> But it s the time where Lenovo is preparing the new models, and guess what,
> they suffer from the same symptoms.

I just received the confirmation from Lenovo that this series makes
the new laptops working.

Cheers,
Benjamin

>
> So I took a few time to work on this and finally got my head around the
> width and height problem. Once I got it, it was simple clear, but this also
> means we can not really rely on a device tree property for that.
>
> So in the elan* drivers, the "traces" are simply how many antennas there
> are on each axis. Which means that if a trace of 4 is reported in the
> events, it means it is simply seen by 4 antennas. So the computation of the
> width/height is the following: we take how many antennas there are, we
> subtract one to have the number of holes between the antennas, and we
> divide the number of unit we have in the axis by the value we just
> computed.
> This gives a rough 4mm on the P52, in both directions.
>
> And once you get that, you can just realize that the unit of the width and
> height are just the same than the X and Y coordinates, so we can apply the
> same resolution.
>
> So, in the end, that means that elan_i2c needs the information, or it will
> not be able to convert the number of crossed antennas into a size, but this
> is something specific to this touchpad.
>
> So here come, 7 months later the v2 on the subject.
>
> Cheers,
> Benjamin
>
> Benjamin Tissoires (10):
>   Input: elantech - query the min/max information beforehand too
>   Input: elantech - add helper function elantech_is_buttonpad()
>   Input: elantech - detect middle button based on firmware version
>   dt-bindings: add more optional properties for elan_i2c touchpads
>   Input: elan_i2c - do not query the info if they are provided
>   Input: elantech/SMBus - export all capabilities from the PS/2 node
>   Input: elan_i2c - handle physical middle button
>   Input: elan_i2c - export true width/height
>   Input: elan_i2c - correct the width/size base value
>   Input: elantech: remove P52 from SMBus blacklist
>
>  .../devicetree/bindings/input/elan_i2c.txt    |  11 +
>  drivers/input/mouse/elan_i2c_core.c           |  85 +++--
>  drivers/input/mouse/elantech.c                | 318 ++++++++++--------
>  drivers/input/mouse/elantech.h                |   8 +
>  4 files changed, 251 insertions(+), 171 deletions(-)
>
> --
> 2.21.0
>
