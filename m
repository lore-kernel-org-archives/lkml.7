Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAD1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 784AA20857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtKrig73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbfCZPWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:22:06 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36695 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731652AbfCZPVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:21:50 -0400
Received: by mail-it1-f193.google.com with SMTP id h9so20600870itl.1;
        Tue, 26 Mar 2019 08:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J6aYt82B/im1x/Yyr0qGXhiLTzFyVheHcnku77QlNA8=;
        b=RtKrig73ZaeRLJqjod9yAuZZ/PW+U5Jdk9k3l6bkTPy5xRobq6AKynDzaw308lmyku
         elR8m80GNMYSy+TnJPwQocyV42ta0RKp7pxri0wz2C/s232eRi8g+m5ZuIodWUuExD5Z
         qEvNx59geh7gzzjRMbxbmLUdZJlisdYe3sb8b97ofCj+qMQiZPk2YX/w6zT1fEd9kvGx
         58Na8oxWCpzxpE/Mn2qK07lVxzOX8wVE9W4hLJXO1+bexELeF35phgX09Nmrs07SS08U
         kgqyppP8TVIrfzPCSzBshaa9UN5zysf0vCp957XfvtosUC56jRlFHDuldeVg33qIioAH
         rrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J6aYt82B/im1x/Yyr0qGXhiLTzFyVheHcnku77QlNA8=;
        b=QS7fG+EX/vrEaNM7s65i+Ru5PxYVuTPGVwDc6wLGK4yaF4Ocfu+uCBz/ViOmdlm85v
         dikHIIkIJhit/TN95WJZSqYAnet1R6dudo4zX4iVpmPko0w9tWK+D3M1RmGjgBKdXlyo
         g93l9oOFciz0vcZe+Yv+TO1vYciVL6cmt6XOuFHUD382yiJB0aGu7ywvY5VK+sPaT3Kj
         BU0vtRQOBBMvPunaCp7ol2AkGSnSTMC8SaVsH8b5DHgHtvgzrEnsGVBIN6i17OZRCoab
         jRRfpGLnf80ikatRYKTNMe1XoJfIOcaQYKSekBtf3XLCrj5FAN9N/B1P3ba4AcIuTqWg
         934w==
X-Gm-Message-State: APjAAAVyarUfn4zAjlVmzaQKngkKECjJkioynb0RCcvfNcBRosxfoM/q
        A1qSNh1DjybICRQsoHRfXNc=
X-Google-Smtp-Source: APXvYqzQmMOwsVZBvJGxm8+3v+CdARmSuXNTJ1+edpRp6wzv8fzRvt9amN0gFZNZcwnMGHJzxJK47Q==
X-Received: by 2002:a02:c4c8:: with SMTP id h8mr23250884jaj.33.1553613709403;
        Tue, 26 Mar 2019 08:21:49 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id w14sm6861045iol.32.2019.03.26.08.21.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 08:21:48 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH v4 1/2] staging: mt7621-mmc: Remove obsolete Kconfig flags
Date:   Tue, 26 Mar 2019 09:21:38 -0600
Message-Id: <20190326152139.18609-2-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326152139.18609-1-thirtythreeforty@gmail.com>
References: <20190326152139.18609-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These values are not referred to anywhere else in the kernel. Card
detect is controlled by the device tree property "mediatek,cd-poll",
and there is no driver support for eMMC whatsoever.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
v2: Rewrite of v1
v3: [Not present]
v4: Resubmit of v2

 drivers/staging/mt7621-mmc/Kconfig | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/Kconfig b/drivers/staging/mt7621-mmc/Kconfig
index 1eb79cd6e22f..01f231dd8511 100644
--- a/drivers/staging/mt7621-mmc/Kconfig
+++ b/drivers/staging/mt7621-mmc/Kconfig
@@ -6,11 +6,3 @@ config MTK_AEE_KDUMP
 	bool "MTK AEE KDUMP"
 	depends on MTK_MMC
 
-config MTK_MMC_CD_POLL
-	bool "Card Detect with Polling"
-	depends on MTK_MMC
-
-config MTK_MMC_EMMC_8BIT
-	bool "eMMC 8-bit support"
-	depends on MTK_MMC && RALINK_MT7628
-
-- 
2.21.0

