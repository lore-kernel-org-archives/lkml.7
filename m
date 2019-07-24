Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A71C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9311622CB8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564033311;
	bh=he61A2f42ighlk64zvro43y+G1T98ICDsXNodbMcuN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iAbay2+u4hPdY3pOjtrzR3SQp0ksHJpnGT8LCa5+iQwRVdditS9l3gs7Ud8ccJBQ3
	 M0tIcNIK9u0RWhh67vYO9jJ3j+UG8O4Bq6q8STu99nfWHQeRJ6JOtZwtXurxG+1Crf
	 t/PLJvw8M6yGjy43Bu5nknre0OczYiOouE+y2+bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390789AbfGYFlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387941AbfGYFlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:41:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4445522C7D;
        Thu, 25 Jul 2019 05:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564033306;
        bh=he61A2f42ighlk64zvro43y+G1T98ICDsXNodbMcuN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zhaAk0G/pZGyQCyjV2eQw13BFdTD+cPw4V2bpfj5/UmhW0fDGJMQGdbIoN0gC4nL5
         R9wnkO+7gGNEA51PlsjNw1k/bE23jEg4PlmKceTyDAJ5fh7JQY1WHazvb9HL99ooOz
         2CQevCb2rIkNAeDOOCQ2t+//UMY3nv7s9kqaqiy0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Efremov <efremov@ispras.ru>,
        Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 161/271] floppy: fix out-of-bounds read in next_valid_format
Date:   Wed, 24 Jul 2019 21:20:30 +0200
Message-Id: <20190724191708.969220476@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5635f897ed83fd539df78e98ba69ee91592f9bb8 ]

This fixes a global out-of-bounds read access in the next_valid_format
function of the floppy driver.

The values from autodetect field of the struct floppy_drive_params are
used as indices for the floppy_type array in the next_valid_format
function 'floppy_type[DP->autodetect[probed_format]].sect'.

To trigger the bug, one could use a value out of range and set the drive
parameters with the FDSETDRVPRM ioctl.  A floppy disk is not required to
be inserted.

CAP_SYS_ADMIN is required to call FDSETDRVPRM.

The patch adds the check for values of the autodetect field to be in the
'0 <= x < ARRAY_SIZE(floppy_type)' range of the floppy_type array indices.

The bug was found by syzkaller.

Signed-off-by: Denis Efremov <efremov@ispras.ru>
Tested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/floppy.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index b1425b218606..dd49737effbf 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3391,6 +3391,20 @@ static int fd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	return 0;
 }
 
+static bool valid_floppy_drive_params(const short autodetect[8])
+{
+	size_t floppy_type_size = ARRAY_SIZE(floppy_type);
+	size_t i = 0;
+
+	for (i = 0; i < 8; ++i) {
+		if (autodetect[i] < 0 ||
+		    autodetect[i] >= floppy_type_size)
+			return false;
+	}
+
+	return true;
+}
+
 static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
 		    unsigned long param)
 {
@@ -3517,6 +3531,8 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 		SUPBOUND(size, strlen((const char *)outparam) + 1);
 		break;
 	case FDSETDRVPRM:
+		if (!valid_floppy_drive_params(inparam.dp.autodetect))
+			return -EINVAL;
 		*UDP = inparam.dp;
 		break;
 	case FDGETDRVPRM:
@@ -3714,6 +3730,8 @@ static int compat_setdrvprm(int drive,
 		return -EPERM;
 	if (copy_from_user(&v, arg, sizeof(struct compat_floppy_drive_params)))
 		return -EFAULT;
+	if (!valid_floppy_drive_params(v.autodetect))
+		return -EINVAL;
 	mutex_lock(&floppy_mutex);
 	UDP->cmos = v.cmos;
 	UDP->max_dtr = v.max_dtr;
-- 
2.20.1



