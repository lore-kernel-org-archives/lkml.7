Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35474C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 09:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D7E2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 09:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rxb3WBd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfG1Jaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 05:30:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46718 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfG1Jav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 05:30:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id c3so3382346pfa.13;
        Sun, 28 Jul 2019 02:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=5Pz4rCVD0vWLA17p+mMhsqMFpeVJDTz+U0y7lXimbeo=;
        b=rxb3WBd0NCoKGgDCvLUZ9MwueRLsV2bBb8hisfN3xX8w6/eJB0NovX4//X771U1zp4
         rWGBGpoZpRvwgW8Kvuwwnei8pKU0OmhGWscNi75ufVCaOwwmhVDqM9ppJElD1a0rqCTI
         1sj+QGGHyEptASUvqtgtXOCTTDaiFLj/8RLVuiz6rq54uRY1x3+qy4rbQ4O0lRwgMuhJ
         ab01hKUXR3t5KGydKYZHPCcQ/axBEO08aaAT5B0kIZRxJpHMofJW6xtujcD88BWe5Aqv
         wfBUPYsd611bgcIv5HifAAHNpRNkhCg0h9NIwu1C6H7IUhmmiy4kCHBPd1079P/2uUY2
         08Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=5Pz4rCVD0vWLA17p+mMhsqMFpeVJDTz+U0y7lXimbeo=;
        b=qhyry8/h5Ev54DdO8MQewI1PY/lxgc5CJHww0ocoOQfHcvfn1zfCYYH3KA7LPIsfue
         flM6n23yToVOksuUJUxFgyZY9Pi9TZNTY52h13k1TmsgVDfhuXkD8BDye/etp37rkeZf
         glri9m8KcECF+4cJBF0xXPsCK/sSsiwC6RKsSIVWqrBtA6XNIrbYJSrUuPRl5+PL0/d2
         h0WafzkQ0mVgpNFwMkDd6h1NBhFcZI6Z1y07hxpvbUuK2pPUlf75BHoQNrQdi2gislbm
         XjrL1beHHOONEPfJ5ZuRpYpreiyg7Xkyi323POp9Stnj6SMsStu7KMW30cf/D9+jFkF0
         lKjA==
X-Gm-Message-State: APjAAAXO+5+BwALk7GDVl4mkZz20vK3dYZ8lz9zXRnw+EJTJvGGOt5gk
        YDV2HjKDi4r5W8MnEkd8FuM=
X-Google-Smtp-Source: APXvYqwZ2IM4/sha2sxku6bqL2fendny9Jm6t5sLo8mngCSairpU4j2k6G5G9vIgUsDB4arnpUlXXw==
X-Received: by 2002:aa7:9254:: with SMTP id 20mr31908859pfp.212.1564306251153;
        Sun, 28 Jul 2019 02:30:51 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com. [147.11.224.80])
        by smtp.gmail.com with ESMTPSA id s20sm66237380pfe.169.2019.07.28.02.30.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 28 Jul 2019 02:30:50 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: interrupt-controller: msi: Correct msi-controller@c's reg
Date:   Sun, 28 Jul 2019 02:30:18 -0700
Message-Id: <1564306219-17439-1-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The base address of msi-controller@c should be set to c.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 Documentation/devicetree/bindings/interrupt-controller/msi.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/msi.txt b/Documentation/devicetree/bindings/interrupt-controller/msi.txt
index c60c034..c20b51d 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/msi.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/msi.txt
@@ -98,7 +98,7 @@ Example
 	};
 
 	msi_c: msi-controller@c {
-		reg = <0xb 0xf00>;
+		reg = <0xc 0xf00>;
 		compatible = "vendor-b,another-controller";
 		msi-controller;
 		/* Each device has some unique ID */
-- 
2.7.4

