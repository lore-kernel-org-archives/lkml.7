Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCD6FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BC1222C9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239664;
	bh=X39QoiUNcdlxe6a7mbnH/4RYg5FRPgmaxjD8Yo95tP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OPxNsUfQ4QM5FqDYwwPixyom3FuxEtJBOsJZHND6iYvA1Ka7UXIy3Xe23pkTSgiik
	 lmILiy4iC9s6FFcusFzr2oxzVL5cM9UHtkqHEhBvGqQpsQ+NZLZsf4PlWj8fR+e0f7
	 rGXJ5SayU4Dx8S9utuRV4vHzdmUu2ep5vkYS1atw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390073AbfKHTBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:01:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390054AbfKHTA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:00:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81B2C21D7E;
        Fri,  8 Nov 2019 19:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239659;
        bh=X39QoiUNcdlxe6a7mbnH/4RYg5FRPgmaxjD8Yo95tP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bz4+ka+hu+AptjpfqUgHN8njE4bgl68hF/ahXVcXVXkakw3tfNa9yyEjVaK22GxTA
         0xo3j8fTOg9YprsGVA7gjv6myQGera1tL9gWSzIVWr+jczJ5QcUDS+7P3ox4wKBumm
         BPdfiolH9YfwVITlQA0bH9Dem+bGdpkFgYxD3m18=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 18/79] scsi: fix kconfig dependency warning related to 53C700_LE_ON_BE
Date:   Fri,  8 Nov 2019 19:49:58 +0100
Message-Id: <20191108174754.513760749@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174745.495640141@linuxfoundation.org>
References: <20191108174745.495640141@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Bogendoerfer <tbogendoerfer@suse.de>

[ Upstream commit 8cbf0c173aa096dda526d1ccd66fc751c31da346 ]

When building a kernel with SCSI_SNI_53C710 enabled, Kconfig warns:

WARNING: unmet direct dependencies detected for 53C700_LE_ON_BE
  Depends on [n]: SCSI_LOWLEVEL [=y] && SCSI [=y] && SCSI_LASI700 [=n]
  Selected by [y]:
  - SCSI_SNI_53C710 [=y] && SCSI_LOWLEVEL [=y] && SNI_RM [=y] && SCSI [=y]

Add the missing depends SCSI_SNI_53C710 to 53C700_LE_ON_BE to fix it.

Link: https://lore.kernel.org/r/20191009151128.32411-1-tbogendoerfer@suse.de
Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 7c097006c54db..a8ac480276323 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -862,7 +862,7 @@ config SCSI_SNI_53C710
 
 config 53C700_LE_ON_BE
 	bool
-	depends on SCSI_LASI700
+	depends on SCSI_LASI700 || SCSI_SNI_53C710
 	default y
 
 config SCSI_STEX
-- 
2.20.1



