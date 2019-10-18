Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FDACA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A499520872
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437196;
	bh=A1CC+d9DZVVwc+jQwceLaceB74uPRg43Vtk7GxRaMSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qDRyyzmj0jnuHL9Ghey221fMCnusLaXmtZ4DAq1l0nTQSgjAKAaZ0Pv+X2xWQ02Oy
	 JMM1roSu6F8towg0DT0f6u6gh8eHqbTxSza0D6sgXDLKY/ZHZrxsvMBXSl8/EYsp+E
	 xoA2YjU+jsjTjbkMzZdptR1GtEal5Da88HtUcozw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732119AbfJRWGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:06:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731464AbfJRWGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:06:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D4DF20679;
        Fri, 18 Oct 2019 22:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436402;
        bh=A1CC+d9DZVVwc+jQwceLaceB74uPRg43Vtk7GxRaMSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hZ/+J5ZO6BMVIrW2l0gqDRlx0rOPAKpmj6lULZYQ2Czsw3JfZ8kScit8gVAvu/YsK
         sQZW6eODt4Sy2IIBL0xaf3zkeXqLaZ9RA2lCr80S2H0BuzdieTcvHxLSjEzkxpAaCK
         ClHhGfjJP7UK4NlTv7w5ytndor+C+QcrWTsVnGjM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pascal Bouwmann <bouwmann@tau-tec.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 051/100] iio: fix center temperature of bmc150-accel-core
Date:   Fri, 18 Oct 2019 18:04:36 -0400
Message-Id: <20191018220525.9042-51-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220525.9042-1-sashal@kernel.org>
References: <20191018220525.9042-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pascal Bouwmann <bouwmann@tau-tec.de>

[ Upstream commit 6c59a962e081df6d8fe43325bbfabec57e0d4751 ]

The center temperature of the supported devices stored in the constant
BMC150_ACCEL_TEMP_CENTER_VAL is not 24 degrees but 23 degrees.

It seems that some datasheets were inconsistent on this value leading
to the error.  For most usecases will only make minor difference so
not queued for stable.

Signed-off-by: Pascal Bouwmann <bouwmann@tau-tec.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/accel/bmc150-accel-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 383c802eb5b86..cb8c98a440109 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -125,7 +125,7 @@
 #define BMC150_ACCEL_SLEEP_1_SEC		0x0F
 
 #define BMC150_ACCEL_REG_TEMP			0x08
-#define BMC150_ACCEL_TEMP_CENTER_VAL		24
+#define BMC150_ACCEL_TEMP_CENTER_VAL		23
 
 #define BMC150_ACCEL_AXIS_TO_REG(axis)	(BMC150_ACCEL_REG_XOUT_L + (axis * 2))
 #define BMC150_AUTO_SUSPEND_DELAY_MS		2000
-- 
2.20.1

