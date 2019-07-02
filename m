Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667F6C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF3820989
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIUrlL36"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfGBR3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 13:29:17 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44062 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfGBR3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 13:29:16 -0400
Received: by mail-oi1-f194.google.com with SMTP id e189so13691227oib.11;
        Tue, 02 Jul 2019 10:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b/VodJHchTtPTwJ7u4UXy48B+Jx4LeRpv6rlLSWJCYs=;
        b=ZIUrlL36rqsKjgHMotePAaXOU0MvxKbBHXwPN/4ciNOhSG3YChe11HDdUYn3GZahP8
         Up+ppoUl8UIW9nT4/wRcmwcVjWd6J74V1/lAKyqVJQw8azl4HyJZdMkb0R+bafevLra3
         GSfaD6SUApZOucM/FRc78bSdTICUV88Wyb4UILbmzSTp1t/xpQ+LOGmjUEqlxPTRGksR
         YaFDFT86xpeI7DQameuTPO0XRxltmG9gGnnAmBAAVh5Di0mo1MK1cHDrEoguz1KVRIpm
         Iy7HNz7sbUX4Q/4L/ykJOfvOg/vko2LwWKiKGSj//bpX9QTWi2cmTB5O67srnV4Ufw8+
         B+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b/VodJHchTtPTwJ7u4UXy48B+Jx4LeRpv6rlLSWJCYs=;
        b=ogf9eCC7i/dEAmLF/YM0kr7FsrhqhUs66QX5HhdylcBmAF5jtkk/rtmh0asV57/Ak9
         UNR70FXdUdCAx0PIVi5m0UlB48r9eduZSxTmt6v6rGpsEP/x9vFkD+RcRu1luKvMQfR4
         1svbX1mfL3odOcjIHtegC6yxR5GqmbM/rb4RYF1PwD2hmRPehK2E3mhArPfFazY8CThS
         cTeKE9je52pEsW8unwOD8SKaXm69AKZbAK1V/7Z8I/byQSBGPFrtmQEp72m/8Zd0y4vd
         NMnKVEdWBVJqFvCqdJZS4Mlnyr8X+FVQmnjKifPjGXenOYzG++93m2VrLJlHLFNJSKB1
         5Rww==
X-Gm-Message-State: APjAAAXYtzeI2wl4G/g0C4tPU18dItDjVcjSf52Sm4tmXq8xVBBSW1QR
        /sp2B9BjWUMDtROTLQ7AeBhjOVFy7Rm6SwcHy7c=
X-Google-Smtp-Source: APXvYqyQW7rwE2U62EZyCpSDHSbsXQSpdyDQtGlD5HfJbPRxf1D0HBWZTWRVxGX+u3hQTI1hT9R0SdmcFXL8Y85phy8=
X-Received: by 2002:aca:e4c9:: with SMTP id b192mr3795893oih.82.1562088555714;
 Tue, 02 Jul 2019 10:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190403185310.8437-1-matwey@sai.msu.ru> <20190614164554.27679-1-matwey@sai.msu.ru>
In-Reply-To: <20190614164554.27679-1-matwey@sai.msu.ru>
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date:   Tue, 2 Jul 2019 20:29:03 +0300
Message-ID: <CAJs94EZy7HD-ge8vKGSeMMS+WYw-U=Zxw9gXMLoobpYX6rVt4A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] musb: Improve performance for hub-attached webcams
To:     Bin Liu <b-liu@ti.com>, Greg KH <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     "open list:MUSB MULTIPOINT HIGH SPEED DUAL-ROLE CONTROLLER" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

=D0=BF=D1=82, 14 =D0=B8=D1=8E=D0=BD. 2019 =D0=B3. =D0=B2 19:47, Matwey V. K=
ornilov <matwey@sai.msu.ru>:
>
> The series is concerned to issues with isochronous transfer while
> streaming the USB webcam data. I discovered the issue first time
> when attached PWC USB webcam to AM335x-based BeagleBone Black SBC.
> It appeared that the root issue was in numerous missed IN requests
> during isochronous transfer where each missing leaded to the frame
> drop. Since every IN request is triggered in MUSB driver
> individually, it is important to queue the send IN request as
> earlier as possible when the previous IN completed. At the same
> time the URB giveback handler of the device driver has also to be
> called there, that leads to arbitrarily delay depending on the
> device driver performance. The details with the references are
> described in [1].
>
> The issue has two parts:
>
>   1) peripheral driver URB callback performance
>   2) MUSB host driver performance
>
> It appeared that the first part is related to the wrong memory
> allocation strategy in the most USB webcam drivers. Non-cached
> memory is used in assumption that coherent DMA memory leads to
> the better performance than non-coherent memory in conjunction with
> the proper synchronization. Yet the assumption might be valid for
> x86 platforms some time ago, the issue was fixed for PWC driver in:
>
>     1161db6776bd ("media: usb: pwc: Don't use coherent DMA buffers for IS=
O transfer")
>
> that leads to 3.5x performance gain. The more generic fix for this
> common issue are coming for the rest drivers [2].
>
> The patch allowed successfully running full-speed USB PWC webcams
> attached directly to BeagleBone Black USB port.
>
> However, the second part of the issue is still present for
> peripheral device attached through the high-speed USB hub due to
> its 125us frame time. The patch series is intended to reorganize
> musb_advance_schedule() to allow host to send IN request quicker.
>
> The patch series is organized as the following. First three patches
> improve readability of the existing code in
> musb_advance_schedule(). Patches 4 and 5 introduce updated
> signature for musb_start_urb(). The last patch introduce new
> code-path in musb_advance_schedule() which allows for faster
> response.
>
> References:
>
> [1] https://www.spinics.net/lists/linux-usb/msg165735.html
> [2] https://www.spinics.net/lists/linux-media/msg144279.html
>
> Changes since v1:
>  - Patch 6 was redone to keep URB giveback order and stop transmission at
>    erroneous URB.
>
> Matwey V. Kornilov (6):
>   usb: musb: Use USB_DIR_IN when calling musb_advance_schedule()
>   usb: musb: Introduce musb_qh_empty() helper function
>   usb: musb: Introduce musb_qh_free() helper function
>   usb: musb: Rename musb_start_urb() to musb_start_next_urb()
>   usb: musb: Introduce musb_start_urb()
>   usb: musb: Decrease URB starting latency in musb_advance_schedule()
>
>  drivers/usb/musb/musb_host.c | 132 ++++++++++++++++++++++++++++---------=
------
>  drivers/usb/musb/musb_host.h |   1 +
>  2 files changed, 86 insertions(+), 47 deletions(-)
>
> --
> 2.16.4
>


--=20
With best regards,
Matwey V. Kornilov
