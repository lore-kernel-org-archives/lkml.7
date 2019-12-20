Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D60C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA31D227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bd6VoMSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfLTB4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 20:56:10 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36649 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfLTB4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:56:07 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so8325639ljg.3;
        Thu, 19 Dec 2019 17:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bvf4OSFNQcVF0tHhO08aQEMZiSb+xUsqvddNKBq6qy4=;
        b=Bd6VoMSSSa1RicZ+I28MEZGmHVihxQ19SWOCxipeyddeJuncj92l5Cgi33++6ROUwB
         it7G77fdZJYRvdsl0mnmrPdKTKTRAAaGNFt8POQgJBG6wc8lmW1NwTHP63k8YgrfQUid
         tbWjyBxkXSH+KMUnj05kvlSTgdGuT5c7TB7uhV6F6LmhpZZ134hGwTf5U+nP7CkdYg0z
         WzHqfGkUYRKFTeeMfCuZqUdLpx7r9KeEl2awrvHS3ZLoSEvyDKt9v2WJksLR+ky4g/yX
         bMIITNmt36cKRy74nhEBy8UXYrycmq20576CErSEFjImWJkrhxxn32uXm9gNYzEtst3l
         /Utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bvf4OSFNQcVF0tHhO08aQEMZiSb+xUsqvddNKBq6qy4=;
        b=prAxA8qymhj5VmtgkE8dY6d34i2blVdDMpukn783McgRwhsszOCDvT+r4cA4rXYSL6
         DaL1NMPrTCCBBM+F+iSiS1AzsYGkS+rHSwIFaOXVLhCCa44arpPWsOR/5uHvW8xOTJp7
         9szzw6T+kECea6a8QsCSYokz/uAAunQJTH6xYRogIbGZVHwwuZjZKs6BDEFtjTOff2Cg
         bduGOh1LRTkKjMZzi1PNUSgdX4iV1vxuHh/EdH+3f5FQxPWVtJoILYAlBr8wTS9BeC5f
         k1NyOjLGtitf8qWv70DcS/Mz+yLOjBUNNDVPrtEkDq3PWwEpov5n2pW9gkJt4d3Y/Ve9
         N3dg==
X-Gm-Message-State: APjAAAWdAOuHWSyE3/jGPlWfRXtscpp/GI2UKRidN5kYODl1NJu4xyvq
        tjGik6pk7QpKdfkOFXyyZSA=
X-Google-Smtp-Source: APXvYqycKZLWIMN3WjdC1WHu5/wqQ7pFn1IvsljswfPU+EuCg6LNm0xb33rPQJfqWa8tvGQQIchPYg==
X-Received: by 2002:a05:651c:1110:: with SMTP id d16mr8429271ljo.86.1576806965406;
        Thu, 19 Dec 2019 17:56:05 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m13sm3270901lfo.40.2019.12.19.17.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 17:56:04 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/10] dt-binding: usb: ci-hdrc-usb2: Document NVIDIA Tegra support
Date:   Fri, 20 Dec 2019 04:52:29 +0300
Message-Id: <20191220015238.9228-2-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220015238.9228-1-digetx@gmail.com>
References: <20191220015238.9228-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVIDIA Tegra SoCs use ChipIdea silicon IP for the USB controllers.

Acked-by: Peter Chen <peter.chen@nxp.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
index cfc9f40ab641..51376cbe5f3d 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
@@ -15,6 +15,10 @@ Required properties:
 	"qcom,ci-hdrc"
 	"chipidea,usb2"
 	"xlnx,zynq-usb-2.20a"
+	"nvidia,tegra20-udc"
+	"nvidia,tegra30-udc"
+	"nvidia,tegra114-udc"
+	"nvidia,tegra124-udc"
 - reg: base address and length of the registers
 - interrupts: interrupt for the USB controller
 
-- 
2.24.0

