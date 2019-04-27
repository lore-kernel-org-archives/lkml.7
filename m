Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293D7C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007BD206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfD0PSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:18:55 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34234 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727683AbfD0PPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:38 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP39-00014C-Vl; Sat, 27 Apr 2019 16:15:36 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2i-0004SC-RT; Sat, 27 Apr 2019 16:15:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.180125125@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 057/202] char/mwave: fix potential Spectre v1
 vulnerability
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

commit 701956d4018e5d5438570e39e8bda47edd32c489 upstream.

ipcnum is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

drivers/char/mwave/mwavedd.c:299 mwave_ioctl() warn: potential spectre issue 'pDrvData->IPCs' [w] (local cap)

Fix this by sanitizing ipcnum before using it to index pDrvData->IPCs.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/char/mwave/mwavedd.c | 7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/char/mwave/mwavedd.c
+++ b/drivers/char/mwave/mwavedd.c
@@ -59,6 +59,7 @@
 #include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/serial_8250.h>
+#include <linux/nospec.h>
 #include "smapi.h"
 #include "mwavedd.h"
 #include "3780i.h"
@@ -289,6 +290,8 @@ static long mwave_ioctl(struct file *fil
 						ipcnum);
 				return -EINVAL;
 			}
+			ipcnum = array_index_nospec(ipcnum,
+						    ARRAY_SIZE(pDrvData->IPCs));
 			PRINTK_3(TRACE_MWAVE,
 				"mwavedd::mwave_ioctl IOCTL_MW_REGISTER_IPC"
 				" ipcnum %x entry usIntCount %x\n",
@@ -317,6 +320,8 @@ static long mwave_ioctl(struct file *fil
 						" Invalid ipcnum %x\n", ipcnum);
 				return -EINVAL;
 			}
+			ipcnum = array_index_nospec(ipcnum,
+						    ARRAY_SIZE(pDrvData->IPCs));
 			PRINTK_3(TRACE_MWAVE,
 				"mwavedd::mwave_ioctl IOCTL_MW_GET_IPC"
 				" ipcnum %x, usIntCount %x\n",
@@ -383,6 +388,8 @@ static long mwave_ioctl(struct file *fil
 						ipcnum);
 				return -EINVAL;
 			}
+			ipcnum = array_index_nospec(ipcnum,
+						    ARRAY_SIZE(pDrvData->IPCs));
 			mutex_lock(&mwave_mutex);
 			if (pDrvData->IPCs[ipcnum].bIsEnabled == TRUE) {
 				pDrvData->IPCs[ipcnum].bIsEnabled = FALSE;

