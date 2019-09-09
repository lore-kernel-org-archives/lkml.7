Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D86C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2864421D6C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 16:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dj5KPMu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfIIQdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 12:33:20 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44594 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfIIQdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 12:33:19 -0400
Received: by mail-io1-f66.google.com with SMTP id j4so30153634iog.11;
        Mon, 09 Sep 2019 09:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AvT+f9cEL1vGiQWAZExwzAMP70MtlJ3IxUh/9G+ER/E=;
        b=Dj5KPMu0kD52YffT8ZFudAnK2ovKtPbgMmLM7BiXrVP4OodzIcpdgSSW+2LQGDQFud
         3G5xq7la8Lj/fB2+X7fKOty6H6PvhzfKNIRj3BLwJkILTsVZdpVu2CXOAu2mu23/7ACr
         eNADveWgLBQsusoUa1BzI8J+pbg7V0BC0GzumyRu4fBPvDTr1I26Hyp9VPEg71JKwI61
         iIn7eovAly6WYoRgb5Xm3LRcPc67VAKjuEdTVQ3juz8noLTGrXRcAWx2RnApSrfiUwU3
         S/it1Kg0Cd2YGL3GxnUVf18Qep/mvhX/6N4WHUoVO2Gotpfb/2mkc74r+oUktvE6bDG8
         cihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AvT+f9cEL1vGiQWAZExwzAMP70MtlJ3IxUh/9G+ER/E=;
        b=KoUlq9UGYYZNgwZ+79ZkDK7oUrKIsQ4ps/w3IaTqTj1dgbSMWSghYCSW2/KFJCHIp0
         B/3ggWaDdEG/esHzrwEsjbZpRxuX7FHxgALPGr+FEUPEOYDJo5GuQVpK2wAMHIDAs4oW
         4FJg7fkM5N3M799+7SqYxVARfdcH6yqqTsdVPDOhWCRkJep6EsSFaPQIqSuvs+eQChSA
         j15ZNzvtjhmcAEgqUfuPTJRCTJ/t3nqwohFmcx5nnZgi7XBHusUdK82u37ByvU8GE102
         cTAy6NVYhI2aoMmRZsjKmKEQ2coEgNuaIHWoJ2Xn7zJoHnk4pCFpgThyC3rt8QxDbHCn
         ZktQ==
X-Gm-Message-State: APjAAAVJjdUKUNYwLkK/r7YsjPbrNk2EF8y0TOxKwbpNlKZUHoTe5LJP
        tCQ7/3cUzoaYpDTmSaPn5fsRIuRam6+Kwe3qveE=
X-Google-Smtp-Source: APXvYqwv7CWrXJztK9pBx6gwerAZfeXV9pu4iftrVhRpaLSD0F8G4WHC0hJkmGjswO4ASrYk9hj723co7TTVm9EZ+sE=
X-Received: by 2002:a02:cdca:: with SMTP id m10mr12873526jap.44.1568046798789;
 Mon, 09 Sep 2019 09:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190403185310.8437-1-matwey@sai.msu.ru> <20190614164554.27679-1-matwey@sai.msu.ru>
 <CAJs94EZy7HD-ge8vKGSeMMS+WYw-U=Zxw9gXMLoobpYX6rVt4A@mail.gmail.com> <20190702173335.GA2724@uda0271908>
In-Reply-To: <20190702173335.GA2724@uda0271908>
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date:   Mon, 9 Sep 2019 19:33:07 +0300
Message-ID: <CAJs94Ebq5epN6zhXE9N_NiTdQEZ1wYcGxnGr_vahxaKxdWGW7A@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] musb: Improve performance for hub-attached webcams
To:     Bin Liu <b-liu@ti.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "open list:MUSB MULTIPOINT HIGH SPEED DUAL-ROLE CONTROLLER" 
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=B2=D1=82, 2 =D0=B8=D1=8E=D0=BB. 2019 =D0=B3. =D0=B2 20:33, Bin Liu <b-l=
iu@ti.com>:
>
> Matwey,
>
> On Tue, Jul 02, 2019 at 08:29:03PM +0300, Matwey V. Kornilov wrote:
> > Ping?
>
> I was offline and just got back. I will review it soon. Sorry for the
> delay.

