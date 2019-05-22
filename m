Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497D1C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14526217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558553340;
	bh=wH9Spo+cobOVPeklXqWymbyM/pL58QP1QBrIVX3yXh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kh0fso1GJR5UpgeO/45a01Xykz3zJbw3a/w62A7b8qIChTkFgKhChqPi+yMC3IVIW
	 FMfpfR+s7QomwMpjzdz1QMjMMc7JhHFSNn0lEubCnBufCTdRCbM72PMkE1TM+S/pSU
	 jeTnbSoSCZ1erUzqlAxTFIEPiSsySNioLq7gG7Ss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbfEVT27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:28:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732355AbfEVT24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:28:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7127B20675;
        Wed, 22 May 2019 19:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553336;
        bh=wH9Spo+cobOVPeklXqWymbyM/pL58QP1QBrIVX3yXh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yLchkmEeVIQS+pbCTx/7HjkXyfzLZHB9iM++bJa2yvsIJwaopcmM3mKLBgd4S/kgm
         +EMjD92Np4h6D929Cd7/4saijAr2x1WmkdveUJLJn7JQmXxZlgaBMaDuT04INaraqV
         yz/bCJBSFlA4PiD+uqOlB7AtPxBxF5PitDCvfdbU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sameeh Jubran <sameehj@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 009/167] net: ena: gcc 8: fix compilation warning
Date:   Wed, 22 May 2019 15:26:04 -0400
Message-Id: <20190522192842.25858-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192842.25858-1-sashal@kernel.org>
References: <20190522192842.25858-1-sashal@kernel.org>
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
index 3c7813f04962b..db6f6a877f630 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2229,7 +2229,7 @@ static void ena_config_host_info(struct ena_com_dev *ena_dev)
 
 	host_info->os_type = ENA_ADMIN_OS_LINUX;
 	host_info->kernel_ver = LINUX_VERSION_CODE;
-	strncpy(host_info->kernel_ver_str, utsname()->version,
+	strlcpy(host_info->kernel_ver_str, utsname()->version,
 		sizeof(host_info->kernel_ver_str) - 1);
 	host_info->os_dist = 0;
 	strncpy(host_info->os_dist_str, utsname()->release,
-- 
2.20.1

