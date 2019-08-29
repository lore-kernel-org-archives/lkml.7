Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AD9C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8AB2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gkLh4E5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfH2PYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:24:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33966 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbfH2PX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:23:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id s18so3902327wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4DbXu44h6zYgUhoI2+oC/PW70jCUJ0aSE0KZ0LmuHcU=;
        b=gkLh4E5U8zTo9TVea9wVjBFgrFpDenNKYz9qy/FLex/I5uDweFPrkzPcn1IETEyneG
         V/LnaPjJuG21eHtkmi5mUpM/oQJqS9gFpkQqAod/sAEbyTI4Wg3a7360JaCJKa3VcGwx
         uYy7vvDuEFdnMQuzeoU79E1i7aYqC1kP6AsJhqSLDc/DHjI1qL7YCoA8eypjjSZYc3lM
         pNKwRUGZ/VJH2In7GMBwOdrXUfnbBxyI6z4tKGYifluidRlI7Ntwy9r3Z3q0YF/YsFxh
         Ziek74oF0XXfgfZe5xufMKEQNPb9M7uxF/Ztsfn8UuPVpaSvfNR/uj4TcGT3T3nbwOyc
         6lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4DbXu44h6zYgUhoI2+oC/PW70jCUJ0aSE0KZ0LmuHcU=;
        b=l4ZowANAO3B7yTurRUn2ILWUho9+fGiXrS/8Y+0RQBfKnZ2d/3CHCmFzBN5n9DDj6Q
         cFqDjTf8sQiv0m4b13pKqOSX78G07pRZI9upkgaUqrbXWjoLqEZBWRSBQFwPnzVLLSGp
         7+Z7uHqIg85egaSPmdoTkT4C+1pSLBsp35u8xNxCJwLYSEPaj910d9+GcoNvA5vYBfAH
         UXaG2HsiOH9vUpCx0j0IcZaGbCvXdT5T2Rf2OZIY3wzGR0b9c/xdQD4HBw0DYzbWSLzy
         F3Md/DE/p2B8cqbyDXyqCIaAAgs+h00IjWa+M+GxIArRYvOqQ8DdQk0LMKY2lbFe8+eB
         tnPQ==
X-Gm-Message-State: APjAAAWrm9tBaquph9nV3+cjBxmAX0mq2sr2TBfbc0batf3j7RfYHeFn
        oVqy/2md32uIm61I9Pfp1LzaY5ItSRlfHA==
X-Google-Smtp-Source: APXvYqwwvv/Bga0e4qQQrLGeLWTenKP0N+cZ1PVW2irmpfKismMyhtgiqXfxyPv0z+uZK+ieRvK8pw==
X-Received: by 2002:adf:9222:: with SMTP id 31mr433433wrj.93.1567092234757;
        Thu, 29 Aug 2019 08:23:54 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d17sm4866871wre.27.2019.08.29.08.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 08:23:54 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 15/15] arm64: dts: meson-sm1-sei610: add keep-power-in-suspend property in SDIO node
Date:   Thu, 29 Aug 2019 17:23:42 +0200
Message-Id: <20190829152342.27794-16-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829152342.27794-1-narmstrong@baylibre.com>
References: <20190829152342.27794-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WiFi firmware requires that the power is kept enabled while in
suspend mode. Add the keep-power-in-suspend property in the SDIO node
to specify that the power must be kept when entering in a system wide
suspend state.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index e1cac880b02c..9f83dcfe96ac 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -301,6 +301,9 @@
 	non-removable;
 	disable-wp;
 
+	/* WiFi firmware requires power to be kept while in suspend */
+	keep-power-in-suspend;
+
 	mmc-pwrseq = <&sdio_pwrseq>;
 
 	vmmc-supply = <&vddao_3v3>;
-- 
2.22.0

