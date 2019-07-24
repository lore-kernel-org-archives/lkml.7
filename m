Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6E8C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D8622ADB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 14:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="SX2ut3mI";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="SX2ut3mI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbfGXOwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 10:52:39 -0400
Received: from node.akkea.ca ([192.155.83.177]:58500 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfGXOwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 10:52:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 75C354E200E;
        Wed, 24 Jul 2019 14:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1563979956; bh=W426McEeRu00NL6SGbRAa/sPcq/i1n5Nzqqz+qZ1PyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SX2ut3mIwIFnpXFTyiwY0Y3apXdfbq/oGUfh/jRvRAOvUS0VGV9EbljAkx9p8gaRw
         uq4JUq71eUulQiQMS91or+H8C7IW7cpANqZ6DGWK0k5u4CwvbEQKavqN/p4oGt1Lpd
         W4iJsJYNka2y0faW3cvpIGrLl1MLRneQVgsj6xHY=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NUn_LOvSUZ8f; Wed, 24 Jul 2019 14:52:36 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id D15054E2003;
        Wed, 24 Jul 2019 14:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1563979956; bh=W426McEeRu00NL6SGbRAa/sPcq/i1n5Nzqqz+qZ1PyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SX2ut3mIwIFnpXFTyiwY0Y3apXdfbq/oGUfh/jRvRAOvUS0VGV9EbljAkx9p8gaRw
         uq4JUq71eUulQiQMS91or+H8C7IW7cpANqZ6DGWK0k5u4CwvbEQKavqN/p4oGt1Lpd
         W4iJsJYNka2y0faW3cvpIGrLl1MLRneQVgsj6xHY=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     kernel@puri.sm
Cc:     =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bob Ham <bob.ham@puri.sm>,
        Angus Ainslie <angus@akkea.ca>
Subject: [PATCH 2/2] net: usb: qmi_wwan: Add the BroadMobi BM818 card
Date:   Wed, 24 Jul 2019 07:52:27 -0700
Message-Id: <20190724145227.27169-3-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190724145227.27169-1-angus@akkea.ca>
References: <20190724145227.27169-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Ham <bob.ham@puri.sm>

The BroadMobi BM818 M.2 card uses the QMI protocol

Signed-off-by: Bob Ham <bob.ham@puri.sm>
Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/net/usb/qmi_wwan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 69e0a2acfcb0..b6dc5d714b5e 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1295,6 +1295,7 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x2001, 0x7e3d, 4)},	/* D-Link DWM-222 A2 */
 	{QMI_FIXED_INTF(0x2020, 0x2031, 4)},	/* Olicard 600 */
 	{QMI_FIXED_INTF(0x2020, 0x2033, 4)},	/* BroadMobi BM806U */
+	{QMI_FIXED_INTF(0x2020, 0x2060, 4)},	/* BroadMobi BM818 */
 	{QMI_FIXED_INTF(0x0f3d, 0x68a2, 8)},    /* Sierra Wireless MC7700 */
 	{QMI_FIXED_INTF(0x114f, 0x68a2, 8)},    /* Sierra Wireless MC7750 */
 	{QMI_FIXED_INTF(0x1199, 0x68a2, 8)},	/* Sierra Wireless MC7710 in QMI mode */
-- 
2.17.1

