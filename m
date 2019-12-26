Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7269C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A600E20828
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 22:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV215Hsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfLZW3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 17:29:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43552 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfLZW3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 17:29:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so24647317wre.10;
        Thu, 26 Dec 2019 14:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1OGCzyJCrst2owrhk2ZRzZZ6qSHUKtNRJtopFQDCbsw=;
        b=PV215Hsw6rpU6vP8tuImqgBgyPzKwDg6oiJfeK9BI2rBRmCV9RZnRJNdrTCmzA18sl
         AS3RHvtygKstcKILeYIz6G/MRPlhXvv0PePSsxoH1jzN1uyxUntdJieJRMFKYUL3pDcx
         LanX2V0scXGeF7VHZ6HaGbNyujNzZtZH0bz1hUL7vBdudj7EZ640BDJVl6oVbOJoxFIp
         iRopL0GXGwJfFzZDLeiVMMIJvD61+LmfjeVFFMeFaIHqQafRZrNaDnrBj4r9HNCMhj0x
         T2uPxmMyn/YJDo0PQZM+RPTDbESmeZSa2PqitWJjHy1HN9nyoLfZhsZ8a6NYDuMIeArW
         Ti/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1OGCzyJCrst2owrhk2ZRzZZ6qSHUKtNRJtopFQDCbsw=;
        b=anMjLgZriyVGd7EUZqPERgEaLoKuxcIvsnmo4k/iBYvD1cT9+8v+5o4P8hmyRmP+ZT
         dlHbKEJf1cWnY6oDItNed5Pc359gWHFagWfSc5QI3KX+1ZlsK6f3Uv+Szid0K1p963cc
         4ZzPxkCh6zbkl5FfFkGJD87T+qbZz4IBsDmAWeJBvU104BkjbRObskw1D4jg8pFYgD5E
         8DaLhk1Q9RRbROhZ7HTXmiqvlN33u7q7Q1OvZPWL/yUtOoGzttUkLmXE6EFmymR1Ta3u
         6GWmbVxVFaA4+Eu46VSr2vEMTYAHt66cikCn7rutPTlM+KKt6ixoLgexok9hHabTECR2
         28lQ==
X-Gm-Message-State: APjAAAVyUpkSnUZ2e31Edzfe2tmyidvJJzvL1F3Zgkmc0+xIcQgZXw0S
        JZb8S09NUu7ErzzNClr2+eI=
X-Google-Smtp-Source: APXvYqzQzABVu+SKYv0g1W8iRSiOGI4Mbm6b7r1KT2cZ4MqQy2HX6xRCwfE2nFShloC8CUsB++GnHg==
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr46093512wrv.197.1577399382667;
        Thu, 26 Dec 2019 14:29:42 -0800 (PST)
Received: from localhost.localdomain (p5B3F7018.dip0.t-ipconnect.de. [91.63.112.24])
        by smtp.gmail.com with ESMTPSA id j2sm9731276wmk.23.2019.12.26.14.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 14:29:42 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, sam@ravnborg.org,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] dt-bindings: Add an entry for Monolithic Power System, MPS
Date:   Thu, 26 Dec 2019 23:29:27 +0100
Message-Id: <20191226222930.8882-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191226222930.8882-1-sravanhome@gmail.com>
References: <20191226222930.8882-1-sravanhome@gmail.com>
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

