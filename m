Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D91FC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B0821D7F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213127;
	bh=YfqKLYSnsyumgux2Rxwepr9n4EMJK++Yk6lQwlbYAtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nhbWd6RohEV/yr0ZpXBYxh69wjpBp6SHYyigCBCiGCPk9OQAiraKn3+i88q0zK0sH
	 JhyZMd/8hL0rJXCblMc04/FRZHJ4jZhFohAcAV1oVRl8EiG4qJaF723XvqXT64fS0z
	 iFpT6Hq+N2gHs0CC+/WDid9I5hHLS4Fk3yvbQicg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbfKHLiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:38:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:51538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732746AbfKHLii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:38:38 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0075721D7B;
        Fri,  8 Nov 2019 11:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213117;
        bh=YfqKLYSnsyumgux2Rxwepr9n4EMJK++Yk6lQwlbYAtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ub6uhxxIvAFxuRipXtMWtAX3RdS2A51lb3t8SaP3R8D+YJ3/6yaRhXsm6XjBmYnjA
         lNCXKvNjhHCOIQlAc5fa93b5fCkYSXahOPm6fUfO95nl9tq6UPB1mn1YAJyDU3xZ4z
         YUrbUwW6ODJQuZK5HkA0VSboQzO29FxxTljClOQU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Akshu Agrawal <akshu.agrawal@amd.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 037/205] ASoC: AMD: Change MCLK to 48Mhz
Date:   Fri,  8 Nov 2019 06:35:04 -0500
Message-Id: <20191108113752.12502-37-sashal@kernel.org>
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

