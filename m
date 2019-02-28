Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B3EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7ED2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIXnBsCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbfB1NSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:18:55 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36834 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732593AbfB1NSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:18:51 -0500
Received: by mail-lj1-f195.google.com with SMTP id v10so17115797lji.3;
        Thu, 28 Feb 2019 05:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EnxVFjv0sJZsDhiPW9qc3IgJCRO74aOC680wPGEHp64=;
        b=QIXnBsCwph453Sew/t3YcxUUYO45b/7rqbIyrxGmtJvQhJDSTERFrYYsQYBXFGNPLX
         2dgPh6Z7WM11TeeVWA8hoFxEIbt9hs0B4a/o3SlXLrc4rBAn9C6SE720/kNZK/ehkNpg
         gjGfifzjfdVHyPq/Xw0yo0SzQTiLveoSG5vx1niIWMCm6j69P7ZjSpiuBwbsfDu2rqHZ
         cz0SlyLVOxzAThR8aLG6o1SKGSC6qexyA/tYLql9+S39ZwoCXTc7IZmecpz3EkKc6Zmt
         ZsRFbuRNMnLT3uUjZOdFp951y78k69RVRaGb4EOxZeRtZlF10EHcWA1s/CRJR7EnhFk0
         h10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EnxVFjv0sJZsDhiPW9qc3IgJCRO74aOC680wPGEHp64=;
        b=A23zyRdDvHcGv/e29S3OcP/Ika2QY++u4vnvd9WYtWQKS+tDhJZmHh+lvLIBrtLZff
         j/sLgwVs6QX93TB46rIzxFj2a7Epr/ySj6m4gHcqUyMc65kO1gQyFFilLGzdwP7OiUJC
         fQ6N6znGmLSIqHXggV0DKQgbxAY+k6cLiyaQzfokH0OsqLZVaAA96+q6fy13D3+NtQZj
         vVOmROZMcI/Dsr2IjBHKg1wEnHGy4CfgQhKa/AvaSwSwZoGesKpswrALhbOJzN72PZb6
         3+4jEhfWsa5xOt1IEo3owHeR8YJTF9unHrU40ocDLokfA5zxq7c1wANig3dJ1RDeJGNA
         CRQQ==
X-Gm-Message-State: APjAAAXKnYok+QoYuaAQkrDJXog77E3QQpx3bYJqZ56jTTTeSsUeTpSp
        V5z7PTd0c7PIqp2A58j38bY=
X-Google-Smtp-Source: APXvYqx/IvPlgk66zI8TOQRQ2S5/4q1C1FZAtOscgNom3d8fTU7ZdNLQYK9RPQaayusITgoSsj99hw==
X-Received: by 2002:a2e:9b99:: with SMTP id z25mr4582146lji.106.1551359929658;
        Thu, 28 Feb 2019 05:18:49 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id l26sm4600069lfc.37.2019.02.28.05.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:18:48 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 6/7] ARM: tegra: Always boot CPU in ARM-mode
Date:   Thu, 28 Feb 2019 16:17:06 +0300
Message-Id: <20190228131707.2592-7-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228131707.2592-1-digetx@gmail.com>
References: <20190228131707.2592-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU always jumps into reset handler in ARM-mode from the Trusted
Foundations firmware, hence let's make CPU to always jump into kernel
in ARM-mode regardless of the firmware presence. This is required to
make Thumb-2 kernel working with the Trusted Foundations firmware on
Tegra30.

Tested-by: Robert Yang <decatf@gmail.com>
Tested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/reset-handler.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 6bea95d165fa..3bf202819534 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -113,6 +113,7 @@ ENTRY(__tegra_cpu_reset_handler_start)
  *       must be position-independent.
  */
 
+	.arm
 	.align L1_CACHE_SHIFT
 ENTRY(__tegra_cpu_reset_handler)
 
-- 
2.20.1

