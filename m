Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBE7C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE65C222C8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 16:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569344066;
	bh=kLpdyiyaKSkUkZH7ucq8Vfr+n9PdgsA9ejhy5q8h7sA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=vpSngROk3o9Ukf1frrHVFp9xAEwkiTx6Z2GdGxvZZatUmbfFBtfj8iKTd5X3Tic8w
	 uXbKqYZsdWg6OowOWwFxo6ULPD1DLW9faHo7EDUr5/zgnzrFDtXPkyRMuyOjc8S+yB
	 F04vrPSbMTfwqyX1859RQg743bpRwEyDrZ0osOdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfIXQyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 12:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441631AbfIXQwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:52:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF233217D9;
        Tue, 24 Sep 2019 16:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343937;
        bh=kLpdyiyaKSkUkZH7ucq8Vfr+n9PdgsA9ejhy5q8h7sA=;
        h=From:To:Cc:Subject:Date:From;
        b=ZhlMhWi5DRpUkZx2gw2YCuntEkBFmq6i23mgMmjImaRzm1TJeEScNOaSpn7DR+5HB
         3C91kL6eq6DAy3RszKtrsSIjOBYaQG9Dfs4Yy9TAJ90l4v+MGGtRA8HztJXGFkQUT5
         VSJ2JBZhFvy6Gm55heRkGeYtOnOBjGpztA5wlFVM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marko Kohtala <marko.kohtala@okoko.fi>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 01/14] video: ssd1307fb: Start page range at page_offset
Date:   Tue, 24 Sep 2019 12:51:59 -0400
Message-Id: <20190924165214.28857-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marko Kohtala <marko.kohtala@okoko.fi>

[ Upstream commit dd9782834dd9dde3624ff1acea8859f3d3e792d4 ]

The page_offset was only applied to the end of the page range. This caused
the display updates to cause a scrolling effect on the display because the
amount of data written to the display did not match the range display
expected.

Fixes: 301bc0675b67 ("video: ssd1307fb: Make use of horizontal addressing mode")
Signed-off-by: Marko Kohtala <marko.kohtala@okoko.fi>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>
Cc: Michal Vokáč <michal.vokac@ysoft.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190618074111.9309-4-marko.kohtala@okoko.fi
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/ssd1307fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index fa3480815cdb6..88e0763edcc72 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -421,7 +421,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 	if (ret < 0)
 		return ret;
 
-	ret = ssd1307fb_write_cmd(par->client, 0x0);
+	ret = ssd1307fb_write_cmd(par->client, par->page_offset);
 	if (ret < 0)
 		return ret;
 
-- 
2.20.1

