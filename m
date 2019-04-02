Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69EAC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56372084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INHLAsVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbfDBPpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:45:25 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45192 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDBPpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:45:24 -0400
Received: by mail-pl1-f194.google.com with SMTP id bf11so6454015plb.12;
        Tue, 02 Apr 2019 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q/E3+JmOJdNiQHCEoucXmrhRai0CKnVHGQ34PFUCFXk=;
        b=INHLAsVqbSFRC+HHBJfGXoh4WSlnKkIqQtxFLSgpHWOnoby1QaJ520s565koSBtuX8
         dkb+R1zQ910pkEDFkN7jHOtI/BqvDFd5e9sL5vcQje+DcJl+OLqNqgXFiaf9S6zmEf8c
         Nsplzb89D7nDsyf8o0LcDBUH/GEcdmrAhmisH3BBft03HcGev6szSMbQNshuhhBo362u
         NeTeL5B1YDGkjvidBlwkTrhjnwPG01n+HPq+tGrLT/EquHrIhtGyftXKzdzlB+lA/xAc
         +LhTGtRuXAPdA3ULRgSnUWpVM3+A6yHMW+ehgDSSQKIuUlMvZ8yAnP6A5t3we03kOmoK
         YosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q/E3+JmOJdNiQHCEoucXmrhRai0CKnVHGQ34PFUCFXk=;
        b=G/qkGznodt0VudI3/D4lKsfJ/k2X+1o1KC4XMp5R/W5f5pesCJq24tDELH2/8Qb8lE
         Pjs+k2Id8Z4P4sF/n8+/5W7wiLp8FQS9ZKD3UE+w0+/wESXNn066/Wc3SBMH4mUreSo3
         jcZBRAayaukUJYNDO7//tO62uEGJ7yGVoM8rQj23OJb3whtqoLtv9c7YKovaZ0WjKRCh
         VUvmb+2BL5mfl0Qro2hVpibiuXpig4b2xT13AKUeT9IlVFX2LB3q0wCEkpiESKokryLT
         GMHX6pbCguEnZpyqq24a7lHLa7eAs8Q0HpmGIjmI6zs5GJ6uVCero/xSqDCTkn+R89p8
         Mh1Q==
X-Gm-Message-State: APjAAAUY9XAjIa6QY1RmPd7hE89BGNn6ithHOWX87MFyupyJNaxKxFhj
        qx4nEXRIpf6Gl9zx4Ztsr9M=
X-Google-Smtp-Source: APXvYqyDHUYgcw9us/4BcYwFd84wxTNbC/bCnJrAipaqkazRmUhwQ8g7ZvOwDO7hw7imGpp0uYtpzQ==
X-Received: by 2002:a17:902:8bca:: with SMTP id r10mr61030560plo.67.1554219923054;
        Tue, 02 Apr 2019 08:45:23 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id p3sm23535885pfn.167.2019.04.02.08.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 08:45:22 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2 1/5] nvmem: sunxi-sid: fix wrong description in kernel doc
Date:   Tue,  2 Apr 2019 11:45:10 -0400
Message-Id: <20190402154514.11284-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190402154514.11284-1-tiny.windzz@gmail.com>
References: <20190402154514.11284-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qfprom->sunxi-sid

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
index 99c4ba6a3f61..d37017e343b1 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
@@ -12,7 +12,7 @@ Required properties:
 - reg: Should contain registers location and length
 
 = Data cells =
-Are child nodes of qfprom, bindings of which as described in
+Are child nodes of sunxi-sid, bindings of which as described in
 bindings/nvmem/nvmem.txt
 
 Example for sun4i:
-- 
2.17.0

