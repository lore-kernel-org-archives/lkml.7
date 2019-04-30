Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E65C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3115E21707
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 15:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tr6x7iaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfD3PUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:20:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35872 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD3PUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 11:20:06 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3UFK4gH098216;
        Tue, 30 Apr 2019 10:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556637604;
        bh=Uqo1rYPaiEdr4WtmfXLxd7DkqOaPj2fMGdePDnnl2i8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=tr6x7iaRXQIkUMyXxmftS3aio0H0hFRiuhtVzIVZLXg20nP2zKZWP05N3iPvHL6MC
         yjF6/icVrJsHFziYpKRtc0/WtPk5kOwlWYcsTFeciiGjPGo+Rvs+632+AQdzG2fzoT
         cwMdSgXJjPdtkOVSA4LMYiZYRgTXqCf4JbzXLLIQ=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3UFK4nw081846
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Apr 2019 10:20:04 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 30
 Apr 2019 10:20:03 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 30 Apr 2019 10:20:04 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3UFK3Am096959;
        Tue, 30 Apr 2019 10:20:03 -0500
Date:   Tue, 30 Apr 2019 10:20:03 -0500
From:   Bin Liu <b-liu@ti.com>
To:     "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MUSB MULTIPOINT HIGH SPEED DUAL-ROLE CONTROLLER" 
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 0/6] musb: Improve performance for hub-attached webcams
Message-ID: <20190430152003.GH20993@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MUSB MULTIPOINT HIGH SPEED DUAL-ROLE CONTROLLER" <linux-usb@vger.kernel.org>
References: <20190403185310.8437-1-matwey@sai.msu.ru>
 <CAJs94EZsDOo6wp2rZmsETLs7uPE3CCv1bNOsewxehyw8R52scA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJs94EZsDOo6wp2rZmsETLs7uPE3CCv1bNOsewxehyw8R52scA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matwey,

On Wed, Apr 24, 2019 at 06:42:30PM +0300, Matwey V. Kornilov wrote:
> Ping

Sorry for my late response. This series does improve isoch transfers for
webcam on musb. A few of my cameras used to fail to stream 640x480@30fps
now the test passed with your patches. Thank you for the work.

But since the patch changes the way handling urb giveback, I would need
more time to run more tests.

-Bin.

> 
> ср, 3 апр. 2019 г. в 21:53, Matwey V. Kornilov <matwey@sai.msu.ru>:
> >
> > The series is concerned to issues with isochronous transfer while
> > streaming the USB webcam data. I discovered the issue first time
> > when attached PWC USB webcam to AM335x-based BeagleBone Black SBC.
> > It appeared that the root issue was in numerous missed IN requests
> > during isochronous transfer where each missing leaded to the frame
> > drop. Since every IN request is triggered in MUSB driver
> > individually, it is important to queue the send IN request as
> > earlier as possible when the previous IN completed. At the same
> > time the URB giveback handler of the device driver has also to be
> > called there, that leads to arbitrarily delay depending on the
> > device driver performance. The details with the references are
> > described in [1].
> >
> > The issue has two parts:
> >
> >   1) peripheral driver URB callback performance
> >   2) MUSB host driver performance
> >
> > It appeared that the first part is related to the wrong memory
> > allocation strategy in the most USB webcam drivers. Non-cached
> > memory is used in assumption that coherent DMA memory leads to
> > the better performance than non-coherent memory in conjunction with
> > the proper synchronization. Yet the assumption might be valid for
> > x86 platforms some time ago, the issue was fixed for PWC driver in:
> >
> >     1161db6776bd ("media: usb: pwc: Don't use coherent DMA buffers for ISO transfer")
> >
> > that leads to 3.5x performance gain. The more generic fix for this
> > common issue are coming for the rest drivers [2].
> >
> > The patch allowed successfully running full-speed USB PWC webcams
> > attached directly to BeagleBone Black USB port.
> >
> > However, the second part of the issue is still present for
> > peripheral device attached through the high-speed USB hub due to
> > its 125us frame time. The patch series is intended to reorganize
> > musb_advance_schedule() to allow host to send IN request quicker.
> >
> > The patch series is organized as the following. First three patches
> > improve readability of the existing code in
> > musb_advance_schedule(). Patches 4 and 5 introduce updated
> > signature for musb_start_urb(). The last patch introduce new
> > code-path in musb_advance_schedule() which allows for faster
> > response.
> >
> > References:
> >
> > [1] https://www.spinics.net/lists/linux-usb/msg165735.html
> > [2] https://www.spinics.net/lists/linux-media/msg144279.html
> >
> > Matwey V. Kornilov (6):
> >   usb: musb: Use USB_DIR_IN when calling musb_advance_schedule()
> >   usb: musb: Introduce musb_qh_empty() helper function
> >   usb: musb: Introduce musb_qh_free() helper function
> >   usb: musb: Rename musb_start_urb() to musb_start_next_urb()
> >   usb: musb: Introduce musb_start_urb()
> >   usb: musb: Decrease URB starting latency in musb_advance_schedule()
> >
> >  drivers/usb/musb/musb_host.c | 114 +++++++++++++++++++++++++++----------------
> >  1 file changed, 71 insertions(+), 43 deletions(-)
> >
> > --
> > 2.16.4
> >
> 
> 
> -- 
> With best regards,
> Matwey V. Kornilov
