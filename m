Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B27C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F6720674
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRiOk0L6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKVAJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 19:09:44 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:45327 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfKVAJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 19:09:44 -0500
Received: by mail-io1-f54.google.com with SMTP id v17so5810763iol.12;
        Thu, 21 Nov 2019 16:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EqXFR4oe2v0yUDAdGyEFCfnnL8/GnQC/j+RehHrO9cc=;
        b=LRiOk0L6EDLOJZ6Df0c95tQr3vVhNEIl3T34fTzaugVH2fHs++y0MhfU9BYD7lRzts
         HQwDvOWRBo9NUUouKIDybXNn+eEWEzq85p4rMYZ9MttUP4Dci0AyB1iLe6EY4JSsvqPX
         zrYiJrIhoXg9M3gloXBvNcWmxY/z/khJYwgEIdxPGtjEMgaeM6ufcnbuJ0l5zSlrE7SU
         ZgkRhn8iHIK2tjVONVe59mznrYfScTBxHU2HZWe1ccdZAOx9eQ9CQS1aD7GHf2o8ByO0
         JMt+Prpuw2kcfozLKaXySE3bhij4ndlhBv/dP2RWEm2ZhW8hvvNOOxV5HLju1mynj/UQ
         U27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EqXFR4oe2v0yUDAdGyEFCfnnL8/GnQC/j+RehHrO9cc=;
        b=TXw08/MrUYiv1WlkUsNJCZkLHW3unaFSCT74XMHxH3aRigthyTFYwtkYZ+Gv93mEMX
         qvogGe+J7RXpLIRrlhAwI4TcvwEe/YLg4zW6F6AJk3eWJAZBoEt7qlt6kPpCrWsTQnDu
         r0qOA3Ya7vSjWVaUz+N7EH5EJPOqMdsTAEPV6uiuqQeRqSooKzctyXzO79fklnQ+t5Tv
         oUyfIUosdO903rrY07gbIJT22/LNvv8gOjuEq35XVrODxPuE8AjXw3G9bCEId5E5jWVC
         EF7Y229NywAo2aPp4izG8PfBqTY13BM6+nsW1jWLq0RBXJF7j1HjB57Rhl8ViwHvZCYN
         mnvg==
X-Gm-Message-State: APjAAAVc9jm4yav/kZBqh7+2Etnh9th0RBfrBZb3hNxRjSn8x5isixBo
        qwQlIS4/ItOfbfCw3ALIWAdFabEd
X-Google-Smtp-Source: APXvYqx2ZlN0bP8EYCW9aGBGd6wGw3g04GF+708E3bMC0I4OfMiFVzTJYVmw6XqNr0CKTG7ztR4U3g==
X-Received: by 2002:a02:8793:: with SMTP id t19mr4693128jai.90.1574381381407;
        Thu, 21 Nov 2019 16:09:41 -0800 (PST)
Received: from localhost.localdomain (c-68-55-68-202.hsd1.mi.comcast.net. [68.55.68.202])
        by smtp.gmail.com with ESMTPSA id c21sm2024349ilg.31.2019.11.21.16.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 16:09:40 -0800 (PST)
From:   Jason Kridner <jkridner@gmail.com>
X-Google-Original-From: Jason Kridner <jdk@ti.com>
To:     devicetree@vger.kernel.org
Cc:     Jason Kridner <jkridner@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jyri Sarha <jsarha@ti.com>, linux-kernel@vger.kernel.org,
        Caleb Robey <c-robey@ti.com>, Jason Kridner <jdk@ti.com>
Subject: [PATCH v2] dt-bindings: Add vendor prefix for BeagleBoard.org
Date:   Thu, 21 Nov 2019 19:09:26 -0500
Message-Id: <20191122000926.19408-1-jdk@ti.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for BeagleBoard.org Foundation

Signed-off-by: Jason Kridner <jdk@ti.com>
---
Changes in v2:
  - Use 'beagle' rather than 'beagleboard.org' to be shorter and avoid
    needing to quote within a yaml regular expression.
  - Assign 'from' to author e-mail address.
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 967e78c5ec0a..1cce6641b21b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -139,6 +139,8 @@ patternProperties:
     description: Shenzhen AZW Technology Co., Ltd.
   "^bananapi,.*":
     description: BIPAI KEJI LIMITED
+  "^beagle,.*":
+    description: BeagleBoard.org Foundation
   "^bhf,.*":
     description: Beckhoff Automation GmbH & Co. KG
   "^bitmain,.*":
-- 
2.17.1

