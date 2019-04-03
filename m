Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C15C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CC220830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bKwfIYF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfDCBTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 21:19:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35780 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfDCBTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 21:19:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id t21so7270647pfe.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 18:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z3Gjjm8urpQmwa27v9Sjjvl+dcCrPC1YUfnNsGknUyc=;
        b=bKwfIYF+HgviNccFjZ2o7R1N4dCiwTZmyh8Yb99yGXYQP1wzQcIRL7Y+dxuIBFoRYr
         uZEe4NrWhOszdjV2pGowv0TegHj3J4Q8KiJWTcQgByObjgddzLarLu3ZJ7wzXOP8+LEV
         lcciEY/WplJLmOadNxIDgaWcqCANpt8MmpCM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z3Gjjm8urpQmwa27v9Sjjvl+dcCrPC1YUfnNsGknUyc=;
        b=AJvMYPaay2mGbvc/i9/zSzsFo/dI7/1aCC5qrlRTprXxY6C091ZwigBJp78qYffW2B
         vY72ULXv82KPrf/dag0n1jSp6Ih9L9MfFNr3q+iLKBcNwoCLOOXRCUwVLWG+0A/yt3iG
         PBafAYjvgTfaZhuFPB5uMELf4d3Y2n1XlMNvvJpuFllZHZsPUw+Z/wBFOuX/VB6mE2ET
         U8SeOMEJaUxnODISszXUZgPo5Ca5K5bp5JI2OAYiQePkPPTN8uKVO39xdA39YUqvl+xc
         Q1WBHXtiRDYgL2FSG1gQJ108ToWmBzum8SE5EqyAr/qb7a6X+3ZhZZeQA17zPHg/Nw/i
         6XdQ==
X-Gm-Message-State: APjAAAUCqnVu45j9YLcrJ689+iav0MkOFBVZ0/bn5vN8qiO8u8ooHyr5
        lkDzQq1ylaVQZi1XpcUz0+TCrA==
X-Google-Smtp-Source: APXvYqzQKx5ul5lm0fBUfpU+ODkUaywjGsaMWtLkFQNmkgrQvwEDVmYgUlPSlUyluowxoCRrbRzGfA==
X-Received: by 2002:a62:204b:: with SMTP id g72mr66535643pfg.51.1554254349273;
        Tue, 02 Apr 2019 18:19:09 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 4sm19589046pfn.159.2019.04.02.18.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 18:19:08 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v6 7/9] dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
Date:   Tue,  2 Apr 2019 18:18:28 -0700
Message-Id: <20190403011830.3254-8-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190403011830.3254-1-ray.jui@broadcom.com>
References: <20190403011830.3254-1-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Update iProc I2C binding document to add new compatible string
"brcm,iproc-nic-i2c". Optional property "brcm,ape-hsls-addr-mask" is
also added that allows configuration of the host view into the APE's
address for "brcm,iproc-nic-i2c"

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
index 7a32bf81bfa9..d12cc33cca6c 100644
--- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
@@ -3,7 +3,7 @@ Broadcom iProc I2C controller
 Required properties:
 
 - compatible:
-    Must be "brcm,iproc-i2c"
+    Must be "brcm,iproc-i2c" or "brcm,iproc-nic-i2c"
 
 - reg:
     Define the base and range of the I/O address space that contain the iProc
@@ -26,6 +26,10 @@ Optional properties:
     case, this property should be left unspecified, and driver will fall back
     to polling mode
 
+- brcm,ape-hsls-addr-mask:
+    Required for "brcm,iproc-nic-i2c". Host view of address mask into the
+    'APE' co-processor. Value must be unsigned, 32-bit
+
 Example:
 	i2c0: i2c@18008000 {
 		compatible = "brcm,iproc-i2c";
-- 
2.17.1

