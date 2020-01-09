Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111B7C33CA3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C8B2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 11:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0BNqC+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbgAIL0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 06:26:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34901 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729912AbgAILZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 06:25:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so7013700wro.2;
        Thu, 09 Jan 2020 03:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nuqpk77kadkNu92XiqO2mE8dn2Lkq0m2HM+duPrRe3U=;
        b=Z0BNqC+lVJImVHhxkH+mKYHoSrVLe6o98T0SHE2OqPD/BP0Xn5kt4q4EnDtOMgetdR
         bjfHNj7Pz09P/6QEzxlL6eWr4F0YWptos7gYGqP8iBBkV1dFsZGGbDPJIhRq3uMSC6gM
         lFeOZlTN7GCV9agnU0yEP2eARWC82ewIHFyBGCqTeEn4XM82Nu2MVlXxPZjJjNVkgeje
         Uk3eDxHoh4NHevvHeWAZGXomb1TyBhOCqZF5yA6VgIY6fuYP8EjlHvU3MbeVshvl/B2d
         iahJohmrYJVsOKfaJSMVrsQ3/UEYRwjC/FllK8kdisUG9FkesNH0E+Rn5dL9YB5O1iAt
         QgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nuqpk77kadkNu92XiqO2mE8dn2Lkq0m2HM+duPrRe3U=;
        b=eVM9cRuHozSgjlcj5lDLpXYIYEuebmbhXCVQpdWfhQ7hDDnmyngPMbI98x7JP2kq+t
         xWI/Q3tGxCvW2OmMqvPAvGWWtiTWt8vWm4SkfSOwuhU1WS0Aoo4hfgARpS52ZKfQvvVF
         711BfSYx57oRGs0FUrRQP7dsIQwuOHEAO7TsE28ZDrEgaQX/SaPiVW6eWScdKLPI/ED1
         deRALjWVLmXndYBnT5oxzRRLk9NkmIFZpKTnuJ1fr1q9ybVKOAt/G4EyGEwetFc83n6b
         fVhlYoadR6rhSBDc23hRJpM0APkkldVcpF+7XXfLMPOnwbAEUY9g28BS5Cqa2fC4MmjL
         1NTQ==
X-Gm-Message-State: APjAAAU4dujhRoKxfJkU82dGHYQevHA8WOTZQFjXXzVy9wQ3I6wggIeq
        Z/cMkuet8pTjzBjv9GRVXqTxNBGXVzizmw==
X-Google-Smtp-Source: APXvYqxwl1xjzZ9fiNXx9ucGH3K/mp3eG7nqocTr3gGSbdmGPStk/gbcBBHHZ0RnELFsVauC0LkrwQ==
X-Received: by 2002:adf:fe8c:: with SMTP id l12mr9753042wrr.215.1578569157802;
        Thu, 09 Jan 2020 03:25:57 -0800 (PST)
Received: from localhost.localdomain (p5B3F655B.dip0.t-ipconnect.de. [91.63.101.91])
        by smtp.gmail.com with ESMTPSA id 60sm8298660wrn.86.2020.01.09.03.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 03:25:57 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, sam@ravnborg.org,
        icenowy@aosc.io, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/4] dt-bindings: Add an entry for Monolithic Power System, MPS
Date:   Thu,  9 Jan 2020 12:25:45 +0100
Message-Id: <20200109112548.23914-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109112548.23914-1-sravanhome@gmail.com>
References: <20200109112548.23914-1-sravanhome@gmail.com>
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

