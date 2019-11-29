Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29AFC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8122176D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="UwqMMJ2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfK2Iwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 03:52:39 -0500
Received: from sender4-pp-o98.zoho.com ([136.143.188.98]:25879 "EHLO
        sender4-pp-o98.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2Iwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 03:52:39 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575017479; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=OeYaZf5Ai4mqYUx6O3aKZVncW+0gRvxPdF/yQGFi8Bl1QgOi34D4UHYEXHb3GKFe+Pbqu8G3zH6C6XPE2qtnDyEmqz2n/85dYq7OcsmVkViDyyBd0HK7L8wu0zjmH6Qc1JKxmTEWxuwwGkHxQp4g+ArfCV8ZtlAutlIrfh6eTVY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1575017479; h=Cc:Date:From:In-Reply-To:Message-ID:References:Subject:To; 
        bh=CWVkIKGWM1uCRb9ESC8xbmHPGthlsjybV4VJ6FVoO0U=; 
        b=LuYOhBr1HYTQzgxsIbcyNlFkrUsk3lU67/tJ0xmXFDqMkPtViUm0pahdbvqsZvYVn23r3L7Wkyn5Y22sN6qBsjRCb6GVFAI2QKadPGuy/o20UULyQlcxSyb+0txPegXegnSmZvo5IduoLeVqPvzqjizJuBq/yDE3CIoqJKwHyZk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=Q3maPDNxH98D41j1QKfHHSWGzqJ5646FVCBoZ/xbW3mf9GjI+7Mo7qcXZL6LUxOUUBKvzfjV9j5P
    6tdKWn+9+aKSfCmeTddQOOrxTQitYAn5WIjGgOepg+S/AEVEklUO  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1575017479;
        s=zm2019; d=zoho.com; i=zhouyanjie@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=CWVkIKGWM1uCRb9ESC8xbmHPGthlsjybV4VJ6FVoO0U=;
        b=UwqMMJ2WHPsm2FCMFCiBVw/jvsaoT3M4MuUxrrtJpJHmtPxpU2beJfxpe/rOXPtS
        jQycqpo7sSDM7pHFlzViBWCy1DPOiUHhmYmMuhuEuPzavKeIH9bBbwYktNwBdKU8FfK
        edKaQJBkB6QLYQ//LNtvrdJV0HE69ree9cwghKI4=
Received: from zhouyanjie-virtual-machine.localdomain (139.207.146.46 [139.207.146.46]) by mx.zohomail.com
        with SMTPS id 157501747653225.0066604018798; Fri, 29 Nov 2019 00:51:16 -0800 (PST)
From:   Zhou Yanjie <zhouyanjie@zoho.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com, paulburton@kernel.org,
        jhogan@kernel.org, mripard@kernel.org, shawnguo@kernel.org,
        mark.rutland@arm.com, syq@debian.org, ralf@linux-mips.org,
        heiko@sntech.de, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, krzk@kernel.org,
        geert+renesas@glider.be, paul@crapouillou.net,
        prasannatsmkumar@gmail.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, 772753199@qq.com
Subject: [PATCH v6 05/12] MIPS: X1000: Add pdma controller DT node.
Date:   Fri, 29 Nov 2019 16:48:46 +0800
Message-Id: <1575017333-29020-6-git-send-email-zhouyanjie@zoho.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575017333-29020-1-git-send-email-zhouyanjie@zoho.com>
References: <1575017333-29020-1-git-send-email-zhouyanjie@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the appropriate DT node to probe the pdma controller driver
using the devicetree.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---

Notes:
    v4:
    New patch.
    
    v4->v5:
    No change.
    
    v5->v6:
    No change.

 arch/mips/boot/dts/ingenic/x1000.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
index 13a6c9ff..c432828 100644
--- a/arch/mips/boot/dts/ingenic/x1000.dtsi
+++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dt-bindings/clock/x1000-cgu.h>
+#include <dt-bindings/dma/x1000-dma.h>
 
 / {
 	#address-cells = <1>;
@@ -173,4 +174,16 @@
 
 		status = "disabled";
 	};
+
+	pdma: dma-controller@13420000 {
+		compatible = "ingenic,x1000-dma";
+		reg = <0x13420000 0x400
+			   0x13421000 0x40>;
+		#dma-cells = <2>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <10>;
+
+		clocks = <&cgu X1000_CLK_PDMA>;
+	};
 };
-- 
2.7.4


