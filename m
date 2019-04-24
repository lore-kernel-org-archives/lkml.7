Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991F9C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9D4218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116996;
	bh=yaJjvoi84Hs7O+Cf19wpVcaxRjhWD83LgWXnvr+8C74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mufh1VlymAbMAqqQ9ku7dwhQ6aLWxRSbKOVpXBhR8yjNnpFuho+lEKKECsjwW+oNw
	 9uTPBWAPOnt14ugXUIQLwjDxhHZW4Kee+LVvBr2ri8bzBOHP6817n2REJrgt9XHcut
	 ek8hk5jqu3d01PkwYYzGGJXPDtR/rIb8TSp6PFpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbfDXOnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731922AbfDXOkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:40:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A669C21915;
        Wed, 24 Apr 2019 14:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116820;
        bh=yaJjvoi84Hs7O+Cf19wpVcaxRjhWD83LgWXnvr+8C74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FQes5UV3UIzy8ge2nzxAv38mE2KIwtshKZTgq801ar8RWk+SeHxyBXoVTr4f7B+X3
         BETJrU1PKdGQGxeFWQMEO7Vxk2cE0yhNvGncJklv0qko3dk8C1vFo/4uaER6a+s1d/
         RypVw+AmUy7XLC9FUOUIPZ+XnmtSmmC2LIAlLsfU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>,
        linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 30/52] HID: input: add mapping for Assistant key
Date:   Wed, 24 Apr 2019 10:38:48 -0400
Message-Id: <20190424143911.28890-30-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143911.28890-1-sashal@kernel.org>
References: <20190424143911.28890-1-sashal@kernel.org>
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
index a3916e58dbf5..e649940e065d 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -982,6 +982,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x1b8: map_key_clear(KEY_VIDEO);		break;
 		case 0x1bc: map_key_clear(KEY_MESSENGER);	break;
 		case 0x1bd: map_key_clear(KEY_INFO);		break;
+		case 0x1cb: map_key_clear(KEY_ASSISTANT);	break;
 		case 0x201: map_key_clear(KEY_NEW);		break;
 		case 0x202: map_key_clear(KEY_OPEN);		break;
 		case 0x203: map_key_clear(KEY_CLOSE);		break;
-- 
2.19.1

