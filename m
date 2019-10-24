Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAEDCA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C5221906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AO2viM8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503696AbfJXQje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:39:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34270 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503504AbfJXQil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:38:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so21708960wrr.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 09:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UL330JCxNCb1QfPA7XEdnee8d8sanDm58UEp+DpPD5E=;
        b=AO2viM8RfA1DxiniDHFsPnX7EJHu7id0/Nbauz4pHVAcEh/Vqn3h1cCsIRCAaGNIJr
         ZjlMabMeGfI++dacJ1ty4Ouq/jr7hOu1XAeoUkC1u+G903TpW9UwEjkRM1uCUUrcLVxI
         H/H643bgLQqGEWNJw5wEUgSR2bEqy2cfVXnngqm+AfFt0J2WpsMNXHexR2K3WYED4KND
         5mSLuNIQ72aRBZgvd7e+0KcCpu5+ZxUSH+089gVL4hDpasT4MWDHRnUdhJFbpRUu6rim
         ZFOwtDQ0W393tuxnG/lfjtS+iV+0GJXV74Y3KSZgyVIRWQsZLwLeBhH/kvS3Dlr7XQ3g
         bKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UL330JCxNCb1QfPA7XEdnee8d8sanDm58UEp+DpPD5E=;
        b=iFJHcPB1mFZe+tZNgQhDpnTfcDVPoamkbqL4OaUWphLpcT2HbqLtyUc0753//vD8rD
         w2jytXwdCw+x9zz2qUExJaofl8VfoOetQ4TRHLOG4Z+qxTHoARr9VlAhzH2GrsjjK9M1
         hFPvqp08epsqtphHVl0mLqMvI5ZweuZ/ZLdWqeEydaqbW4nbnmBcAzTq777tSU8JAeFK
         FqGXmQporkrn4VCq+Vk4KgBUECXoE5Q1vgl9vT/INDPVprSxjmGepSU2zOgvPCr5q0Yx
         9d/WNluXUO0crIQ0J0hruAU//cnYWr/8bnt6DVc5ohWth1uEjckoo8uadKpeiCT8X6YL
         uwaA==
X-Gm-Message-State: APjAAAW6n8A4M7iTGbd7DjTKaeHbinbGzgesgYdILzMmSzY0XximMviu
        LNDIfuQoOYXrjBzutjZHpb05LA==
X-Google-Smtp-Source: APXvYqy2xkfi86nA4mhOrLIzpA090ARXwDKjuWsAZVNAIY7/Ok8ONn/AZjlyCf2mh96jrKmo/A+TgA==
X-Received: by 2002:adf:da42:: with SMTP id r2mr4493849wrl.383.1571935118290;
        Thu, 24 Oct 2019 09:38:38 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id 6sm3446175wmd.36.2019.10.24.09.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 09:38:37 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 02/10] mfd: cs5535-mfd: Remove mfd_cell->id hack
Date:   Thu, 24 Oct 2019 17:38:24 +0100
Message-Id: <20191024163832.31326-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191024163832.31326-1-lee.jones@linaro.org>
References: <20191024163832.31326-1-lee.jones@linaro.org>
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

