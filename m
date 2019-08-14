Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABEEC32750
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A38B20989
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 02:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565750407;
	bh=y8odlk2dpswyj2RIwILXZLj5oh36R3W5sI1MEz6rc+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cu+O832a2QPBSoTBODA+9LqGIGmRGTi43Tk46yaiRwtCDvlfkCUZVrc2SKQEvC+Hg
	 aZ2O/YmrINjCIQFxZRgXCrI/TW1fymCkk2DyGDZL+xoxBG+5V7qPr054fKubAnJOxI
	 NfrQInS6mRqnilbIliTNlmSMCISMkU+0vYzAG6qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfHNCLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 22:11:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727144AbfHNCLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 22:11:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24A452084D;
        Wed, 14 Aug 2019 02:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565748662;
        bh=y8odlk2dpswyj2RIwILXZLj5oh36R3W5sI1MEz6rc+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vDlZax5FAKAIp1grank7QixEEHTubsvG6FXPVmBg9rFBr/vVE+G06hUJY30ckMc9r
         cd4X/6bUCCVd+8Q5TeGPeMq0i5V8vghT3qZsyFdEBL2+8WJI2II2jkrfCUzIAmjhyV
         kz4v7cuq31GCWaxExqNw0K8BSTSPxQZB3lko6iRs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joe Perches <joe@perches.com>, Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 007/123] iio: adc: max9611: Fix misuse of GENMASK macro
Date:   Tue, 13 Aug 2019 22:08:51 -0400
Message-Id: <20190814021047.14828-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814021047.14828-1-sashal@kernel.org>
References: <20190814021047.14828-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>

[ Upstream commit ae8cc91a7d85e018c0c267f580820b2bb558cd48 ]

Arguments are supposed to be ordered high then low.

Signed-off-by: Joe Perches <joe@perches.com>
Fixes: 69780a3bbc0b ("iio: adc: Add Maxim max9611 ADC driver")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/max9611.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index 917223d5ff5bb..0e3c6529fc4c9 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -83,7 +83,7 @@
 #define MAX9611_TEMP_MAX_POS		0x7f80
 #define MAX9611_TEMP_MAX_NEG		0xff80
 #define MAX9611_TEMP_MIN_NEG		0xd980
-#define MAX9611_TEMP_MASK		GENMASK(7, 15)
+#define MAX9611_TEMP_MASK		GENMASK(15, 7)
 #define MAX9611_TEMP_SHIFT		0x07
 #define MAX9611_TEMP_RAW(_r)		((_r) >> MAX9611_TEMP_SHIFT)
 #define MAX9611_TEMP_SCALE_NUM		1000000
-- 
2.20.1

