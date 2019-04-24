Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29387C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F552077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pmxawvew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbfDXPmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:42:45 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38633 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbfDXPmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:42:45 -0400
Received: by mail-oi1-f195.google.com with SMTP id a6so14654917oie.5;
        Wed, 24 Apr 2019 08:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f+eaeNBHAZ4Q033/wgZwMa1ytnHX4s6j+vUUFaBHOk0=;
        b=Pmxawvew6x3QWDn62c+3mmrUcBeJdQI9hgjpMk7sC3pGYdjGBY8E4tDMS3NUoEosAX
         AbsilrxAwJvoXhv/hkXHk3MGsHEGY5oaQWDBGlfqIGCJV1I3E7eznMT3kzJkmMrCawSE
         P3djq57sL441T4B+ZqJ6gNN9CbVk1gbTSVEHwjl9HJcX2utVi6lvQen2uhB8yhKcJAB3
         iDLagwGA71O4lLgNzFrGXWHU7JnMv78DPUDA0SmgFd8R8es76Qw5FzADbFbFQT+Qu3Io
         /777CUfJAx07K3XA8BhGZ3lp29nOpD60OXaQPk5YIAELEMElTVlOsTGZR0mVZxDIyJQF
         qUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f+eaeNBHAZ4Q033/wgZwMa1ytnHX4s6j+vUUFaBHOk0=;
        b=GwLGnXKbE6ShEmhZQNMNPadoLmZBImXcA6KJClg/PGYcfpFHKQvwKCJdszzOMCydLa
         GBuObZvs2GjjONtPbxjIhlp3ih+FUJkZAbJLun9WjZwytG6oT3R3aRMpC6S5rS/fDXVL
         YpgYICqTMMCXxqdbd2svxtXhJdA4oSGeKR1HCjZo6SOTvrP7p4UCJktxcMEy4YBSY9oS
         Ma+hvxFMB7uZ2jGZNzpSnHppLLS2VPDT0J3+ewfvoC8BAKcG2dKBZHF8AhWkSt3WwxHC
         i9vIL0H6PluRSCW9gzIWFmV1J7AGr4PYK+ZhKcqDC1dTvt/DGyygFBhRxsfkiqqH2XC/
         Qvsg==
X-Gm-Message-State: APjAAAV41vp2CedauvrvU1GWOAfRgJDax3SHxuHLe+PKeBw6dm1bwnNu
        Irr5oF5a6H0rgvYLPEI8wf49+3+lfqU9aLGlPrQ=
X-Google-Smtp-Source: APXvYqz23bK+wLzeK3s8jRd2TlS78+pguwzU8oJetcB+PHsAyt2GKXgiiwhC8yvmS3nBxThwF3kmZsIkRMruKenTpUA=
X-Received: by 2002:aca:e350:: with SMTP id a77mr6245029oih.82.1556120564065;
 Wed, 24 Apr 2019 08:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190403185310.8437-1-matwey@sai.msu.ru>
In-Reply-To: <20190403185310.8437-1-matwey@sai.msu.ru>
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date:   Wed, 24 Apr 2019 18:42:30 +0300
Message-ID: <CAJs94EZsDOo6wp2rZmsETLs7uPE3CCv1bNOsewxehyw8R52scA@mail.gmail.com>
Subject: Re: [PATCH 0/6] musb: Improve performance for hub-attached webcams
To:     Bin Liu <b-liu@ti.com>, Greg KH <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:MUSB MULTIPOINT HIGH SPEED DUAL-ROLE CONTROLLER" 
        <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping

=D1=81=D1=80, 3 =D0=B0=D0=BF=D1=80. 2019 =D0=B3. =D0=B2 21:53, Matwey V. Ko=
rnilov <matwey@sai.msu.ru>:
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
> Matwey V. Kornilov (6):
>   usb: musb: Use USB_DIR_IN when calling musb_advance_schedule()
>   usb: musb: Introduce musb_qh_empty() helper function
>   usb: musb: Introduce musb_qh_free() helper function
>   usb: musb: Rename musb_start_urb() to musb_start_next_urb()
>   usb: musb: Introduce musb_start_urb()
>   usb: musb: Decrease URB starting latency in musb_advance_schedule()
>
>  drivers/usb/musb/musb_host.c | 114 +++++++++++++++++++++++++++----------=
------
>  1 file changed, 71 insertions(+), 43 deletions(-)
>
> --
> 2.16.4
>


--=20
With best regards,
Matwey V. Kornilov
