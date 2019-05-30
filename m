Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421FFC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19224251A1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559189525;
	bh=W3deDqBV973O01uZLmx5KBYNQkKfVaEZ3DxcfVjdSI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VkLqbPQ7NzA9+pFhuj8J3eOzdIlJNCtMAytzQb+voiJ+zeKRyNCtkOKSr5wuPYanr
	 cisIYRrXLlYLKEGcMGsFMF9/2rLYFrlH1ZuiGdGNOp6MaSYSEnaZgCURkVPkvau5tK
	 /Ahs8KKe9y2aj9vw9dAgaFeFlxOo4mjY1YA0dy3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbfE3EME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:12:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730784AbfE3DQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:16:44 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C801D24628;
        Thu, 30 May 2019 03:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186203;
        bh=W3deDqBV973O01uZLmx5KBYNQkKfVaEZ3DxcfVjdSI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lX7Ja1IKI+WR+qvtuTeKLWTFwpwsugk3xBxB0O9ZdXg9KuDQhHF4GEyLthGtyF61r
         fmdSeXmRRUB+36c5K9asHSwDNRhLW4Ug+u5+UP77+rpjIvAvQGK0btClbcwnbGgX+9
         zj4nZXxAGJPcVOoyPwydACVEnpSwVChDLKrZl//8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mariusz Bialonczyk <manio@skyboo.net>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 089/276] w1: fix the resume command API
Date:   Wed, 29 May 2019 20:04:07 -0700
Message-Id: <20190530030531.802190504@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030523.133519668@linuxfoundation.org>
References: <20190530030523.133519668@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 62909da8aca048ecf9fbd7e484e5100608f40a63 ]

>From the DS2408 datasheet [1]:
"Resume Command function checks the status of the RC flag and, if it is set,
 directly transfers control to the control functions, similar to a Skip ROM
 command. The only way to set the RC flag is through successfully executing
 the Match ROM, Search ROM, Conditional Search ROM, or Overdrive-Match ROM
 command"

The function currently works perfectly fine in a multidrop bus, but when we
have only a single slave connected, then only a Skip ROM is used and Match
ROM is not called at all. This is leading to problems e.g. with single one
DS2408 connected, as the Resume Command is not working properly and the
device is responding with failing results after the Resume Command.

This commit is fixing this by using a Skip ROM instead in those cases.
The bandwidth / performance advantage is exactly the same.

Refs:
[1] https://datasheets.maximintegrated.com/en/ds/DS2408.pdf

Signed-off-by: Mariusz Bialonczyk <manio@skyboo.net>
Reviewed-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/w1/w1_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
index 0364d3329c526..3516ce6718d94 100644
--- a/drivers/w1/w1_io.c
+++ b/drivers/w1/w1_io.c
@@ -432,8 +432,7 @@ int w1_reset_resume_command(struct w1_master *dev)
 	if (w1_reset_bus(dev))
 		return -1;
 
-	/* This will make only the last matched slave perform a skip ROM. */
-	w1_write_8(dev, W1_RESUME_CMD);
+	w1_write_8(dev, dev->slave_count > 1 ? W1_RESUME_CMD : W1_SKIP_ROM);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(w1_reset_resume_command);
-- 
2.20.1



