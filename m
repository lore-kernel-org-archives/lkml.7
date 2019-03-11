Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AE3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E209D2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334605;
	bh=jjmgwTV3pVQtY4uvk5kwsUgFdYYYHBN8EYFFBi9A2jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tyj6hJp/bzwgTPrxMvNSV5QPl+j554NLr5cjEZuGKGZ/QwHZ+sl6GbaM87GlrVrMx
	 WCtJlZXmprDEQAv0MQwFV5M2z92olNweqb/l2g0OqrZDgWCwt9d/7MH4GLqXQUROel
	 oWChx+hRZN/mo+K7EhBcAHtqaZT4MAt7SJgmHgnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbfCKUDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:03:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729445AbfCKT6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:58:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD33F2084F;
        Mon, 11 Mar 2019 19:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334328;
        bh=jjmgwTV3pVQtY4uvk5kwsUgFdYYYHBN8EYFFBi9A2jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ae9ikXZtkTEMTiLsbqXXLw9UmlkCx8NY5p6cqGP2z/lkp8m91l+w6wJhLMPVuUDyE
         Jz+gHk/jcRY2lPi7G7X3WARW1fxjwuvJ0DUFPoMJt8YcIj1imE+ysew+H6cY6khdyc
         2e9jG3rxOpl+F+6oh2KOWG+Bd2zaRxOOyS2F737Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 15/27] Input: matrix_keypad - use flush_delayed_work()
Date:   Mon, 11 Mar 2019 15:58:12 -0400
Message-Id: <20190311195824.139043-15-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195824.139043-1-sashal@kernel.org>
References: <20190311195824.139043-1-sashal@kernel.org>
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
index 782dda68d93a..c04559a232f7 100644
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

