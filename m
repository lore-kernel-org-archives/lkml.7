Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083DDC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D642081C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558554576;
	bh=R6v1aA3Ic/WVnvJ6wLhYL66yF3yvqaKXoKHmMFCyvnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n7oB1+E45p5Lv0EfRkHsG/kWZgV7696e4m2n5s6ioq9VzdsEplMpq2pKA7XuPWkvY
	 b/PaF8FfsLz3SkN8yMi2Dw+7xQ3ydHGj4XpCrA5yOWmh4T/1qJDVEixxsQPI7Y/uHd
	 fMzADh+9d2FpLLLYc+PI6oNcnmReb0t+VnT/c8DE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732178AbfEVT0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:26:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730243AbfEVT0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:26:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEEC8217D7;
        Wed, 22 May 2019 19:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553208;
        bh=R6v1aA3Ic/WVnvJ6wLhYL66yF3yvqaKXoKHmMFCyvnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BEo/E9lHwlr4VlqnB/ap5VU9+VtIz6ZEwH9g71EMnfmpHlR07VcqFYIvvOsvcIZET
         g0bJuyz3W7e2TYrX1DAgtVDrdxLAdXeDvekOowGCGUGOiyGq8FBhjYv90toowEGZRe
         04oqqGG3zyB/8mKUI/AFCjv3Jul0u2Zfi8TFXVec=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sameeh Jubran <sameehj@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 012/244] net: ena: gcc 8: fix compilation warning
Date:   Wed, 22 May 2019 15:22:38 -0400
Message-Id: <20190522192630.24917-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192630.24917-1-sashal@kernel.org>
References: <20190522192630.24917-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sameeh Jubran <sameehj@amazon.com>

[ Upstream commit f913308879bc6ae437ce64d878c7b05643ddea44 ]

GCC 8 contains a number of new warnings as well as enhancements to existing
checkers. The warning - Wstringop-truncation - warns for calls to bounded
string manipulation functions such as strncat, strncpy, and stpncpy that
may either truncate the copied string or leave the destination unchanged.

In our case the destination string length (32 bytes) is much shorter than
the source string (64 bytes) which causes this warning to show up. In
general the destination has to be at least a byte larger than the length
of the source string with strncpy for this warning not to showup.

This can be easily fixed by using strlcpy instead which already does the
truncation to the string. Documentation for this function can be
found here:

https://elixir.bootlin.com/linux/latest/source/lib/string.c#L141

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Sameeh Jubran <sameehj@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 1b5f591cf0a23..b5d72815776cb 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2223,7 +2223,7 @@ static void ena_config_host_info(struct ena_com_dev *ena_dev)
 
 	host_info->os_type = ENA_ADMIN_OS_LINUX;
 	host_info->kernel_ver = LINUX_VERSION_CODE;
-	strncpy(host_info->kernel_ver_str, utsname()->version,
+	strlcpy(host_info->kernel_ver_str, utsname()->version,
 		sizeof(host_info->kernel_ver_str) - 1);
 	host_info->os_dist = 0;
 	strncpy(host_info->os_dist_str, utsname()->release,
-- 
2.20.1

