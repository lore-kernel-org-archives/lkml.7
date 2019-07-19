Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2239EC76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E3921852
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563509125;
	bh=hO0BYjKuzESqnP+z7jG/uEiXsaMKPUk3qsNkPddSo9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kAQBOEJV74FfBsstfBrlu0gsswq6ME5wb+r6pE3r8rgVoEWDSW6IlH17hx8DbalH3
	 n/QHZsUL8v+0JMdaRu0ZXudHERzMK0/sG2/9sxXuTu6mKTS1f/qrydmtC6jzMR+Evu
	 xhc+LZEXUYmLdCR/DSKb6L3fYGvht7KXVAx8Bvo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfGSEFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731479AbfGSEFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:05:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C278D2189F;
        Fri, 19 Jul 2019 04:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509110;
        bh=hO0BYjKuzESqnP+z7jG/uEiXsaMKPUk3qsNkPddSo9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=00d/8R+H/FjZ+Nt24eUUUg40AY+e8j0oYuzcuO8a94VbnlK4SI3uMxIzk9YrEBzNq
         M8b8ElSY1QA3t5+u8xIbZTDg4oab9eopVmePpuu3DqNlKPUG1NKsmlHfhgWexbn9cq
         +cZTIYu+uMcMQHG+BHvrboSFspC6Npp5vwe5FoDw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Gomez <dagmcr@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>, patches@opensource.cirrus.com
Subject: [PATCH AUTOSEL 5.1 074/141] mfd: madera: Add missing of table registration
Date:   Fri, 19 Jul 2019 00:01:39 -0400
Message-Id: <20190719040246.15945-74-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719040246.15945-1-sashal@kernel.org>
References: <20190719040246.15945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Gomez <dagmcr@gmail.com>

[ Upstream commit 5aa3709c0a5c026735b0ddd4ec80810a23d65f5b ]

MODULE_DEVICE_TABLE(of, <of_match_table>) should be called to complete DT
OF mathing mechanism and register it.

Before this patch:
modinfo ./drivers/mfd/madera.ko | grep alias

After this patch:
modinfo ./drivers/mfd/madera.ko | grep alias
alias:          of:N*T*Ccirrus,wm1840C*
alias:          of:N*T*Ccirrus,wm1840
alias:          of:N*T*Ccirrus,cs47l91C*
alias:          of:N*T*Ccirrus,cs47l91
alias:          of:N*T*Ccirrus,cs47l90C*
alias:          of:N*T*Ccirrus,cs47l90
alias:          of:N*T*Ccirrus,cs47l85C*
alias:          of:N*T*Ccirrus,cs47l85
alias:          of:N*T*Ccirrus,cs47l35C*
alias:          of:N*T*Ccirrus,cs47l35

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/madera-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index 2a77988d0462..826b971ccb86 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -286,6 +286,7 @@ const struct of_device_id madera_of_match[] = {
 	{ .compatible = "cirrus,wm1840", .data = (void *)WM1840 },
 	{}
 };
+MODULE_DEVICE_TABLE(of, madera_of_match);
 EXPORT_SYMBOL_GPL(madera_of_match);
 
 static int madera_get_reset_gpio(struct madera *madera)
-- 
2.20.1

