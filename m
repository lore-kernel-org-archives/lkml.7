Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00415CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE50121872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ao4VWypj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390134AbfJWIMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:12:43 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36393 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfJWIMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:12:43 -0400
Received: by mail-io1-f68.google.com with SMTP id c16so3983441ioc.3;
        Wed, 23 Oct 2019 01:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xeGHhIazHjbmXETf2LAZnyOId7SvzhgwolMgMV8mqgI=;
        b=ao4VWypjOJKTjbSco/Rm0FE9dAVuyvq1d6PKfUiUCaqYYvJdFIV+fbDUolBd0PRsbY
         pkkJ+Oebiwc6SkqJJUo/ElWVHbqdEgNaneOk9yP24LfDqzlt+kv/uo2Z76zaKQfeC32J
         er0fwJOHwdNj7ON2ZzqxTv+uq2UUMTuO1LFMw52psE/wyKzJxxj/vOinljG51ZHACOwv
         LVQAiLSIWoCMwimKQiE6s+N1jspEyaepbD2taKipH4mR46QZk5dxNkHA7ZrGBKT7Vhq2
         ktSpXPouo3LVBo41+UjrEnk968zAW3qfzv0PWsBldQ5yMdbR1ZyqMaW+oRANIytf1Bzq
         hGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xeGHhIazHjbmXETf2LAZnyOId7SvzhgwolMgMV8mqgI=;
        b=oOjgESWnAGvPx3XV2rjUDyeXVaodDRFIZ+CDQ+UOe9ApYWk55zJinh8ULSNpF9s5KY
         Cv7EdASvjL7xvDq2Bavp15o///FytvVX6Jq5XL27TSfQmTXA88OzL8Rxo5OEr9xJxEKV
         GypG884g/Hb/yCFgGbY72w2LM9nY5nSEU/MY5J3VEFq6kOTmTQdwdAhSh7+LV0TqBW1W
         fO4aTZhM62ArS0ox9RRNvCsX64Vqs0s71zL5EkvEbFWS0cA7y+cHDpRLAa4UaNI6j6tG
         gprsYduoYFMDbmXsBYZyjGI5dNOGfRoguSulhZPGT/rI0jnodbYUSTFDghTBdzTaCST5
         aevA==
X-Gm-Message-State: APjAAAUSk4brjqCuNRft05/BPamimDuTL/hWQJVRXtkF9xgIZ4kOgV1j
        JJFOUaiPHn14EpR27Uwf/GaXBYuMYaA3sxmRgoKJCeli
X-Google-Smtp-Source: APXvYqz08ZAczsyFOKIP/xkqWmG2xjQ+k0gwAgP+fzy6aUhuD+eBMPQ+sh9I1mHHf7vqHMHyR3yZfXU25nKQIaZvspc=
X-Received: by 2002:a5e:9e0a:: with SMTP id i10mr2022517ioq.172.1571818361783;
 Wed, 23 Oct 2019 01:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190403185310.8437-1-matwey@sai.msu.ru> <20190614164554.27679-1-matwey@sai.msu.ru>
 <CAJs94EZy7HD-ge8vKGSeMMS+WYw-U=Zxw9gXMLoobpYX6rVt4A@mail.gmail.com>
 <20190702173335.GA2724@uda0271908> <CAJs94Ebq5epN6zhXE9N_NiTdQEZ1wYcGxnGr_vahxaKxdWGW7A@mail.gmail.com>
In-Reply-To: <CAJs94Ebq5epN6zhXE9N_NiTdQEZ1wYcGxnGr_vahxaKxdWGW7A@mail.gmail.com>
From:   "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date:   Wed, 23 Oct 2019 11:12:29 +0300
Message-ID: <CAJs94EYv4TUDm-J+9ToGccGC-hMQ1XU12DZYUmQVdfdjL5PBPg@mail.gmail.com>
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

=D0=BF=D0=BD, 9 =D1=81=D0=B5=D0=BD=D1=82. 2019 =D0=B3. =D0=B2 19:33, Matwey=
 V. Kornilov <matwey.kornilov@gmail.com>:
