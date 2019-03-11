Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD65C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF3A2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334811;
	bh=EpJP57YoT/YdMfcexnVjkst3eovynuTr87OP6EhcZH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=azPZQBEX6gC8SnkeYj/WWIU8hGmFdaVY8M4CGkhE61fNCU95iuLINSaJ5YyfsY9sE
	 YdLmPo78aI3zjC9SRcbmgImJy3BQpfTJ2DWcyN9xmX9AnD6Ci6aPTFPZW2tcrJWPBS
	 Yp0qvMdidSqlleYhXOiDkzXVMEKACIe6PNDPVNzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfCKUGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:06:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729192AbfCKT5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:57:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B2E92084F;
        Mon, 11 Mar 2019 19:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334268;
        bh=EpJP57YoT/YdMfcexnVjkst3eovynuTr87OP6EhcZH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PioG4zJffhXMExzhniEMkFHNYdpdIQRjA3DomgAClnJ9J9sYbwkImTOwdmUKponyy
         i2FaHH6PkX86on3NQrvWmlFj9wSlxRvq0iUR6nbfNMHYU7/IRvnATNn81m/JAp6K8U
         ccAleZJEob77do+jxRwHa8/R4zxOZgALx5dFhFoY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 25/44] Input: matrix_keypad - use flush_delayed_work()
Date:   Mon, 11 Mar 2019 15:56:41 -0400
Message-Id: <20190311195700.138462-25-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195700.138462-1-sashal@kernel.org>
References: <20190311195700.138462-1-sashal@kernel.org>
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
index 403452ef00e6..3d1cb7bf5e35 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -222,7 +222,7 @@ static void matrix_keypad_stop(struct input_dev *dev)
 	keypad->stopped = true;
 	spin_unlock_irq(&keypad->lock);
 
-	flush_work(&keypad->work.work);
+	flush_delayed_work(&keypad->work);
 	/*
 	 * matrix_keypad_scan() will leave IRQs enabled;
 	 * we should disable them now.
-- 
2.19.1