Ping?

>
> -Bin.
>
> >
> > =D0=BF=D1=82, 14 =D0=B8=D1=8E=D0=BD. 2019 =D0=B3. =D0=B2 19:47, Matwey =
V. Kornilov <matwey@sai.msu.ru>:
> > >
> > > The series is concerned to issues with isochronous transfer while
> > > streaming the USB webcam data. I discovered the issue first time
> > > when attached PWC USB webcam to AM335x-based BeagleBone Black SBC.
> > > It appeared that the root issue was in numerous missed IN requests
> > > during isochronous transfer where each missing leaded to the frame
> > > drop. Since every IN request is triggered in MUSB driver
> > > individually, it is important to queue the send IN request as
> > > earlier as possible when the previous IN completed. At the same
> > > time the URB giveback handler of the device driver has also to be
> > > called there, that leads to arbitrarily delay depending on the
> > > device driver performance. The details with the references are
> > > described in [1].
> > >
> > > The issue has two parts:
> > >
> > >   1) peripheral driver URB callback performance
> > >   2) MUSB host driver performance
> > >
> > > It appeared that the first part is related to the wrong memory
> > > allocation strategy in the most USB webcam drivers. Non-cached
> > > memory is used in assumption that coherent DMA memory leads to
> > > the better performance than non-coherent memory in conjunction with
> > > the proper synchronization. Yet the assumption might be valid for
> > > x86 platforms some time ago, the issue was fixed for PWC driver in:
> > >
> > >     1161db6776bd ("media: usb: pwc: Don't use coherent DMA buffers fo=
r ISO transfer")
> > >
> > > that leads to 3.5x performance gain. The more generic fix for this
> > > common issue are coming for the rest drivers [2].
> > >
> > > The patch allowed successfully running full-speed USB PWC webcams
> > > attached directly to BeagleBone Black USB port.
> > >
> > > However, the second part of the issue is still present for
> > > peripheral device attached through the high-speed USB hub due to
> > > its 125us frame time. The patch series is intended to reorganize
> > > musb_advance_schedule() to allow host to send IN request quicker.
> > >
> > > The patch series is organized as the following. First three patches
> > > improve readability of the existing code in
> > > musb_advance_schedule(). Patches 4 and 5 introduce updated
> > > signature for musb_start_urb(). The last patch introduce new
> > > code-path in musb_advance_schedule() which allows for faster
> > > response.
> > >
> > > References:
> > >
> > > [1] https://www.spinics.net/lists/linux-usb/msg165735.html
> > > [2] https://www.spinics.net/lists/linux-media/msg144279.html
> > >
> > > Changes since v1:
> > >  - Patch 6 was redone to keep URB giveback order and stop transmissio=
n at
> > >    erroneous URB.
> > >
> > > Matwey V. Kornilov (6):
> > >   usb: musb: Use USB_DIR_IN when calling musb_advance_schedule()
> > >   usb: musb: Introduce musb_qh_empty() helper function
> > >   usb: musb: Introduce musb_qh_free() helper function
> > >   usb: musb: Rename musb_start_urb() to musb_start_next_urb()
> > >   usb: musb: Introduce musb_start_urb()
> > >   usb: musb: Decrease URB starting latency in musb_advance_schedule()
> > >
> > >  drivers/usb/musb/musb_host.c | 132 ++++++++++++++++++++++++++++-----=
----------
> > >  drivers/usb/musb/musb_host.h |   1 +
> > >  2 files changed, 86 insertions(+), 47 deletions(-)
> > >
> > > --
> > > 2.16.4
> > >
> >
> >
> > --
> > With best regards,
> > Matwey V. Kornilov



--=20
With best regards,
Matwey V. Kornilov
