Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42164C76195
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA2920818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 06:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tm2mbZg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfGQGLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 02:11:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43848 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfGQGLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:11:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so10606398pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 23:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vN79lmOQ+vzumU1jDpqE7NFEQZL1EfXi0bwxGYdVrVI=;
        b=tm2mbZg6hha+q1G9c4kaetRiZMsb6+GMeXdyEK9s+xiCXMjwjzqAlHeOQ/fMUbeD0W
         wu7s49zatRRw/wpRb1aXNDxc0go3LI4pFc7EDAr6aM+ulHogSDI/U80Bnl/r/zzHe3j2
         YGhGdP/d2w6s6BKVDvRX2pMu5/XTHZuOy2cancQoj++vMHTsxfSETaYjfCDUD2zEcUCL
         VobPZkRq+xDb3YPUowTi6AtLYK5IEkI5VpIhbW8rp6z09XXJti3sX1sIaYOm6g43B3kQ
         z5SCDiQBfNbgcduk5aiGCI8fxY64zdLYmaZxU75GDSfo7WoosRucOGlfddt9WvHeTrMF
         5+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vN79lmOQ+vzumU1jDpqE7NFEQZL1EfXi0bwxGYdVrVI=;
        b=dRIrRa4RAjR4i5Hgy0yEcRPxCLVycxpQZUYRmo3+RxuiXBB7LqXN++mJk5dZ3BlVF9
         I1JLM3yv5gIH5hpI3CSNvOmq9jvyLJSL/tN+HixIwS9sihi2QPcx86CowMZo6mJSpMa1
         OIejwpa4l069feKi4r8WAz6cY7qjMZNIK644AeMDDtCMZ/U5aW7+xuOVDMuP+eZZIk5I
         EcVorIXEF9pymeHYf5IUF6pouZBTTE/BQnfgh97BAcoRpZEdacRZPcL8RW4Q6wRxbjMH
         8NTlYKwAyT2zF/ExvAOZRho9Uth1AvMMkoxTAppeOK5HuJuAODWMHU83EOJ+L1b+wfk1
         tG1g==
X-Gm-Message-State: APjAAAXrJiPV99lKQTxy1/go8gQaCUCIykF67lb/QWmM7W+gKdZ2ViTy
        Xzz+peLmqq8Ch+je7aTbcTTSX6hEyA==
X-Google-Smtp-Source: APXvYqzsCsoCU0LtZpW6aTjrP7Q95hULw+ZhlXOavzCScJo+T+BGRa+MK/t5qSfF8EgwqbbRpxPRkg==
X-Received: by 2002:a65:458d:: with SMTP id o13mr38583589pgq.34.1563343861778;
        Tue, 16 Jul 2019 23:11:01 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7301:59e6:f493:40df:9c8a:5041])
        by smtp.gmail.com with ESMTPSA id r27sm25993313pgn.25.2019.07.16.23.10.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 23:11:01 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Darshak.Patel@einfochips.com,
        kinjan.patel@einfochips.com, prajose.john@einfochips.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/3] dt-bindings: Add Vendor prefix for Einfochips
Date:   Wed, 17 Jul 2019 11:40:37 +0530
Message-Id: <20190717061039.9271-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190717061039.9271-1-manivannan.sadhasivam@linaro.org>
References: <20190717061039.9271-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree vendor prefix for Einfochips.
https://www.einfochips.com/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 1acf806b62bf..9b74c4de5676 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -255,6 +255,8 @@ patternProperties:
     description: Emerging Display Technologies
   "^eeti,.*":
     description: eGalax_eMPIA Technology Inc
+  "^einfochips,.*":
+    description: Einfochips
   "^elan,.*":
     description: Elan Microelectronic Corp.
   "^elgin,.*":
-- 
2.17.1

