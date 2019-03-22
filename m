Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41EDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879EA2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254902;
	bh=RL5cmei/Z4IQv3iPhdrt9JaUSFgrYuRuuMz9n+Qnmck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mwnXiKg7r2zZpPNM1zxuykLugpsbn9Jx+ArtHO9ArASfEm1pTtAPyauTNKH+Nv2jX
	 18KL9H6pL8nbIT9QDSlJsWWmExjVjTNUDc5/ASFHG5UbzHGM2q0SBMEMxigxF7dQ77
	 IfQM8bo4a2e2pfYqMLMNu7e5nCqOQszmAYWJHmdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731443AbfCVLll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:41:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731421AbfCVLlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:41:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3006B2082C;
        Fri, 22 Mar 2019 11:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254896;
        bh=RL5cmei/Z4IQv3iPhdrt9JaUSFgrYuRuuMz9n+Qnmck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqWUkSn31eS4r/2aqJQsTQza50Vm68j7qS20t/c7Mfu662j57e0nLOmTDwz88A9ma
         c1s9g/50tOI2QVBq9aQFB+K4AQbLrv1937B24Z3p+6cPHgoAiZ3PwFQRG33HFke+Be
         xwWZxsXEWECbXZlD0AFLKwmjonsmBm3yltYLhlhM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 026/118] pinctrl: meson: meson8b: fix the sdxc_a data 1..3 pins
Date:   Fri, 22 Mar 2019 12:14:58 +0100
Message-Id: <20190322111217.901591820@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

[ Upstream commit c17abcfa93bf0be5e48bb011607d237ac2bfc839 ]

Fix the mismatch between the "sdxc_d13_1_a" pin group definition from
meson8b_cbus_groups and the entry in sdxc_a_groups ("sdxc_d0_13_1_a").
This makes it possible to use "sdxc_d13_1_a" in device-tree files to
route the MMC data 1..3 pins to GPIOX_1..3.

Fixes: 0fefcb6876d0d6 ("pinctrl: Add support for Meson8b")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/meson/pinctrl-meson8b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index cbe5f5cbddb8..e1b689f840ab 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -662,7 +662,7 @@ static const char * const sd_a_groups[] = {
 
 static const char * const sdxc_a_groups[] = {
 	"sdxc_d0_0_a", "sdxc_d13_0_a", "sdxc_d47_a", "sdxc_clk_a",
-	"sdxc_cmd_a", "sdxc_d0_1_a", "sdxc_d0_13_1_a"
+	"sdxc_cmd_a", "sdxc_d0_1_a", "sdxc_d13_1_a"
 };
 
 static const char * const pcm_a_groups[] = {
-- 
2.19.1



