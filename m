Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43241C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F03D206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 23:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfFDXA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 19:00:27 -0400
Received: from sed198n136.SEDSystems.ca ([198.169.180.136]:29140 "EHLO
        sed198n136.sedsystems.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfFDXAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 19:00:22 -0400
X-Greylist: delayed 1464 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jun 2019 19:00:21 EDT
Received: from barney.sedsystems.ca (barney [198.169.180.121])
        by sed198n136.sedsystems.ca  with ESMTP id x54MZv1K029406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Jun 2019 16:35:58 -0600 (CST)
Received: from SED.RFC1918.192.168.sedsystems.ca (eng1n65.eng.sedsystems.ca [172.21.1.65])
        by barney.sedsystems.ca (8.14.7/8.14.4) with ESMTP id x54MZtKp036309
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 4 Jun 2019 16:35:57 -0600
From:   Robert Hancock <hancock@sedsystems.ca>
To:     linux-kernel@vger.kernel.org
Cc:     lee.jones@linaro.org, Robert Hancock <hancock@sedsystems.ca>
Subject: [PATCH 1/2] mfd: core: Support multiple OF child devices of the same type
Date:   Tue,  4 Jun 2019 16:35:42 -0600
Message-Id: <1559687743-31879-2-git-send-email-hancock@sedsystems.ca>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559687743-31879-1-git-send-email-hancock@sedsystems.ca>
References: <1559687743-31879-1-git-send-email-hancock@sedsystems.ca>
X-Scanned-By: MIMEDefang 2.64 on 198.169.180.136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the MFD core supported assigning OF nodes to created MFD
devices, but relied solely on matching the of_compatible string. This
would result in devices being potentially assigned the wrong node if
there are multiple devices with the same compatible string within a
multifunction device.

Add support for matching the full name of the node in the MFD cell
definition, so that we can match against a specific instance of a
device. If this is not specified, we match just based on the
compatible string, as before.

Signed-off-by: Robert Hancock <hancock@sedsystems.ca>
---
 drivers/mfd/mfd-core.c   | 5 ++++-
 include/linux/mfd/core.h | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 1ade4c8..74bc895 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -177,7 +177,10 @@ static int mfd_add_device(struct device *parent, int id,
 
 	if (parent->of_node && cell->of_compatible) {
 		for_each_child_of_node(parent->of_node, np) {
-			if (of_device_is_compatible(np, cell->of_compatible)) {
+			if (of_device_is_compatible(np, cell->of_compatible) &&
+			    (!cell->of_full_name ||
+			     !strcmp(cell->of_full_name,
+				     of_node_full_name(np)))) {
 				pdev->dev.of_node = np;
 				break;
 			}
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 99c0395..470f6cb 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -55,6 +55,9 @@ struct mfd_cell {
 	 */
 	const char		*of_compatible;
 
+	/* Optionally match against a specific device of a given type */
+	const char		*of_full_name;
+
 	/* Matches ACPI */
 	const struct mfd_cell_acpi_match	*acpi_match;
 
-- 
1.8.3.1

