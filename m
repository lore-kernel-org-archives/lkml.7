Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F0CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D7421A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdQ6YV2u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbfISHsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:48:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35397 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfISHsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:48:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id v8so1993841wrt.2;
        Thu, 19 Sep 2019 00:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4+IikWYzTHVoP+qr/bH+QADSSsqMyHaDXXhUq1MQaqE=;
        b=CdQ6YV2u8DkvN7NZv3oWamzT06hOVlVxmHK0/goVfJ5nYPRBaDq2MzukNnVes247od
         6A/pVklUbgoTWlHmjo65l+vUzL1dxZJ+AJ6API3LDshNMG4Lo39mi2j3YMKQtdi5iyMX
         k91ok8cbypGednfDRH+hiu/W01ecXreCaFnvov2ay/ZvgNslymEx+bxXLuqUz4U15Gb8
         ///K99QyOBJ+RAtDcPlzICgC1FJJUllwS1e8anhhY7NAcdFGd4CT9Nuy0OR9tQw7YAqM
         jg9jpcKKU4rut4Epc8K/jaWjD2wdGBsqFsaP3dO5xyAhyjGjDOX/e4MoIzBrY9b0vIwF
         eThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4+IikWYzTHVoP+qr/bH+QADSSsqMyHaDXXhUq1MQaqE=;
        b=C2KKgeCLPKM9pXBpP6SY2v1p7a/Q1Rt165+3zpMoBuUBXcccFTIWmmGYdPemho5pqo
         B8HrhXMMbfXkqpt0ECdFIcrns7kasXRDL4UJj9Rh/lddW/3WUYjWhiQcA6mKzl+527+t
         ByzbZsWustE5tLsSuxqGIkadTYftdR5bpE2PQeSNsuHGMlF0U7dZFf3/Ya6F8P/n5Ae7
         EH97RP3EMQK4s9wH2XIOuAFOro21T10YBrY8CTcOefIjNi4nNXSnBxDXhQPhQagMcB4U
         YhBbeRKR1DoY8wtYBVMsJlXQU0nNMmbaV3iUlMBItv3Ki0GqYmSvShlA0P3af33KZYzz
         9n4g==
X-Gm-Message-State: APjAAAXg98RdtnRLIER1paG+gr/ELmObbEMfSHm4z3KgNRzKLzFjNcVF
        qCuZvW+X+qyRG9QrgDGhebOjlPMjCmA=
X-Google-Smtp-Source: APXvYqw+ahU3bBlwVkjXOnMv6LzIZQwXrl99hJ4LTJG7ynNbH/PcROfnsBVY/iP/I8DZyIaaNEALyg==
X-Received: by 2002:adf:e485:: with SMTP id i5mr911416wrm.175.1568879302252;
        Thu, 19 Sep 2019 00:48:22 -0700 (PDT)
Received: from linux-code.mgc.mentorg.com (nat-sch.mentorg.com. [139.181.36.34])
        by smtp.gmail.com with ESMTPSA id q66sm7120969wme.39.2019.09.19.00.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 00:48:21 -0700 (PDT)
From:   Srikanth Krishnakar <skrishnakar@gmail.com>
X-Google-Original-From: Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>
To:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        dvhart@infradead.org, andy@infradead.org
Cc:     Cedric_Hombourger@mentor.com, Srikanth_Krishnakar@mentor.com,
        jan.kiszka@siemens.com
Subject: [PATCH] platform/x86: pmc_atom: Add Siemens SIMATIC IPC2x7E to critclk_systems DMI table
Date:   Thu, 19 Sep 2019 13:15:56 +0530
Message-Id: <20190919074556.25691-1-Srikanth_Krishnakar@mentor.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SIMATIC IPC227E and IPC277E uses the PMC clock for on-board components
and gets stuck during boot if the clock is disabled. Therefore, add this
device to the critical systems list.

The Board revision does vary in some instances and hence use PRODUCT_NAME
to allow the boards to boot with identical names.

Tested on SIMATIC IPC227E and IPC277E.

Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
CC: Jan Kiszka <jan.kiszka@siemens.com>
CC: Cedric Hombourger <Cedric_Hombourger@mentor.com>
Signed-off-by: Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>
---
 drivers/platform/x86/pmc_atom.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/pmc_atom.c b/drivers/platform/x86/pmc_atom.c
index 9aca5e7ce6d0..1e48c2ec684e 100644
--- a/drivers/platform/x86/pmc_atom.c
+++ b/drivers/platform/x86/pmc_atom.c
@@ -419,7 +419,14 @@ static const struct dmi_system_id critclk_systems[] = {
 		.ident = "SIMATIC IPC227E",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "SIEMENS AG"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "6ES7647-8B"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "SIMATIC IPC227E"),
+		},
+	},
+	{
+		.ident = "SIMATIC IPC277E",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SIEMENS AG"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "SIMATIC IPC277E"),
 		},
 	},
 	{ /*sentinel*/ }
-- 
2.17.1

