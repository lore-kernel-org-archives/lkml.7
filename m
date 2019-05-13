Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F080CC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE58C208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 21:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8I4XgVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfEMVx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 17:53:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44142 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfEMVxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 17:53:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id z16so7435674pgv.11;
        Mon, 13 May 2019 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Af+6okQBbBqI283SlkSp5KD4CPy+AkHPzwyEcYQ+9Mg=;
        b=O8I4XgVOCq74r1feptf9zgrHpt+U2iBYWs7/dKmUqEO2eqiOnOXtCBz3KC2sAI9Ofg
         4AZnd1Yk9AZNzgyR3VeDDvu8v2JoVVFB/dhQdMWGdcVk7gm+gs5OuVO21mon5ULj33Bv
         6Cvx5mt45jq1Tlc7oJuSd/ZiIbqZTn+lQ1amW5YtrZmIECmeEHT+9fLtWrw2UR7tET9w
         mxT9sjR5o/bJmE/ghiyCVdzcq/XK7QGZtDZemzhOmczjy50wUFP0KKmnrZr+blMafYKc
         ZcsUEzfZiWsaTqaY7e002vRgdV6JAMUQTHTe6oZIbPZiFunn6fXPVKCYvMk/82rRG3xj
         JP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Af+6okQBbBqI283SlkSp5KD4CPy+AkHPzwyEcYQ+9Mg=;
        b=IuxbEF3+sun1gW65gLAxfXHzMo+1xeqv7XcUJ9cwO/4ugqNNtmlDuwBymWAxMZprDu
         lv0QXfAiQSJdLyebUplxUi0pVk5jTgKpL895NUYveNeBLLsq533GCV2oMhpMX8OED6/g
         00NGG0zUvthtqt5zieHQr3GLFlpq18zExrAjuVb0NBSKaVtSqy6lX5leNCr5aIgXKW6l
         ZoSwae8v2aKRuhIuN9n1MMsV+b9IfjGWlYP8adfdfwEbmRoQRYKeDpMubZa674wlbfyd
         FjEqbZadMvbCbCTxpu6AhdsErajde3UQ2oCS961IxUTfFuuwJbimSfPUdUV+Bjq57BfI
         kRtw==
X-Gm-Message-State: APjAAAVSOSDi8NnT5zYkwp5M/RCucXCQvCinuL9GAGN+OZUoRuYFk+kD
        Ij6V/oDUnw/NJaguL+4nHKo=
X-Google-Smtp-Source: APXvYqxQfC7rxTwzqnurcGJCKorLWeHY83pWqcRsPzAnMoDQiajt5AJ/SVJ9Hn1lxg1NpzzxhtNboQ==
X-Received: by 2002:a63:6a41:: with SMTP id f62mr34252054pgc.392.1557784404434;
        Mon, 13 May 2019 14:53:24 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id h11sm13761369pfn.170.2019.05.13.14.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 14:53:23 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@vger.kernel.org (open list:BROADCOM NVRAM DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] firmware: bcm47xx_nvram: Allow COMPILE_TEST
Date:   Mon, 13 May 2019 14:52:50 -0700
Message-Id: <20190513215250.19246-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513215250.19246-1-f.fainelli@gmail.com>
References: <20190513215250.19246-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow building building the BCM47xx NVRAM and SPROM drivers using
COMPILE_TEST.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/firmware/broadcom/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/broadcom/Kconfig b/drivers/firmware/broadcom/Kconfig
index f77cdb3a041f..c041dcb7ea52 100644
--- a/drivers/firmware/broadcom/Kconfig
+++ b/drivers/firmware/broadcom/Kconfig
@@ -1,6 +1,6 @@
 config BCM47XX_NVRAM
 	bool "Broadcom NVRAM driver"
-	depends on BCM47XX || ARCH_BCM_5301X
+	depends on BCM47XX || ARCH_BCM_5301X || COMPILE_TEST
 	help
 	  Broadcom home routers contain flash partition called "nvram" with all
 	  important hardware configuration as well as some minor user setup.
-- 
2.17.1

