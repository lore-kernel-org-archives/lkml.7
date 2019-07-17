Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12261C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EF52182B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgrOIjmJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfGQPDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 11:03:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40479 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfGQPDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 11:03:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id p184so10964361pfp.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 08:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OvPD4V/2GZaORYFcR4jNZsYwHU4GxPLSWCPMlgr5s7U=;
        b=IgrOIjmJgKBptnHAlAOggl4vyW2xDVXq6Qa3xqi0E0Hx4InuRoNtZV6BfDII03Uaom
         u2fK5IKS82Lvqe5V27rjDjoONDlTjc77hLgCk0G5XEoeH0H+huhvKjU1Pd9MipLs9Zus
         gpq+lcg7uVf7Pb8jLrT5HhM/oiQKQyic0NWKackH6Zo1SAuVpm3g9OWDBmL+pcpTtpsl
         GN7j+CsrPHHEtIt25XEYEi8zTXimuiNG592oFUUa+x/V2k8YC1hHpgxhDVX4VRumMeoS
         a5j9FoVrcfEdURkf60purDrwGXZya8yBs86W9D1dqAizMD77pI5Q4Eqmx/PE9/2UPzmr
         ztaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OvPD4V/2GZaORYFcR4jNZsYwHU4GxPLSWCPMlgr5s7U=;
        b=NuEqavFB9eRvkUGYy3nBCEI32Et2UPTJzn6Tqx+8PgdrqfBXjBwLj12Gus1g06ctLW
         EY9xy+MLjs0HZIhecXrlM/nTjVeEdiinl4ftqASgKlYRRyrKYPmJRr7RxAu9dvzTPUBZ
         5qM6Isiydq0HEKVC0+K17qyUbjjiV+zzX8JWccSrWOE4jCDV9RnXjYae/F476CO4ZaLo
         qvn8nCm0HnbHnQU0hwPHyN3Wo2JXcIM1swCeesoDJP5x886UeTMyj3fKC0q+N76OeQ+P
         mtShX0WCNikMMTiHLQAugrL+A713hFSIVp8i0Ety2rIgQaFkyaq7qEgfnyO2n7TrY6o5
         Wt2w==
X-Gm-Message-State: APjAAAWHu/0NndNG5XtMyyaAIFyQq59IjuakpZ4ezVpyAWzBJO75XNKQ
        L7GJA2EfTysTPrNaTlUVmBzcYjHT
X-Google-Smtp-Source: APXvYqwlKK93KUyr6TQlswdXXuF/PevkzQcVQAjxUomXEGl+4Rh1zM9IdLtXuOUmNwh77E04NQJUdg==
X-Received: by 2002:a17:90a:2768:: with SMTP id o95mr44323526pje.37.1563375781161;
        Wed, 17 Jul 2019 08:03:01 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id b37sm44728961pjc.15.2019.07.17.08.03.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 08:03:00 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Cory Tusar <cory.tusar@zii.aero>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: vf610-zii-scu4-aib: Fix pinctrl_i2c1's identation
Date:   Wed, 17 Jul 2019 08:02:52 -0700
Message-Id: <20190717150253.20107-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190717150253.20107-1-andrew.smirnov@gmail.com>
References: <20190717150253.20107-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix pinctrl_i2c1's inconsistent identation.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Cory Tusar <cory.tusar@zii.aero>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/vf610-zii-scu4-aib.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
index d7019e89f588..a64de809299f 100644
--- a/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
+++ b/arch/arm/boot/dts/vf610-zii-scu4-aib.dts
@@ -777,7 +777,8 @@
 			VF610_PAD_PTB15__I2C0_SDA		0x37ff
 		>;
 	};
-		pinctrl_i2c1: i2c1grp {
+
+	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			VF610_PAD_PTB16__I2C1_SCL		0x37ff
 			VF610_PAD_PTB17__I2C1_SDA		0x37ff
-- 
2.21.0

