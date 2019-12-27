Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9271C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D5E21582
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577469364;
	bh=5+KBnVdLRuk87lNb6TdfP6q2MkTmfaix4p79kTqEKBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RDFEbOPl3m80Zm/vPPLd0/hGF178jDKkxi6wdtsEJixdHhS/OoKGRHsFIe0BZ0Tpp
	 s8BJMcQ0aubAUBuglnQr5yMQAIoETKQgdm2PHGIvXqo5UHcjgMgsxPVpPmcKSEmP4Y
	 UBqzh3Q5esSK2RKnk35OmzOyv2W7vTtJCGfceCsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfL0R4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:56:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbfL0RmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:42:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9DB820740;
        Fri, 27 Dec 2019 17:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468527;
        bh=5+KBnVdLRuk87lNb6TdfP6q2MkTmfaix4p79kTqEKBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xmxRPHGyA5yO0vU1fkoGCm9RHHdn5dmNRLQ//7V8y4swIe4u0knlYHyS5rarw8B9x
         yJzOC07IHDwj1nobZGwm+GP1QJ2hhZVNDdXzYJfQsGFUz+keooawgOJQkERy0lDk/D
         2xfv6oB1r+WKmR8PWUD8UwMTnPkEaEv+z+ZAENtM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 058/187] reset: Do not register resource data for missing resets
Date:   Fri, 27 Dec 2019 12:38:46 -0500
Message-Id: <20191227174055.4923-58-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174055.4923-1-sashal@kernel.org>
References: <20191227174055.4923-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit db23808615e29d9a04f96806cac56f78b0fee0ef ]

When an optional reset is not present, __devm_reset_control_get() and
devm_reset_control_array_get() still register resource data to release
the non-existing reset on cleanup, which is futile.

Fix this by skipping NULL reset control pointers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/reset/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 3c9a64c1b7a8..f343bd814d32 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -787,7 +787,7 @@ struct reset_control *__devm_reset_control_get(struct device *dev,
 		return ERR_PTR(-ENOMEM);
 
 	rstc = __reset_control_get(dev, id, index, shared, optional, acquired);
-	if (!IS_ERR(rstc)) {
+	if (!IS_ERR_OR_NULL(rstc)) {
 		*ptr = rstc;
 		devres_add(dev, ptr);
 	} else {
@@ -930,7 +930,7 @@ devm_reset_control_array_get(struct device *dev, bool shared, bool optional)
 		return ERR_PTR(-ENOMEM);
 
 	rstc = of_reset_control_array_get(dev->of_node, shared, optional, true);
-	if (IS_ERR(rstc)) {
+	if (IS_ERR_OR_NULL(rstc)) {
 		devres_free(devres);
 		return rstc;
 	}
-- 
2.20.1

