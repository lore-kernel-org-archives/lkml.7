Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D6EC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03DD622DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566308552;
	bh=xkOguyIoW1yOha86Xsi1iAhd5p+3H7N1VkEgoBiJRSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X5q6DGiolUWmB3xhZgUOr17hom9wWwJ7Dt3176FStIEac2xmE54HfPMj9LO43H+fr
	 4pQv1Xs0NR8H5P5ilxb+X6nq0dxWPkEv8Bs5T7gFztTfJMXqPSlfDgnJiP8LyRhplA
	 vodD7MSNFtqt8WvoUc8MJ5VWYEPwYgdp120Bs+UY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfHTNma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 09:42:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730629AbfHTNm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:42:28 -0400
Received: from sasha-vm.mshome.net (unknown [12.236.144.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DB09233A0;
        Tue, 20 Aug 2019 13:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566308547;
        bh=xkOguyIoW1yOha86Xsi1iAhd5p+3H7N1VkEgoBiJRSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XIYFQ0gfpwCN6b1h7o3HdaQzwkYviH2AJtslyt8RNHc7i9MEGgsZ4chjm8SGw1AdT
         cK0kD9VQWneq88FePpBOqbznSF68qA6E0pxK3pZE6+q3K3db+1pUB9R7BzQ7xulZoH
         PZ5p8gPAr1/UBOd+VtAAxtALB09kYKrywXFKda6w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     zhengbin <zhengbin13@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 14/27] auxdisplay: panel: need to delete scan_timer when misc_register fails in panel_attach
Date:   Tue, 20 Aug 2019 09:42:00 -0400
Message-Id: <20190820134213.11279-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190820134213.11279-1-sashal@kernel.org>
References: <20190820134213.11279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhengbin <zhengbin13@huawei.com>

[ Upstream commit b33d567560c1aadf3033290d74d4fd67af47aa61 ]

In panel_attach, if misc_register fails, we need to delete scan_timer,
which was setup in keypad_init->init_scan_timer.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/auxdisplay/panel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 3b25a643058c9..0b8e2a7d6e934 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -1618,6 +1618,8 @@ static void panel_attach(struct parport *port)
 	return;
 
 err_lcd_unreg:
+	if (scan_timer.function)
+		del_timer_sync(&scan_timer);
 	if (lcd.enabled)
 		charlcd_unregister(lcd.charlcd);
 err_unreg_device:
-- 
2.20.1

