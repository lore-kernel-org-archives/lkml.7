Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51F9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6502168B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 10:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="CjDt333L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbfICKgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 06:36:02 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:57240 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726631AbfICKf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 06:35:59 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 617E6C0C43;
        Tue,  3 Sep 2019 10:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1567506958; bh=8U/YgJ3ZNxmNXa7KrjxfkomJifVMndkP3bF2LzIDNf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=CjDt333L/nT99syog7bhkYL6MGXyuz9V+zVSV314edDeWg5PXKGcSAKbVo7gW7pvl
         ZbqkszQVVoG923TnaGsvnptH3roxRmrsrnqxqepVsp/fMQPUpoem9GeWwbC57IIXsu
         E7SzUAJOzOQVOjXcV+MfTN/d5xSbvRPbOf7ZO1cGIFzRTUAXHXyLp+VjjFa0BHkhD7
         lFUphqnRW5jEqTX+R3inF9guPjpJqp1R5B5bjtcPlQLfZrPUGwRDxl1zhIdcLuZ1BJ
         4k69JxyQb0dQ8D4HupdzaLxmStCGn4JQ1YhhQ5oRX2/aClIt0o1L7fZCFPDruldzc7
         KzOpXppK07WjA==
Received: from de02.synopsys.com (germany.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id D9A90A005E;
        Tue,  3 Sep 2019 10:35:56 +0000 (UTC)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id C301E3C0DA;
        Tue,  3 Sep 2019 12:35:56 +0200 (CEST)
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i3c@lists.infradead.org
Cc:     bbrezillon@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        pgaj@cadence.com, Joao.Pinto@synopsys.com,
        Vitor Soares <Vitor.Soares@synopsys.com>
Subject: [PATCH v2 3/5] dt-bindings: i3c: Make 'assigned-address' valid if static address == 0
Date:   Tue,  3 Sep 2019 12:35:52 +0200
Message-Id: <c0505ef73add4512ce1ee2a71b1c8bc8f771151b.1567437955.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1567437955.git.vitor.soares@synopsys.com>
References: <cover.1567437955.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1567437955.git.vitor.soares@synopsys.com>
References: <cover.1567437955.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I3C devices without a static address can require a specific dynamic
address for priority reasons.

Let's update the binding document to make the 'assigned-address' property
valid if static address == 0 and add an example with this use case.

Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
---
 Documentation/devicetree/bindings/i3c/i3c.txt | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i3c/i3c.txt b/Documentation/devicetree/bindings/i3c/i3c.txt
index ab729a0..c851e75 100644
--- a/Documentation/devicetree/bindings/i3c/i3c.txt
+++ b/Documentation/devicetree/bindings/i3c/i3c.txt
@@ -98,9 +98,7 @@ Required properties
 
 Optional properties
 -------------------
-- assigned-address: dynamic address to be assigned to this device. This
-		    property is only valid if the I3C device has a static
-		    address (first cell of the reg property != 0).
+- assigned-address: dynamic address to be assigned to this device.
 
 
 Example:
@@ -129,6 +127,15 @@ Example:
 
 		/*
 		 * I3C device without a static I2C address but requiring
+		 * specific dynamic address.
+		 */
+		sensor@0,39200154004 {
+			reg = <0x0 0x6072 0x303904d2>;
+			assigned-address = <0xb>;
+		};
+
+		/*
+		 * I3C device without a static I2C address but requiring
 		 * resources described in the DT.
 		 */
 		sensor@0,39200154004 {
-- 
2.7.4

