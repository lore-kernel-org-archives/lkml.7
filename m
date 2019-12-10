Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE2EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973142073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 12:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfLJMMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:12:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7207 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727224AbfLJMMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:12:47 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 631AA4F7801B4F2AC67B;
        Tue, 10 Dec 2019 20:12:45 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Tue, 10 Dec 2019 20:12:39 +0800
From:   John Garry <john.garry@huawei.com>
To:     <masahiroy@kernel.org>
CC:     <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <anders.roxell@linaro.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH] merge_config.sh: Add option for allmodconfig
Date:   Tue, 10 Dec 2019 20:09:14 +0800
Message-ID: <1575979754-184896-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently there has been some work in reporting and fixing bugs in booting
an allmodconfig kernel - here are a few examples:

https://lore.kernel.org/linux-edac/304df85b-8b56-b77e-1a11-aa23769f2e7c@huawei.com/T/#t
https://lore.kernel.org/linux-ide/bdf02e03-86a1-3d35-2908-28187f504495@huawei.com/T/#t
https://lore.kernel.org/netdev/CADYN=9LCPfbpwdTWKw03B22-y3Text=RWXW7XP7wJBHYsMOgrA@mail.gmail.com/
https://sourceforge.net/p/openipmi/mailman/message/36871567/

If we want to boot an allmodconfig kernel we may still want to force some
loadable modules built-in, like UART drivers. Or just still turn off some
configs.

So add an option to add add fragments to an allmodconfig kernel.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/scripts/kconfig/merge_config.sh b/scripts/kconfig/merge_config.sh
index 63c8565206a4..01697fb6dfbe 100755
--- a/scripts/kconfig/merge_config.sh
+++ b/scripts/kconfig/merge_config.sh
@@ -23,6 +23,7 @@ clean_up() {
 usage() {
 	echo "Usage: $0 [OPTIONS] [CONFIG [...]]"
 	echo "  -h    display this help text"
+	echo "  -a    use allmodconfig instead of alldefconfig"
 	echo "  -m    only merge the fragments, do not execute the make command"
 	echo "  -n    use allnoconfig instead of alldefconfig"
 	echo "  -r    list redundant entries when merging fragments"
@@ -41,6 +42,11 @@ CONFIG_PREFIX=${CONFIG_-CONFIG_}
 
 while true; do
 	case $1 in
+	"-a")
+		ALLTARGET=allmodconfig
+		shift
+		continue
+		;;
 	"-n")
 		ALLTARGET=allnoconfig
 		shift
@@ -171,6 +177,7 @@ fi
 
 # Use the merged file as the starting point for:
 # alldefconfig: Fills in any missing symbols with Kconfig default
+# allmodconfig: Fills in any missing symbols with =m when loadable
 # allnoconfig: Fills in any missing symbols with # CONFIG_* is not set
 make KCONFIG_ALLCONFIG=$TMP_FILE $OUTPUT_ARG $ALLTARGET
 
-- 
2.17.1

