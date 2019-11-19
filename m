Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9604EC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC0721823
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141173;
	bh=YfqKLYSnsyumgux2Rxwepr9n4EMJK++Yk6lQwlbYAtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G4trpbzqyTUGi3dN7auQf6PSxMZ+jx6vOTGof4KErz7uLoMszYxSaOS2dq7tp/z6i
	 TeS7eG6tZSwv49fAA2/h6RYcVKM1RSoP1DDyxlfvikVFTxATQBJ9LqxDXFjsjMnF50
	 WOuTzIbqLGeOjX1orCFSe+/hdZ6FOWLF7LhtRYus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfKSF0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:26:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728517AbfKSF0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:26:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B4F3222A2;
        Tue, 19 Nov 2019 05:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141169;
        bh=YfqKLYSnsyumgux2Rxwepr9n4EMJK++Yk6lQwlbYAtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c3qJk6vjm5DUrbsf4EJiNYz9gQTQoTERhhuocowdbXSRXfWWfliiCCK6+01GoFzXO
         ODdp4pMLhp+/cYbJNPSKUgJ8HojAUbgzPM4vR3PVeo73W1Mb01T6QZgBhHUfNGMLRO
         bTiYpTqFFSp6gSAX9+fn5OGx2mhWMWuiEHf8Bj+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Akshu Agrawal <akshu.agrawal@amd.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 069/422] ASoC: AMD: Change MCLK to 48Mhz
Date:   Tue, 19 Nov 2019 06:14:26 +0100
Message-Id: <20191119051404.111282632@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akshu Agrawal <akshu.agrawal@amd.com>

[ Upstream commit a1b1e9880f0c2754a5ac416a546d9f295f72eabc ]

25Mhz MCLK which was earlier used was of spread type.
Thus, we were not getting accurate rate. The 48Mhz system
clk is of non-spread type and we are changing to it to get
accurate rate.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 8e3275a96a821..e53b54d77692e 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -42,7 +42,7 @@
 #include "../codecs/da7219.h"
 #include "../codecs/da7219-aad.h"
 
-#define CZ_PLAT_CLK 25000000
+#define CZ_PLAT_CLK 48000000
 #define DUAL_CHANNEL		2
 
 static struct snd_soc_jack cz_jack;
-- 
2.20.1



