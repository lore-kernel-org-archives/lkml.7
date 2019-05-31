Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52541C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CC125DC5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yINLZjD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfEaGjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:39:32 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36166 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfEaGjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:39:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id u22so5570895pfm.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 23:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ICFTAiKSf2WEzyVIUIY8aH5uQWN1lQV5+leEube4wOk=;
        b=yINLZjD+HVEFLHnmBFCdaPByQVMX2rctt7beGazUFTz8SHp0i6GnldmLXvhO0SP1Mz
         7fX8RkgnOgIIb2Yw3l4Y21M7JGbNFv+YLDPL4/l3XsYsQVW6gGUyANu0YsgWNQx5IlxX
         f8QIY1qI8vwu0jLKn8vFzYaePqLd2NGNmIQb162ZDMIqMlOf6tQ6II45zLwA26CK+O7n
         dPe+qTtVVsiNhNaoSnBeLdaoeawx1YDrAajs+58G5KKSDFRSeaBUkt09kb13GOd2gdBQ
         YMgtz5njgfXJCFAJkcKQM4lP6OFfh6dx1xvguxX/bK2i0l/RfWExcQGo9P//Xyf2munI
         VRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ICFTAiKSf2WEzyVIUIY8aH5uQWN1lQV5+leEube4wOk=;
        b=gNybkNGBR3FAI5gAfRbCa3NOTC6icei1I9Lj4+mdhPLdWYkfvw11SElNq2aMKQP5HJ
         ziLWqjXOz8wv0U+JLl50OxcYPqbWD0xZz4jlY/kCrLZ430qNtDcpQiqR2rLy9ryA9rRw
         Hoy1IeSylWoUfWlREOvtXMQEwwYmG7WbN4VzDV1SlTPy8A6YWrzCiP1IRcIh4jgnhDZ1
         gQrNMJj6ZxP6z63Mu3A1nwIPAHfw6U7umB/EEm8rpoRHzH2JlJ+9gJ1o47LcK5wL2YuM
         8rq13vt4ekutejpPFZRpLBFhsc7Z1x078K2T12UbcP/vqgJR8LtO9B7gg7azx/Zxq9Q9
         slVw==
X-Gm-Message-State: APjAAAXpHQVrB8C9616KVI0owhjjDgvtjcg6qQrmTmH+ipOYMvqzTbOg
        idqv+VlUnQMOwUCLZqxvJoQD
X-Google-Smtp-Source: APXvYqznyxZqc7FxorCk79gSUVlxMAYRL8gfbuzZWRdj6FY2XyPDB/CbxTdwXToIOIdbggnpYI8PVg==
X-Received: by 2002:a17:90a:d3d7:: with SMTP id d23mr6850098pjw.26.1559284770391;
        Thu, 30 May 2019 23:39:30 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:72cb:ebf2:a51d:3877:feab:5634])
        by smtp.gmail.com with ESMTPSA id y12sm4644158pgp.63.2019.05.30.23.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 23:39:29 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        robh+dt@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@st.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 3/4] dt-bindings: arm: stm32: Document Avenger96 devicetree binding
Date:   Fri, 31 May 2019 12:08:48 +0530
Message-Id: <20190531063849.26142-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531063849.26142-1-manivannan.sadhasivam@linaro.org>
References: <20190531063849.26142-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit documents Avenger96 devicetree binding based on
STM32MP157 SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index f53dc0f2d7b3..4d194f1eb03a 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -25,5 +25,7 @@ properties:
           - const: st,stm32h743
 
       - items:
+          - enum:
+              - arrow,stm32mp157a-avenger96 # Avenger96
           - const: st,stm32mp157
 ...
-- 
2.17.1

