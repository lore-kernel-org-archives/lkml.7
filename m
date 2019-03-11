Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C141C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7F321734
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334142;
	bh=WA9HePv95xQ6u/mO8f6hJhrUuU79gR7iLRUX3wjKbuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pWz/zwTE2tGDvXgIUl0knj1eYTEjNQmHEulW07PobPlO1yKzj+sVy27EY2dECP9Ij
	 ZNfcghfNUJkeVtXtiHmo6lzmtcWPciErcaElxujtkxgoSftx7HSjzgNHghnwzuZj1G
	 7aoGYTN36G09FCtPGq65hs3ZVev4i3NEYgS5yjjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbfCKTzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:32922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbfCKTzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:55:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 660C3214D8;
        Mon, 11 Mar 2019 19:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334139;
        bh=WA9HePv95xQ6u/mO8f6hJhrUuU79gR7iLRUX3wjKbuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V0p7VDGr8tMrU4rEmTTjkIZhMx3pvc5nOskyVFFzulPrUcxAC1SXkqXa667U/0XUG
         g3Cnd7GLUboGjn/X4izilw4FXoQrxbQbQXH/qVt6wL8hxY9IyE5yIumzV2HPzmppOt
         dYTLavI0hMoKziHtw0UYo2VI/Yb4pyw+N/McAsCA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Chris Siebenmann <cks@cs.toronto.edu>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 09/52] hwmon: (nct6775) Fix fan6 detection for NCT6793D
Date:   Mon, 11 Mar 2019 15:54:33 -0400
Message-Id: <20190311195516.137772-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195516.137772-1-sashal@kernel.org>
References: <20190311195516.137772-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 2a2ec4aa0577ec0b7df2d1bde5c84ed39a8637cb ]

Commit 2d99925a15b6 ("hwmon: (nct6775) Separate fan/pwm configuration
detection for NCT6793D") accidentally removed part of the code detecting
if fan6 is enabled or not. As result, fan6 is no longer detected on Asus
PRIME Z370-A. Restore the missing detection code.

Fixes: 2d99925a15b6 ("hwmon: (nct6775) Separate fan/pwm configuration detection for NCT6793D")
Reported-by: Chris Siebenmann <cks@cs.toronto.edu>
Cc: Chris Siebenmann <cks@cs.toronto.edu>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 4adec4ab7d06..59ee01f3d022 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -3594,7 +3594,8 @@ nct6775_check_fan_inputs(struct nct6775_data *data)
 			fan5pin |= cr1b & BIT(5);
 			fan5pin |= creb & BIT(5);
 
-			fan6pin = creb & BIT(3);
+			fan6pin = !dsw_en && (cr2d & BIT(1));
+			fan6pin |= creb & BIT(3);
 
 			pwm5pin |= cr2d & BIT(7);
 			pwm5pin |= (creb & BIT(4)) && !(cr2a & BIT(0));
-- 
2.19.1

