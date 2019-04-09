Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E460BC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AF92084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmdqI3hG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfDIP62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:58:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46312 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfDIP61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:58:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so21564098wrw.13;
        Tue, 09 Apr 2019 08:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mhGRionJ1a886bu/5/NUsU858Dc/28TevVrTJCzI2gA=;
        b=QmdqI3hGGs2/e1Wjz2zMsMsZBD/UfdYdELDUr1hV9GypxEiy9H5JXJPUrsEn6vm23M
         YfKTUb5VExep6cio66Q2hQFnHthUeEfwR7ougaHb+9awuJn1K1dD/bAlj5lazRS/wOpD
         ASduoiCS85T3SQKoGxvEzpqbt5j+xFScU17KVDUyaqbeojP8CZwqGd60W/KMj+Iiior4
         zMSHMd/RFTybib1T8ovaiqxwqyFj75dUAUetXguixRwcvdhqk4O2P6bwB/9L6P+2+Jls
         gXoDYPX/e8FuE4Hn8hUhDnyJ9oJoS7mqEuaJgbRWmp5IgsyYEH71GbQPdwftcVMEwOtk
         v3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mhGRionJ1a886bu/5/NUsU858Dc/28TevVrTJCzI2gA=;
        b=hJxooZKC/emxzYDSum77RCbM01xIrOkt9jXvc59HQuj4g1CPjuDZVWZzqVMT0JTUKy
         Wbx/MhICRjYz/JGCtlRv/FfOFmxw75ZYEClK8dgjhEqgRGEXSULefRviLg5syaxMXO/j
         CNbS9+ypQDH1xdAUax619vM9npPQVnTSdbTIF0qzqxdaec6zq9UyOYExOc48m7zVeFtL
         l8fcnebIEYQAY9T54PjEGtYJLRFJgRwuVZgmTGRTklcX/p7DsGnfsWGyQzHOyJGCYJPy
         YYrdOFhGfggi6XqkMpNRI82roPVgjxd9tU/O28fXpdGFdj8D2Mic6hCG78mpK3G1Cvxx
         eNGg==
X-Gm-Message-State: APjAAAUAau7ScjVtyL2PjYjWO/eAdZzgQyk4ZbKTt+K+lvi1fB+nbwGX
        +A7o4lqfzAfkvJKa6lSjCKlLWyMP
X-Google-Smtp-Source: APXvYqzS+P90L2H2+qa485GaJmc7RKPeVM4+tW0H5fs7d9LZYXO2s+LvcM+/zEdRmDjd48iD+PpjcQ==
X-Received: by 2002:adf:c7c8:: with SMTP id y8mr7899707wrg.149.1554825505759;
        Tue, 09 Apr 2019 08:58:25 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id z17sm19869207wmc.7.2019.04.09.08.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 08:58:24 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH] dt-bindings: mfd: axp20x: Add fallback for axp805
Date:   Tue,  9 Apr 2019 18:05:50 +0200
Message-Id: <20190409160550.1086-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

axp805 is actually compatible and used with axp806 as fallback.
But it's actually undocumented and trig a warning with checkpatch.

DT compatible string "x-powers,axp805" appears un-documented.

Add this compatible in the dt-bindings documentation.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 Documentation/devicetree/bindings/mfd/axp20x.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index 2af4ff95d6bc..4991a6415796 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -25,6 +25,7 @@ Required properties:
     * "x-powers,axp223"
     * "x-powers,axp803"
     * "x-powers,axp806"
+    * "x-powers,axp805", "x-powers,axp806"
     * "x-powers,axp809"
     * "x-powers,axp813"
 - reg: The I2C slave address or RSB hardware address for the AXP chip
-- 
2.17.1

