Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B73C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 677D2218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117284;
	bh=32jGaKs86OGoM74r4xJa0+du06WuIF2ZcgJf1byDWDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=muZX1+X6Q1iinwVH+tp18FEMsD5QJWZ88rpPFdSQ2Zg86dYi+hSZ1OCbpGxymS+xN
	 P06a6kBAFdIRX2u5VCg9FT6xhU3lzZwk3kUHR42Yg7CtkWbnxFZoBU3k+RTKnLXuzW
	 BIzyAPNfzO9wLf35EUGBTtX0ztu/i86dobAxH6ZY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732353AbfDXOr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732343AbfDXOrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:47:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83C2821900;
        Wed, 24 Apr 2019 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556117272;
        bh=32jGaKs86OGoM74r4xJa0+du06WuIF2ZcgJf1byDWDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E84Hbu13xXzoD8s6aPTNXtaUNF0HfJl4zYcsGratrNEqNiO6swxKZt/sUzJ9o8MI6
         8g9EpgL3mps/4RH8Uo0yyWjqsVR+gnur2b/Rt3dG5b41SiTQxNGREKoFKR8rbChaor
         AqWhZudKkSHYLgKae7XA1+x9Ntx19785PI7A9xyA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 19/35] HID: input: add mapping for Assistant key
Date:   Wed, 24 Apr 2019 10:46:53 -0400
Message-Id: <20190424144709.30215-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424144709.30215-1-sashal@kernel.org>
References: <20190424144709.30215-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit ce856634af8cda3490947df8ac1ef5843e6356af ]

According to HUTRR89 usage 0x1cb from the consumer page was assigned to
allow launching desktop-aware assistant application, so let's add the
mapping.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d146a9b545ee..1aa7d268686b 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -973,6 +973,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x1b8: map_key_clear(KEY_VIDEO);		break;
 		case 0x1bc: map_key_clear(KEY_MESSENGER);	break;
 		case 0x1bd: map_key_clear(KEY_INFO);		break;
+		case 0x1cb: map_key_clear(KEY_ASSISTANT);	break;
 		case 0x201: map_key_clear(KEY_NEW);		break;
 		case 0x202: map_key_clear(KEY_OPEN);		break;
 		case 0x203: map_key_clear(KEY_CLOSE);		break;
-- 
2.19.1

