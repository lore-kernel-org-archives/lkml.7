Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D80BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06251217D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568932304;
	bh=fyQekP0mArh+zpjTNqJQ4onGKRm1HDxeaza/MX5kIQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2GOHyy/tJJdJtau11jf+wnDTRR34XqTeSuLwugCtq7ZoEAiTC/hI4V68KK7fq6Ov8
	 Do1Htr+Z/BniQItgZpoFsoQEh+uRzYJdO77LX4sbepcXaYQ8JPxi6MP1mgMZxjRjOV
	 erMpcka01uiB4b/Z4grvdUKYReY2VLBFuobnt78Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392270AbfISWOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392238AbfISWOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:14:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A298721924;
        Thu, 19 Sep 2019 22:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931260;
        bh=fyQekP0mArh+zpjTNqJQ4onGKRm1HDxeaza/MX5kIQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bknqK1fig21sK9/Z1GhjKLONQz1wZ/NfwIogqDJ50tplLq3gZIfOzomprQ6ftaHTg
         FgiycOpikj9OMB1UDgYoDCErXbgpl/8LxhP+fgilk63x1tvv9WPolQnlUlS6j8+3sO
         aYXpcTGbunzAFvQEw7Shts/mBLcvnH4sgdw4ombI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 61/79] amd-xgbe: Fix error path in xgbe_mod_init()
Date:   Fri, 20 Sep 2019 00:03:46 +0200
Message-Id: <20190919214812.996287097@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214807.612593061@linuxfoundation.org>
References: <20190919214807.612593061@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit b6b4dc4c1fa7f1c99398e7dc85758049645e9588 ]

In xgbe_mod_init(), we should do cleanup if some error occurs

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: efbaa828330a ("amd-xgbe: Add support to handle device renaming")
Fixes: 47f164deab22 ("amd-xgbe: Add PCI device support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/xgbe/xgbe-main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-main.c b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
index b41f23679a087..7ce9c69e9c44f 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-main.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
@@ -469,13 +469,19 @@ static int __init xgbe_mod_init(void)
 
 	ret = xgbe_platform_init();
 	if (ret)
-		return ret;
+		goto err_platform_init;
 
 	ret = xgbe_pci_init();
 	if (ret)
-		return ret;
+		goto err_pci_init;
 
 	return 0;
+
+err_pci_init:
+	xgbe_platform_exit();
+err_platform_init:
+	unregister_netdevice_notifier(&xgbe_netdev_notifier);
+	return ret;
 }
 
 static void __exit xgbe_mod_exit(void)
-- 
2.20.1



