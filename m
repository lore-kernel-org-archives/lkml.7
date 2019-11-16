Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADB1C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56E021739
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919430;
	bh=e0kwQxqjl/q5q36XpJycaaUijSZMetJRcSRLw0P4rkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OGuy0GyEfv6pKDoXO1v6LkQTY8xAGYIsdPV97YkqhAohut2oV8SpX+iSgMuOtcOE9
	 9TFJ9Yq9u2b8Y9usx0OyQmWppWnElE2HIgesUnO0mwszCMm6pWf5X2SsGTIYZKzPa0
	 YZtEXD5m6Nw0hjoKgo0t9S6IRAvNCfGK+hHoXhEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730531AbfKPPu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:50:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730478AbfKPPuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:50:19 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C56F721479;
        Sat, 16 Nov 2019 15:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919419;
        bh=e0kwQxqjl/q5q36XpJycaaUijSZMetJRcSRLw0P4rkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uKZsLnD/VAwJx4hUiSHppjgNQbwApeS3I6NUzsJoPuKio490EvPchnD5YSkBST3Fj
         eQ6N/LfLMo2WpI5Wp89b5MtX1j1bMEqGZKKGgxgJNj23OO357jsG50Su8H05li23el
         z4NfPFlqDPZMiagkMZQ4pZhRx4kyE4MlDgpZz2VI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Nikolay Borisov <nborisov@suse.com>,
        Changbin Du <changbin.du@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 119/150] btrfs: avoid link error with CONFIG_NO_AUTO_INLINE
Date:   Sat, 16 Nov 2019 10:46:57 -0500
Message-Id: <20191116154729.9573-119-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 7e17916b35797396f681a3270245fd29c1e4c250 ]

Note: this patch fixes a problem in a feature outside of btrfs ("kernel
hacking: add a config option to disable compiler auto-inlining") and is
applied ahead of time due to cross-subsystem dependencies.

On 32-bit ARM with gcc-8, I see a link error with the addition of the
CONFIG_NO_AUTO_INLINE option:

fs/btrfs/super.o: In function `btrfs_statfs':
super.c:(.text+0x67b8): undefined reference to `__aeabi_uldivmod'
super.c:(.text+0x67fc): undefined reference to `__aeabi_uldivmod'
super.c:(.text+0x6858): undefined reference to `__aeabi_uldivmod'
super.c:(.text+0x6920): undefined reference to `__aeabi_uldivmod'
super.c:(.text+0x693c): undefined reference to `__aeabi_uldivmod'
fs/btrfs/super.o:super.c:(.text+0x6958): more undefined references to `__aeabi_uldivmod' follow

So far this is the only file that shows the behavior, so I'd propose
to just work around it by marking the functions as 'static inline'
that normally get inlined here.

The reference to __aeabi_uldivmod comes from a div_u64() which has an
optimization for a constant division that uses a straight '/' operator
when the result should be known to the compiler. My interpretation is
that as we turn off inlining, gcc still expects the result to be constant
but fails to use that constant value.

Link: https://lkml.kernel.org/r/20181103153941.1881966-1-arnd@arndb.de
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Changbin Du <changbin.du@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[ add the note ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 49a02bf091aea..204d585e012a8 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1863,7 +1863,7 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 }
 
 /* Used to sort the devices by max_avail(descending sort) */
-static int btrfs_cmp_device_free_bytes(const void *dev_info1,
+static inline int btrfs_cmp_device_free_bytes(const void *dev_info1,
 				       const void *dev_info2)
 {
 	if (((struct btrfs_device_info *)dev_info1)->max_avail >
@@ -1892,8 +1892,8 @@ static inline void btrfs_descending_sort_devices(
  * The helper to calc the free space on the devices that can be used to store
  * file data.
  */
-static int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
-				       u64 *free_bytes)
+static inline int btrfs_calc_avail_data_space(struct btrfs_fs_info *fs_info,
+					      u64 *free_bytes)
 {
 	struct btrfs_device_info *devices_info;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
-- 
2.20.1

