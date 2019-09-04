Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362EEC3A5AA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09145208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620731;
	bh=koAIJkUdUSSuqVjfYC76UrPAJthYulamgGKUFle+VMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QuaVx2zOGI3fPxO1BblYR7Db4QaL6/BIwbyvT508gkBof4xSSSWX/PO9+QpnrSQnq
	 T++6rBPdMNkhXNzXzeUuE94Mvgj8a+sBaPZgvHYB3jGDMwoxUicJn4aoIfeeZciitR
	 p5cwUthHvyD5FeHj5qGOqzi4/zwcHIHVlmvRZBwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390447AbfIDSMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:12:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731429AbfIDSMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:12:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C56C2087E;
        Wed,  4 Sep 2019 18:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620728;
        bh=koAIJkUdUSSuqVjfYC76UrPAJthYulamgGKUFle+VMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KbjHXUjWCGI4M3fHvd4A4kBSgYhUHFXpremCSCoN8wf5DkC6fG3Y1nihw/NyOhfM/
         tctQdmto+k5ljMVn29XDIu1/ZUKsTdIiHfzCzuCvGYg/JFEk1msKKCFss8kP6qI/SC
         z4WtkDyDsc1LFZFHWHvY5tHXlxzQ0mgqO6yVXfxc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@archlinux.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 074/143] HID: logitech-hidpp: remove support for the G700 over USB
Date:   Wed,  4 Sep 2019 19:53:37 +0200
Message-Id: <20190904175316.949077684@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a3384b8d9f63cc042711293bb97bdc92dca0391d ]

The G700 suffers from the same issue than the G502:
when plugging it in, the driver tries to contact it but it fails.

This timeout is problematic as it introduce a delay in the boot,
and having only the mouse event node means that the hardware
macros keys can not be relayed to the userspace.

Link: https://github.com/libratbag/libratbag/issues/797
Fixes: 91cf9a98ae41 ("HID: logitech-hidpp: make .probe usbhid capable")
Cc: stable@vger.kernel.org # v5.2
Reviewed-by: Filipe Laíns <lains@archlinux.org>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-logitech-hidpp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 34e2b3f9d540d..4effce12607b0 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3769,8 +3769,6 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC332) },
 	{ /* Logitech G502 Hero Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC08B) },
-	{ /* Logitech G700 Gaming Mouse over USB */
-	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC06B) },
 	{ /* Logitech G700s Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC07C) },
 	{ /* Logitech G703 Gaming Mouse over USB */
-- 
2.20.1



