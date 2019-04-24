Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FA3C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220DB218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116431;
	bh=uCby67JLHpu/Em2Ve4gpxb/keNXhbegp/ApeEr97MFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rGTqnNYOoM0Fy0MvDsx67ob2uurYlQDAdgvXqI/Imq9XOHINP2p+WqRn+LB16htaT
	 HqK1TwXSc4QOQFDYMoqgCq4MFndS05FatiM1wGtG+Ey3G6SmY1SZ3TuFYd60kwYpx4
	 mAiIksMdtH1jCWP93kA1+gOw7VUtuLhxa/wzhXzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbfDXOdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfDXOds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:33:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC7A7218FD;
        Wed, 24 Apr 2019 14:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116427;
        bh=uCby67JLHpu/Em2Ve4gpxb/keNXhbegp/ApeEr97MFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RO8fiVIgF9OjkVIPkgyVHsNa4Qjj7CPXtXt2Gya2Zik3aCCK7ooAxotDhUemQzUAt
         HJ4A2crbNiovrn8rU4VlP3NqPNVBK8H6lH435NaLMI72cYorjsEs/QM0wTNjQu78+x
         ge5XNEnRWQDrxn+gZXS/7jMqeC6hKLKukk5LxhBY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 02/66] HID: Increase maximum report size allowed by hid_field_extract()
Date:   Wed, 24 Apr 2019 10:32:36 -0400
Message-Id: <20190424143341.27665-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 94a9992f7dbdfb28976b565af220e0c4a117144a ]

Commit 71f6fa90a353 ("HID: increase maximum global item tag report size
to 256") increases the max report size from 128 to 256.

We also need to update the report size in hid_field_extract() otherwise
it complains and truncates now valid report size:
[ 406.165461] hid-sensor-hub 001F:8086:22D8.0002: hid_field_extract() called with n (192) > 32! (kworker/5:1)

BugLink: https://bugs.launchpad.net/bugs/1818547
Fixes: 71f6fa90a353 ("HID: increase maximum global item tag report size to 256")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
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
2.19.1

