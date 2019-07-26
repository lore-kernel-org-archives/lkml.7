Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448FBC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40A12166E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E/8yDjb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfGZHVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 03:21:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42691 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfGZHVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:21:45 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so24055118pff.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 00:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=UKHcPnP1X/YH0KxOMapb8zoNNla2jhYhzX+lsHS5cTM=;
        b=E/8yDjb7ZXAoXz4rohf7xtU4fhLLX5e2g+HPtRaZkv3EEOnRi93Lc23PAFcSQlkXjb
         J3Wa6rERdfomrw2OTiK4FH5qYxtfwCfuIP5rQTWocufBjT6s+yyn1isAdW1mS7TBlhF9
         zqljjj5O16ddI36qYavzuNIlDPSDILRII6NiiRPPmJihn6ZmtXZXEsUy2qxRn9toErIe
         4pfyj+dW/0gFmCbyCGfQd+hC89i8hZK+dH8qwarrCFKd4U4csbslNRiqS39I2iAeb36O
         DbPPLxMS6drd93OWQxQEkAus7EIMyOpygAFaoynlbckmOxeAGcmfGvzwBIlPb3h08hLh
         3cYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=UKHcPnP1X/YH0KxOMapb8zoNNla2jhYhzX+lsHS5cTM=;
        b=kLjev8eYmL0diM0FSNs3Bp+x4thwIxGkB3Z6PuQkYjdUYaLuTFBa/qLKZ2Iq0poZpN
         dgY90kRVx/tuENDMPvxyNJCm+JFXAWlgsNjARFRzfapc7ViJWYMkdX39xqfjVI47x/sm
         z516VN8BlskuY3nLQAxILNRgSDKiN4m5Rd3POCFuc2pSpNZnt4yjNXbT0z7agCW+Zq9y
         OX3m1rmM0WtJTytxIYGvkkoKVyQt1U3Avv1ATEkscdWUSHOPN2dQUorBoXa0xkDI700y
         pi5XfIqnf1PiF9HsXdTwdRqJdstbzEwFcUXeVw/Gxqk+jbP//9Iy91XpRkkGOGH94EZe
         amzw==
X-Gm-Message-State: APjAAAVuO66sqaU7rKlIbDZuc1QIMtVm1iL1ood1qBK6WLXqrrBdQYST
        UMtZZu8yIhpdDFUKXbW3fVOPqg==
X-Google-Smtp-Source: APXvYqx0MzCJG7d9iPnuvF6O22gUq9ll3iEEBUmjoDkNejDovvr6c+hOVWesySnuyHKOJNCRdJYZtg==
X-Received: by 2002:a63:b747:: with SMTP id w7mr36749242pgt.205.1564125704234;
        Fri, 26 Jul 2019 00:21:44 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id o12sm39216152pjr.22.2019.07.26.00.21.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 00:21:43 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc:     weicx@spreadst.com, sherry.zong@unisoc.com, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] dt-bindings: spi: sprd: Change the hwlock support to be optional
Date:   Fri, 26 Jul 2019 15:20:53 +0800
Message-Id: <23d51f5d9c9cc647ad0c5a1fb950d3d9fb9c1303.1564125131.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1564125131.git.baolin.wang@linaro.org>
References: <cover.1564125131.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1564125131.git.baolin.wang@linaro.org>
References: <cover.1564125131.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to add hardware spinlock proctection due to add multiple
msater channel, so change it to be optional in documentation.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 .../devicetree/bindings/spi/spi-sprd-adi.txt       |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt b/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
index 8de589b..2567c82 100644
--- a/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
@@ -25,18 +25,23 @@ data by ADI software channels at the same time, or two parallel routine of setti
 ADI registers will make ADI controller registers chaos to lead incorrect results.
 Then we need one hardware spinlock to synchronize between the multiple subsystems.
 
+The new version ADI controller supplies multiple master channels for different
+subsystem accessing, that means no need to add hardware spinlock to synchronize,
+thus change the hardware spinlock support to be optional to keep backward
+compatibility.
+
 Required properties:
 - compatible: Should be "sprd,sc9860-adi".
 - reg: Offset and length of ADI-SPI controller register space.
-- hwlocks: Reference to a phandle of a hwlock provider node.
-- hwlock-names: Reference to hwlock name strings defined in the same order
-	as the hwlocks, should be "adi".
 - #address-cells: Number of cells required to define a chip select address
 	on the ADI-SPI bus. Should be set to 1.
 - #size-cells: Size of cells required to define a chip select address size
 	on the ADI-SPI bus. Should be set to 0.
 
 Optional properties:
+- hwlocks: Reference to a phandle of a hwlock provider node.
+- hwlock-names: Reference to hwlock name strings defined in the same order
+	as the hwlocks, should be "adi".
 - sprd,hw-channels: This is an array of channel values up to 49 channels.
 	The first value specifies the hardware channel id which is used to
 	transfer data triggered by hardware automatically, and the second
-- 
1.7.9.5

