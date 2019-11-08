Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6C9C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744DA207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214515;
	bh=ib4vu3ssWv+BcS446FDJwbNCxuG0zk6e/VuXGHHpq9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QP1WiQRlno5nC81NsUIrw/rXqLGwfvTCvtD4NaZhNDBG8tQH+JeMc6lOwolvGgCnJ
	 shyuth1eVyUMCbEx0hdkXoHio4kADcrQCpPYDTD/hFtaWYAIoMu0ihYdZfS9JTVia8
	 Yw3uvLk9xu4kYu9DxQ2mBSkHPJ0I0Znqd3q8tE+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391262AbfKHMBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:01:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732829AbfKHLnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:43:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 954B5222C6;
        Fri,  8 Nov 2019 11:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213411;
        bh=ib4vu3ssWv+BcS446FDJwbNCxuG0zk6e/VuXGHHpq9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e4jFu8uFp3ISRpOQJnkXG1elXD0E3MffG6MW506ji3QA+EfiTeP1HX1jyzjZgm0N0
         iDw3zA7DpWDkmAum8R6JYHxiRAS8CFLRy43jvd4sHJxlbk1RkdygVRngxMuzsZNXIs
         GyY1QDdUKBp++N/SBla4rKpASt9I1iNyiDircqmQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 014/103] ALSA: seq: Do error checks at creating system ports
Date:   Fri,  8 Nov 2019 06:41:39 -0500
Message-Id: <20191108114310.14363-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit b8e131542b47b81236ecf6768c923128e1f5db6e ]

snd_seq_system_client_init() doesn't check the errors returned from
its port creations.  Let's do it properly and handle the error paths.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/seq/seq_system.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/core/seq/seq_system.c b/sound/core/seq/seq_system.c
index 8ce1d0b40dce1..ce1f1e4727ab1 100644
--- a/sound/core/seq/seq_system.c
+++ b/sound/core/seq/seq_system.c
@@ -123,6 +123,7 @@ int __init snd_seq_system_client_init(void)
 {
 	struct snd_seq_port_callback pcallbacks;
 	struct snd_seq_port_info *port;
+	int err;
 
 	port = kzalloc(sizeof(*port), GFP_KERNEL);
 	if (!port)
@@ -144,7 +145,10 @@ int __init snd_seq_system_client_init(void)
 	port->flags = SNDRV_SEQ_PORT_FLG_GIVEN_PORT;
 	port->addr.client = sysclient;
 	port->addr.port = SNDRV_SEQ_PORT_SYSTEM_TIMER;
-	snd_seq_kernel_client_ctl(sysclient, SNDRV_SEQ_IOCTL_CREATE_PORT, port);
+	err = snd_seq_kernel_client_ctl(sysclient, SNDRV_SEQ_IOCTL_CREATE_PORT,
+					port);
+	if (err < 0)
+		goto error_port;
 
 	/* register announcement port */
 	strcpy(port->name, "Announce");
@@ -154,16 +158,24 @@ int __init snd_seq_system_client_init(void)
 	port->flags = SNDRV_SEQ_PORT_FLG_GIVEN_PORT;
 	port->addr.client = sysclient;
 	port->addr.port = SNDRV_SEQ_PORT_SYSTEM_ANNOUNCE;
-	snd_seq_kernel_client_ctl(sysclient, SNDRV_SEQ_IOCTL_CREATE_PORT, port);
+	err = snd_seq_kernel_client_ctl(sysclient, SNDRV_SEQ_IOCTL_CREATE_PORT,
+					port);
+	if (err < 0)
+		goto error_port;
 	announce_port = port->addr.port;
 
 	kfree(port);
 	return 0;
+
+ error_port:
+	snd_seq_system_client_done();
+	kfree(port);
+	return err;
 }
 
 
 /* unregister our internal client */
-void __exit snd_seq_system_client_done(void)
+void snd_seq_system_client_done(void)
 {
 	int oldsysclient = sysclient;
 
-- 
2.20.1

