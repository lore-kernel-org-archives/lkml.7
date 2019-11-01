Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB34C47E49
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71C6208CB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NLpmXnv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbfKAHpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:45:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55660 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730095AbfKAHp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:45:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id g24so8446741wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 00:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o/WXNJ1LA673vdJ8sFOa/ninCgRnpi26dheEONfyqB0=;
        b=NLpmXnv7R42LKiqA47VpSnkRY8XSxT2H2FVSayMw/zkOdsQZzOkqdbPIQ/zqzCB0db
         y1kbqWP6t1ZUqf2oG8daRFBPtTfdlI0EhlkJjDINFp0R+3vik28XAfGFzUi/YcMLwbZ4
         q5YudIUt0fOEXyeHJzEPJKZHIEheIL/Vl2oW2w92Bksv+d5sT+DP9vkVugFdl/uXBG0Z
         DTkzSlSAWby6oCttAgyuuRZpASHljJq6nuGd0k9KJ8HyDyz4Gad2Ni90RK5h/+fk+tfK
         Xxp5P3XYMA0CjrWLUpV8mIegqZNVrZgpJRxOU5z/h2T25UfZimy0TX/BlswzJX++KXp4
         KvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o/WXNJ1LA673vdJ8sFOa/ninCgRnpi26dheEONfyqB0=;
        b=eVGzx4P+POqAKGQKsZIVuDpl+0V+8aLjhoTH157vEJmiTu4II17RKATrYvNsG6XVGW
         237CDOJAuc5P/AnEdokjz7/P2MvJx8EpoKkLTvcAKC8yGoFB9DoXAxq9urcazWs8KnRX
         S0ReY9357K3A5nVs0EJ2thbmWW3UkYVldpHwBzUtZtD6vWffmgP6YW9ruCqkmW8skU+Q
         D1PoCwwLwLkezgWKqGzrtmQO3KvKMMcZYHFPaVXz0qv8y+JNEMyJ1VAXjwz17worc+t6
         u1m//ASGZkGVBf9n1Z52sQi2d7zgbs7npft9spuneV/0LVq/5vstqnR1Iah0c05aVTyC
         sMKQ==
X-Gm-Message-State: APjAAAU/kqYO7nFU/nnW58jdr+QXSOC6BYse3/2LONyc3gyJfeIvbesq
        ygu5ETW2pX5HSm9XiGj/cJfjVQ==
X-Google-Smtp-Source: APXvYqxrp51r0BToycxLzs+62ME/8nCKs9NXgANVP3qglKRs+XlWI6yZaUm8W6tBL1BpnBLsbC2Slg==
X-Received: by 2002:a1c:5f04:: with SMTP id t4mr8374156wmb.23.1572594326248;
        Fri, 01 Nov 2019 00:45:26 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.64])
        by smtp.gmail.com with ESMTPSA id b1sm576215wrw.77.2019.11.01.00.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 00:45:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, linus.walleij@linaro.org, baohua@kernel.org,
        stephan@gerhold.net, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 04/10] mfd: cs5535-mfd: Register clients using their own dedicated MFD cell entries
Date:   Fri,  1 Nov 2019 07:45:12 +0000
Message-Id: <20191101074518.26228-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101074518.26228-1-lee.jones@linaro.org>
References: <20191101074518.26228-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CS5535 is the only user of mfd_clone_cell().  It makes more sense to
register child devices in the traditional way and remove the quite
bespoke mfd_clone_cell() call from the MFD API.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/mfd/cs5535-mfd.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
index 3b569b231510..d0fb2e52ee76 100644
--- a/drivers/mfd/cs5535-mfd.c
+++ b/drivers/mfd/cs5535-mfd.c
@@ -50,16 +50,19 @@ static struct mfd_cell cs5535_mfd_cells[] = {
 		.num_resources = 1,
 		.resources = &cs5535_mfd_resources[PMS_BAR],
 	},
+};
+
+static struct mfd_cell cs5535_olpc_mfd_cells[] = {
 	{
-		.name = "cs5535-acpi",
+		.name = "olpc-xo1-pm-acpi",
+		.num_resources = 1,
+		.resources = &cs5535_mfd_resources[ACPI_BAR],
+	},
+	{
+		.name = "olpc-xo1-sci-acpi",
 		.num_resources = 1,
 		.resources = &cs5535_mfd_resources[ACPI_BAR],
 	},
-};
-
-static const char *olpc_acpi_clones[] = {
-	"olpc-xo1-pm-acpi",
-	"olpc-xo1-sci-acpi"
 };
 
 static int cs5535_mfd_probe(struct pci_dev *pdev,
@@ -101,10 +104,14 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
 			goto err_remove_devices;
 		}
 
-		err = mfd_clone_cell("cs5535-acpi", olpc_acpi_clones,
-				     ARRAY_SIZE(olpc_acpi_clones));
+		err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
+				      cs5535_olpc_mfd_cells,
+				      ARRAY_SIZE(cs5535_olpc_mfd_cells),
+				      NULL, 0, NULL);
 		if (err) {
-			dev_err(&pdev->dev, "Failed to clone MFD cell\n");
+			dev_err(&pdev->dev,
+				"Failed to add CS5535 OLPC sub-devices: %d\n",
+				err);
 			goto err_release_acpi;
 		}
 	}
-- 
2.17.1

