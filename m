Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B189FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311EE21D7B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573215292;
	bh=mI0XnBDEH7h1/bR0rM/YZoWXwkI7rtsi+5SzyY7LTRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EB/FO80zBIzf5T49OwWZdQmwmpEgxW0xswoUJLa/X4R73TITyQDApZjDMYwV21Dk7
	 0MKOMK3oYBYFnD9SdBDLr2ieR9GZrEKh4bsaUmfFOBcTSy4fBt36w6SkXzhm5pzdut
	 0WbfGBFzNbBO6CSy3pqB8+7sizjVDx983Cc1BjMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390998AbfKHMOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:14:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:50804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732085AbfKHLiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:38:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F38B121D7B;
        Fri,  8 Nov 2019 11:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213079;
        bh=mI0XnBDEH7h1/bR0rM/YZoWXwkI7rtsi+5SzyY7LTRY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=arZaxpvVWbdz1p+UlM/P4UGIeveg0wHBqDOGA9474G7RoBCU7aXkNG8dl2dqBBdNC
         hbfe2UHergjDPqlWZAXjNURRWvC/E3u8y8kgmKZu2gFxS85C98M9Bvl26uZP+T94b7
         qihLiUuqtmrxnlo3VwLTHBPx+W5oaSxEx8JZlC5Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shreyas NC <shreyas.nc@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 006/205] soundwire: Initialize completion for defer messages
Date:   Fri,  8 Nov 2019 06:34:33 -0500
Message-Id: <20191108113752.12502-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shreyas NC <shreyas.nc@intel.com>

[ Upstream commit a306a0e4a5326269b6c78d136407f08433ab5ece ]

Deferred messages are async messages used to synchronize
transitions mostly while doing a bank switch on multi links.
On successful transitions these messages are marked complete
and thereby confirming that all the buses performed bank switch
successfully.

So, initialize the completion structure for the same.

Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index dcc0ff9f0c224..dbabd5e69343f 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -175,6 +175,7 @@ static inline int do_transfer_defer(struct sdw_bus *bus,
 
 	defer->msg = msg;
 	defer->length = msg->len;
+	init_completion(&defer->complete);
 
 	for (i = 0; i <= retry; i++) {
 		resp = bus->ops->xfer_msg_defer(bus, msg, defer);
-- 
2.20.1

