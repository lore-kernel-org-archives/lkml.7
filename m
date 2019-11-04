Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDD1CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46126222C6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572904384;
	bh=gzJIr3oEpeI6UESWP5YHp1gXpssUBoR3tv0ZGUfuQ44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tXlBd+VkEAPue7AF5q4S6tLFfnjfkeMWxhUZCUBPZyM4sEFSPi2SqJGOk34XkzJcU
	 bJq2CYWnkFE69o1FnJ+RVwbMzjI+kaZX2dBKkZU4Rd5v8RffV4Ah66eH8eulEu8isV
	 k4AznK4cgXY2ytqYMtgd7mrZeuhPt5MwvvGhUNt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbfKDVxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:53:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730857AbfKDVw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:52:56 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34441218BA;
        Mon,  4 Nov 2019 21:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572904375;
        bh=gzJIr3oEpeI6UESWP5YHp1gXpssUBoR3tv0ZGUfuQ44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o2kZUnfuvw+7LlNprxWbWotEnGgqHi8aFAEWMW3BOPyqUEH+xEBoP1UlODXgokV31
         UZNxp38t9+u+DkQhfX+zpkmdiTy9tejKFcNRoSJXceh7bcy8kIJvvVNUFXClejE8TH
         Vzst89gWR7JJKL9zck3GWjD7jA06YDfd3XD67FnI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pascal Bouwmann <bouwmann@tau-tec.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 25/95] iio: fix center temperature of bmc150-accel-core
Date:   Mon,  4 Nov 2019 22:44:23 +0100
Message-Id: <20191104212054.393098137@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212038.056365853@linuxfoundation.org>
References: <20191104212038.056365853@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 807299dd45ebf..7e86a5b7ec4e8 100644
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



