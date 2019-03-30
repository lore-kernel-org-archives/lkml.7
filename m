Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB4EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5AB218FE
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907203;
	bh=m9Y7iFDLI/nCrq/NSxpT+jNqzok2H7Th/PXF8eUHhWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oplKburmpSVpVcfWtLZ0q/5CG3UDqEN1tqoIKhIC87JSqAQaPey3+Ua/PHkJX1e+e
	 eZuf+4YqLXnrPHEzvRWO3RMBSjd7JgCwsFVr8V0/basBV1u7fzkvJAsPr6WCELdFDA
	 48J2+Q4znGMFlgw+44df8M9PuiIs+KsSTddAaDwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbfC3AxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731238AbfC3AxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:53:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFBFA218EA;
        Sat, 30 Mar 2019 00:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907198;
        bh=m9Y7iFDLI/nCrq/NSxpT+jNqzok2H7Th/PXF8eUHhWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0QlPDqWmarHJ2bnx/gmfjNCMp887eUycYgR5JzMZdXDfZqo6b6ZGXvPwC2AoeQU1F
         dFv44jhiftuY2HXYy1UoqnvWXi3TeJRBE8s4LgnPGU2iiZZz+Iou1zLULrtiIsCQJj
         OOOv00jNtx+jAmItiD27PBS72vvK4Uvl3WYukYXE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 11/52] auxdisplay: hd44780: Fix memory leak on ->remove()
Date:   Fri, 29 Mar 2019 20:52:18 -0400
Message-Id: <20190330005301.26868-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005301.26868-1-sashal@kernel.org>
References: <20190330005301.26868-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 41c8d0adf3c4df1867d98cee4a2c4531352a33ad ]

We have to free on ->remove() the allocated resources on ->probe().

Fixes: d47d88361fee ("auxdisplay: Add HD44780 Character LCD support")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/auxdisplay/hd44780.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/auxdisplay/hd44780.c b/drivers/auxdisplay/hd44780.c
index f1a42f0f1ded..df3da49ff9e8 100644
--- a/drivers/auxdisplay/hd44780.c
+++ b/drivers/auxdisplay/hd44780.c
@@ -299,6 +299,8 @@ static int hd44780_remove(struct platform_device *pdev)
 	struct charlcd *lcd = platform_get_drvdata(pdev);
 
 	charlcd_unregister(lcd);
+
+	kfree(lcd);
 	return 0;
 }
 
-- 
2.19.1

