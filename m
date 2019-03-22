Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A010C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB352075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255226;
	bh=p0PByOu6X9QMGXZImOqpDd5LVUwwgN5duWIXw7bxqrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A4nWMNq+5I48VTMixEPPmEnTt7cAaNzQ/fAmBHI4D2ABr6LVlIBhV+Dj/g/AWo4H9
	 L0pNBrI/VzyrDlg+hhcsqF8auafhRKAQV3qZvYbSruS0XVuM9ZO5L8YSxPWMqlwnL5
	 fMM6D7fjxH7cmvQBx9WCQ3X7rj2C6eqleT97TnjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbfCVLrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:47:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbfCVLrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:47:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98AC82075E;
        Fri, 22 Mar 2019 11:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255223;
        bh=p0PByOu6X9QMGXZImOqpDd5LVUwwgN5duWIXw7bxqrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JCLKs8KbLHT9apYvR5Rf3C7H6xdiaHbFf1v0T5JM5G8tjvR3TltHnz3aJzAP2z4NU
         g6MY5i90dz6uoRfSbqb72G7Vcoyo+tjZNzNHit7mJPQTuCK4VxnoPtYjyUBfynS6HU
         NF1+u0c0zqOSBX+CQ9NFK6yJtrx2AQQsLEgItFyk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 024/183] Input: matrix_keypad - use flush_delayed_work()
Date:   Fri, 22 Mar 2019 12:14:12 +0100
Message-Id: <20190322111243.499474206@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



