Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2331C2D0D2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 23:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8846206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 23:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIcbn4mm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfLUXkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 18:40:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40951 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLUXkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 18:40:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so12888868wrn.7;
        Sat, 21 Dec 2019 15:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1OGCzyJCrst2owrhk2ZRzZZ6qSHUKtNRJtopFQDCbsw=;
        b=QIcbn4mm7iZrsshycY/zZRl4urc2YNpq1U9jXqMZb1Dr1mJf+HeFzwjtCMuVYBHNDl
         NGwJQuEpVKajqBjxZitVWmuFhXrhqugb66kOnB2gqGnEXUdD759gfl72jgO3XVWDbwXx
         7AS4nfchLxxu5SryqMdUTB5oUjPK+FD5uj/JT/qj9SFe7BpXctfycCmPtm+ickECJaBy
         nxFOB3ANTLv3DI7tJXnNPYNE3tgyRKBBLAK2lYqc1VEeWHY6fumJFzlWsi79HJDFGdMQ
         4nOKKl4jCN9Rffj0y4YJ85jQ1HbHSQ9LOb6wMfBYqxNA6OX+z17F6w78pUX3J2eEgtbc
         Wi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1OGCzyJCrst2owrhk2ZRzZZ6qSHUKtNRJtopFQDCbsw=;
        b=m2qaGXpYiXkyC+Wt0MrlNAXYfIAPOXb6Us9Xuk1Cuhbd3KAxz20NlpUIG9Zef7oiTJ
         T3zKT98kW0iNnWRIPwFkpdzGvcrrazWqAHUE6cl+dFMK1rmPzrvuXDxXXVAjUNCbNB/E
         tSowYSilgxjhQJdx/YDiMRwqcHH1L6iMkiGfTYPOjsJuA/GtciLM4n/NIHHv/tkSBxiX
         l41hJkkxwKDyZqcr68F+bkXRxp9vwWtruztdw0G/bvecansIPFJiodZCRxiO+CjGNd0L
         vz9YZoHVwHHPFI14K3yIrYfhhLzeLXvVcIXB/O2saq0jUqIyQ/CPVF/NlUCDTZA/tTQo
         eyWA==
X-Gm-Message-State: APjAAAXj2ZcOyJDIqCe+cqHzqNWntsTNTuDE2yYC5FDMdn6XY9RFLPN1
        w4acl58xcywhZ3flIDr5k+Q=
X-Google-Smtp-Source: APXvYqwc3fww2D05CKgZ/wmVf4Zb4lqFKDGBPDHBezzzTw2ITC2+a18BpKvLb9k4b1t6EVd+CnyMug==
X-Received: by 2002:a5d:6349:: with SMTP id b9mr23423436wrw.346.1576971641199;
        Sat, 21 Dec 2019 15:40:41 -0800 (PST)
Received: from localhost.localdomain (p5B3F6223.dip0.t-ipconnect.de. [91.63.98.35])
        by smtp.gmail.com with ESMTPSA id q3sm14179151wmj.38.2019.12.21.15.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 15:40:40 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, sam@ravnborg.org,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: Add an entry for Monolithic Power System, MPS
Date:   Sun, 22 Dec 2019 00:40:26 +0100
Message-Id: <20191221234029.7796-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191221234029.7796-1-sravanhome@gmail.com>
References: <20191221234029.7796-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for Monolithic Power System, MPS

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
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

