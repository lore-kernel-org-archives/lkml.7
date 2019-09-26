Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B69AC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 23:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44BD206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 23:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6QkT3js"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfIZXCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 19:02:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33291 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbfIZXCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 19:02:16 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so399582pfl.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 16:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BUlZji+Rcf1QSUSKX0sbLRSuJG6J/nutRT82xrVSps4=;
        b=f6QkT3jsNf/ZOcGH6FB/1DJZT7DaSassU4MHSbdIutq9L/ZTArEweNYdaMmXS5nHw7
         xQaVtowTtHfZ0HOOX31is86bTTCFIrMbNcEFNoItfItfim7iJ5bkNmSz4BxnPeIE3oUL
         EoHcSGJ26Pa74CpTmcS5dtWN4IGzRJcMjTkB1QnwbLidaYD/DuD/cLCiXczHobwojyHa
         uox1RZUn+3H/SAkGkATy4nTJDhf5/EV0BFrsu7kLX19eUx6v1tQ5RnhIdGn2PnYPGy8T
         lyvLYdIv1OqaWF8+/A605+hNdhSXJ0lvSwGSE9oWdOcqJlIFP5jVFWlgr+geWQK+ANRt
         +veg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BUlZji+Rcf1QSUSKX0sbLRSuJG6J/nutRT82xrVSps4=;
        b=Rxdy/JyfW/M+/0K7T01xFnCWjKMBRZcKc7V2UnbaQkthyo56GwzjYqsewLr7rnQinp
         TO9KkYtuKsmOnFaa6z+N6mg4zrQncERc1TtlcH/t+SUlN0B+UqYJkZ6gz3Zi6zMjwe4U
         CPouXTHyUSvBsSKfKIFC1l9MC9LuslkTSJ5sKJVGYnCYdVIhmO4TfTR/LycZZZ9iyQlM
         /TuLByHWHgQfutdQxTDZN39MLGuekFVyfc9KKepvonEpvgBOvajnilngV/cp9RQN5Zcn
         0+D/8g7XqeXolDSB18hqO7OWj8ovE4KH7vS+b+GszqcEP9cvW3e8VCnWkoGFuzSL9iZT
         T1kA==
X-Gm-Message-State: APjAAAXMuhLCcxt8kFRdTDLS7Tmk0SMtI30FUs18Iji83HBXgip1/X03
        W7AwczXVfuh4Fv38KznOum0=
X-Google-Smtp-Source: APXvYqyDB5aAhghP8WMbDE9y8l+6tdtiHyGMcJktKIFawVWUDNTvJEgFQwW1/MaC4ltWN94fm0IccA==
X-Received: by 2002:a63:441b:: with SMTP id r27mr5887449pga.357.1569538934465;
        Thu, 26 Sep 2019 16:02:14 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id q13sm313970pfn.150.2019.09.26.16.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 16:02:14 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH] arm64: defconfig: Enable SN65DSI86 display bridge
Date:   Thu, 26 Sep 2019 16:02:09 -0700
Message-Id: <20190926230209.47592-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables display on the Lenovo Yoga C630 by connecting the DSI output
from the SoC to the eDP input of the panel.

Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0134a84481f8..f318836bb9b8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -541,6 +541,7 @@ CONFIG_DRM_MSM=m
 CONFIG_DRM_TEGRA=m
 CONFIG_DRM_PANEL_SIMPLE=m
 CONFIG_DRM_SII902X=m
+CONFIG_DRM_TI_SN65DSI86=m
 CONFIG_DRM_I2C_ADV7511=m
 CONFIG_DRM_VC4=m
 CONFIG_DRM_ETNAVIV=m
-- 
2.17.1

