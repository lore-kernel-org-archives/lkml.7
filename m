Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E7BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF3E2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504266;
	bh=fxeZbVkpq1WQ5KTii8YT5z9m75oqu4FMBQQXMZWQytg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jE/Fx17sxuoNzTCjrWxvFs9+iqRcoQEaTc3wI2hFjKlXJeljOzZ+m6afYT+nVtFDk
	 rTeiF+EuokXpBVEF/d97mnDXTNFUEP79MXUTS9DQFHIHbx/XGxVXElxCWRg3f4TjOm
	 XImZ5LXVhp9xJnyLdgwfY3GTa8snP8sG5g+JuHBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfCMTLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:11:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727284AbfCMTLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:11:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C1302173C;
        Wed, 13 Mar 2019 19:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504260;
        bh=fxeZbVkpq1WQ5KTii8YT5z9m75oqu4FMBQQXMZWQytg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FEeFals4Snjr87yMnFaPlSpgTxmkYIKdba8DOYM4K9v4kI9fktz88bpW7lCpZIbiG
         +mbCvSbZUiW96eW5Fhrgb1qEcHmDJgdCN4eZkFhdWEDJYwquuQZlidY8NXdVSQpuT5
         Yrjd2Rlg6wR8j6kP8z8F3Hy4eEp0zjMk53UUAoUo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Beniamino Galvani <bgalvani@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 18/60] qmi_wwan: apply SET_DTR quirk to Sierra WP7607
Date:   Wed, 13 Mar 2019 15:09:39 -0400
Message-Id: <20190313191021.158171-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
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
index 6e381354f658..74bebbdb4b15 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1208,8 +1208,8 @@ static const struct usb_device_id products[] = {
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

