Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA17AC00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6BC22B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfjIOhRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbfLKOFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:05:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44176 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbfLKOFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:05:00 -0500
Received: by mail-pg1-f193.google.com with SMTP id x7so10812801pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 06:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cUUCtvV6dE7G+n+i4G2mZsNxXxqu2jZTcnec8ASN3Qc=;
        b=rfjIOhRvPOYZ/dAXmCNf7a/TIjgXPUapHGuKnYw1EHqnxyIuWXwJdZ7OZ8vo5foJ4U
         hipSjIC9xJF3uHK0K3sSyzjumI8s+p9XQbvx86oz/grSzOQ78igqPg9uOy+ACckg8He+
         SnsZAvNfSZa3nxwuSgQ5q4zG/hFZt6EPR27tfVe+lrNtRkEjths8Y/cVTlR7XuL/DHU+
         +VKpUKy0Ry1OIwFa4v3J+zZXHcsQgIwFekUdX6jtfacTftC7jRakvkh/6CD+FRbD/8/5
         RKcsbuFt7fJjanI4qw7AVy4+gSvzQ4TXkF9C+wC/MVcLuyPuQuz91aFZjttOlxX0WFDA
         O9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cUUCtvV6dE7G+n+i4G2mZsNxXxqu2jZTcnec8ASN3Qc=;
        b=XujxVRb7pP1hTmtkjqAyTfEdH6Pdta5xakyLMmmP+19TYG1DNWagOCilvBLRNPXpXd
         Ny94KmqbPPihCiakKO4Zmm1CTjsqT3KVSJgM8LWccATlPBA25+Gr6MvzBJU9snVmTnhq
         /obGhc1woIkK+xnBEm6a09hmPqMQOFY541tcDCsvt34gvSLBGKgy0JfCPoWZa8TZKnwU
         v+7zaiNAaQsZAfCFwTqDVwZ39IdVrdVL0tA/FxK+21ryqNdCUd+9C5YQos/JpzA505cs
         1Tzfgv4BW8SV7ii8NfF++Hh2oYi88sWTzsY1ZnMFMSN+CFyzmuCGBkOGMEg01YEV8+fD
         /LLw==
X-Gm-Message-State: APjAAAWP2k6iKZlhI7FoZhWGQ0yVzD/FgTbeYp3baC7phwa3r9sxjbFS
        MAj3VHn/U8MG1UXg01TgLPU=
X-Google-Smtp-Source: APXvYqw91JEsFIrGZNMXi9Usn6ggISlqDCZqbfwZNdXS+nPBATkP7rouWQW4phJsTFq+yy3p1gZxhQ==
X-Received: by 2002:a62:ee09:: with SMTP id e9mr3734785pfi.243.1576073100169;
        Wed, 11 Dec 2019 06:05:00 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id o12sm3489656pfg.152.2019.12.11.06.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 06:04:58 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: dts: vf610-zii-scu4-aib: Add node for switch watchdog
Date:   Wed, 11 Dec 2019 06:04:44 -0800
Message-Id: <20191211140444.7076-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191211140444.7076-1-andrew.smirnov@gmail.com>
References: <20191211140444.7076-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C child node for switch watchdog present on SCU4.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/vf610-zii-scu4-aib.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
index a02c7ea3b92d..b642520199ba 100644
--- a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
+++ b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
@@ -536,6 +536,11 @@
 	pinctrl-0 = <&pinctrl_i2c1>;
 	status = "okay";
 
+	watchdog@38 {
+		compatible = "zii,rave-wdt";
+		reg = <0x38>;
+	};
+
 	adc@4a {
 		compatible = "adi,adt7411";
 		reg = <0x4a>;
-- 
2.21.0

