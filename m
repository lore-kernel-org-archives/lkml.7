Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C155C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2CC2054F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570120242;
	bh=rpLu/oS3jQttqG3AiJBi6ubdqtvP3hbrdcN6X/C/dR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MCbnXoyFs1cYnoX7MgH66/ekBWDPL4t+mLRyFjM31OC4pUXgkZ+dvPoevpzjiRm1i
	 BmRNAEwR7StHy3o9PmZ3qnflFpIyRbnhwhxzGz+VU6+WwUPRL6THLfK6vE28VKCNwm
	 XSQH/+3XLLf/UZ3xCYLgNAWzTuSrjDUIGLhisgZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391783AbfJCQal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:30:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391773AbfJCQag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:30:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64D522054F;
        Thu,  3 Oct 2019 16:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570120235;
        bh=rpLu/oS3jQttqG3AiJBi6ubdqtvP3hbrdcN6X/C/dR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=11+90N1uG7Ru377jQqtqaP3p8NlfF7xp1m+MFUZBK+wJxZPQt9sS1XWfyfpH3g3mm
         IcVHZR4rmKLkHTjHAG0JN2AnXsQCgB26TccKgliYpcQUyYiQJDWNwSqmngBLKwDBlh
         1lwjfof+r135SbuFsWlaZ7D4KuCCBTQyfsgYnVwI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 120/313] led: triggers: Fix a memory leak bug
Date:   Thu,  3 Oct 2019 17:51:38 +0200
Message-Id: <20191003154544.782495162@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154533.590915454@linuxfoundation.org>
References: <20191003154533.590915454@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit 60e2dde1e91ae0addb21ac380cc36ebee7534e49 ]

In led_trigger_set(), 'event' is allocated in kasprintf(). However, it is
not deallocated in the following execution if the label 'err_activate' or
'err_add_groups' is entered, leading to memory leaks. To fix this issue,
free 'event' before returning the error.

Fixes: 52c47742f79d ("leds: triggers: send uevent when changing triggers")
Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/leds/led-triggers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index 8d11a5e232271..eff1bda8b5200 100644
--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -173,6 +173,7 @@ int led_trigger_set(struct led_classdev *led_cdev, struct led_trigger *trig)
 	list_del(&led_cdev->trig_list);
 	write_unlock_irqrestore(&led_cdev->trigger->leddev_list_lock, flags);
 	led_set_brightness(led_cdev, LED_OFF);
+	kfree(event);
 
 	return ret;
 }
-- 
2.20.1



