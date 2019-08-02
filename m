Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF02C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366492086A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564739123;
	bh=viojl1Wh9riP/rQAtRHoMpxVkEnfhYOshj1b+skoEmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=INpIcesEEkAwsisCllJq0nX4T5s20EPJjcbcfPF8sLwqT6GokVUmFgpV3ZnjqeJwF
	 oCtafgIzHYgolNAQWup0jHgJrStgHjZ/4Dx/1Iev9jw6lfYKS2wcYuGaKH6ecxC+vr
	 llGV35ZkYdiyG4AHWf1ksNOwEQQyzcpyp67XjOuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405426AbfHBJpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:45:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403831AbfHBJpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:45:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D144221726;
        Fri,  2 Aug 2019 09:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739116;
        bh=viojl1Wh9riP/rQAtRHoMpxVkEnfhYOshj1b+skoEmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0vauINYqPeGCvejJReZtDNi9M1pKNgDIQP0ur5XhR3vCCSsNgO5D7tiWsnMspc+BK
         6686xCyOTLYGq7s/Hh6C7XOuZl2EKd8zI+YeUhBcNJEOD+sVtWlEmM7LvTTP6Sd1S3
         MXL4c5M97qsZTgq2pFlfqFfJUfMy1zQBwG+nLxAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Efremov <efremov@ispras.ru>,
        Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 105/223] floppy: fix out-of-bounds read in next_valid_format
Date:   Fri,  2 Aug 2019 11:35:30 +0200
Message-Id: <20190802092246.036345213@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
References: <20190802092238.692035242@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/floppy.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3384,6 +3384,20 @@ static int fd_getgeo(struct block_device
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
@@ -3510,6 +3524,8 @@ static int fd_locked_ioctl(struct block_
 		SUPBOUND(size, strlen((const char *)outparam) + 1);
 		break;
 	case FDSETDRVPRM:
+		if (!valid_floppy_drive_params(inparam.dp.autodetect))
+			return -EINVAL;
 		*UDP = inparam.dp;
 		break;
 	case FDGETDRVPRM:
@@ -3707,6 +3723,8 @@ static int compat_setdrvprm(int drive,
 		return -EPERM;
 	if (copy_from_user(&v, arg, sizeof(struct compat_floppy_drive_params)))
 		return -EFAULT;
+	if (!valid_floppy_drive_params(v.autodetect))
+		return -EINVAL;
 	mutex_lock(&floppy_mutex);
 	UDP->cmos = v.cmos;
 	UDP->max_dtr = v.max_dtr;


