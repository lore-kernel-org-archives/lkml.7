Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E441C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4D320663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ST9u1Nlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfCFXVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:21:35 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41843 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfCFXVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:21:34 -0500
Received: by mail-pg1-f196.google.com with SMTP id k11so8666472pgb.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 15:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KanrZIzkWldxaMBTEZNDdJ/ktuGpuyFRdMUdxblJEY8=;
        b=ST9u1NlhgtyayYWqk0GhSmeuCR5MuOuOGwfw9j0eDDfUnyHe6FCueZvIQV047pkPO2
         iC54s5n+fMRITQXXpDEUw0EPDwnf013eKghNzpRok8/JMpRHUqdyb/G2A9+N3NW95FWM
         JvgNBVTWPlfHhUgFl/jY4uN7gvl+xuFsFBTmivUuWhBhNSNlmFEMX9MITYGzRKA1wQD7
         NAyrGVGHpyEzHTAGhRCPTsMqaYkkrR3Mc8t2SjfRQhvDubxnli7lUObdk/MeSdZHh1tV
         hInv+C+z78viYUDX5XCdBg0hAmYBMpl8dZ/tFsLh/+8xrT41WwTJMG+NZTSFbujlKdM1
         1ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KanrZIzkWldxaMBTEZNDdJ/ktuGpuyFRdMUdxblJEY8=;
        b=cwFKzikkCOBJGXTrnO5hAEkscyxRhh5xIlyfblZTTvAJDn7lHKXbeNePJ+IbjD5aaV
         sNsL8fXxx3XT3WJG9RDAKs0klIHrSKbnGkiDQSrg7aUYJ/mlpPVpUC23Ooq3TGPZdf+n
         pTaaHmRdfY7flIoyTqwF8fguL0Q+U5my2uBrYpdpGPYO9aS02ZmLdrHcB3TnhWXC3Cpc
         gxHBst4Ww9/etH843gN7/CHDJCgqI4YL1tneuUZnnToXedCVPh2LLVoRcYxX6dvDdJCx
         ZzU9zmX21uEB708mbHh893LpPu+0YQ6Eyt0oBatpMjHg1bEByHD2eRlksYoUNR7vF+vZ
         mzhA==
X-Gm-Message-State: APjAAAVZQ19thplRQTeaB0mN69g8Vc1uRFQ5GiAUzv+0ySAuhH7T0v3h
        /JzQdLWqItIn5zZMxpNaV+JUrA==
X-Google-Smtp-Source: APXvYqyvzBMTxIuYh9HcJcTCiDJ0aAMXm6sn/SSuAcHP5+FDjH7O8PZ+bMXspVfF7/u3NIKwifzE7Q==
X-Received: by 2002:a62:3047:: with SMTP id w68mr9647415pfw.17.1551914493294;
        Wed, 06 Mar 2019 15:21:33 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s6sm5649251pgm.90.2019.03.06.15.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 15:21:32 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: remoteproc: Rename qcom,adsp binding document
Date:   Wed,  6 Mar 2019 15:22:20 -0800
Message-Id: <20190306232220.32722-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qcom,adsp binding document has evolved to cover the mechanism to
load and boot firmware on a range of different Hexagon based remote
subsystems. Rename the binding and update the description to better
capture this.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../{qcom,adsp.txt => qcom,q6v5-pas.txt}          | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)
 rename Documentation/devicetree/bindings/remoteproc/{qcom,adsp.txt => qcom,q6v5-pas.txt} (88%)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5-pas.txt
similarity index 88%
rename from Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
rename to Documentation/devicetree/bindings/remoteproc/qcom,q6v5-pas.txt
index 292dfda9770d..bbe9c7465a2c 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,q6v5-pas.txt
@@ -1,7 +1,8 @@
-Qualcomm ADSP Peripheral Image Loader
+Qualcomm TrustZone based Peripheral Image Loader
 
-This document defines the binding for a component that loads and boots firmware
-on the Qualcomm ADSP Hexagon core.
+This document defines the binding for the TrustZone based "Peripheral
+Authentication Service" (PAS) interface for loading and booting firmware on the
+Qualcomm Hexagon cores.
 
 - compatible:
 	Usage: required
@@ -85,10 +86,10 @@ on the Qualcomm ADSP Hexagon core.
 
 
 = SUBNODES
-The adsp node may have an subnode named either "smd-edge" or "glink-edge" that
-describes the communication edge, channels and devices related to the ADSP.
-See ../soc/qcom/qcom,smd.txt and ../soc/qcom/qcom,glink.txt for details on how
-to describe these.
+The remoteproc node may have an subnode named either "smd-edge" or "glink-edge"
+that describes the communication edge, channels and devices related to the
+remoteproc.  See ../soc/qcom/qcom,smd.txt and ../soc/qcom/qcom,glink.txt for
+details on how to describe these.
 
 
 = EXAMPLE
-- 
2.18.0

