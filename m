Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36797CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D1D21734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 07:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vdGFsAjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbfKAHp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 03:45:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33753 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730082AbfKAHp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 03:45:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id s1so8831462wro.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 00:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C/fpce4zj8Symqro3B0UUT4uQWdn48veRLNE2xUiEm4=;
        b=vdGFsAjypI0mSjBgOqNUooAp4m4MfQ3YHrTg00PdnnA9cGN40by+eWJugaNkshf/ZB
         KR3IFrZ6ysfOE0+XKewaL50A4TNjCAL7tv0Fsi0pIY1f86g/5nZkEKP085Tux1fMEM3Y
         kUDK9XDy5ceVyg+QvbSqg6AuLfDPqtWroZrgdR0WAx0L91cOQrcqgWdjIHErHpt4VXCS
         4yHGTUCPWjz6TvOinw8pjau6F783yazcdNr+vFEpgamEysT4OqJ8ZL3O0y2usDFtAtww
         M34m9y7C+zIIeHrIkOF4qbE9xNou0Z3cBPGq/bUeLDmImLlg6fiOV/IofRdBOY0vepuW
         YXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C/fpce4zj8Symqro3B0UUT4uQWdn48veRLNE2xUiEm4=;
        b=tEqAjAgBaBbk0tobWG99PL/8myN/FXj5fSffHguRZ8cIxwaAII9ZN0DlFyCql4DXbS
         glv8AIGFwbOvOAxNKK2vmxslWHQXxGbD1ZNaynwtioD1In5xPoYlEXa1KjJks2PjVM73
         r7pd6Llk60OSSA20GKuOPhz3CymszgHkGkWQ4sG9IHB1CbfbJjiqPSuMzUMtHjweX0f3
         vTJ0KMkiy55Gn0eFRxPWw6r5zLFH0XAxvxn0+hw2XySA7EVZDbY23aGJuDtU97Qc/CG+
         g6VMk/E4R4hWp8vAHnvNRZUB4seaZiILnbKLfoD8dYIdeWGS4qdQA2jLOOGIVNmE3Dqh
         dYgQ==
X-Gm-Message-State: APjAAAV/++AaH3gx8RCP2qF0lXi6WSd2UPFX/6NWMB1ORC9a2QVyb5ZI
        D3j5kTz6Ak2WFtDwpp8g6p101w==
X-Google-Smtp-Source: APXvYqwq+F6gA3UQw8pVEhUfe9Xu39bSZwSSmj9CGYK4g86iUd/eJHgSykb2d4ooTXLkEUz4BlNDww==
X-Received: by 2002:a5d:6944:: with SMTP id r4mr1938621wrw.238.1572594323745;
        Fri, 01 Nov 2019 00:45:23 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.64])
        by smtp.gmail.com with ESMTPSA id b1sm576215wrw.77.2019.11.01.00.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 00:45:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, linus.walleij@linaro.org, baohua@kernel.org,
        stephan@gerhold.net, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v4 02/10] mfd: cs5535-mfd: Remove mfd_cell->id hack
Date:   Fri,  1 Nov 2019 07:45:10 +0000
Message-Id: <20191101074518.26228-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191101074518.26228-1-lee.jones@linaro.org>
References: <20191101074518.26228-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation abuses the platform 'id' mfd_cell member
to index into the correct resources entry.  Seeing as enough resource
slots are already available, let's just loop through all available
bars and allocate them to their appropriate slot, even if they happen
to be zero.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/mfd/cs5535-mfd.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
index cda7f5b942e7..b35f1efa01f6 100644
--- a/drivers/mfd/cs5535-mfd.c
+++ b/drivers/mfd/cs5535-mfd.c
@@ -63,25 +63,21 @@ static struct resource cs5535_mfd_resources[NR_BARS];
 
 static struct mfd_cell cs5535_mfd_cells[] = {
 	{
-		.id = SMB_BAR,
 		.name = "cs5535-smb",
 		.num_resources = 1,
 		.resources = &cs5535_mfd_resources[SMB_BAR],
 	},
 	{
-		.id = GPIO_BAR,
 		.name = "cs5535-gpio",
 		.num_resources = 1,
 		.resources = &cs5535_mfd_resources[GPIO_BAR],
 	},
 	{
-		.id = MFGPT_BAR,
 		.name = "cs5535-mfgpt",
 		.num_resources = 1,
 		.resources = &cs5535_mfd_resources[MFGPT_BAR],
 	},
 	{
-		.id = PMS_BAR,
 		.name = "cs5535-pms",
 		.num_resources = 1,
 		.resources = &cs5535_mfd_resources[PMS_BAR],
@@ -90,7 +86,6 @@ static struct mfd_cell cs5535_mfd_cells[] = {
 		.disable = cs5535_mfd_res_disable,
 	},
 	{
-		.id = ACPI_BAR,
 		.name = "cs5535-acpi",
 		.num_resources = 1,
 		.resources = &cs5535_mfd_resources[ACPI_BAR],
@@ -108,23 +103,18 @@ static const char *olpc_acpi_clones[] = {
 static int cs5535_mfd_probe(struct pci_dev *pdev,
 		const struct pci_device_id *id)
 {
-	int err, i;
+	int err, bar;
 
 	err = pci_enable_device(pdev);
 	if (err)
 		return err;
 
-	/* fill in IO range for each cell; subdrivers handle the region */
-	for (i = 0; i < ARRAY_SIZE(cs5535_mfd_cells); i++) {
-		int bar = cs5535_mfd_cells[i].id;
+	for (bar = 0; bar < NR_BARS; bar++) {
 		struct resource *r = &cs5535_mfd_resources[bar];
 
 		r->flags = IORESOURCE_IO;
 		r->start = pci_resource_start(pdev, bar);
 		r->end = pci_resource_end(pdev, bar);
-
-		/* id is used for temporarily storing BAR; unset it now */
-		cs5535_mfd_cells[i].id = 0;
 	}
 
 	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, cs5535_mfd_cells,
-- 
2.17.1

