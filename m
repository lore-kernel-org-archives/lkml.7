Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393F6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CAF2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393302AbfHWIxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:53:35 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40110 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389120AbfHWIxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:53:33 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x7N8rO5h020359, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x7N8rO5h020359
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 23 Aug 2019 16:53:24 +0800
Received: from fc30.localdomain (172.21.177.138) by RTITCASV01.realtek.com.tw
 (172.21.6.18) with Microsoft SMTP Server id 14.3.468.0; Fri, 23 Aug 2019
 16:53:22 +0800
From:   Hayes Wang <hayeswang@realtek.com>
To:     <netdev@vger.kernel.org>
CC:     <nic_swsd@realtek.com>, <linux-kernel@vger.kernel.org>,
        <jslaby@suse.cz>, Hayes Wang <hayeswang@realtek.com>
Subject: [PATCH net 0/2] r8152: fix side effect
Date:   Fri, 23 Aug 2019 16:53:00 +0800
Message-ID: <1394712342-15778-314-Taiwan-albertk@realtek.com>
X-Mailer: Microsoft Office Outlook 11
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.177.138]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 0ee1f4734967 ("r8152: napi hangup fix after disconnect")
add a check to avoid using napi_disable after netif_napi_del. However,
the commit ffa9fec30ca0 ("r8152: set RTL8152_UNPLUG only for real
disconnection") let the check useless.

Therefore, I revert commit 0ee1f4734967 ("r8152: napi hangup fix
after disconnect") first, and add another patch to fix it.

Hayes Wang (2):
  Revert "r8152: napi hangup fix after disconnect"
  r8152: avoid using napi_disable after netif_napi_del.

 drivers/net/usb/r8152.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.21.0

