Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C96C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B089220879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558553506;
	bh=r8OJ0Lvs9EiXT0z3rsg9GusRJUVtlhz+gyLKUPXKbsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mORkU+j4ITQPA8IuA/Yi8BTCCAsrLup8GPEYYMk16Zew+wdoyTam0I5EPQMhXVLZl
	 A7VCfJyhwD/TVS341oqo8w20MefuqX3bKels5Kmea9yeKiKLC3hzMum5CBWwYRX7r3
	 fj0iewO21kElijpZTDNPxWyyebnjcf+LrSgCASJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387624AbfEVTbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:31:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387591AbfEVTbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:31:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 488F6204FD;
        Wed, 22 May 2019 19:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553501;
        bh=r8OJ0Lvs9EiXT0z3rsg9GusRJUVtlhz+gyLKUPXKbsw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DywC0j9AoS6aYn8GJoZMdaTlq4xLPjV+h3lwUrxVNgmIyu2VsLZF0Shru7FN4IRAE
         Qq79YE8Z7bHOWLeGDjxxuOV3aVOn02Xq/iN14BIAZNSVAO4D92MfjNf3vHna40lfhX
         GMHIkIXalCIo1jtZD77vAvvz67qoyFHE33pVjL3E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mariusz Bialonczyk <manio@skyboo.net>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 09/92] w1: fix the resume command API
Date:   Wed, 22 May 2019 15:30:04 -0400
Message-Id: <20190522193127.27079-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522193127.27079-1-sashal@kernel.org>
References: <20190522193127.27079-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mariusz Bialonczyk <manio@skyboo.net>

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
index 282092421cc9e..1a9d9ec8db4df 100644
--- a/drivers/w1/w1_io.c
+++ b/drivers/w1/w1_io.c
@@ -437,8 +437,7 @@ int w1_reset_resume_command(struct w1_master *dev)
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

