Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83080C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 589F721849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BMxm0rLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfGSHJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:09:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37333 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbfGSHJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:09:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id i70so3300291pgd.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 00:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1bNSUve/pXrf+sup56CDnfI8ZoTKP2QzwnZv3hxzyr8=;
        b=BMxm0rLneBaUzO6uvV2j7xck7bF6x09mf0F27/8TZc5OqqvBJtOMHyXj8lJt6CcjGp
         YEmWJIiAKK+KZi44BaBh0hKwOe6dFI6X+zUFBgrfzg28iOQyonY49DW8vA/iJ0dJJ8so
         FsbWxkFj5DJpVKqQe+gauBQmdulWsMWjm3hsHc6TAwXKIg/j5k8iYNRfVTXGDMPsF017
         vJeTXco3N4/lj2kSI/nKzHBtknwSI2psj2LI5uHiGrvmk1YDx9cdxqz+nqEXG2f1U6ub
         WjEEe/y0/As5VuUtiZ2QvnZjgq0Egbgvs6B0iQXUMlccNSWb+eLxFIQeznF7LeUkqhBo
         SGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1bNSUve/pXrf+sup56CDnfI8ZoTKP2QzwnZv3hxzyr8=;
        b=ilRPGE9YJr46VmyaQbS5tUDV1NfQN9Cifwf7bSG0rWfLJBOuGQOe8/hd4T+kRbhcEb
         otkgwntkCITJFRTX5na4GjkJXdTpeA0N3/zQgvOSxppD4hcRKuagDWcB+XZb3aX/i8gN
         w8VBX9WizqAg3EwJ1uQc6U6vsV200TpboMc6SrFQFZlcnfrm7aNsOlSaKJgimRvKSmd4
         DCDuQ64rQw3BWesSU3sYafELHzfVP15WYSub3R1M3vf8bQp3IPcnXAgxprwdJv07AF7k
         BYJjC18NlR+y40R5srPK3KQNKEY1U2TH7BhaHIBwA9Z036TL8pkUl5jrYTB9YQNziW6r
         Wcew==
X-Gm-Message-State: APjAAAXBibgBmONt3GehWnstmbjmsobOcf3Njh9Wn3Nh3AGmdSr9l6MF
        SNLG5l9hWL5107n1ctQZrN/C
X-Google-Smtp-Source: APXvYqz+ntFqUef71itprU0QfhrLSx4biiOXZwZEKA25oS7byv43fSukhUUOEJq44czk7qMKC3cN5w==
X-Received: by 2002:a17:90a:2506:: with SMTP id j6mr20752744pje.129.1563520191528;
        Fri, 19 Jul 2019 00:09:51 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:730b:4a40:d09e:c7ec:fbb:1676])
        by smtp.gmail.com with ESMTPSA id r6sm56259346pjb.22.2019.07.19.00.09.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 00:09:50 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Darshak.Patel@einfochips.com,
        kinjan.patel@einfochips.com, prajose.john@einfochips.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: Add Vendor prefix for Einfochips
Date:   Fri, 19 Jul 2019 12:39:24 +0530
Message-Id: <20190719070926.29114-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190719070926.29114-1-manivannan.sadhasivam@linaro.org>
References: <20190719070926.29114-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree vendor prefix for Einfochips.
https://www.einfochips.com/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
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

