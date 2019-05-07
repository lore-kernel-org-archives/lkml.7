Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD9BC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A2920C01
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MIaRFN3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfEGP7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 11:59:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44338 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEGP7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 11:59:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id d3so4381847plj.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:from:to:cc:subject:date:message-id;
        bh=Jk4l4aIhsSS1QaMGb/xfaCHwS6DqaTwgoIuoYji1K5w=;
        b=MIaRFN3fv3+GWWwZnBAErq1T33G8rzvbl422n5Qc2yFfjz++rNY//jxFv5G8+cbVGQ
         qyeY4WCPn7hxzv86c9HWZEWHxzzxQoHAFjjxfZE+1aEcjFLFH4mN/wDg4dw9MM3CQItK
         vZzfjNK5gcbQ8n+9E5LUpqiywcxxVNOOSihLlQd1KqJQt6Iaem9CcHh3nbMXqsIfxXkI
         t5IxN7pdYihTH8VdxjCB4Ckeyma451Dmjhvdq7V86U/X4I4ZXAIiYG0O5Vc3G0dJPFy7
         eTEgNQSBRY4U0BofW4a6Me1G3BmxKOEr5do0Qog9ddXygfCoU8OIYYuQqz+wCjKEBzw0
         QO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=mime-version:x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jk4l4aIhsSS1QaMGb/xfaCHwS6DqaTwgoIuoYji1K5w=;
        b=Qp9VoIC3ly0pc3YrB9dcFqCjugAv6a8IVvDu+LSC5LTGYKALvLDkfXoKzhwmwTJH2A
         wsTmLMLudfQCLpt68utdIvGEBI72nUUeuQ8J96zBaf18Wry6irJ5rRLXGiohjmMrPWxw
         4c4r0zcY+vBIuNGU9gR86BSZhXDdTfj99F9s2aeclxUdb7oAe8y18Mfnbw+wgZEdH7II
         Q0sa2ewtInu8IduZskAProqvtmyxZKEba5q6KHyki7Ddj+zI9ubtew9osFF4jnNdVbYW
         pPE33HUSdOFvZUnZH/FP/w0jgE8k0EzTIPKZ0Pbj31ALVcwQrjpmpml44Quse6IKmC7g
         Oyyw==
MIME-Version: 1.0
X-Gm-Message-State: APjAAAXdfVPui3ag59vSq2sVvs6N1OZpoHsSfa+EPvC7ED3ZtaXsTWbd
        e7WDijIexwuezg+f4AJh3y5pa8eCT5xXmFZM9YfVU26jc94PuTujexkjNSPFAvQDJ6pha6wcKAx
        rtx206jwHSHtHazy6/Q==
X-Google-Smtp-Source: APXvYqzjuXzlJfYmm6OQjWmSFkfZp7p5+/RBKtyuW9GmAw6VaX33RD5pvt2FRSYs/l0C4jzCq+840g==
X-Received: by 2002:a17:902:9a03:: with SMTP id v3mr42085296plp.27.1557244789768;
        Tue, 07 May 2019 08:59:49 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id h187sm22543540pfc.52.2019.05.07.08.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 May 2019 08:59:49 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, richard@nod.at, palmer@sifive.com,
        aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v3 v3 1/3] mtd: spi-nor: add support for is25wp256
Date:   Tue,  7 May 2019 21:29:33 +0530
Message-Id: <1557244775-14206-1-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update spi_nor_id table for is25wp256 (32MB)device from ISSI,
present on HiFive Unleashed dev board (Rev: A00).

Set method to enable quad mode for ISSI device in flash parameters
table.

Based on code originally written by Wesley Terpstra <wesley@sifive.com>
and/or Palmer Dabbelt <palmer@sifive.com>
https://github.com/riscv/riscv-linux/commit/c94e267766d62bc9a669611c3d0c8ed5ea26569b

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 10 +++++++++-
 include/linux/mtd/spi-nor.h   |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index fae1474..c5408ed 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1834,6 +1834,10 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp128",  INFO(0x9d7018, 0, 64 * 1024, 256,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 1024,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			SPI_NOR_4B_OPCODES)
+	},
 
 	/* Macronix */
 	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
@@ -3650,6 +3654,10 @@ static int spi_nor_init_params(struct spi_nor *nor,
 		case SNOR_MFR_MACRONIX:
 			params->quad_enable = macronix_quad_enable;
 			break;
+		case SNOR_MFR_ISSI:
+			params->quad_enable = macronix_quad_enable;
+			break;
+
 
 		case SNOR_MFR_ST:
 		case SNOR_MFR_MICRON:
@@ -4127,7 +4135,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (ret)
 		return ret;
 
-	if (nor->addr_width) {
+	if (nor->addr_width && JEDEC_MFR(info) != SNOR_MFR_ISSI) {
 		/* already configured from SFDP */
 	} else if (info->addr_width) {
 		nor->addr_width = info->addr_width;
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index b3d360b..ff13297 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -19,6 +19,7 @@
 #define SNOR_MFR_ATMEL		CFI_MFR_ATMEL
 #define SNOR_MFR_GIGADEVICE	0xc8
 #define SNOR_MFR_INTEL		CFI_MFR_INTEL
+#define SNOR_MFR_ISSI		0x9d		/* ISSI */
 #define SNOR_MFR_ST		CFI_MFR_ST	/* ST Micro */
 #define SNOR_MFR_MICRON		CFI_MFR_MICRON	/* Micron */
 #define SNOR_MFR_MACRONIX	CFI_MFR_MACRONIX
-- 
1.9.1


-- 
The information transmitted is intended only for the person or entity to 
which it is addressed and may contain confidential and/or privileged 
material. If you are not the intended recipient of this message please do 
not read, copy, use or disclose this communication and notify the sender 
immediately. It should be noted that any review, retransmission, 
dissemination or other use of, or taking action or reliance upon, this 
information by persons or entities other than the intended recipient is 
prohibited.
