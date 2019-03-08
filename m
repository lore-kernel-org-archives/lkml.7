Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A5AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 05:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866CE20684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 05:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfCHFL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 00:11:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35609 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfCHFL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 00:11:26 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1h27mz-0001VB-IU; Fri, 08 Mar 2019 05:11:22 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] HID: Increase maximum report size allowed by hid_field_extract()
Date:   Fri,  8 Mar 2019 13:11:17 +0800
Message-Id: <20190308051117.21899-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 71f6fa90a353 ("HID: increase maximum global item tag report size
to 256") increases the max report size from 128 to 256.

We also need to update the report size in hid_field_extract() otherwise
it complains and truncates now valid report size:
[ 406.165461] hid-sensor-hub 001F:8086:22D8.0002: hid_field_extract() called with n (192) > 32! (kworker/5:1)

BugLink: https://bugs.launchpad.net/bugs/1818547
Fixes: 71f6fa90a353 ("HID: increase maximum global item tag report size to 256")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/hid/hid-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 9993b692598f..860e21ec6a49 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1301,10 +1301,10 @@ static u32 __extract(u8 *report, unsigned offset, int n)
 u32 hid_field_extract(const struct hid_device *hid, u8 *report,
 			unsigned offset, unsigned n)
 {
-	if (n > 32) {
-		hid_warn(hid, "hid_field_extract() called with n (%d) > 32! (%s)\n",
+	if (n > 256) {
+		hid_warn(hid, "hid_field_extract() called with n (%d) > 256! (%s)\n",
 			 n, current->comm);
-		n = 32;
+		n = 256;
 	}
 
 	return __extract(report, offset, n);
-- 
2.17.1

