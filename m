Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B4EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30D72082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CXDY6sqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbfCVLn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:43:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42174 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbfCVLnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:43:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id v22so1744002lje.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 04:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XlbZNwo48GDl8y2bTtq9+IFF2msXuiIlT62vhrOeZBw=;
        b=CXDY6sqQh6KwApY+SQ9njZa+ZRLGK5a6Pet3IchbpMatt21+Pg+zDdjwkkcIDTxrVQ
         H/yMWtOKphzH9tS/oWivtHxb5BYuZjbPyYPTbvRBeCjT7JMg0qOq31TjQSLOigWR0DV4
         BxW0CaM3olUDf0n32DNbPndNsfvfobr98owLUHos4knoGG7y6pG7L8Q47jJTGJrFVGzJ
         LPVBQS9iwP3WyKd2zWPjQKvsmd9HYIU0Leqza96R8/RN7h2LSQaoYjF2lqgwQCDFm77x
         6T/dzT7Cc2R6CBgcDIQ8XQZbFqG5CMP0hWlDrycGBYt1E6i20T+7qGtUgAerlf+D2QM3
         YW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XlbZNwo48GDl8y2bTtq9+IFF2msXuiIlT62vhrOeZBw=;
        b=M0U39girkVgb6Tzj5LeGrF+RASiQK87t0Ua9epKi4sir4k5xSCGZzQK/8kZl0f9xvD
         P6FZOmcfllitYIsKO2nMhOcdVU3sgSLiJtTjgZm7NnJEV2GIZS6TiD27cd+5hMSpbUGl
         ioUPrT7WHyn9RfAe5+HQt1Gr0CjaxiMzjFPUb5CchqLcf5jBD78hBoLEo0pCz4Zf5PQN
         0K9ZzlwM48RxF/RVfTy3rUS2H842hUqjn/BR92PqnLm026Qyd1nthH53cBudOfwIeemr
         C9MMTBSuFljzZkBvg5B4U2v1rmpH/R68Y0cAbmDHWl1AXZ95gTAh8PhLc1E0ixZSHJ43
         2Ahw==
X-Gm-Message-State: APjAAAVfVyvbVbP9jwsth+m06BSXD4wAutVLtRAC2SHjoN+nddI/cj25
        sBEMGMDeEgVHuHn3C1igufjSvw==
X-Google-Smtp-Source: APXvYqzJVq19Ys/DS0h9U528gw0Ga+03jwg3HSgwRVZHTFdvhfry7ZldqMo7t7mNt6UjAaTYopHleA==
X-Received: by 2002:a2e:8719:: with SMTP id m25mr5199259lji.50.1553255029470;
        Fri, 22 Mar 2019 04:43:49 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id u142sm1596399lff.14.2019.03.22.04.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 04:43:48 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, Alex Dubov <oakad@yahoo.com>,
        Alex Dubov <alex.dubov@gmail.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rui Feng <rui_feng@realsil.com.cn>
Subject: [PATCH 2/2] MAINTAINERS: Add Ulf Hansson to the MEMORYSTICK section
Date:   Fri, 22 Mar 2019 12:43:45 +0100
Message-Id: <20190322114345.26532-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The amount of changes to the memorystick subsystem are limited as of today.
However, I have a couple of times been funneling changes through my MMC
tree and it have turned out fine. So, I am here by volunteering to continue
doing this, by adding myself and the link to the MMC tree to the MEMSTICK
section.

Cc: Alex Dubov <oakad@yahoo.com>
Cc: Alex Dubov <alex.dubov@gmail.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Rui Feng <rui_feng@realsil.com.cn>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61bdbade3daf..8434d6ffa243 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14463,11 +14463,15 @@ T:	git git://linuxtv.org/media_tree.git
 S:	Maintained
 F:	drivers/media/i2c/imx355.c
 
-SONY MEMORYSTICK STANDARD SUPPORT
+SONY MEMORYSTICK SUBSYSTEM
 M:	Maxim Levitsky <maximlevitsky@gmail.com>
 M:	Alex Dubov <oakad@yahoo.com>
+M:	Ulf Hansson <ulf.hansson@linaro.org>
+L:	linux-mmc@vger.kernel.org
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
 S:	Maintained
-F:	drivers/memstick/core/ms_block.*
+F:	drivers/memstick/
+F:	include/linux/memstick.h
 
 SONY VAIO CONTROL DEVICE DRIVER
 M:	Mattia Dongili <malattia@linux.it>
-- 
2.17.1

