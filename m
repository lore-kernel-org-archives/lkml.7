Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE7BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAEE20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139660;
	bh=I2YXyW3xudM/S0rpg7oaGCBz6lJqr95ls3mUaCi7Mas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fZ7zX64qOWlpVJZr3HildtEaXFNRxuqQAFhC0wTFefZjoObgHQ9hJbEEiiB9/aiKD
	 YQoLfYAWlcSXnR5bF12aM14Ep8dnOSB+ebcDOjI6azhI54ANlbnxz773d7ZHoMopbE
	 wt1nkm0oN+F1pTsokZrjDOTIYJ+S6ZJuJQwnChLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbfDAR1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:32850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732681AbfDAR1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:27:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9058F2063F;
        Mon,  1 Apr 2019 17:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139652;
        bh=I2YXyW3xudM/S0rpg7oaGCBz6lJqr95ls3mUaCi7Mas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oILCHVwaq70FNSAvGnThu263oHwzLEDHvfIMIGclAf2A9SmTms/JCtWjVQux8pBuo
         dk1iMKsh253pxvBIHe2odqFVdHE6urL+1dnugupxZihCw+6yWYKnNBZC+XGkDDSlwt
         eMU8c0i0NhyhKZ+0GtvOLzSKb8gT3QMbhN4y2izs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Roman Kiryanov <rkir@google.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 03/56] video: fbdev: Set pixclock = 0 in goldfishfb
Date:   Mon,  1 Apr 2019 19:02:19 +0200
Message-Id: <20190401170103.630315574@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ace6033ec5c356615eaa3582fb1946e9eaff6662 ]

User space Android code identifies pixclock == 0 as a sign for emulation
and will set the frame rate to 60 fps when reading this value, which is
the desired outcome.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Roman Kiryanov <rkir@google.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/goldfishfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -234,7 +234,7 @@ static int goldfish_fb_probe(struct plat
 	fb->fb.var.activate	= FB_ACTIVATE_NOW;
 	fb->fb.var.height	= readl(fb->reg_base + FB_GET_PHYS_HEIGHT);
 	fb->fb.var.width	= readl(fb->reg_base + FB_GET_PHYS_WIDTH);
-	fb->fb.var.pixclock	= 10000;
+	fb->fb.var.pixclock	= 0;
 
 	fb->fb.var.red.offset = 11;
 	fb->fb.var.red.length = 5;


