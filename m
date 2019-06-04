Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58866C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E61224D3E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559635144;
	bh=BGPVBwJeHoElaUtEavKKbm0/aDM8XNbhtrBPJNIJn9Y=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=IpTxIbzd5ywkMLezJFwwUwhq55+6Jm9/WjpYKjjnZJ/VMgYDJHvbMOxvVmh/p+7Ua
	 PyWt1jCj15cDo1aLQEed15ulTkAoqYzSsIe/fz4anV7ldx6vJ/BYjLdA/3Bx2iz7Ca
	 n81MJJp41KWXrrDkqWMe6m1gG+hhHR9UuXiB78dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfFDH7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbfFDH7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:59:02 -0400
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEB3D24D3D;
        Tue,  4 Jun 2019 07:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559635142;
        bh=BGPVBwJeHoElaUtEavKKbm0/aDM8XNbhtrBPJNIJn9Y=;
        h=From:To:Cc:Subject:Date:From;
        b=DyY2TTvBHAhL+dlseHCh809aq7njNbpYYJOhcA3Nv8vFJeYLItkwqo1/IfSN6RQxE
         zSVx3hroxmFFPFRhwYj+l8jLFykJ73rWLBWiUfb29+9/XIU0dzuKQEhOI5SHktYlTY
         gU5BtQjZaITuRbo353CZK4RZG78hZRFZqFHajGWQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] s390: configs: Remove useless UEVENT_HELPER_PATH
Date:   Tue,  4 Jun 2019 09:58:57 +0200
Message-Id: <1559635137-20900-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the CONFIG_UEVENT_HELPER_PATH because:
1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
   CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
   made default to 'n',
2. It is not recommended (help message: "This should not be used today
   [...] creates a high system load") and was kept only for ancient
   userland,
3. Certain userland specifically requests it to be disabled (systemd
   README: "Legacy hotplug slows down the system and confuses udev").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/s390/configs/defconfig          | 1 -
 arch/s390/configs/zfcpdump_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index c59b922cb6c5..18cff2e4607d 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -94,7 +94,6 @@ CONFIG_NET_CLS_RSVP6=m
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_ACT_POLICE=y
 CONFIG_BPF_JIT=y
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index 7dc7f58c4287..d92bab844b73 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -24,7 +24,6 @@ CONFIG_CRASH_DUMP=y
 # CONFIG_SECCOMP is not set
 CONFIG_NET=y
 # CONFIG_IUCV is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_BLK_DEV_RAM=y
 # CONFIG_BLK_DEV_XPRAM is not set
-- 
2.7.4

