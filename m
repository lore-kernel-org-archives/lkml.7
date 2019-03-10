Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E68C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 15:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796912084D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 15:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO4rfb0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfCJPTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 11:19:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40672 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfCJPTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 11:19:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id c17so1062420eds.7;
        Sun, 10 Mar 2019 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wiS4Sqqx9DgFpGVCn525WRVyxF2MbuXAiQeW4DyIvuE=;
        b=OO4rfb0hlUNFwifAv6yjZNNHJIiu/+F8EtKxO0phLs2bUw36Q2bRxHKbbako4RP8uQ
         6939PS0A6f95YzYrDJmaZQFKUEI6Ibrq5qrhViFsw8uLRyct8pcZTr13m4j7s1npglKe
         SS5Yc8PaQseXVB66389CKZSSasinz/y3sKwvPVB+ZVqmnMj7LXueEC4nTBrqp5VDaEYF
         us3YxUZclJiMFrQiapExNNR4uZ/XP2vRUslqFPXfBfjGUt240T7CR8sL6xZZo/uHfOOz
         46xjTXY6WQW//HMPoPvVeMkPhrra9hllUnRnJY3hIvHDIsGuQ6c+Zti2YG1yrYF85qrm
         bHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wiS4Sqqx9DgFpGVCn525WRVyxF2MbuXAiQeW4DyIvuE=;
        b=PV5Rf0yyMz0DsOKEHf7qigLZwtDY0KCdM/8DiEXoJJmXkkvkiuUOU5Sd4AveIJ8p7A
         DBvXBywdWwLG7ttrmo4XhfQ9zgmYKMBQyL/Sxhi1Een8zJDxq9sWmokIodhxjmf+KZbg
         adGGniDUOJoPqolCDsFp3VvLneyheHdfoPryJreshy5a1h/a9Bc47OB5p5tczSnUuW60
         3XmoWnvPYyz9EtwLmAGc9fSLEeg169qKh3ueptaQgO4eo96DcB8hFd+YZ4r48pRKcOis
         URNBP6Buh44/vHUgBOpe00YTrhF754efYhQ9iMnaOMRVfwOkvwLL5UpBcYmD4xOrPc5z
         +9jQ==
X-Gm-Message-State: APjAAAXqQxZAeQ8JFq9uY8nsENDKp3wCNUCaUd+RqEqHrOp4f/DDylv7
        6lQjCGMgfhVIsO98yUNqNwSnWA4H
X-Google-Smtp-Source: APXvYqzUApQUbrdLKY0F1CNl1yTUeduWuhKN6A0jF6RlslrzSlVIXtFyt5HQU+vRrXis4ayo7KfPdw==
X-Received: by 2002:aa7:d795:: with SMTP id s21mr39424922edq.116.1552231179807;
        Sun, 10 Mar 2019 08:19:39 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id x42sm1075277edx.9.2019.03.10.08.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 08:19:39 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: rockchip: remove disable-wp from rv1108-elgin-r1 emmc node
Date:   Sun, 10 Mar 2019 16:19:28 +0100
Message-Id: <20190310151928.2344-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190219130317.2817-1-jbx6244@gmail.com>
References: <20190219130317.2817-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mmc.txt didn't explicitly say disable-wp is for SD card slot only,
but that is what it was designed for in the first place.
Remove all disable-wp from emmc or sdio controllers.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 arch/arm/boot/dts/rv1108-elgin-r1.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/rv1108-elgin-r1.dts b/arch/arm/boot/dts/rv1108-elgin-r1.dts
index 1c4507b66..b1db92471 100644
--- a/arch/arm/boot/dts/rv1108-elgin-r1.dts
+++ b/arch/arm/boot/dts/rv1108-elgin-r1.dts
@@ -37,7 +37,6 @@
 &emmc {
 	bus-width = <8>;
 	cap-mmc-highspeed;
-	disable-wp;
 	no-sd;
 	no-sdio;
 	non-removable;
-- 
2.11.0

