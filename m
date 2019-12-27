Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9A8C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5217420722
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577470583;
	bh=CML4ynmYXN0xB1zt3WrGElGGQONxilXaUfFuXX/uags=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M4vrdw2/P4jdUadE/Ab7x8uMCNPeqEMwPtUUDi3eNsN29PKMCsuCtgTC6eNn7ldcm
	 ikb1lfnooLRKtRTr2yMtWF/llap+Tjth8iwwkrWN/HQL67cawtHQ3I9r7ikSFZuhpy
	 XiPJYupuvqpvZJSlnv/8Qwt8JOKeo3iOE/en31mU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfL0SQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:16:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbfL0SQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 13:16:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8DE421582;
        Fri, 27 Dec 2019 18:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577470572;
        bh=CML4ynmYXN0xB1zt3WrGElGGQONxilXaUfFuXX/uags=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x9Vu0wV5WdDPE8Xh6k2e/Qo4EzlnGs9Z1K//SwN06HKsUsl4N0+CfuqkVsge813/X
         gsS2fkJLG9II4WEyUq0hTyuYkhy32h/L7ZaC8oncX/+iVFEyhY25SNZhcaYs0BmgDy
         RcL4FgoTVe2rKZim6J1H/A+BnOCSFjskOKjlGX7A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Hebb <tommyhebb@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 19/25] kconfig: don't crash on NULL expressions in expr_eq()
Date:   Fri, 27 Dec 2019 13:15:43 -0500
Message-Id: <20191227181549.8040-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227181549.8040-1-sashal@kernel.org>
References: <20191227181549.8040-1-sashal@kernel.org>
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
index ed29bad1f03a..96420b620963 100644
--- a/scripts/kconfig/expr.c
+++ b/scripts/kconfig/expr.c
@@ -201,6 +201,13 @@ static int expr_eq(struct expr *e1, struct expr *e2)
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

