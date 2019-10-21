Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B79CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BD92084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O2gJBDIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfJUK6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:58:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51177 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbfJUK6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:58:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id q13so2740389wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=skmII0RjDFD6SFbyT8IGszhWT77ReZDZIQ2EcDM2hGg=;
        b=O2gJBDIt/uu3D3HrGWT7bdvLhDBGsgkK+oKb1wgbr874atEZbtzgTb8tFMtu8f/0R6
         DqH9iU2QQIsK7OyqVEb3An+lKaclKzQvZwQ/cjdA3GiRoKszuxJb5p9srbdXf89RCJmo
         qpwCM28UgKws0pbdkgaxpwhS8W9n+q0Yn0uGsj+fB5S2t2AA9m8Mx8LifNoureM40/ss
         CQPAx86Vv5QabLz+CB7Y/c4SgIwxO1/6zKvo5bnGXcSYEYTp6iLO+gK4sWphMt/NfFor
         NR/+JYtiap6aqa7V0py2HEeSMWxcnmxz//1mXU17TOnqGHkOvcjvGRD5mVzQfPt6aqlY
         ufEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=skmII0RjDFD6SFbyT8IGszhWT77ReZDZIQ2EcDM2hGg=;
        b=rljpBIIkBrKGt1SNShNEqTI5gfrQVLiBLGopdyY6/jwwNwtfLlqo3vuA0OR0dK0q7m
         lZWLq7nR/8usRlNjXAEHU0+fG0uNMExl0ACH5P0ubfo6zCrmoMvyezSJANplJ82DabDt
         HKAPP3BpofJJGsL+NW+xx25GdQDS+Rra+enGvIL9lBq3O5UiGhYLMcJWjfH6lJpd7tEg
         lReKIRDLU4jbmiMeyQr8H6jQyDEgN6wEkyH6tlngkFyXorNyfVa8LpwkqiMOsfByxsBw
         iuCTRO+PA2WMamrppQ3DTvnjasrMgi5XpZxWAedcs+PyxTBMOe7JFDZmaw9VDQ6RZ9ON
         iGQw==
X-Gm-Message-State: APjAAAXzDXKDawsyI6hyfHEFE6cCqc9SLRi8bBMPS3XD+f+Be+mClRYF
        Jm9jElP1QOxWNobwuR3i4k4y0Q==
X-Google-Smtp-Source: APXvYqz3U3MGv8VHAO1I2eIglmjVZ+mPUIWrzgDEdGlAlL0T5JpQMoPplNl1K4VOBbZfJbY965PkdQ==
X-Received: by 2002:a1c:a9cb:: with SMTP id s194mr2818850wme.92.1571655509326;
        Mon, 21 Oct 2019 03:58:29 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id q22sm12544289wmj.31.2019.10.21.03.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:58:28 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 4/9] mfd: cs5535-mfd: Register clients using their own dedicated MFD cell entries
Date:   Mon, 21 Oct 2019 11:58:17 +0100
Message-Id: <20191021105822.20271-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021105822.20271-1-lee.jones@linaro.org>
References: <20191021105822.20271-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CS5535 is the only user of mfd_clone_cell().  It makes more sense to
register child devices in the traditional way and remove the quite
bespoke mfd_clone_cell() call from the MFD API.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/cs5535-mfd.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
index 053e33447808..96a99ac13384 100644
--- a/drivers/mfd/cs5535-mfd.c
+++ b/drivers/mfd/cs5535-mfd.c
@@ -57,9 +57,17 @@ static struct mfd_cell cs5535_mfd_cells[] = {
 	},
 };
 
-static const char *olpc_acpi_clones[] = {
-	"olpc-xo1-pm-acpi",
-	"olpc-xo1-sci-acpi"
+static struct mfd_cell cs5535_olpc_mfd_cells[] = {
+	{
+		.name = "olpc-xo1-pm-acpi",
+		.num_resources = 1,
+		.resources = &cs5535_mfd_resources[ACPI_BAR],
+	},
+	{
+		.name = "olpc-xo1-sci-acpi",
+		.num_resources = 1,
+		.resources = &cs5535_mfd_resources[ACPI_BAR],
+	},
 };
 
 static int cs5535_mfd_probe(struct pci_dev *pdev,
@@ -105,10 +113,14 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
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
+				"Failed to add CS5532 OLPC sub-devices: %d\n",
+				err);
 			goto err_release_acpi;
 		}
 	}
-- 
2.17.1

