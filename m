Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFE0C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 18:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA6320833
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 18:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VmUMtyc5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfDTSOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 14:14:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42530 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbfDTSOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 14:14:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so10722407wrx.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 11:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=HuYzYMY8SPTVztUJocmFSD8jYupkdlAAnzaWkVmTGDk=;
        b=VmUMtyc58Ej5M2oczqt402uzBb/otmDmbBARbFQK6M8tfb0HMs3kh96eXwvPlFh8PY
         be1brBjNndo58REyhPK3d/JqrJGMG6Ao6OO2gq8axLx7geCBDZzTgjtVoselWEimskGx
         FrNsInmeYfEV+GJH+VugclEvSfLh6HOq+u6T76IX7o/2yw/x/qeTDCA/DmkwN4/jp929
         AwmMuqbYyoPNAno7aPMYqejBf45Hw7gOZJ22khG+QeD5u1kap/faG97kVCm3PSUE5+Ws
         P40gKdCCngDMlpw4dQmOpU8XbtzTfRor+YZMOeiIk5JelsrpI9bTm0I9MkdmKTDoEZb8
         qHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HuYzYMY8SPTVztUJocmFSD8jYupkdlAAnzaWkVmTGDk=;
        b=ZoRgp8e9NrCe7eUA7AWb2yrJtqCX+OgDHIPnmvrMFDQwu+FUVr7Z6mN+KnRta8cMus
         lAuTPcqpYYAButhzoHuU7F0/oXzuB1jFo1hv/vGZUJKZ2CuuTB2h05m13G3Mz6TrCiC0
         82SKfIq2IPQzW9i1KBVyQXrzKWYGcYHuMws7E07jt3OMNQIIAZJo/kkDlz9uADORk2IS
         EFDz59zi/74bN5ZcujSNq8bn5TsSVFAS64OvTyiU8yhIjSV0gIVGoJ7StlxWm9UGuLhK
         4yrAD8WOqEFpW//ZGO9J1+pb0iC/PZBbJGcYj/bCfV2O4nQsp5Kpg3IyB/kEVnW8n/pR
         dzgg==
X-Gm-Message-State: APjAAAXO5/kr0wYPzwsttzE9egL5zbi2futFcYtLQybC9g0nYbvRXdu5
        R+O4PdCYaN2tiCBcqyu0Jrmplw==
X-Google-Smtp-Source: APXvYqwKJDDLjcC1KT7gkDnmQMcMvmHpXfBvWILHOl1CL/vkVpoYeqe2FATJVPoeDUFFiTuJscJlWg==
X-Received: by 2002:a5d:4e82:: with SMTP id e2mr7734332wru.164.1555784082100;
        Sat, 20 Apr 2019 11:14:42 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id t74sm17122337wmt.3.2019.04.20.11.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 20 Apr 2019 11:14:41 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, mark.rutland@arm.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] dt-bindings: add an explanation for internal phy-mode
Date:   Sat, 20 Apr 2019 18:14:33 +0000
Message-Id: <1555784073-21679-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When working on the Allwinner internal PHY, the first work was to use
the "internal" mode, but some answer was made my mail on what are really
internal mean for PHY.

This patch write that in the doc.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/devicetree/bindings/net/ethernet.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet.txt b/Documentation/devicetree/bindings/net/ethernet.txt
index cfc376bc977a..78b098d2d4e9 100644
--- a/Documentation/devicetree/bindings/net/ethernet.txt
+++ b/Documentation/devicetree/bindings/net/ethernet.txt
@@ -18,7 +18,8 @@ Documentation/devicetree/bindings/phy/phy-bindings.txt.
   Specification).
 - phy-mode: string, operation mode of the PHY interface. This is now a de-facto
   standard property; supported values are:
-  * "internal"
+  * "internal" (Internal means there is not a standard bus between the MAC and
+     the PHY, something proprietary is being used to embed the PHY in the MAC.)
   * "mii"
   * "gmii"
   * "sgmii"
-- 
2.21.0

