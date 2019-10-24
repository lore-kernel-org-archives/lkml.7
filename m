Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72CCCA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDFE205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dEYKAgP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503554AbfJXQir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:38:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43576 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503523AbfJXQio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:38:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so21606689wrr.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hp9auP1eDPhHh11Inl/NtM2csOEQVC7OB8vmkOBN3Yo=;
        b=dEYKAgP8b62ELK3aQy8Sm5kXfcxSfxaAtjT6k+tEy2Fr1SkdaT8Z6Pmgbfx5CXzc14
         jTsX9Jkng/DOgrAv0GelNisE3nHQ7yTupEmSIAw/5n4kSTtlYrgx/YLnF8DGyvAslB8P
         p0BbLyzg/LECSvrUWBrp0j7oW4JkIqArUMeHE28aaAMfMMnvRLn1MfFJ+8lVl8XlSmxk
         n/TCMCnjjEQPP1XiIBwM5a61rQX3N5AwYfykWqp0MbROF9g2ZoZQBdCr5CjtYKC5eVzL
         +Es6ogdDihTa1NzCLCbLUQ9BywpWX9XItmuPED0qWoroBUJsMwNdyk6pt70Y5qJYO4hx
         31OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hp9auP1eDPhHh11Inl/NtM2csOEQVC7OB8vmkOBN3Yo=;
        b=HnT9HhS1+3TIKCbbm+ZZAONQ2wKyDOriG8NHJ+NA6yfYBmusY6Lsa9BmXBzCixT+wE
         peY2/BT/xmUrC+1om5PpA2jnGdGtvrXy2rIms7NyXcTWzeGc9hMJGsWiT35yJNbozIOE
         xwqWPEwZjuVRh4yXbrRVaXRD4qfajL3UX5/iBkhWndMUNSr58XLQ4ukX8QNZ9++QEo5p
         eDVjzOJOXxVI3CWquct+2wDxMeAYMOAWzDEgL3ZCLw3GahzgpxFT610oEg1y9I+VNUHO
         lJ4AXGlWSSGel6ijPwUrvg7uokuMOAfyClCvl2PQQrxNfxzNwFmpzaEdvT+4byA4yg2+
         f1xQ==
X-Gm-Message-State: APjAAAV4f/GlqAzy1os/dEKe5f7v2JJ+Ux3j1PwPjf3wHu0AOUWIvTGQ
        LUTeNtpuUz22RcO1IuesjXR5LQ==
X-Google-Smtp-Source: APXvYqwGElQJItgpvXG2KweIz1nT4zNaMi0EfD6C7LIDSjrHnlkygJRqfB/W9QG2S4JqeD5Mmp8A+Q==
X-Received: by 2002:adf:f686:: with SMTP id v6mr5010878wrp.141.1571935120637;
        Thu, 24 Oct 2019 09:38:40 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id 6sm3446175wmd.36.2019.10.24.09.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:38:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 04/10] mfd: cs5535-mfd: Register clients using their own dedicated MFD cell entries
Date:   Thu, 24 Oct 2019 17:38:26 +0100
Message-Id: <20191024163832.31326-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024163832.31326-1-lee.jones@linaro.org>
References: <20191024163832.31326-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CS5535 is the only user of mfd_clone_cell().  It makes more sense to
register child devices in the traditional way and remove the quite
bespoke mfd_clone_cell() call from the MFD API.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/cs5535-mfd.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
index 27fa8fa1ec9b..4c034c9f2303 100644
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

