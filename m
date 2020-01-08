Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D84C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9D420643
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXTrMoi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgAHNMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:12:51 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44775 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgAHNMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:12:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id q10so3278897wrm.11;
        Wed, 08 Jan 2020 05:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nuqpk77kadkNu92XiqO2mE8dn2Lkq0m2HM+duPrRe3U=;
        b=vXTrMoi9ny6SyfEbDroOFiy13rXsm9xd0xlj+9eQ1fzwnGbMWbNcj65z80JuTH0j3o
         LqposB+USq2eRVpMBmcXcg0c3bMEayBbMRIth/y1trZmreK00VCxECeEfi2bXe8NIJJ7
         dJOXtkX4FEvVB4hQV7TTp6iEVUObgWSyBi0CpWqx84ZKZLu+XfgEuGUqMOY1I9G7eMAb
         2dl57WB70FPXNphxxJZw6pTZpDJ5uOwcszogG6GKh4QwXUG/7q2aHMiRGE/0n0exmvom
         0F0jYaDIP0Pupynqo/QJXtg4lMyIcSW+l42IkjssJ4FOnM+4TQfkHBS7okXvZ4pYCyLq
         Q9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nuqpk77kadkNu92XiqO2mE8dn2Lkq0m2HM+duPrRe3U=;
        b=C6HWspAInkgEaWrhGxIMfwVL6QY3FuEcyi8WWqZrpwND8+K4yvsX9hew1RzFS8iQ4g
         uCQUcZ/fKYb4eVkRhV4pK8VRTlcZKNIWidVVVrLlBuBRdIKkYQCNi/k5P8KLSIeUKcIM
         ddw9vpmfBmGGKtmtu1kk0FXXSP5772EGN1ducUfpCgQMIcWlRulmvP4yFEx7OlP5dg/s
         JxM4rYLOzzmbyYNbm1tmLMBWvv7KlL5itj29qSQ18dngR4io0IqdE2jdDFWcLpfYHNlI
         z0VgdVPlafE1wh7bZOgf8/OsdPtsfr3q5Vdn8mnvMMYhMNVwjGRjVBeSOvLrVeFFdM39
         92dw==
X-Gm-Message-State: APjAAAVLrLsx855PZJiwoQJDS6/96IALW6sv55bn1prk5GPG+XT/yAua
        lwj2rP1eXsiIqhIgdOesddA=
X-Google-Smtp-Source: APXvYqxov2u+Q5XuvFKfwjKinkkNhYGJc0E7fB08f5MPFiCTn72XJ++ioM3Ov3j3M8/N8l8qdHiwJQ==
X-Received: by 2002:a5d:4d0e:: with SMTP id z14mr4370956wrt.208.1578489165017;
        Wed, 08 Jan 2020 05:12:45 -0800 (PST)
Received: from localhost.localdomain (p5B3F64F6.dip0.t-ipconnect.de. [91.63.100.246])
        by smtp.gmail.com with ESMTPSA id k82sm3875878wmf.10.2020.01.08.05.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 05:12:44 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, sam@ravnborg.org,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] dt-bindings: Add an entry for Monolithic Power System, MPS
Date:   Wed,  8 Jan 2020 14:12:31 +0100
Message-Id: <20200108131234.24128-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108131234.24128-1-sravanhome@gmail.com>
References: <20200108131234.24128-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for Monolithic Power System, MPS

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6046f4555852..5eac9d08bfa8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -605,6 +605,8 @@ patternProperties:
     description: MiraMEMS Sensing Technology Co., Ltd.
   "^mitsubishi,.*":
     description: Mitsubishi Electric Corporation
+  "^mps,.*":
+    description: Monolithic Power Systems, Inc.
   "^mosaixtech,.*":
     description: Mosaix Technologies, Inc.
   "^motorola,.*":
-- 
2.17.1

