Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B28C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B74F2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLjX5pYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfEQQDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 12:03:04 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35078 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbfEQQDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 12:03:03 -0400
Received: by mail-ot1-f66.google.com with SMTP id n14so7217045otk.2;
        Fri, 17 May 2019 09:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gRcrtb5zkBV22N7ejZ8gd80yYzuG0eMMK0Likb2l39A=;
        b=qLjX5pYMmcTMjN5iFgyQsKZE0y6c8l2+gMnFTxjnwzcVJC9+73IQv1ERNRGBwqcVB1
         jRNQe7asKnOot4X72/nbnRE7ZLXpGGHhCVQHVNfntOjMG1qo7pS5msGMHFXbT8alz6NV
         8MZ4GlFAmF9tHddkLWQiIfiLZoD3R230cflReazsdSKB8hmkKBI5BpKwxrIt27vfGiRV
         iaoxpaCP0JJhEj2JXMFaw8wwGrfzzn0XPmAsNMq0oa8ktvb2lMmfwa7TtfouoWL0DbPa
         0DGFpoS0qsgQPx2kd48oCzrUSwvRpDEoz39no2EGJVCoA96kzHrljKfOemLP4MpMrC+3
         9VWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gRcrtb5zkBV22N7ejZ8gd80yYzuG0eMMK0Likb2l39A=;
        b=QX2t0l632nKJLGVdsiMJfTazSfpVn0YXgbqBGE0Q6xNwKDvMNKzBU4ewPFQM4vVWWO
         I/zbvvhL4za3Su7GEo9Xv1N8S9M7Rxw/AYCkT8n7RN1boarq+nabJNl7O6PesKTnmalv
         0Mo9Cmm9komJ7DmjQ1CIyTjy17SNre0EDgvPQhB2StZtH0BsQEqcw1TGllKHe+/cxnIp
         cbb8z2zBPweFyiJToaQAJlbBSlD5RCRMZnpz442oLkuSBqPICb+xe/Blx4gjHxpY8qxV
         Je3ZjaoMA/2Y5zS/KoT68GtCtlN5QE+bFkVDYPkfhcc53KUeacZYNjFW33OI/GeoaBxB
         nkdA==
X-Gm-Message-State: APjAAAV0NPSvS2v1UHoK+H6HycCkmm78B7eKYDaVYyM3IsvYoD4qbsBD
        HRU2Vi9VGYgUX9EeuYBPlLL6qBCg0iEXSPHYqzk=
X-Google-Smtp-Source: APXvYqxmJfR52ctG4tHDsK2W7JZpTz8cICNLg1PMwwOW2FZTYEBQrxwnQVaenqKDcW/K5NYKOXtN9pY4O8t6RCdDLOk=
X-Received: by 2002:a9d:64c1:: with SMTP id n1mr8954538otl.259.1558108983107;
 Fri, 17 May 2019 09:03:03 -0700 (PDT)
MIME-Version: 1.0
From:   Jaewon Kim <jaewon31.kim@gmail.com>
Date:   Sat, 18 May 2019 01:02:28 +0900
Message-ID: <CAJrd-UuMRdWHky4gkmiR0QYozfXW0O35Ohv6mJPFx2TLa8hRKg@mail.gmail.com>
Subject: [RFC PATCH] usb: host: xhci: allow __GFP_FS in dma allocation
To:     gregkh@linuxfoundation.org, m.szyprowski@samsung.com,
        linux-mm@kvack.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>, ytk.lee@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello I don't have enough knowledge on USB core but I've wondered
why GFP_NOIO has been used in xhci_alloc_dev for
xhci_alloc_virt_device. I found commit ("a6d940dd759b xhci: Use
GFP_NOIO during device reset"). But can we just change GFP_NOIO
to __GFP_RECLAIM | __GFP_FS ?

Please refer to below case.

I got a report from Lee YongTaek <ytk.lee@samsung.com> that the
xhci_alloc_virt_device was too slow over 2 seconds only for one page
allocation.

1) It was because kernel version was v4.14 and DMA allocation was
done from CMA(Contiguous Memory Allocator) where CMA region was
almost filled with file page and  CMA passes GFP down to page
isolation. And the page isolation only allows file page isolation only to
requests having __GFP_FS.

2) Historically CMA was changed at v4.19 to use GFP_KERNEL
regardless of GFP passed to  DMA allocation through the
commit 6518202970c1 "(mm/cma: remove unsupported gfp_mask
parameter from cma_alloc()".

I think pre v4.19 the xhci_alloc_virt_device could be very slow
depending on CMA situation but free to USB deadlock issue. But as of
v4.19, I think, it will be fast but can face the deadlock issue.
Consequently I think to meet the both cases, I think USB can pass
__GFP_FS without __GFP_IO.

If __GFP_FS is passed from USB core, of course, the CMA patch also
need to be changed to pass GFP.

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 005e65922608..38abcd03a1a2 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3893,7 +3893,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct
usb_device *udev)
         * xhci_discover_or_reset_device(), which may be called as part of
         * mass storage driver error handling.
         */
-       if (!xhci_alloc_virt_device(xhci, slot_id, udev, GFP_NOIO)) {
+       if (!xhci_alloc_virt_device(xhci, slot_id, udev, __GFP_RECLAIM
| __GFP_FS)) {
                xhci_warn(xhci, "Could not allocate xHCI USB device
data structures\n");
                goto disable_slot;
        }


Thank you
