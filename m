Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52732C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 10:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290B7222C1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 10:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbfCXK2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 06:28:15 -0400
Received: from avasout02.plus.net ([212.159.14.17]:47283 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbfCXK2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 06:28:15 -0400
Received: from deneb ([80.229.24.9])
        by smtp with ESMTP
        id 80MMh60E72SW580MNhM3SG; Sun, 24 Mar 2019 10:28:13 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=NtavjPVJ c=1 sm=1 tr=0
 a=E/9URZZQ5L3bK/voZ0g0HQ==:117 a=E/9URZZQ5L3bK/voZ0g0HQ==:17
 a=NTGMnVQrEZIA:10 a=CCpqsmhAAAAA:8 a=-An2I_7KAAAA:8 a=9qxNCY_qAAAA:8
 a=VwQbUJbxAAAA:8 a=D19gQVrFAAAA:8 a=w-YdG8ML7ShXMl4_PY4A:9
 a=ul9cdbp4aOFLsgKbc677:22 a=Sq34B_EcNBM9_nrAYB9S:22 a=A2X48xt2e1hG9NJDz63Y:22
 a=AjGcO6oz07-iQ99wixmX:22 a=W4TVW4IDbPiebHqcZpNg:22
Received: from mac by deneb with local (Exim 4.89)
        (envelope-from <mac@mcrowe.com>)
        id 1h80ML-0001xW-Mk; Sun, 24 Mar 2019 10:28:09 +0000
From:   Mike Crowe <mac@mcrowe.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mike Crowe <mac@mcrowe.com>, Kay Sievers <kay@vrfy.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        stable@vger.kernel.org
Subject: [PATCH] kmsg: Return -ESPIPE rather than EBADF from llseek(SEEK_CUR)
Date:   Sun, 24 Mar 2019 10:27:13 +0000
Message-Id: <20190324102712.1488-1-mac@mcrowe.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJl/CbTQc6m3M9qqf2LC9OSlcDhslkxIQU+lrsy3VpN2QmPF5yAQrfmdAL1uVVSiMq/3FkTlEOZTMBN5P6643y9Fjz4RwGO38TyBWYFNhYl1e1YlBIoG
 5NFrtdcr2xXiwgj9c5SmXRFwGr7zBNowkE8WwawjIPFMX9B95pFplnAw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

glibc's dprintf implementation tries to determine the current file position
by calling lseek(fd, 0, SEEK_CUR). Unfortunately it treats receiving EINVAL
as an error. See https://sourceware.org/bugzilla/show_bug.cgi?id=17830

From what I can tell prior to Kay Sievers printk record commit
e11fea92e13fb91c50bacca799a6131c81929986, calling lseek(fd, 0, SEEK_CUR)
with such a file descriptor would not return an error.

Prior to Kay's change, Arnd Bergmann's commit
6038f373a3dc1f1c26496e60b6c40b164716f07e seemed to go to some lengths to
preserve the successful return code rather than returning (the perhaps more
logical) -ESPIPE.

glibc is happy with either a successful return or -ESPIPE. It seems that
the consensus is to return -ESPIPE in this situation.

Alexander Sverdlin supplied this test case:
--8<--
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <fcntl.h>

 int main(int argc, char **argv)
 {
         return dprintf(open("/dev/kmsg", O_WRONLY), "\n") < 0;
 }
-->8--

Signed-off-by: Mike Crowe <mac@mcrowe.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Tested-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc: stable@vger.kernel.org
Fixes: e11fea92e1 ("kmsg: export printk records to the /dev/kmsg interface")
---
 kernel/printk/printk.c | 5 +++++
 1 file changed, 5 insertions(+)

Originally posted as https://lkml.org/lkml/2015/1/15/575 . Thanks to
Alexander for waking this up and helping to test the updated fix.

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 02ca827b8fac..4f047b13162c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -945,6 +945,11 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
 		user->idx = log_next_idx;
 		user->seq = log_next_seq;
 		break;
+	case SEEK_CUR:
+		/* For compatibility with userspace expecting SEEK_CUR
+		 * to not yield EINVAL. */
+		ret = -ESPIPE;
+		break;
 	default:
 		ret = -EINVAL;
 	}
-- 
2.20.1

