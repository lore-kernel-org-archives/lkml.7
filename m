Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4283EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066842087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334368;
	bh=u7tdxveZIEC3AEQvWptyY1Uik45qna8CWEXHEfl0Ntw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M8ZJF6amMO8YVaoAllGjp+uUtrZmANYH3ovFy5AjEutm7uGPd2EwYfVF+5vT85YS+
	 xq2DiXANWsh2b37Rv3/GYilXpmM10IakF6S4eCWTKv4U+k5bhz8Yxd1jG3jZ0Gc9T1
	 L7ELZpN3UmFmOnlxWGRtTSYzW32QHActFWGJwfLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfCKT70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729607AbfCKT7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:59:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA0072064A;
        Mon, 11 Mar 2019 19:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334363;
        bh=u7tdxveZIEC3AEQvWptyY1Uik45qna8CWEXHEfl0Ntw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eB33/q7Assh0SkPnlwXDs9dxqvV3BB/r64kHJwzVKlNkwW8SUvT2QGEr6D06H/QHa
         dhHuGLRTzecpWFv8XZ+6dZsHQ2sg/3LznIjjjGS7PhQtUFDL7gQ46zJJaDdGBWFdpv
         kQJHURpGljwLDnXoAgM7MBg6HfMyUKTFDsKSGUzM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 06/12] Input: matrix_keypad - use flush_delayed_work()
Date:   Mon, 11 Mar 2019 15:59:06 -0400
Message-Id: <20190311195912.139410-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195912.139410-1-sashal@kernel.org>
References: <20190311195912.139410-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit a342083abe576db43594a32d458a61fa81f7cb32 ]

We should be using flush_delayed_work() instead of flush_work() in
matrix_keypad_stop() to ensure that we are not missing work that is
scheduled but not yet put in the workqueue (i.e. its delay timer has not
expired yet).

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/matrix_keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index c64d87442a62..2e12e31f45c5 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -220,7 +220,7 @@ static void matrix_keypad_stop(struct input_dev *dev)
 	keypad->stopped = true;
 	spin_unlock_irq(&keypad->lock);
 
-	flush_work(&keypad->work.work);
+	flush_delayed_work(&keypad->work);
 	/*
 	 * matrix_keypad_scan() will leave IRQs enabled;
 	 * we should disable them now.
-- 
2.19.1

