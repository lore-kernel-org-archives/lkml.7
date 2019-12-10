Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD00C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96087246AA
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012253;
	bh=lODidp+xqeK9X0+Fcutlh0HKg83nX1UWyAhTUhsKRRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S6awge9Qz37CFv+a29DQpnkNyNxE+XsG6qJ4CX80hiD0Rhv45GYerPowBYZgVkhYW
	 UhU26gEnv+D6/A024+p39XQsnEOnNNyYbRkok5Stq/iK0OmwWmnFaIeXsJeLPlj4B0
	 VXH/+FyiEsh7UPU0BSItlP1DSjPkjudCYmu8Vvxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfLJVKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:10:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbfLJVKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:10:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 574EC246AA;
        Tue, 10 Dec 2019 21:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012243;
        bh=lODidp+xqeK9X0+Fcutlh0HKg83nX1UWyAhTUhsKRRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oVq0i3pVVAaFpHGbzhUH+8gFURWcMe7rGIGdWto9Pri8uALQj9zyLMVnW5Cwmndep
         DXUc/0LSSbYjsfGeI1oEK1+Ut2etfTZ4tPvNCwAYkU1Orw/DR2W60z635S1bmGWgPa
         FPfqY2BREGEXjv8XcSmfKMUrzSWwBjpNb6lsjA6w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 191/350] ALSA: bebob: expand sleep just after breaking connections for protocol version 1
Date:   Tue, 10 Dec 2019 16:04:56 -0500
Message-Id: <20191210210735.9077-152-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

[ Upstream commit d3eabe939aee3ffd5b133766a932629a9746298c ]

As long as I investigated, some devices with BeBoB protocol version 1
can be freezed during several hundreds milliseconds after breaking
connections. When accessing during the freezed time, any transaction
is corrupted. In the worst case, the device is going to reboot.

I can see this issue in:
 * Roland FA-66
 * M-Audio FireWire Solo

This commit expands sleep just after breaking connections to avoid
the freezed time as much as possible. I note that the freeze/reboot
behaviour is similar to below models:
 * Focusrite Saffire Pro 10 I/O
 * Focusrite Saffire Pro 26 I/O

The above models certainly reboot after breaking connections.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://lore.kernel.org/r/20191101131323.17300-2-o-takashi@sakamocchi.jp
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/firewire/bebob/bebob_stream.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/firewire/bebob/bebob_stream.c b/sound/firewire/bebob/bebob_stream.c
index 6c1497d9f52ba..ce07ea0d4e71d 100644
--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -415,15 +415,16 @@ static int make_both_connections(struct snd_bebob *bebob)
 	return 0;
 }
 
-static void
-break_both_connections(struct snd_bebob *bebob)
+static void break_both_connections(struct snd_bebob *bebob)
 {
 	cmp_connection_break(&bebob->in_conn);
 	cmp_connection_break(&bebob->out_conn);
 
-	/* These models seems to be in transition state for a longer time. */
-	if (bebob->maudio_special_quirk != NULL)
-		msleep(200);
+	// These models seem to be in transition state for a longer time. When
+	// accessing in the state, any transactions is corrupted. In the worst
+	// case, the device is going to reboot.
+	if (bebob->version < 2)
+		msleep(600);
 }
 
 static int
-- 
2.20.1

