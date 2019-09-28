Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80FDC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 00:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7518C2075D
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 00:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="GlwGJc11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfI1A2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 20:28:11 -0400
Received: from mx3.ucr.edu ([138.23.248.64]:47507 "EHLO mx3.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfI1A2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 20:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1569630490; x=1601166490;
  h=from:to:cc:subject:date:message-id;
  bh=TAaIQrNrlHpHXTlhnOmvtGHU4z3it1xGbWOJk5Kgq0s=;
  b=GlwGJc11+8mUmm/EHSgM33tEXKIAaz0BYaH6q1mcjyP7uo9GWZ1b+IAU
   OsDZ98851KzzNAlwpvPGRZevzWhJ90T4xgN9gn8kHZzRlXBYkTphey1dU
   x0yqhpr8g7Gf8v9YiN7cWEkVw/mK5Jk8M8HKWfugz2qI7RnO/9e4huT7i
   451yb3bEWpupJsZPDydihyQTPgfaw+JM+89rLMHqbhmGsvQPD3JKRCJTu
   4wGPddDHVgFFm9uGXLN9COBBQweqUIy/TCuRYLrVBICJIdsO15wBa97/R
   NJCxnEIw3DM2APORJxyPiebHnnKnMVzmnaO5pTb68KoVHz12UgbYLMqkf
   Q==;
IronPort-SDR: aIylKq8+GXLkQ5nDQ36HEjnm4UKdNrxwwBv2cwa4NPeKh6zTJh/jcwfe0dQSwUJ7npg9bMLRQf
 NuhH1N3eDmfagmJwwAT/tyR2xVa7GnFVspmiVbX93dnsEuY0en7ubPpxVpAv4hN0VEyE6lNVad
 MdlbO39qYFDVJ44d6dT1ieL8wY3WK3gLaTMsvglK46CA4F+WRFY6AtiBzUuaedk0w8EKQCnfde
 +LmPm3lGPgH02APJvAJJdmRG7boQvX9ALrqAVtjuwGiZdnorapU9WaJ9C80xp01QM60gYu37td
 3hA=
IronPort-PHdr: =?us-ascii?q?9a23=3Am8qV7xxaep0HkbvXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd1OMXIJqq85mqBkHD//Il1AaPAdyArakbwLGP+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhGiTanb75/Lhq6oAvMusILnYZsN6E9xw?=
 =?us-ascii?q?fTrHBVYepW32RoJVySnxb4+Mi9+YNo/jpTtfw86cNOSL32cKskQ7NWCjQmKH?=
 =?us-ascii?q?0169bwtRbfVwuP52ATXXsQnxFVHgXK9hD6XpP2sivnqupw3TSRMMPqQbwoXz?=
 =?us-ascii?q?mp8rxmQwH0higZKzE58XnXis1ug6JdvBKhvAF0z4rNbI2IKPZyYqbRcNUfRW?=
 =?us-ascii?q?pARcZRTC1BAoWzb4ASEeQPJPtTr4f8p1QQqRuxGBSnCOfhxzNUg3P727Ax3e?=
 =?us-ascii?q?Y8HgHcxAEuH8wAvmnaotv2M6kfSvy5wLXSwDnfdf5axSvx5Y7VeR4hu/GMWr?=
 =?us-ascii?q?dwfNLTxkkuFgLFjkiQqYv4ND6S1uUMsmib4PBhVe6zl2IqpRp8oiWzycc2kI?=
 =?us-ascii?q?XGmJ8ayk3d+Ch/3Y07JsW4RVZlbdK4FJZcrSKXOotsTs88Xm1kpDw2xqMatZ?=
 =?us-ascii?q?KnZCQG1ZUqyhrFZ/CZfYWF4gjvWPiQLDtihn9od7SyjAuo/0e60O3zTMy03U?=
 =?us-ascii?q?5PripCj9bDqGgA1wfW6sibUvt9+Vqh2SqX2wDT9O5EJUc0mLLeK5E7w74wko?=
 =?us-ascii?q?MfsVzNHiPrgUn2grGaelk49uSy5OTnZbLmppCYN4BqkA3xLqMumsmnDeQ5NA?=
 =?us-ascii?q?gBQXSb9Pyi2LH/+UD1WrZHg/0snqXHrZzWOd4XqrClDwNJyooj7gywDzai0N?=
 =?us-ascii?q?QWh3kHK1dFdQqHjonoO1HBOvH4Aeujj1miizpr2uzJPqf7DprTM3fDja/tfa?=
 =?us-ascii?q?xh5E5E1Aoz0ddf6opQCrEAJvLzR0DwuMXbDhAnKQy0xfjoCNFm24MAVmKAHL?=
 =?us-ascii?q?WZPLnRsVCW/OIvJfeDZIsPtDb6Mfgl6K2mo2U+nAosfLupwJxfPGGqHv1nex?=
 =?us-ascii?q?3CSWfnmJEMHXpc7Vl2d/DjlFDXCW0bXH21Ra9po25jBQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HQBwAiqI5df8jSVdFmhXxMEI0ehXJ?=
 =?us-ascii?q?QAQEBBosmGHGFeoosAQgBAQEMAQEtAgEBhECDOiM4EwIDCQEBBQEBAQEBBQQ?=
 =?us-ascii?q?BAQIQAQEJCwsIJ4VCgjopgzULFhVSgRUBBQE1IjmCRwGBdhShLoEDPIwlM4h?=
 =?us-ascii?q?xAQkNgUgJAQiBIoc1hFmBEIEHg25zh2OCRASBLwEBAY1whyuWSQEGAoIQFIF?=
 =?us-ascii?q?4kwcnhDmJO4s/AS2KKJxqAgoHBg8jgUaBek0lgWwKgURQEBSBWhcVji0hM4E?=
 =?us-ascii?q?Ijj0B?=
X-IPAS-Result: =?us-ascii?q?A2HQBwAiqI5df8jSVdFmhXxMEI0ehXJQAQEBBosmGHGFe?=
 =?us-ascii?q?oosAQgBAQEMAQEtAgEBhECDOiM4EwIDCQEBBQEBAQEBBQQBAQIQAQEJCwsIJ?=
 =?us-ascii?q?4VCgjopgzULFhVSgRUBBQE1IjmCRwGBdhShLoEDPIwlM4hxAQkNgUgJAQiBI?=
 =?us-ascii?q?oc1hFmBEIEHg25zh2OCRASBLwEBAY1whyuWSQEGAoIQFIF4kwcnhDmJO4s/A?=
 =?us-ascii?q?S2KKJxqAgoHBg8jgUaBek0lgWwKgURQEBSBWhcVji0hM4EIjj0B?=
X-IronPort-AV: E=Sophos;i="5.64,557,1559545200"; 
   d="scan'208";a="83503902"
Received: from mail-pf1-f200.google.com ([209.85.210.200])
  by smtp3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Sep 2019 17:28:10 -0700
Received: by mail-pf1-f200.google.com with SMTP id r7so3061082pfg.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 17:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5TzNbCB6im2bWtNvAjp9ds0IpKiNbjs0dzM5n1GDW5Y=;
        b=GmNeC9rhu25ErtZYx+dv0XYQX8WMJR3eT7wc4lfQvRRf+dpu/ylytZANOpqge4NPTz
         QvQK33iSy9VexTaCQmAnCag+qpdod/0E58pcc6ZVg8ieVoWlm9baYIvwCubhXw5AAGF9
         OY54CViZ2AK3LXDjEmai5xWd59FQVgrvLHk2Lof/t4PBXDOuZXNdQlA9NhFL5l7z/fJ3
         dTtPe3qX+XjjElYWi71I1a94+wcKEXFqpF3kXkbqw6E9tr9a+se+qocYrlTl+h1IOTA/
         kZ9FkR4MbvCcjlfc3KfDR36zkVNifbP26Cvrorn8nojzJZAasF8StyZxTldEAdmG7Gtm
         2zXw==
X-Gm-Message-State: APjAAAWDp0lL7XgMwDy3Mid9+ZIKb+4MDy67/TlOvjsjkGucWy+skNBZ
        g4jZDyD7+V8J6sINlhnlaLxy+LpY1ZXpjN+3eb7A8/RllrU8IaOGyodQ4jvroh615HnXIMXDcac
        7GtBLth1fcoL/gat9rlSkdLFIPg==
X-Received: by 2002:aa7:9794:: with SMTP id o20mr7869534pfp.8.1569630489410;
        Fri, 27 Sep 2019 17:28:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwZO38LKJW4wkfyAvREDNgDGgsGnvGUuysM1wKez8wkjAb6Ao/r93FnGs/LBCi1PNvs9qnNnw==
X-Received: by 2002:aa7:9794:: with SMTP id o20mr7869510pfp.8.1569630489164;
        Fri, 27 Sep 2019 17:28:09 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id z25sm3612636pfn.7.2019.09.27.17.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 17:28:08 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: imx25-gcq: Variable could be uninitialized if regmap_read() fails
Date:   Fri, 27 Sep 2019 17:28:51 -0700
Message-Id: <20190928002852.28329-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function mx25_gcq_irq(), local variable "stats" could
be uninitialized if function regmap_read() returns -EINVAL.
However, this value is used in if statement, which is
potentially unsafe. The same case applied to the variable
"data" in function mx25_gcq_get_raw_value() in the same file.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 drivers/iio/adc/fsl-imx25-gcq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index df19ecae52f7..dbf3e8e85aba 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -74,7 +74,10 @@ static irqreturn_t mx25_gcq_irq(int irq, void *data)
 	struct mx25_gcq_priv *priv = data;
 	u32 stats;
 
-	regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
+	int ret = regmap_read(priv->regs, MX25_ADCQ_SR, &stats);
+
+	if (ret)
+		return ret;
 
 	if (stats & MX25_ADCQ_SR_EOQ) {
 		regmap_update_bits(priv->regs, MX25_ADCQ_MR,
@@ -121,7 +124,10 @@ static int mx25_gcq_get_raw_value(struct device *dev,
 		return -ETIMEDOUT;
 	}
 
-	regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);
+	int ret = regmap_read(priv->regs, MX25_ADCQ_FIFO, &data);
+
+	if (ret)
+		return ret;
 
 	*val = MX25_ADCQ_FIFO_DATA(data);
 
-- 
2.17.1

