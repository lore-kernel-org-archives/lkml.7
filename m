Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C22C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 03:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDFB2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 03:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfHMDmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 23:42:38 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39389 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfHMDmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 23:42:37 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x7D3gYlt011959, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x7D3gYlt011959
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 13 Aug 2019 11:42:34 +0800
Received: from fc30.localdomain (172.21.177.138) by RTITCASV01.realtek.com.tw
 (172.21.6.18) with Microsoft SMTP Server id 14.3.468.0; Tue, 13 Aug 2019
 11:42:33 +0800
From:   Hayes Wang <hayeswang@realtek.com>
To:     <netdev@vger.kernel.org>
CC:     <nic_swsd@realtek.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Hayes Wang <hayeswang@realtek.com>
Subject: [PATCH net-next v2 0/5] r8152: RX improve
Date:   Tue, 13 Aug 2019 11:42:04 +0800
Message-ID: <1394712342-15778-295-albertk@realtek.com>
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <1394712342-15778-289-Taiwan-albertk@realtek.com>
References: <1394712342-15778-289-Taiwan-albertk@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.177.138]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
For patch #2, replace list_for_each_safe with list_for_each_entry_safe.
Remove unlikely in WARN_ON. Adjust the coding style.

For patch #4, replace list_for_each_safe with list_for_each_entry_safe.
Remove "else" after "continue".

For patch #5. replace sysfs with ethtool to modify rx_copybreak and
rx_pending.

v1:
The different chips use different rx buffer size.

Use skb_add_rx_frag() to reduce memory copy for RX.

Hayes Wang (5):
  r8152: separate the rx buffer size
  r8152: replace array with linking list for rx information
  r8152: use alloc_pages for rx buffer
  r8152: support skb_add_rx_frag
  r8152: change rx_copybreak and rx_pending through ethtool

 drivers/net/usb/r8152.c | 374 ++++++++++++++++++++++++++++++++--------
 1 file changed, 304 insertions(+), 70 deletions(-)

-- 
2.21.0

