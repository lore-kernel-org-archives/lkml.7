Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0260CC31E4D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA522168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 08:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImPTz3XJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfFNIDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 04:03:37 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:41854 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfFNIDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 04:03:34 -0400
Received: by mail-pl1-f178.google.com with SMTP id s24so680548plr.8;
        Fri, 14 Jun 2019 01:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xB93p51LoWFDyQP6GRTibbBaNfliN1OIfftKtAHaj1c=;
        b=ImPTz3XJKn6/xYqThv+m8LLGxrSkgJBJy3RnJfixNCUgZBb7Q0vl7Hz2EbfbZKC9s5
         bJS8CeLzQBd87BZpaN+d8jWr6wPtybATrqi/d+LqTATCxj4VdwEUf+vZ3bGsXXJJyZnt
         cbCN0E1VNQAxEI0ZxoKIo7BQOO2AU9pnEIh0d6IFnC5nFAnA8oeE3h6eFz9Y05Rpw+BK
         HQKMP4ScLNxNui9S/BRKXqInF6NClVA62c6zzinjUx/T1rmi9kQ6aMr/4akySf0ZM9zk
         ZKEl4IKQjMTz9O85F+r4ASQN5taK98CpIIrn9zArXR3Bp5FeMedudWDNY1XX9mntRozJ
         tKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xB93p51LoWFDyQP6GRTibbBaNfliN1OIfftKtAHaj1c=;
        b=QIbmp/emS1a0v703wX9m7CJW1z/TspV3WCP4orZH//lGCCV7HDKMVTNPjdUnYnNpsl
         w5kq20n/bI8KCdr7moZO8d0usVWywLfW78UbtplkFWhgrGppXUnwl5zW9Juxxjk5nb98
         Eoc/eY+TYhsjQvIi39tD2O9fFc56pVYXtzXC+CLaIEr+aFAUfQN1s/Tm4jRdbM2Kq13v
         BWYBWYLqBOOVZ6UQ9oTYGwXcQTC5ss8eeXICW7I5wF6fqTQ30w2vSJowjz1zZh0X52eZ
         YoooL4+mVUkQ/cdXx8gENh1bbBUH+9ceKNFtrQlqXRc/pT7wyLknITfxNb8cryW02E1B
         q6zQ==
X-Gm-Message-State: APjAAAUn7TWAKI16n8/n7oxMYbgf1R36hjy6LV0/PpSt1Y6oRdnq0mme
        NbRE5KscpAztKZuOEewlIkY=
X-Google-Smtp-Source: APXvYqy6uVhaBGp/EYpOb7nyjOKx2rYmVb6ZbXx3HMat3Hf5iBYw48paro/t8wRJJY8JoBx2IX2aiw==
X-Received: by 2002:a17:902:108a:: with SMTP id c10mr90187111pla.48.1560499413873;
        Fri, 14 Jun 2019 01:03:33 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id c10sm1718237pjq.14.2019.06.14.01.03.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 01:03:33 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Bob Langer <Bob.Langer@zii.aero>,
        Liang Pan <Liang.Pan@zii.aero>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: arm: fsl: Add support for ZII i.MX7 RMU2 board
Date:   Fri, 14 Jun 2019 01:03:17 -0700
Message-Id: <20190614080317.16850-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614080317.16850-1-andrew.smirnov@gmail.com>
References: <20190614080317.16850-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ZII i.MX7 RMU2 board.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Bob Langer <Bob.Langer@zii.aero>
Cc: Liang Pan <Liang.Pan@zii.aero>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 407138ebc0d0..8fb4dc1d55e7 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -158,6 +158,7 @@ properties:
               - fsl,imx7d-sdb             # i.MX7 SabreSD Board
               - tq,imx7d-mba7             # i.MX7D TQ MBa7 with TQMa7D SoM
               - zii,imx7d-rpu2            # ZII RPU2 Board
+              - zii,imx7d-rmu2            # ZII RMU2 Board
           - const: fsl,imx7d
 
       - description:
-- 
2.21.0

