Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA04C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0804216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802604;
	bh=HbEKa7Zri52UCkOvnsCGr3IcPyOq0d/HtyKJPhXp/Z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xtZMZKuYdJdkhOQO8tRaoY/OYUbyZwCF87U9JHhwE8lMJ2/PExYmrvkl3NWowa7RY
	 QxX8UZr8N8b3ATi3//q7cIeztLxJkJbZ5T/mYcDAO741XshNU2rvduZ9hT4rS5g79+
	 HBVEkcyHR8VXzjIOESdCJC2JFQmjKtLqrH7bEzgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbfHNRKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730412AbfHNRJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:09:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79E5B2084D;
        Wed, 14 Aug 2019 17:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802598;
        bh=HbEKa7Zri52UCkOvnsCGr3IcPyOq0d/HtyKJPhXp/Z4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jzipTGXvRM4r/RfLmxC19cbwnv10bWJzb/4TiD/wWnkP0rDAB8eSA/KsmAMGP7iMY
         Yy7Hut40Atsff8+0QxrAfELU3v417EVVb21dAshEHKQCha4xe+JIsuR+Dw0mtJopm2
         /ywBxg3CtoB3J0LucHI61AO0iJEMP6c08lqSGDeQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Tai <thomas.tai@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 44/91] iscsi_ibft: make ISCSI_IBFT dependson ACPI instead of ISCSI_IBFT_FIND
Date:   Wed, 14 Aug 2019 19:01:07 +0200
Message-Id: <20190814165751.476809309@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165748.991235624@linuxfoundation.org>
References: <20190814165748.991235624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 94bccc34071094c165c79b515d21b63c78f7e968 ]

iscsi_ibft can use ACPI to find the iBFT entry during bootup,
currently, ISCSI_IBFT depends on ISCSI_IBFT_FIND which is
a X86 legacy way to find the iBFT by searching through the
low memory. This patch changes the dependency so that other
arch like ARM64 can use ISCSI_IBFT as long as the arch supports
ACPI.

ibft_init() needs to use the global variable ibft_addr declared
in iscsi_ibft_find.c. A #ifndef CONFIG_ISCSI_IBFT_FIND is needed
to declare the variable if CONFIG_ISCSI_IBFT_FIND is not selected.
Moving ibft_addr into the iscsi_ibft.c does not work because if
ISCSI_IBFT is selected as a module, the arch/x86/kernel/setup.c won't
be able to find the variable at compile time.

Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/Kconfig      | 5 +++--
 drivers/firmware/iscsi_ibft.c | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 6e83880046d78..ed212c8b41083 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -198,7 +198,7 @@ config DMI_SCAN_MACHINE_NON_EFI_FALLBACK
 
 config ISCSI_IBFT_FIND
 	bool "iSCSI Boot Firmware Table Attributes"
-	depends on X86 && ACPI
+	depends on X86 && ISCSI_IBFT
 	default n
 	help
 	  This option enables the kernel to find the region of memory
@@ -209,7 +209,8 @@ config ISCSI_IBFT_FIND
 config ISCSI_IBFT
 	tristate "iSCSI Boot Firmware Table Attributes module"
 	select ISCSI_BOOT_SYSFS
-	depends on ISCSI_IBFT_FIND && SCSI && SCSI_LOWLEVEL
+	select ISCSI_IBFT_FIND if X86
+	depends on ACPI && SCSI && SCSI_LOWLEVEL
 	default	n
 	help
 	  This option enables support for detection and exposing of iSCSI
diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
index c51462f5aa1e4..966aef334c420 100644
--- a/drivers/firmware/iscsi_ibft.c
+++ b/drivers/firmware/iscsi_ibft.c
@@ -93,6 +93,10 @@ MODULE_DESCRIPTION("sysfs interface to BIOS iBFT information");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(IBFT_ISCSI_VERSION);
 
+#ifndef CONFIG_ISCSI_IBFT_FIND
+struct acpi_table_ibft *ibft_addr;
+#endif
+
 struct ibft_hdr {
 	u8 id;
 	u8 version;
-- 
2.20.1



