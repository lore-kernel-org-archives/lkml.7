Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A692C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9882054F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569344602;
	bh=0KYDWk08WcsmjsqVyulm42NkijYLKrdWoD4u0javmU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HlfdfZiyDaCPPyYTMq1z8vzTTXytbY6Mj78N4RpcNgPa+CBiP2QfEzSGl61FOg1Fj
	 md7E2VihFu/tAj3IbJQwxKaZGUu6K7ciQXpZ3f6fIQYR1qxH018xMtl8vTHKlUPx1h
	 W6yywcLdSR4sVBai/ceFSa0/aBOa1aSaRyOK8VXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439332AbfIXRDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:03:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409776AbfIXQm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:42:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C57E921D7B;
        Tue, 24 Sep 2019 16:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343349;
        bh=0KYDWk08WcsmjsqVyulm42NkijYLKrdWoD4u0javmU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uUopF5swf1PRb3n/YYYdcyTaj4jutiDpwn0lsbVPKZKDdnwfKZBb4cvqywi8ONIAQ
         1RSrf4NyrUF3KkNaKewnrwVhtflJQb6XhRwzqSVpgaEK9PVOb2VdSOAOPwbuY3eISF
         O80UaZEAcZv5mULeFpZn05xmE+FXIQToKrm1UBYY=
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
Subject: [PATCH AUTOSEL 5.3 13/87] video: ssd1307fb: Start page range at page_offset
Date:   Tue, 24 Sep 2019 12:40:29 -0400
Message-Id: <20190924164144.25591-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164144.25591-1-sashal@kernel.org>
References: <20190924164144.25591-1-sashal@kernel.org>
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
index b674948e3bb8f..3f28e1b5d4221 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -432,7 +432,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 	if (ret < 0)
 		return ret;
 
-	ret = ssd1307fb_write_cmd(par->client, 0x0);
+	ret = ssd1307fb_write_cmd(par->client, par->page_offset);
 	if (ret < 0)
 		return ret;
 
-- 
2.20.1

