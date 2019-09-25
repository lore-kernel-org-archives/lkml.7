Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C14C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 12:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD0E20673
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 12:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbfIYMhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 08:37:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57258 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbfIYMhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 08:37:40 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 79294FA05F0609B81877;
        Wed, 25 Sep 2019 20:37:38 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Sep 2019
 20:37:37 +0800
To:     <apw@canonical.com>, <mingo@kernel.org>, <joe@perches.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] toplevel: Move ipc/ to kernel/ipc/: don't check the ipc dir
Message-ID: <04acff22-430b-9ed7-f700-b644c0632cdd@huawei.com>
Date:   Wed, 25 Sep 2019 20:37:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commit 76128326f97c ("toplevel: Move ipc/ to kernel/ipc/: move
the files"), we met some error messages:

  ./scripts/checkpatch.pl:
  "Must be run from the top-level dir. of a kernel tree"

  ./scripts/get_maintainer.pl:
  "The current directory does not appear to be a linux kernel source tree.

Don't check the ipc dir in checkpatch.pl and get_maintainer.pl.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 scripts/checkpatch.pl     | 2 +-
 scripts/get_maintainer.pl | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 93a7edf..6117d0e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1097,7 +1097,7 @@ sub top_of_kernel_tree {
 	my @tree_check = (
 		"COPYING", "CREDITS", "Kbuild", "MAINTAINERS", "Makefile",
 		"README", "Documentation", "arch", "include", "drivers",
-		"fs", "init", "ipc", "kernel", "lib", "scripts",
+		"fs", "init", "kernel", "lib", "scripts",
 	);

 	foreach my $check (@tree_check) {
diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 5ef5921..2e42aeb 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -1109,7 +1109,6 @@ sub top_of_kernel_tree {
 	&& (-d "${lk_path}drivers")
 	&& (-d "${lk_path}fs")
 	&& (-d "${lk_path}init")
-	&& (-d "${lk_path}ipc")
 	&& (-d "${lk_path}kernel")
 	&& (-d "${lk_path}lib")
 	&& (-d "${lk_path}scripts")) {
-- 
2.7.4

