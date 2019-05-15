Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFED7C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93784216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 10:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557917991;
	bh=MkJAxibFcQEvGbfg4UeaKGxJxd+hEz/ZojEKY43Dfq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WC9AN2E8vkcx58Tb6FMgpy3cWauOVNSk4tyyQ/U86GQill3f6UMytis9LEKUtOuSi
	 m5P+nJv0qMQbKB0ESSH2TCqImMk+yoa7WLJYMKJHjpN2wrw5/01ZAZ7MI8VQszIZhc
	 3nlPqAexmFXjigydlrzu6sf83ADLlV/KQi4b5jks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfEOK7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 06:59:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbfEOK7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 06:59:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82EDE2084F;
        Wed, 15 May 2019 10:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557917986;
        bh=MkJAxibFcQEvGbfg4UeaKGxJxd+hEz/ZojEKY43Dfq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ARJNEqpCY09w9VAZYQz8uWhI7yQ6OnpkBAGhHdPj44/PzoBu3mKJT53SkDijzHsYQ
         9gpe01AG4AxSzI2Fz6JnrVgi5V1unmM3Lxj/C20kDL6eiel17S1wsPUrFvKbzCD7Gz
         phYVq7JnKePwq4U0SL7oG9XDufZm/b1BIDbBhEmA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeremy Fertic <jeremyfertic@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3.18 49/86] staging: iio: adt7316: fix the dac read calculation
Date:   Wed, 15 May 2019 12:55:26 +0200
Message-Id: <20190515090652.214503157@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090642.339346723@linuxfoundation.org>
References: <20190515090642.339346723@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy Fertic <jeremyfertic@gmail.com>

commit 45130fb030aec26ac28b4bb23344901df3ec3b7f upstream.

The calculation of the current dac value is using the wrong bits of the
dac lsb register. Create two macros to shift the lsb register value into
lsb position, depending on whether the dac is 10 or 12 bit. Initialize
data to 0 so, with an 8 bit dac, the msb register value can be bitwise
ORed with data.

Fixes: 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9 driver")
Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/iio/addac/adt7316.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -47,6 +47,8 @@
 #define ADT7516_MSB_AIN3		0xA
 #define ADT7516_MSB_AIN4		0xB
 #define ADT7316_DA_DATA_BASE		0x10
+#define ADT7316_DA_10_BIT_LSB_SHIFT	6
+#define ADT7316_DA_12_BIT_LSB_SHIFT	4
 #define ADT7316_DA_MSB_DATA_REGS	4
 #define ADT7316_LSB_DAC_A		0x10
 #define ADT7316_MSB_DAC_A		0x11
@@ -1414,7 +1416,7 @@ static IIO_DEVICE_ATTR(ex_analog_temp_of
 static ssize_t adt7316_show_DAC(struct adt7316_chip_info *chip,
 		int channel, char *buf)
 {
-	u16 data;
+	u16 data = 0;
 	u8 msb, lsb, offset;
 	int ret;
 
@@ -1439,7 +1441,11 @@ static ssize_t adt7316_show_DAC(struct a
 	if (ret)
 		return -EIO;
 
-	data = (msb << offset) + (lsb & ((1 << offset) - 1));
+	if (chip->dac_bits == 12)
+		data = lsb >> ADT7316_DA_12_BIT_LSB_SHIFT;
+	else if (chip->dac_bits == 10)
+		data = lsb >> ADT7316_DA_10_BIT_LSB_SHIFT;
+	data |= msb << offset;
 
 	return sprintf(buf, "%d\n", data);
 }


