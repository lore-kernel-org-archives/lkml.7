Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9BBC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1BEA20665
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752733;
	bh=QyJeQ8ZDhZb8D1qFG4o4nHOJ0ZDqIXNBerw2Y22BOL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XNFak1ssGInW49ZhkUXVe71v0WRV42OhoQKtmBJP0DatzCydoImv0befsaDHHw+na
	 gDyDNLn7qBR3qWKzJTvUOGeBrS/Yv7ydrHtPzvnTGkWsH/4jK1FOja5tgMJTu1xUls
	 Dq4aJnREiv9d925xsHpeDDH+Zuv/LLxYrMW5tYO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405007AbfHBNcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:32:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391003AbfHBNYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:24:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20422217D4;
        Fri,  2 Aug 2019 13:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752249;
        bh=QyJeQ8ZDhZb8D1qFG4o4nHOJ0ZDqIXNBerw2Y22BOL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjDT+fH3LVOl+WMF1QYLyGM5i3en5klyp2BMVcxQOvt1e4tNy9wg4q78kinhqWTaf
         6BpYXSPvfpD/8MX0Qg40zWZ0DggShmNQnAcYAFuRbXw/ffUAgOx4ReYK89b6xKsTsU
         YRttPhkRJYDR6JOeU4SG0d9Ruy/0xpiWvuM+60Ck=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wenwen@cs.uga.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 37/42] test_firmware: fix a memory leak bug
Date:   Fri,  2 Aug 2019 09:22:57 -0400
Message-Id: <20190802132302.13537-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802132302.13537-1-sashal@kernel.org>
References: <20190802132302.13537-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit d4fddac5a51c378c5d3e68658816c37132611e1f ]

In test_firmware_init(), the buffer pointed to by the global pointer
'test_fw_config' is allocated through kzalloc(). Then, the buffer is
initialized in __test_firmware_config_init(). In the case that the
initialization fails, the following execution in test_firmware_init() needs
to be terminated with an error code returned to indicate this failure.
However, the allocated buffer is not freed on this execution path, leading
to a memory leak bug.

To fix the above issue, free the allocated buffer before returning from
test_firmware_init().

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Link: https://lore.kernel.org/r/1563084696-6865-1-git-send-email-wang6495@umn.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_firmware.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index fd48a15a0710c..a74b1aae74618 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -894,8 +894,11 @@ static int __init test_firmware_init(void)
 		return -ENOMEM;
 
 	rc = __test_firmware_config_init();
-	if (rc)
+	if (rc) {
+		kfree(test_fw_config);
+		pr_err("could not init firmware test config: %d\n", rc);
 		return rc;
+	}
 
 	rc = misc_register(&test_fw_misc_device);
 	if (rc) {
-- 
2.20.1

