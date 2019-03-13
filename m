Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DE8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5459C2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505102;
	bh=z26y/te+YpcSnr78TbAigh0Ivx7a9lTE+DPUVlFfk20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vXAyD9ZWY3EESM7XweCH/+LXrhcFFqkg/D0bosKQocwTass0cIbHgrmnPPKuopvQx
	 wJkWHohXZehIKobf6W2YuAhPIxjQjM0Eb814b96GY2GpwxyOeDj4F60tjercZdVSwF
	 KfxeLoyC3TSXctcoTk3djTBrZdNJZPsMgsVX7OHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbfCMTPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728047AbfCMTPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:15:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35B99217F5;
        Wed, 13 Mar 2019 19:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504544;
        bh=z26y/te+YpcSnr78TbAigh0Ivx7a9lTE+DPUVlFfk20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RYDIOEg5xSLzBL7uclzImADFHzshjGpZY86X3Eqt5QWFAIXEwKQXQkM+Dp6P0IGz4
         dCPWcssoPKPBmrTo3VIo6am0bqBL/F40m2HQxToXwz4XytmNxV46bluNUeOhfBVnQb
         rX2FBvsBhVo6xZjcF4WeZoHvMRp8ir7/uk1x0xks=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Beniamino Galvani <bgalvani@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 12/33] qmi_wwan: apply SET_DTR quirk to Sierra WP7607
Date:   Wed, 13 Mar 2019 15:14:45 -0400
Message-Id: <20190313191506.159677-12-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191506.159677-1-sashal@kernel.org>
References: <20190313191506.159677-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beniamino Galvani <bgalvani@redhat.com>

[ Upstream commit 97dc47a1308a3af46a09b1546cfb869f2e382a81 ]

The 1199:68C0 USB ID is reused by Sierra WP7607 which requires the DTR
quirk to be detected. Apply QMI_QUIRK_SET_DTR unconditionally as
already done for other IDs shared between different devices.

Signed-off-by: Beniamino Galvani <bgalvani@redhat.com>
Acked-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/qmi_wwan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 25204d2c9e89..65e47cc52d14 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1193,8 +1193,8 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x114f, 0x68a2, 8)},    /* Sierra Wireless MC7750 */
 	{QMI_FIXED_INTF(0x1199, 0x68a2, 8)},	/* Sierra Wireless MC7710 in QMI mode */
 	{QMI_FIXED_INTF(0x1199, 0x68a2, 19)},	/* Sierra Wireless MC7710 in QMI mode */
-	{QMI_FIXED_INTF(0x1199, 0x68c0, 8)},	/* Sierra Wireless MC7304/MC7354 */
-	{QMI_FIXED_INTF(0x1199, 0x68c0, 10)},	/* Sierra Wireless MC7304/MC7354 */
+	{QMI_QUIRK_SET_DTR(0x1199, 0x68c0, 8)},	/* Sierra Wireless MC7304/MC7354, WP76xx */
+	{QMI_QUIRK_SET_DTR(0x1199, 0x68c0, 10)},/* Sierra Wireless MC7304/MC7354 */
 	{QMI_FIXED_INTF(0x1199, 0x901c, 8)},    /* Sierra Wireless EM7700 */
 	{QMI_FIXED_INTF(0x1199, 0x901f, 8)},    /* Sierra Wireless EM7355 */
 	{QMI_FIXED_INTF(0x1199, 0x9041, 8)},	/* Sierra Wireless MC7305/MC7355 */
-- 
2.19.1

