Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A232CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBA3222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a1/kW5wJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438918AbfJRM4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:56:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39053 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410148AbfJRM4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:56:15 -0400
Received: by mail-wm1-f67.google.com with SMTP id v17so5994303wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 05:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uffMabFPldA3sW0xXZbJX93ZYIXfUZ6x/6qzeDvqKHU=;
        b=a1/kW5wJjmnv20kwpLmkrzovugTb1olIvoyebb0Vdjs5JnX4ljk48LR2JgfzAjq4/n
         YKi2C6bNqD6clsE+QBZVYEo9XsI9jYOLAtvqUdSnnzW/tlQWAbhfDG+sMMdt2e6Q+1LP
         j0c5e06g8KXzDIAG5CgCngwS8Z6LW3mdQFpgOI20kiWERusJCaNM7w5z37F3BEO+XFwm
         VbQyEFtAOvTXyzASG63fQ6P1o4Xt+5v+br3HT9BljgIjlArGhXRfP++umd0r5DVc1rZm
         TshzZHKWukXC0S2TOXY/8NsmxbDHS/UUjOOwV9zz/ILiIE/4x5e50M9xrFEpir2W6KMQ
         3w2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uffMabFPldA3sW0xXZbJX93ZYIXfUZ6x/6qzeDvqKHU=;
        b=P1bk2o9hdyYgAVyfbrPQyHfG1BImackkh3KwOzVrpxKOhE/EgozpFWeLLgZ/PC9dbJ
         aOhI3rBDOWOfo/MlI4jwAHV0+aSYkXJWKfxL5Jyj4FVmvDRkTvdB91LPZd0j2vtPtwdD
         RUvoZPHk0ijYSfetqMcLNrO19tmKuf76QsOoIhEA7VIfj23JP/7fBRPDqYIrm+seCKuJ
         fZ1fAVPBYsZk5ozOVVgQOViFAS5pR0FCvxT+YSNhBtX0kK9drXaHaRJCVXTOKOuFxnH/
         02ytjQYueuxIPy+pkW/zUbdo8pLsQJ/kFhAqA2d5Dc8J+VaXIe/trK/yv9Hk9Ht0G8IR
         dFfA==
X-Gm-Message-State: APjAAAW/uuYYjcwsulwtG0gVDbf936oMSMOo/zEni0+lpcErbfhJB4sx
        vgckptvc6H+3cjMBM2xlA/dmVg==
X-Google-Smtp-Source: APXvYqyd+jbqP648qNeI/3VI5El40fe71lbxYgMGbkq3kIpZDIl9BMQjAkZaAMbHCWN+vkX68s2WaQ==
X-Received: by 2002:a1c:6702:: with SMTP id b2mr2599688wmc.107.1571403373543;
        Fri, 18 Oct 2019 05:56:13 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.47])
        by smtp.gmail.com with ESMTPSA id q14sm6058491wre.27.2019.10.18.05.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 05:56:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, linus.walleij@linaro.org,
        daniel.thompson@linaro.org, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dilinger@queued.net, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 3/4] mfd: cs5535-mfd: Register clients using their own dedicated MFD cell entries
Date:   Fri, 18 Oct 2019 13:56:07 +0100
Message-Id: <20191018125608.5362-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018125608.5362-1-lee.jones@linaro.org>
References: <20191018125608.5362-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CS5535 is the only user of mfd_clone_cell().  It makes more sense to
register child devices in the traditional way and remove the quite
bespoke mfd_clone_cell() call from the MFD API.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/cs5535-mfd.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
index b01e5bb4ed03..2711e6e42742 100644
--- a/drivers/mfd/cs5535-mfd.c
+++ b/drivers/mfd/cs5535-mfd.c
@@ -95,9 +95,23 @@ static struct mfd_cell cs5535_mfd_cells[] = {
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
+
+		.enable = cs5535_mfd_res_enable,
+		.disable = cs5535_mfd_res_disable,
+	},
+	{
+		.name = "olpc-xo1-sci-acpi",
+		.num_resources = 1,
+		.resources = &cs5535_mfd_resources[ACPI_BAR],
+
+		.enable = cs5535_mfd_res_enable,
+		.disable = cs5535_mfd_res_disable,
+	},
 };
 
 static int cs5535_mfd_probe(struct pci_dev *pdev,
@@ -130,8 +144,18 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
 		goto err_disable;
 	}
 
-	if (machine_is_olpc())
-		mfd_clone_cell("cs5535-acpi", olpc_acpi_clones, ARRAY_SIZE(olpc_acpi_clones));
+	if (machine_is_olpc()) {
+		err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
+				      cs5535_olpc_mfd_cells,
+				      ARRAY_SIZE(cs5535_olpc_mfd_cells),
+				      NULL, 0, NULL);
+		if (err) {
+			dev_err(&pdev->dev,
+				"Failed to add CS5532 OLPC sub-devices: %d\n",
+				err);
+			goto err_disable;
+		}
+	}
 
 	dev_info(&pdev->dev, "%zu devices registered.\n",
 			ARRAY_SIZE(cs5535_mfd_cells));
-- 
2.17.1

