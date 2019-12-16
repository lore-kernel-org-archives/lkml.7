Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2A2C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67640207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576520094;
	bh=LlivjxT72g1WSfdls0+LCRODihuebIfcJGAQ7u9gnkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wYbsRI+dYqfHEKJEOLRpNMamck+T9AOQi8JRd0dbQrCX7TKMXw+pNimUwC/hmTz0C
	 bHPafvORUHwPv0c6bFL1nB5I4NSa/+PV9ji//QFS1nnUYswJrNaGXyRqR+TIf+Wlwe
	 v95uP/RT3ReGauitPeDIldBTDcbmaGONkeb1qCPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731292AbfLPSOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:14:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730990AbfLPSOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:14:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67E0C206E0;
        Mon, 16 Dec 2019 18:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576520088;
        bh=LlivjxT72g1WSfdls0+LCRODihuebIfcJGAQ7u9gnkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HcwkN8dRxop8xzX2uZSQX96MJG5wp7ElVjcGEX0uYYR4hdk55tTQjVN+VlD6f8Sk5
         AFlciW72Hg9GbGt6iEnSyPX647vpeaMxmvTeCaK3UWGkeQQ4stgvHxqfy6/KVj6ImN
         Cek7t+PU2gABsdbI2NU3AaElZmrd1msQW/tciaic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5.4 012/177] ceph: fix compat_ioctl for ceph_dir_operations
Date:   Mon, 16 Dec 2019 18:47:48 +0100
Message-Id: <20191216174815.527496174@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174811.158424118@linuxfoundation.org>
References: <20191216174811.158424118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit 18bd6caaef4021803dd0d031dc37c2d001d18a5b upstream.

The ceph_ioctl function is used both for files and directories, but only
the files support doing that in 32-bit compat mode.

On the s390 architecture, there is also a problem with invalid 31-bit
pointers that need to be passed through compat_ptr().

Use the new compat_ptr_ioctl() to address both issues.

Note: When backporting this patch to stable kernels, "compat_ioctl:
add compat_ptr_ioctl()" is needed as well.

Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/dir.c  |    1 +
 fs/ceph/file.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1809,6 +1809,7 @@ const struct file_operations ceph_dir_fo
 	.open = ceph_open,
 	.release = ceph_release,
 	.unlocked_ioctl = ceph_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 	.fsync = ceph_fsync,
 	.lock = ceph_lock,
 	.flock = ceph_flock,
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2188,7 +2188,7 @@ const struct file_operations ceph_file_f
 	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.unlocked_ioctl = ceph_ioctl,
-	.compat_ioctl	= ceph_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 	.fallocate	= ceph_fallocate,
 	.copy_file_range = ceph_copy_file_range,
 };


