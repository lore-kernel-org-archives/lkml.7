Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC068CA9EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E56C218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vr5P6YWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbfJ2Bnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 21:43:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41820 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfJ2Bnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 21:43:31 -0400
Received: by mail-qt1-f194.google.com with SMTP id o3so17766635qtj.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 18:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X6pL/xiDS/rERWaTtkpN3WZ9KElC/+F38pnanmSrxfQ=;
        b=Vr5P6YWnWuty2sCRj0ER73ABkvrtifU2f1UD80c8mj+f05Lxxt8lmWBrY2a6CAx1aK
         xwGFdy1+liMSJ4p1Gkb5KkjE95ftnNQ0TeoN7aClTPc4uihitkyIahRbQ/g03HIuR1Is
         2iLbNtm0VSqXa8WJzgYClo7XG2TUkUp17HOO/tHgj+119DiauPpXlSYr8sTCNMW5uIfA
         gt+Xn1gb5p2fW1CWvTmzf1Feoe41RYCI7rFp/YzCjylxY3q40DXv3DbCzqOLoFNB0j8X
         9d66q8WzDOaRrsCwneRXamAFX9us1hs1afapF/LrgrSZ1lDctrGYAVwzweIKMKwvjwqr
         eWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X6pL/xiDS/rERWaTtkpN3WZ9KElC/+F38pnanmSrxfQ=;
        b=Nn2P60P5gysg2gbLlLQowIoalQK0hbaq+KfZhyyaf37aFyBO6LII2WjU9gnAgT0jvY
         +vFkI7Zdfg/UT4KHfAT3s6LMcWWiCeECkipB0RE8Ue7dJps4YOPCEuIi3MXLeOYpp1gc
         woWsKIr1WyWIXoVEf4txceRDNtzE34iBS/Y+BR+EHBHpGblY/nFlnWn4m34I6Yu2g4H+
         ndrPxOYI7EQxu+62V9NUM8epE+P2/rvHviW5NQW0FWwbrumAP8ssBYef6yhTD0wS1tBA
         C2WBiqbwmxl4aaUs6hEn7tBRplqo8lnDdnu1XAXBnvrn41S7nFgmq4nECcUs1bZ4QbAc
         BUBA==
X-Gm-Message-State: APjAAAXKrJFmifkJHpFVLR4QSizhr0IJhT1kGDaEls5HQXFe1d2fBENq
        TIA1lRzA8DwUYY6pSRmCj8k=
X-Google-Smtp-Source: APXvYqxX0Is+dPs5ACZzrvpZ7WEkYJWt7NYWebIuP8UZ8Lv2cbiBwlOWjIl1MYk32y891DL3YMooZQ==
X-Received: by 2002:ac8:5354:: with SMTP id d20mr1686212qto.229.1572313410756;
        Mon, 28 Oct 2019 18:43:30 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:483:ade:87ad:69fb:5b32:cf88])
        by smtp.gmail.com with ESMTPSA id 197sm6698394qkh.80.2019.10.28.18.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 18:43:30 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        kim.jamie.bradley@gmail.com, nishkadg.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH 2/5] staging: rts5208: Eliminate the use of Camel Case in file ms.h
Date:   Mon, 28 Oct 2019 22:43:13 -0300
Message-Id: <20191029014316.6452-3-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191029014316.6452-1-gabrielabittencourt00@gmail.com>
References: <20191029014316.6452-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Avoid CamelCase" in file ms.h

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/rts5208/ms.h | 70 ++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/rts5208/ms.h b/drivers/staging/rts5208/ms.h
index 952cc14dd079..dc7289ba9c4c 100644
--- a/drivers/staging/rts5208/ms.h
+++ b/drivers/staging/rts5208/ms.h
@@ -92,37 +92,37 @@
 #define PRO_FORMAT		0x10
 #define PRO_SLEEP		0x11
 
-#define	IntReg			0x01
-#define StatusReg0		0x02
-#define StatusReg1		0x03
-
-#define SystemParm		0x10
-#define BlockAdrs		0x11
-#define CMDParm			0x14
-#define PageAdrs		0x15
-
-#define OverwriteFlag		0x16
-#define ManagemenFlag		0x17
-#define LogicalAdrs		0x18
-#define ReserveArea		0x1A
-
-#define	Pro_IntReg		0x01
-#define Pro_StatusReg		0x02
-#define Pro_TypeReg		0x04
-#define	Pro_IFModeReg		0x05
-#define Pro_CatagoryReg		0x06
-#define Pro_ClassReg		0x07
-
-#define Pro_SystemParm		0x10
-#define Pro_DataCount1		0x11
-#define Pro_DataCount0		0x12
-#define Pro_DataAddr3		0x13
-#define Pro_DataAddr2		0x14
-#define Pro_DataAddr1		0x15
-#define Pro_DataAddr0		0x16
-
-#define Pro_TPCParm		0x17
-#define Pro_CMDParm		0x18
+#define int_REG			0x01
+#define status_reg0		0x02
+#define status_reg1		0x03
+
+#define system_parm		0x10
+#define block_adrs		0x11
+#define CMD_parm		0x14
+#define page_adrs		0x15
+
+#define overwrite_flag		0x16
+#define managemen_flag		0x17
+#define logical_adrs		0x18
+#define reserve_area		0x1A
+
+#define pro_int_REG		0x01
+#define pro_status_reg		0x02
+#define pro_type_reg		0x04
+#define pro_IF_mode_reg		0x05
+#define pro_category_reg	0x06
+#define pro_class_reg		0x07
+
+#define pro_system_parm		0x10
+#define pro_data_count1		0x11
+#define pro_data_count0		0x12
+#define pro_data_addr3		0x13
+#define pro_data_addr2		0x14
+#define pro_data_addr1		0x15
+#define pro_data_addr0		0x16
+
+#define pro_TPC_parm		0x17
+#define pro_CMD_parm		0x18
 
 #define	INT_REG_CED		0x80
 #define	INT_REG_ERR		0x40
@@ -152,12 +152,12 @@
 #define	PAGE_SIZE_0		(PPBUF_BASE2 + 0x1a0 + 8)
 #define	PAGE_SIZE_1		(PPBUF_BASE2 + 0x1a0 + 9)
 
-#define MS_Device_Type		(PPBUF_BASE2 + 0x1D8)
+#define MS_device_type		(PPBUF_BASE2 + 0x1D8)
 
-#define	MS_4bit_Support		(PPBUF_BASE2 + 0x1D3)
+#define MS_4bit_support		(PPBUF_BASE2 + 0x1D3)
 
-#define setPS_NG	1
-#define setPS_Error	0
+#define set_PS_NG	1
+#define set_PS_error	0
 
 #define	PARALLEL_8BIT_IF	0x40
 #define	PARALLEL_4BIT_IF	0x00
-- 
2.20.1

