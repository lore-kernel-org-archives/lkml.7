Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE079C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839A9215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574887255;
	bh=ZbZQWLNVEAwI0OA//as0xFt12U2YZ+kzigbVogJ9SX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UfERAC9/WZ+7YMzFMQaO5LO2wgViNIbVCsYxtBPGLHogG7eLMF9Yd9uK0VmdjQdUn
	 Kt5l82XHTXba82GhMSt1p0tQ3iy0rvGat3cQ4c54kkbm3defkKmjqedHwMn+i4F/WO
	 w75OGeX1gPZ7zvwksRGZ3WcvMIfPCt9u342nARe8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfK0Uky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:40:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:45652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbfK0Ukv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:40:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69262215A4;
        Wed, 27 Nov 2019 20:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887250;
        bh=ZbZQWLNVEAwI0OA//as0xFt12U2YZ+kzigbVogJ9SX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CpfUfNyULnRjqNEuJgmM154S8PNRxLSY6zjkMndVdVB43Y/wYHbUIngdRLkmKT0r6
         1/wcddjlldgBFbuPZ8mmgu0wOr8OAgs6DWqGXcqi0XWQJcJDzWSddUHBc2eLtsVRTl
         YDx3ZI4IsJTEYm4nNJq9fNnlZJNtilLalcKdHq8A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Netanel Belgazal <netanel@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 038/151] net: ena: Fix Kconfig dependency on X86
Date:   Wed, 27 Nov 2019 21:30:21 +0100
Message-Id: <20191127203023.647192005@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203000.773542911@linuxfoundation.org>
References: <20191127203000.773542911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Netanel Belgazal <netanel@amazon.com>

[ Upstream commit 8c590f9776386b8f697fd0b7ed6142ae6e3de79e ]

The Kconfig limitation of X86 is to too wide.
The ENA driver only requires a little endian dependency.

Change the dependency to be on little endian CPU.

Signed-off-by: Netanel Belgazal <netanel@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/Kconfig b/drivers/net/ethernet/amazon/Kconfig
index 99b30353541ab..9e87d7b8360f5 100644
--- a/drivers/net/ethernet/amazon/Kconfig
+++ b/drivers/net/ethernet/amazon/Kconfig
@@ -17,7 +17,7 @@ if NET_VENDOR_AMAZON
 
 config ENA_ETHERNET
 	tristate "Elastic Network Adapter (ENA) support"
-	depends on (PCI_MSI && X86)
+	depends on PCI_MSI && !CPU_BIG_ENDIAN
 	---help---
 	  This driver supports Elastic Network Adapter (ENA)"
 
-- 
2.20.1



