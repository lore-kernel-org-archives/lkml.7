Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B29C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2A323B08
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ScDsWpp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfE2Ozz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:55:55 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4363 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfE2Ozz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:55:55 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cee9d710000>; Wed, 29 May 2019 07:55:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 29 May 2019 07:55:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 29 May 2019 07:55:54 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 May
 2019 14:55:54 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 May
 2019 14:55:54 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 29 May 2019 14:55:54 +0000
Received: from jilin-desktop.nvidia.com (Not Verified[10.19.120.158]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cee9d780000>; Wed, 29 May 2019 07:55:53 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>, <kai.heng.feng@canonical.com>,
        <drinkcat@chromium.org>, <Thinh.Nguyen@synopsys.com>,
        <nsaenzjulienne@suse.de>, <jflat@chromium.org>, <malat@debian.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jim Lin <jilin@nvidia.com>
Subject: [PATCH v11 0/2] usb: xhci: Add Clear_TT_Buffer
Date:   Wed, 29 May 2019 22:55:47 +0800
Message-ID: <1559141749-5159-1-git-send-email-jilin@nvidia.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559141745; bh=9P1Kz4O/jSg8ZsRPR4q5epOTj+e9MWcHICCyeQn5/x0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=ScDsWpp7QSegG36TJT3nabvv1K4yabITtxhAQrfO/5CDeNAnMITOMAOD65J3cO2ft
         igJguqhsleFMyhNGe7isMeRJ1WAdAQ1UzV8FpR46+m1mS0GBnDGwe4E+Ymf7Jt14Kc
         K1wC1jut8D2jHuchotXXu6XkJZkBlzucHL0flS64YFhpuK2mjITC24OBkl0SQth2wo
         gonOSvHnxqajmIBVlmT9G8EXPw4Uz+KIKBi7pmTiAyRNa5k4psxri3ZtERifsAH4Ai
         /Wk0RyGYup75HzuZSGDESh4KPL4rUFYSMeGqql1qakgmG+88Pu29S/DNJBv93ormMC
         6/eAkx8CeLeVA==
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
Another is to invoke usb_hub_clear_tt_buffer() for halt processing.
 
Signed-off-by: Jim Lin <jilin@nvidia.com>

Jim Lin (2):
  usb: Add devaddr in struct usb_device
  usb: xhci: Add Clear_TT_Buffer

 drivers/usb/core/hub.c       |  4 +++-
 drivers/usb/host/xhci-ring.c | 27 ++++++++++++++++++++++++++-
 drivers/usb/host/xhci.c      | 23 +++++++++++++++++++++++
 drivers/usb/host/xhci.h      |  5 +++++
 include/linux/usb.h          |  2 ++
 5 files changed, 59 insertions(+), 2 deletions(-)

-- 
2.1.4

