Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2295BC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AD12186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="js6wQDtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731157AbfDELu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:50:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39743 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731125AbfDELu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:50:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id j9so7631438wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j/G+Q6ryO5QD2klIAN3tHHLuG2QV/gS3koPfNp4bcRs=;
        b=js6wQDtVU2nDddmV7dXvCTKNRa/y/ndS4+ea9fmqr/w5sg6eMJZVW7rbeXQmGks7t3
         DbEtUuQOrWw/Lz7jVoeU3MG71AUYz9RN9ClxkYYqnvdclL0+1xN8NNZ4NiMFzuvWw45m
         53Y2RCXSnh4WIaBRWYybjqvYHy/WLSJt7ws9SxB8b5EowrDOS5g1ZHJ8H+78D0LIi79/
         PaPAl2TqPfa7tSemODxMoWaW5Sn15nRz9tgfc8gkA0YPMy9FPpgkgfFi9BgzC0ER4Eld
         UeasmiJDwRZq5HUxF+m6mho6y5zdjiPINjoYkMHuOdxBs1HEwsK4a5Ld7qEPvcSclf+Q
         Jyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j/G+Q6ryO5QD2klIAN3tHHLuG2QV/gS3koPfNp4bcRs=;
        b=QwSWjsvv91eJobtc1KMzbJqRKQ5Ri8F0HEcnEKaWjM6l7SneuutS8UmNmyrCGrvLn5
         WDMwXGBq/M7Lqgy3GS6XepHdMSlv1seIGppJCN/JE82KRPjeTBQ066atB5JHbJGMNAcw
         XSJ5/PK0jeIKw/9Qbn9PEFI1VmOiLeH1kPyDprs8fz8kgAnFfEyFOkyaQj5ZSbmBJ57X
         3L7mhk7v/qG3Xul4K+CzrZ1JubihxgyD572sIA8SZ7mc9cqnDcTYbAhbV2/sHQ+m8G2E
         QlnY+qxDcVRuI2RBnP+sDzUiQn4JZXGX+ZhElXzEvau4xKgcW5oEH6nj7RnEb8Mcqkj8
         8JxA==
X-Gm-Message-State: APjAAAWIsKKcoHKzyfT9YxfYqKk0HPYR5LpMEScXTd80vAKtVbu8Xdtz
        v6oUgfzPHxtJF4eKCxoyxV0=
X-Google-Smtp-Source: APXvYqzDUpZcwDBcQbPYSpsa5G5tlghd4vZrHUHPbGiJZws4jMXKgcJbhOiwhWclw9PLaKPzP8M9HA==
X-Received: by 2002:adf:eed1:: with SMTP id a17mr8341942wrp.268.1554465054410;
        Fri, 05 Apr 2019 04:50:54 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
        by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:50:53 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 06/20] ASoC: imx-es8328: Switch to SPDX identifier
Date:   Fri,  5 Apr 2019 14:49:56 +0300
Message-Id: <20190405115010.28838-7-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190405115010.28838-1-andradanciu1997@gmail.com>
References: <20190405115010.28838-1-andradanciu1997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 sound/soc/fsl/imx-es8328.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/imx-es8328.c b/sound/soc/fsl/imx-es8328.c
index 9953438086e4..c9d8739b04a9 100644
--- a/sound/soc/fsl/imx-es8328.c
+++ b/sound/soc/fsl/imx-es8328.c
@@ -1,14 +1,7 @@
-/*
- * Copyright 2012 Freescale Semiconductor, Inc.
- * Copyright 2012 Linaro Ltd.
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright 2012 Freescale Semiconductor, Inc.
+// Copyright 2012 Linaro Ltd.
 
 #include <linux/gpio.h>
 #include <linux/module.h>
-- 
2.11.0

