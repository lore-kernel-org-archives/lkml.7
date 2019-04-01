Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B9EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD4A20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140036;
	bh=Ms/lpI9HgRKAcuDYTMV2cJZtyBEBxqPKWhuXNZGICVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O92ODRxFdI4EqdWFLq50XpRL1HLUxtAwCwwqhavVbKxzqFnm7JnbsPXIhSr+wV2hu
	 uiclZqWvDKRWe6FtCjTZEqHaYhPAqApFbFd8k87wqeFFfzX3IeJG2O4SQSPughznOn
	 KW7d9Qvmr3SzhiMfdTWakqBGpmlPE56agKFqVyeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387679AbfDARdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:33:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387670AbfDARdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:33:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CEB820856;
        Mon,  1 Apr 2019 17:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140030;
        bh=Ms/lpI9HgRKAcuDYTMV2cJZtyBEBxqPKWhuXNZGICVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DVH04AH1qgdVkyzt/9hnPtw1Uurt4YrL8hwRISpxv1KGJMEKvMZoi00PElqArixji
         GnNKUAO0d7hx0PPX4lAsn4CpWnhiVaWs7/ktUJw4hudr+6mTxILyUv00U2sQUxOLXP
         vBmYeFmfJGbgdXmOYA/Cwf3r30RFMnNKXpdLb4Ww=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Pitre <nico@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 048/131] hid-sensor-hub.c: fix wrong do_div() usage
Date:   Mon,  1 Apr 2019 19:01:58 +0200
Message-Id: <20190401170056.328720780@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8d43b49e7e0070f96ac46d30659a336c0224fa0b ]

do_div() must only be used with a u64 dividend.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-sensor-hub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 92870cdb52d9..8efaa88329aa 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -218,7 +218,8 @@ int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 		goto done_proc;
 	}
 
-	remaining_bytes = do_div(buffer_size, sizeof(__s32));
+	remaining_bytes = buffer_size % sizeof(__s32);
+	buffer_size = buffer_size / sizeof(__s32);
 	if (buffer_size) {
 		for (i = 0; i < buffer_size; ++i) {
 			hid_set_field(report->field[field_index], i,
-- 
2.19.1



