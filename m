Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E85C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA61521019
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0xgcUn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfCQLsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 07:48:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41866 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfCQLsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 07:48:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id k11so9441901pgb.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 04:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=syAjixV+bBBQ3PGW9Lv91nx1Kx/WIPy5ZQ1RAIyQmag=;
        b=s0xgcUn86JEj6weXjewMyyaW1inEmqnmB1PBmsxZ/W95K+yRdozh6ZnlT6fKZc69Z8
         2XNSXWtj7hEJDEldkh6JLK2zn04lNRoANlfTYHWV7k6PznMiRkvpuuQabnpQXGzrkevF
         0ekjRQFZnte/gGu0IyXruqUcPk7mqn6pvKHvG34seSeA+PIUaBtYtwBZcjYn2sjiGSLu
         Gs79q5gaYfKbFBYPf9woXUVWszciU+I3yHkkHh7tY3azrGM4FMe1enroOl8jRR+STHx5
         GiZl9kL7/jDm7MiRO3R7ZbTOpOFO6mBT7du9XarYN+vA6z3mmuDV5hTMfCJA9tUeh1iU
         J/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=syAjixV+bBBQ3PGW9Lv91nx1Kx/WIPy5ZQ1RAIyQmag=;
        b=XdzyLH8KgoRuI6Gw4jEud8TL1t2qqlgvrOrIarYDIPFP8j+ZRhNhev6Kw73B2UPmtY
         pR2u7RWRlqtU0f1KZungvRvXgW4Nbr28fvYnkW+70A5yLSa1RoJKj//OdYJtmo8aUX+z
         /Q+gVm/JGweLvpmiyWzMft8K8KihMJB/pdNNTkUrxOnUZ2+8xnERHQsEzASCUeAHOoz8
         rabxruzQ0Vp6H6VrQP0Fp40e2bPWZvXB9mKXZXcxGjeq82efz7S8f4SCPNuPvlg1WWdU
         F3RbbSCZxn6G65Sr4PBjXX2+XtnC6Jhasc71KxXqIAL+ndIJrD/aozFRNBrphP9p6rM/
         VeVw==
X-Gm-Message-State: APjAAAXYOyix7BK3pGBdxMO0UA55CisXP4N0I4/n0+qpvtOBlsCCbocw
        MOgVf+aB0VNHaO4nRbmIKr4=
X-Google-Smtp-Source: APXvYqxHXKq2oFfMCRYcf5td6zTk0MD8pkGLN2eY4SS9Ip+qcF9rg8eGpw8N3Bj04eJtCrpORth3SQ==
X-Received: by 2002:aa7:92da:: with SMTP id k26mr13918737pfa.216.1552823298279;
        Sun, 17 Mar 2019 04:48:18 -0700 (PDT)
Received: from localhost.localdomain ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id l184sm12863878pfc.41.2019.03.17.04.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 04:48:17 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCHv2] staging: rtl8723bs: do not use __constant_cpu_to_le16
Date:   Sun, 17 Mar 2019 20:48:03 +0900
Message-Id: <20190317114803.21670-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

cpu_to_le16() is capable enough to detect __builtin_constant_p()
and to use an appropriate compile time ___constant_swahbXX()
function.

So we can use cpu_to_le16() instead of __constant_cpu_to_le16().

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 drivers/staging/rtl8723bs/include/wifi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/wifi.h b/drivers/staging/rtl8723bs/include/wifi.h
index 559bf2606fb7..1e79e6f0c206 100644
--- a/drivers/staging/rtl8723bs/include/wifi.h
+++ b/drivers/staging/rtl8723bs/include/wifi.h
@@ -266,8 +266,8 @@ enum WIFI_REG_DOMAIN {
 
 #define SetFrameType(pbuf, type)	\
 	do {	\
-		*(unsigned short *)(pbuf) &= __constant_cpu_to_le16(~(BIT(3) | BIT(2))); \
-		*(unsigned short *)(pbuf) |= __constant_cpu_to_le16(type); \
+		*(unsigned short *)(pbuf) &= cpu_to_le16(~(BIT(3) | BIT(2))); \
+		*(unsigned short *)(pbuf) |= cpu_to_le16(type); \
 	} while (0)
 
 #define GetFrameSubType(pbuf)	(le16_to_cpu(*(__le16 *)(pbuf)) & (BIT(7) |\
-- 
2.21.0

