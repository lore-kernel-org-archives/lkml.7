Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077C8C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13D720578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207971;
	bh=O/MTctHPgCyvQ0QI32cGss5bUNi/gQpGB+y/MKIRfJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qE0mSvu+jCU9t3qcEaQix5HSWPE1NQ/DmCjQ/wKAN5qg0vGBq9Pg6TwaOUwYPTiLJ
	 Dhm7OF0MbcTjDXfqR0mlvb+V5ZIHUc9I7gW45iY6cWtQwTE8WdhoE6xII8/XhwRhwv
	 DY9QoZuvCswYEgzMKxYA6ufHeZubzPjilOUeA1tQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbfEGFlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:41:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729338AbfEGFla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:41:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B21A205ED;
        Tue,  7 May 2019 05:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207689;
        bh=O/MTctHPgCyvQ0QI32cGss5bUNi/gQpGB+y/MKIRfJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nI9aZ8LMpoWRuZOIdB5HxkiChn4296+MigUHaSCguNCcnCh8KOnFaRXBs9BO1YFgF
         aNJn30vHV+kCnMrsWoAo3xcjoo09oLN+F49VIJ4BsgAZprRXULMQc1dhk/rcGTD8gf
         ncXgwy8RTCTGd+OlZQCfvNocRNTitNJgrIOTtDNM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 05/25] HID: input: add mapping for "Toggle Display" key
Date:   Tue,  7 May 2019 01:41:02 -0400
Message-Id: <20190507054123.32514-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507054123.32514-1-sashal@kernel.org>
References: <20190507054123.32514-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit c01908a14bf735b871170092807c618bb9dae654 ]

According to HUT 1.12 usage 0xb5 from the generic desktop page is reserved
for switching between external and internal display, so let's add the
mapping.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-input.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 302a24931147..9f7b1cf726a8 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -607,6 +607,14 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			break;
 		}
 
+		if ((usage->hid & 0xf0) == 0xb0) {	/* SC - Display */
+			switch (usage->hid & 0xf) {
+			case 0x05: map_key_clear(KEY_SWITCHVIDEOMODE); break;
+			default: goto ignore;
+			}
+			break;
+		}
+
 		/*
 		 * Some lazy vendors declare 255 usages for System Control,
 		 * leading to the creation of ABS_X|Y axis and too many others.
-- 
2.20.1

