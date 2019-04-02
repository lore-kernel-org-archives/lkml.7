Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAC6C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A742084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APn/dN0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbfDBPp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:45:27 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41994 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730680AbfDBPp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:45:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id cv12so6466940plb.9;
        Tue, 02 Apr 2019 08:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GzZzQIgj3RszPn4/9fcOligwHylEZB1ISYK+0RCbrKg=;
        b=APn/dN0t7d6tuR4v3MkmWYYMNexo+pC2bR38AyO0fbOXvPatHODfJGySaGkLeb0H9w
         V2F2qMoPwRIAgEc05SKeD71ZIhMRqZB2D9y5I8aHGyjMt9GdKYYKIZNaVRRYvieScbwX
         a8IkmTLsPXvpxoFz6wmhMiFAnKYTynct4oOhSulDPjn9/URFTx9ZBEh9tWeSeLlVzlXi
         90OaZwvPYMdIxhGt0GGBf1fem+dJTfs9jtARIFiJMbiWV017eRCnK1xlNXr8liuAFcM6
         eDy7c03pYtooVgNPVq1gGw9ogaUSWpwDxdUcHeVIf0jNpsPih3RHVJmaARYUjfZBdR17
         Kp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GzZzQIgj3RszPn4/9fcOligwHylEZB1ISYK+0RCbrKg=;
        b=JfMPwG8pt8PuN2nFKh2WgIKgvieJ7g7ljXhvEyXAcCsazWJLBfSnU5pQqwI7EsXCEZ
         IMrdbEHLu2GLtBcNNFHJ7QApd++Ot4ZwkrA95vRDMjduWs5COmr7Wzio9akemr2HUF01
         n09ZaV0PmVcmzVQ6QkDaT40+bZDwAzgdKeUAEsgEwWUkOluXbKZc/cSRI+lmxdlIncgW
         +BzMTDvsF6ihcY4YegyXJBdXfxJVWKA9TX6wfBcHos1LMWM5PT9F01OQ9feMw8Kz8loo
         p7lZqMSo/plwCzkTQV7LOb/aBV8UMvl/q5Z7tYN0KmJPzyxVVBzYdOl+WH67Y1yL4lwH
         PpHA==
X-Gm-Message-State: APjAAAWlOjSR7tApZetrea+APsdSmpaS46GDmWiMoi1HATA2fexc9uBV
        1zKpJGVdlG1YvVdXLgQMSxU=
X-Google-Smtp-Source: APXvYqxpED15tYdUkEAQeoxxYv6q1rXaL6jbCRuCTA9th5fKhKMFqSUwL0ZnwAtbYlHm+2ukmfwsYg==
X-Received: by 2002:a17:902:1122:: with SMTP id d31mr36972838pla.29.1554219925381;
        Tue, 02 Apr 2019 08:45:25 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id y20sm1112939pfe.188.2019.04.02.08.45.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 08:45:24 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2 2/5] nvmem: sunxi-sid: add binding for H6's SID controller
Date:   Tue,  2 Apr 2019 11:45:11 -0400
Message-Id: <20190402154514.11284-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190402154514.11284-1-tiny.windzz@gmail.com>
References: <20190402154514.11284-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for H6's SID controller.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
index d37017e343b1..cfb18b4ef8f7 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
@@ -8,6 +8,7 @@ Required properties:
   "allwinner,sun8i-h3-sid"
   "allwinner,sun50i-a64-sid"
   "allwinner,sun50i-h5-sid"
+  "allwinner,sun50i-h6-sid"
 
 - reg: Should contain registers location and length
 
-- 
2.17.0

