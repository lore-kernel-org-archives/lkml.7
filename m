Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C63C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42732175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NBtYDEpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfEJMYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 08:24:36 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9759 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfEJMYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 08:24:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd56d8b0001>; Fri, 10 May 2019 05:24:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 May 2019 05:24:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 May 2019 05:24:35 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 May
 2019 12:24:34 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 10 May 2019 12:24:35 +0000
Received: from jilin-desktop.nvidia.com (Not Verified[10.19.120.147]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cd56d810003>; Fri, 10 May 2019 05:24:34 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <kai.heng.feng@canonical.com>,
        <drinkcat@chromium.org>, <keescook@chromium.org>,
        <nsaenzjulienne@suse.de>, <jflat@chromium.org>, <malat@debian.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jim Lin <jilin@nvidia.com>
Subject: [PATCH v9 0/2] usb: xhci: Add Clear_TT_Buffer
Date:   Fri, 10 May 2019 20:24:28 +0800
Message-ID: <1557491070-24715-1-git-send-email-jilin@nvidia.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557491083; bh=W9dcbuG6GvRBKzctoW3lXO7VaO6IJQzTilLnXCzPnKA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=NBtYDEpMRj+n+fDRL9vsUv4l/1vhehhrdTQV1iQ1p9vHlQ8DPP060RLGJvbUiQRQw
         lqrg37nNVDNs3cZGYnF+dfLZ3d6FoOVAb5r/f28k+dd6g+rxXZ2vogeaLt2dtuf0Xw
         E40R+g74bk4YLr17YH4m/NP2WmfXWzq9s9T+1aXWdGHzMHnLjLltKPEYXe2OSwwUlv
         qFXshetdSAMVqU1/9a6Aanlzw96cW9uaEw+zsSbHgTIx8iHPxGn4Az7AK2vbelskz9
         hps4L8YTU5x5rw5Te0uee+TVsAbtOwhkOv41m3EUXPLIQ3V4zWzk93BBaYT9IGtl1W
         UaGpx66LiZuyA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB 2.0 specification chapter 11.17.5 says "as part of endpoint halt
processing for full-/low-speed endpoints connected via a TT, the host
software must use the Clear_TT_Buffer request to the TT to ensure
that the buffer is not in the busy state".

In our case, a full-speed speaker (ConferenceCam) is behind a high-
speed hub (ConferenceCam Connect), sometimes once we get STALL on a
request we may continue to get STALL with the folllowing requests,
like Set_Interface.

Solution is to invoke usb_hub_clear_tt_buffer() to send
Clear_TT_Buffer request to the hub of the device for the following
Set_Interface requests to the device to get ACK successfully.

The Clear_TT_Buffer request sent to the hub includes the address of
the LS/FS child device in wValue field. usb_hub_clear_tt_buffer()
uses udev->devnum to set the address wValue. This won't work for
devices connected to xHC.

For other host controllers udev->devnum is the same as the address of
the usb device, chosen and set by usb core. With xHC the controller
hardware assigns the address, and won't be the same as devnum.

Here we have two patches.
One is to add devaddr in struct usb_device for
usb_hub_clear_tt_buffer() to use.
Another is to update devaddr in XHCI address_device callback
function and invoke usb_hub_clear_tt_buffer() for halt processing.
 
Signed-off-by: Jim Lin <jilin@nvidia.com>

Jim Lin (2):
  usb: hub : Add devaddr in struct usb_device
  usb: xhci: Add Clear_TT_Buffer

 drivers/usb/core/hub.c       |  4 +++-
 drivers/usb/host/xhci-ring.c | 12 ++++++++++++
 drivers/usb/host/xhci.c      |  1 +
 include/linux/usb.h          |  2 ++
 4 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.1.4

