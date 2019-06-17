Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4B7C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059F4208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egbGiMcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfFQPay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:30:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38028 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFQPav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:30:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id a186so5877623pfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 08:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7atjPk/hX+MOamOqti7mhl6Hi5bK3FfVvoUXrTNgdME=;
        b=egbGiMcv/e7NJhMd6l0WLx0L4afEvVDOZGpbmp+um1r1HOD/AlblrSCuNaRrkT1SYW
         SojJI0l5wnzevFYg0HeFrbbN8LT4rppE2ni2Xk0BO1XfiY1L7xAGsXkupm70aVVLlvD+
         0MEhiNdwuo9LPi/az5Q+ZFlkCDj9XV5x8TkdMD3CHuNx5WACbhe6aZS7kH9nFgmgYfdS
         W7sWxVD+tVBwCgtnWXmxJUIP5MpnhYW8JX0G/P+h9Zo3t+y7+RRvCt9wTPFz3dnbUhMk
         QhCg65Le/PpkjkN4Gd2sf8SexDRp8CNlC75YNSoBDWbExS4Xlw5GE0oxAHDjBfveD+1P
         iVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7atjPk/hX+MOamOqti7mhl6Hi5bK3FfVvoUXrTNgdME=;
        b=azrJJWfDNyXnFLsV54VdTRwdn0puRujYV8wLBwVi6+jxvr8is4b5zGpeYVbaOZRsxC
         NBJTOgob7/Ni3xZS/xxTXxxL3YAZ3Ut2JzVApqF1aKBjXRiaArLk3SFK/D24hEyI4bsf
         VXxkZOILCjnDS4aCSNtfATBPGjfnL7bHynOBYgT+x8KtQojOo9XrdSHQc4Kw8FMAVxTP
         hC3n4VzMVQozas3jT01fyOUsU/pFUt3J26w8mP/2nlXD2t68ae/6/i3Mh8gzkqYqHq0O
         2aCpC2ceygel0kREO0ZvpL97RA9JFc3kNDQmloE6X9Tyc6mJoXf6QEFC34ijBJgtQ5Xr
         zWZg==
X-Gm-Message-State: APjAAAUlHC/EkL61n3DmhgpNFP03JvIT68ZTafk77+MbVUCAZ//D+DO3
        SS+x0wArzOoIPMcZnHKpCpw=
X-Google-Smtp-Source: APXvYqxJ5tskuIGBkG5RfoEBhOmSJ3nifjlJ9I1UjCGBFN+u2AbYYuSEHhDS3D+gA/PDV2MgBRdfdg==
X-Received: by 2002:a17:90a:af8e:: with SMTP id w14mr27347299pjq.89.1560785450225;
        Mon, 17 Jun 2019 08:30:50 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id j13sm11426144pfh.13.2019.06.17.08.30.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 08:30:49 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bob Langer <Bob.Langer@zii.aero>,
        Liang Pan <Liang.Pan@zii.aero>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: arm: fsl: Add support for ZII i.MX7 RMU2 board
Date:   Mon, 17 Jun 2019 08:30:25 -0700
Message-Id: <20190617153025.12120-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190617153025.12120-1-andrew.smirnov@gmail.com>
References: <20190617153025.12120-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for ZII i.MX7 RMU2 board.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Bob Langer <Bob.Langer@zii.aero>
Cc: Liang Pan <Liang.Pan@zii.aero>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---

Changes since [v1]:

    - Move RMU2 above RPU2 to keep things alphabetized

    - Collected Reviewed-by tags from Rob and Fabio

[v1] lore.kernel.org/lkml/20190614080317.16850-1-andrew.smirnov@gmail.com

 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 407138ebc0d0..91519cb24083 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -157,6 +157,7 @@ properties:
           - enum:
               - fsl,imx7d-sdb             # i.MX7 SabreSD Board
               - tq,imx7d-mba7             # i.MX7D TQ MBa7 with TQMa7D SoM
+              - zii,imx7d-rmu2            # ZII RMU2 Board
               - zii,imx7d-rpu2            # ZII RPU2 Board
           - const: fsl,imx7d
 
-- 
2.21.0

