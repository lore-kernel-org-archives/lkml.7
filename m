Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A01BC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491692084B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 02:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555383398;
	bh=6BqLgbp0ViFLOjonMFlu+nsmM5na3d+g5jBMvxA3GBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2hDp8I+N4y2dUAE+Mz6f26HhsSm+YWfJYiN4v6ErMOEI3o5VF7y4SFioDQ7boq0Z2
	 tV590wXxfnwSn0SKVawcg4Yd5pjNOLm3qgO0uveAEbpyBqBNi35qLOllUD+l2g44ps
	 5J4K34JgZRPxwgxu6tQCajIXiNZJHK41JF5pmXF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDPC4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 22:56:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43976 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDPC43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 22:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bMA8GC5+AjUSoe7wkFA4yS0uBjN1cENYUWkXHu91bVo=; b=m5QFNdbfev0PVlMDAtvdKbzjnE
        LDtsV6DlrobVu03TbwILB6aVTJHv/W0P50KTSHO1JWQNwX92r9rgAakKwQBClzmcvObWujzjjxKnA
        vAWtdGVN3eNdif3oo+tDmXnymCUm809IFeVVMNouX5o2w6orwiSA/nNEa/LDtk1c+ZvXQ7kICQE4v
        jpKIwZRfjimvd6hhhLKOjaK7P6yon6k8m0ntit9+rrTn2ONUr24hGw7/CBqV4SadnNr6tYEJUIH8F
        kLn8R+fF9TGEqPtAyXE0WejGGfAT+qIKGSxIogasD3mPzplObLG0UGySeUMAYJEafF3fc0YWiDXUf
        xuQtRobA==;
Received: from 177.205.118.176.dynamic.adsl.gvt.net.br ([177.205.118.176] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hGEGp-0007aS-RV; Tue, 16 Apr 2019 02:56:27 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hGEGn-0001la-5Y; Mon, 15 Apr 2019 23:56:25 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH 11/57] docs: extcon: move it to acpi dir and convert it to ReST
Date:   Mon, 15 Apr 2019 23:55:36 -0300
Message-Id: <ecd6b6bcbd5831241609f32ddf5ab484da145959.1555382110.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1555382110.git.mchehab+samsung@kernel.org>
References: <cover.1555382110.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intel-int3496.txt file is a documentation for an ACPI driver.

There's no reason to keep it on a separate directory.

So, instead of keeping it on some random location, move it
to a sub-directory inside the ACPI documentation dir.

For now, keep it with .txt extension, in order to avoid
Sphinx build noise. A later patch should change it to .rst
and movin it to be together with other acpi docs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 .../drivers/extcon-intel-int3496.txt}              | 14 ++++++++++----
 MAINTAINERS                                        |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)
 rename Documentation/{extcon/intel-int3496.txt => acpi/drivers/extcon-intel-int3496.txt} (66%)

diff --git a/Documentation/extcon/intel-int3496.txt b/Documentation/acpi/drivers/extcon-intel-int3496.txt
similarity index 66%
rename from Documentation/extcon/intel-int3496.txt
rename to Documentation/acpi/drivers/extcon-intel-int3496.txt
index 8155dbc7fad3..5137ca834b54 100644
--- a/Documentation/extcon/intel-int3496.txt
+++ b/Documentation/acpi/drivers/extcon-intel-int3496.txt
@@ -1,5 +1,6 @@
+=====================================================
 Intel INT3496 ACPI device extcon driver documentation
------------------------------------------------------
+=====================================================
 
 The Intel INT3496 ACPI device extcon driver is a driver for ACPI
 devices with an acpi-id of INT3496, such as found for example on
@@ -13,15 +14,20 @@ between an USB host and an USB peripheral controller.
 The ACPI devices exposes this functionality by returning an array with up
 to 3 gpio descriptors from its ACPI _CRS (Current Resource Settings) call:
 
-Index 0: The input gpio for the id-pin, this is always present and valid
-Index 1: The output gpio for enabling Vbus output from the device to the otg
+=======  =====================================================================
+Index 0  The input gpio for the id-pin, this is always present and valid
+Index 1  The output gpio for enabling Vbus output from the device to the otg
          port, write 1 to enable the Vbus output (this gpio descriptor may
          be absent or invalid)
-Index 2: The output gpio for muxing of the data pins between the USB host and
+Index 2  The output gpio for muxing of the data pins between the USB host and
          the USB peripheral controller, write 1 to mux to the peripheral
          controller
+=======  =====================================================================
 
 There is a mapping between indices and GPIO connection IDs as follows
+
+	======= =======
 	id	index 0
 	vbus	index 1
 	mux	index 2
+	======= =======
diff --git a/MAINTAINERS b/MAINTAINERS
index 8de292192227..99822421b447 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5958,7 +5958,7 @@ S:	Maintained
 F:	drivers/extcon/
 F:	include/linux/extcon/
 F:	include/linux/extcon.h
-F:	Documentation/extcon/
+F:	Documentation/acpi/drivers/extcon-intel-int3496.txt
 F:	Documentation/devicetree/bindings/extcon/
 
 EXYNOS DP DRIVER
-- 
2.20.1

