Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCFFC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1131522BEB
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998050;
	bh=MMDvgQIDUqkQpJk85ly4IO0t91zrFPbX6gTSnAmSimM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mK7ozTZf+3xrEtfb2m0NIhGAklT4d2eZKFLsOD33qvnJnP3bN3Kcswph24bxwKlk8
	 ZmcFjPZmMdAiG9v6VZjkm4yJF3gToFkAhgxWUrpM5us6boe+WV7CjYuVp9BUHFuzJa
	 ESyxHF/LMDfVfDR4M3LKyLhDNuZSbZIfEEnT5G14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404071AbfGXTyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:54:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404060AbfGXTyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:54:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56131217D4;
        Wed, 24 Jul 2019 19:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998042;
        bh=MMDvgQIDUqkQpJk85ly4IO0t91zrFPbX6gTSnAmSimM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=USet/GRZmfwBmyMIW0+JW8OCT6vsAIyt9QrKIc5j1CfbAGOkU7F/q1NnXs5vZd84C
         4JnSOHVuBFsR3bFQ0NeMjTZEDvBqG17IPTHzS5RZMRZRC6qAX3+M8HCV2fFBWQvMDj
         QDAG1m1+M7yh+ow3o6AzvhhDTb6egPVVRoM4wULQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Efremov <efremov@ispras.ru>,
        Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 226/371] floppy: fix invalid pointer dereference in drive_name
Date:   Wed, 24 Jul 2019 21:19:38 +0200
Message-Id: <20190724191741.490197675@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9b04609b784027968348796a18f601aed9db3789 ]

This fixes the invalid pointer dereference in the drive_name function of
the floppy driver.

The native_format field of the struct floppy_drive_params is used as
floppy_type array index in the drive_name function.  Thus, the field
should be checked the same way as the autodetect field.

To trigger the bug, one could use a value out of range and set the drive
parameters with the FDSETDRVPRM ioctl.  Next, FDGETDRVTYP ioctl should
be used to call the drive_name.  A floppy disk is not required to be
inserted.

CAP_SYS_ADMIN is required to call FDSETDRVPRM.

The patch adds the check for a value of the native_format field to be in
the '0 <= x < ARRAY_SIZE(floppy_type)' range of the floppy_type array
indices.

The bug was found by syzkaller.

Signed-off-by: Denis Efremov <efremov@ispras.ru>
Tested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/floppy.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 77c527db5134..8b443ee1d005 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3379,7 +3379,8 @@ static int fd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 	return 0;
 }
 
-static bool valid_floppy_drive_params(const short autodetect[8])
+static bool valid_floppy_drive_params(const short autodetect[8],
+		int native_format)
 {
 	size_t floppy_type_size = ARRAY_SIZE(floppy_type);
 	size_t i = 0;
@@ -3390,6 +3391,9 @@ static bool valid_floppy_drive_params(const short autodetect[8])
 			return false;
 	}
 
+	if (native_format < 0 || native_format >= floppy_type_size)
+		return false;
+
 	return true;
 }
 
@@ -3519,7 +3523,8 @@ static int fd_locked_ioctl(struct block_device *bdev, fmode_t mode, unsigned int
 		SUPBOUND(size, strlen((const char *)outparam) + 1);
 		break;
 	case FDSETDRVPRM:
-		if (!valid_floppy_drive_params(inparam.dp.autodetect))
+		if (!valid_floppy_drive_params(inparam.dp.autodetect,
+				inparam.dp.native_format))
 			return -EINVAL;
 		*UDP = inparam.dp;
 		break;
@@ -3718,7 +3723,7 @@ static int compat_setdrvprm(int drive,
 		return -EPERM;
 	if (copy_from_user(&v, arg, sizeof(struct compat_floppy_drive_params)))
 		return -EFAULT;
-	if (!valid_floppy_drive_params(v.autodetect))
+	if (!valid_floppy_drive_params(v.autodetect, v.native_format))
 		return -EINVAL;
 	mutex_lock(&floppy_mutex);
 	UDP->cmos = v.cmos;
-- 
2.20.1



