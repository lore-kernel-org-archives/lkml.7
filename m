Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA488C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE0F20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n5hW/mRF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e5d/QFfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfCGMRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:17:25 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59242 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCGMRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:17:22 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A5ADC60ADE; Thu,  7 Mar 2019 12:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551961041;
        bh=RXtIsSNq0sPOCGtmzN0HRVRPkiHYebUNXhndZ5vXhMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5hW/mRFf6SBZZ+M7ILC1BF8N1X3+rFdWOUK1VZ7fYoVYSHsc5ZnsXIzROYDD0a3e
         OM0E/Q9kTZ1arJ3sc4Q5ygf859TWXadWzyrA9qmTz1xxcI+yozm1xHjhxcdebAog3b
         Wync9TA5G/1LZM0ebUw3Dq4dpo62XWqznLacqIuE=
Received: from c-hbandi-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: c-hbandi@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E67F060ADE;
        Thu,  7 Mar 2019 12:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551961038;
        bh=RXtIsSNq0sPOCGtmzN0HRVRPkiHYebUNXhndZ5vXhMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e5d/QFfzrQ5KDCmKKO1jV1n3Y4OVwUukPCGAYBRNWpixrZBIuvozswJbLvwYfZLFD
         0ZRrUaUUlo8iMhBi3UTcaa7yJvm5n1HGW2RDnAStkUTdS9JwUQTpJAskkakcpOHvKV
         NB9+tkUYlOuwjZcnecq/Z1VZskg5iZcRsMRAopGI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E67F060ADE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=c-hbandi@codeaurora.org
From:   Harish Bandi <c-hbandi@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        anubhavg@codeaurora.org, Harish Bandi <c-hbandi@codeaurora.org>
Subject: [PATCH v1 2/2] dt-bindings: net: bluetooth: Add device tree bindings for QTI chip wcn3990
Date:   Thu,  7 Mar 2019 17:46:52 +0530
Message-Id: <1551961012-23898-3-git-send-email-c-hbandi@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1551961012-23898-1-git-send-email-c-hbandi@codeaurora.org>
References: <1551961012-23898-1-git-send-email-c-hbandi@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables regulators for the Qualcomm Bluetooth wcn3990
controller.
Added entry for regulator currents, min and max voltages

Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
---
 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
index 824c0e2..6aed68e 100644
--- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
@@ -50,6 +50,18 @@ serial@898000 {
 		vddxo-supply = <&vreg_l7a_1p8>;
 		vddrf-supply = <&vreg_l17a_1p3>;
 		vddch0-supply = <&vreg_l25a_3p3>;
+		vddio-current = <15000>;
+		vddxo-current = <80000>;
+		vddrf-current = <300000>;
+		vddch0-current = <450000>;
+		vddio-min-voltage = <1800000>;
+		vddxo-min-voltage = <1800000>;
+		vddrf-min-voltage = <1300000>;
+		vddch0-min-voltage = <3300000>;
+		vddio-max-voltage = <1900000>;
+		vddxo-max-voltage = <1900000>;
+		vddrf-max-voltage = <1350000>;
+		vddch0-max-voltage = <3400000>;
 		max-speed = <3200000>;
 	};
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