>
> =D0=B2=D1=82, 2 =D0=B8=D1=8E=D0=BB. 2019 =D0=B3. =D0=B2 20:33, Bin Liu <b=
-liu@ti.com>:
> >
> > Matwey,
> >
> > On Tue, Jul 02, 2019 at 08:29:03PM +0300, Matwey V. Kornilov wrote:
> > > Ping?
> >
> > I was offline and just got back. I will review it soon. Sorry for the
> > delay.
>
> Ping?
>

Ping?

> >
> > -Bin.
> >
> > >
> > > =D0=BF=D1=82, 14 =D0=B8=D1=8E=D0=BD. 2019 =D0=B3. =D0=B2 19:47, Matwe=
y V. Kornilov <matwey@sai.msu.ru>:
> > > >
> > > > The series is concerned to issues with isochronous transfer while
> > > > streaming the USB webcam data. I discovered the issue first time
> > > > when attached PWC USB webcam to AM335x-based BeagleBone Black SBC.
> > > > It appeared that the root issue was in numerous missed IN requests
> > > > during isochronous transfer where each missing leaded to the frame
> > > > drop. Since every IN request is triggered in MUSB driver
> > > > individually, it is important to queue the send IN request as
> > > > earlier as possible when the previous IN completed. At the same
> > > > time the URB giveback handler of the device driver has also to be
> > > > called there, that leads to arbitrarily delay depending on the
> > > > device driver performance. The details with the references are
> > > > described in [1].
> > > >
> > > > The issue has two parts:
> > > >
> > > >   1) peripheral driver URB callback performance
> > > >   2) MUSB host driver performance
> > > >
> > > > It appeared that the first part is related to the wrong memory
> > > > allocation strategy in the most USB webcam drivers. Non-cached
> > > > memory is used in assumption that coherent DMA memory leads to
> > > > the better performance than non-coherent memory in conjunction with
> > > > the proper synchronization. Yet the assumption might be valid for
> > > > x86 platforms some time ago, the issue was fixed for PWC driver in:
> > > >
> > > >     1161db6776bd ("media: usb: pwc: Don't use coherent DMA buffers =
for ISO transfer")
> > > >
> > > > that leads to 3.5x performance gain. The more generic fix for this
> > > > common issue are coming for the rest drivers [2].
> > > >
> > > > The patch allowed successfully running full-speed USB PWC webcams
> > > > attached directly to BeagleBone Black USB port.
> > > >
> > > > However, the second part of the issue is still present for
> > > > peripheral device attached through the high-speed USB hub due to
> > > > its 125us frame time. The patch series is intended to reorganize
> > > > musb_advance_schedule() to allow host to send IN request quicker.
> > > >
> > > > The patch series is organized as the following. First three patches
> > > > improve readability of the existing code in
> > > > musb_advance_schedule(). Patches 4 and 5 introduce updated
> > > > signature for musb_start_urb(). The last patch introduce new
> > > > code-path in musb_advance_schedule() which allows for faster
> > > > response.
> > > >
> > > > References:
> > > >
> > > > [1] https://www.spinics.net/lists/linux-usb/msg165735.html
> > > > [2] https://www.spinics.net/lists/linux-media/msg144279.html
> > > >
> > > > Changes since v1:
> > > >  - Patch 6 was redone to keep URB giveback order and stop transmiss=
ion at
> > > >    erroneous URB.
> > > >
> > > > Matwey V. Kornilov (6):
> > > >   usb: musb: Use USB_DIR_IN when calling musb_advance_schedule()
> > > >   usb: musb: Introduce musb_qh_empty() helper function
> > > >   usb: musb: Introduce musb_qh_free() helper function
> > > >   usb: musb: Rename musb_start_urb() to musb_start_next_urb()
> > > >   usb: musb: Introduce musb_start_urb()
> > > >   usb: musb: Decrease URB starting latency in musb_advance_schedule=
()
> > > >
> > > >  drivers/usb/musb/musb_host.c | 132 ++++++++++++++++++++++++++++---=
------------
> > > >  drivers/usb/musb/musb_host.h |   1 +
> > > >  2 files changed, 86 insertions(+), 47 deletions(-)
> > > >
> > > > --
> > > > 2.16.4
> > > >
> > >
> > >
> > > --
> > > With best regards,
> > > Matwey V. Kornilov
>
>
>
> --
> With best regards,
> Matwey V. Kornilov



--=20
With best regards,
Matwey V. Kornilov
