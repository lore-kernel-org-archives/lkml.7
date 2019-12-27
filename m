Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C49C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96111222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468716;
	bh=dFQraUQ897zd/9F+NFuGJy0G1y79+V4LN5u273fGebw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ltMEO41DXQB8zEGo3N1VRJwUXoxiOvoK1y2HpPBfYZjcwNJ/mG3df3XsA1YHrTpec
	 q96aq1FmtLj7Sfv/qf1L2rLdRY3ekRW8vxulWnm4ip5AFQQuOR2JGJmBPoV3TM7n3K
	 BQfnH1Z8bfBP/G5pRHN/YoF9H8FTprhmQiWAaE7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfL0RpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:45:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbfL0RpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:45:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3BF120740;
        Fri, 27 Dec 2019 17:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468707;
        bh=dFQraUQ897zd/9F+NFuGJy0G1y79+V4LN5u273fGebw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zs55DDTNhaNjiGdMV2L6HDSpn6XGuJhFqZON7pQ2S7oq7mR8dWkF0XmwElCNqpDmu
         QSmEPNPfDbgBtcIoZXvkpZfGyB9jKdwZ8JHA336ZbQGLRmOF6lxqZIPkkdCnlAIVpY
         C5kqdFafbqVqYq0i0NYMKPapFKau8eIDZEjCPTiY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Hebb <tommyhebb@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 63/84] kconfig: don't crash on NULL expressions in expr_eq()
Date:   Fri, 27 Dec 2019 12:43:31 -0500
Message-Id: <20191227174352.6264-63-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174352.6264-1-sashal@kernel.org>
References: <20191227174352.6264-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Hebb <tommyhebb@gmail.com>

[ Upstream commit 272a72103012862e3a24ea06635253ead0b6e808 ]

NULL expressions are taken to always be true, as implemented by the
expr_is_yes() macro and by several other functions in expr.c. As such,
they ought to be valid inputs to expr_eq(), which compares two
expressions.

Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kconfig/expr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/scripts/kconfig/expr.c b/scripts/kconfig/expr.c
index e1a39e90841d..7e38070ee523 100644
--- a/scripts/kconfig/expr.c
+++ b/scripts/kconfig/expr.c
@@ -252,6 +252,13 @@ static int expr_eq(struct expr *e1, struct expr *e2)
 {
 	int res, old_count;
 
+	/*
+	 * A NULL expr is taken to be yes, but there's also a different way to
+	 * represent yes. expr_is_yes() checks for either representation.
+	 */
+	if (!e1 || !e2)
+		return expr_is_yes(e1) && expr_is_yes(e2);
+
 	if (e1->type != e2->type)
 		return 0;
 	switch (e1->type) {
-- 
2.20.1

