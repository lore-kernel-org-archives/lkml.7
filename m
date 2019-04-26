Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20E0C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAA12077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfDZOvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:51:18 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:34357 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZOvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:51:18 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MQuLB-1h7AGc0llv-00NwDM; Fri, 26 Apr 2019 16:50:57 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: use timespec64 in relatime_need_update
Date:   Fri, 26 Apr 2019 16:50:41 +0200
Message-Id: <20190426145053.2137025-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BYwtyRMkhv4BHg1Gq/fMGIxHNJxM8u+QBDyasj/vmibcWLuSwHu
 z2PDg1wDzFCNIaNtJgio0WUyFp/+gCZw+MjfbhYU9bh4CCg+smlLJi/uQO5td0C2iSpg96B
 36RJw6FXfXNyS9HW2vyOkrjKVwB+JIdvUoaYlZxzJmV0Y63H3DXopAPXj3VpUz/UAtlfEgM
 zMacE5pAPYkUAdSXbEoSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QPV3OSjYilI=:+qx6OOT+P/6aZTfFVzS3Dc
 0vH2iFip67TzzYZ5g5gywaKoENKtUvAX01QgBcNlTnWN/csl0QWdHbBn27GyLFTFtke4rT8n8
 ZZmBS8KjTffi7NciH2KQTQg5iQdIY8X0oLi/W+mH5WUm8xSDo3LYMCd3ryAmtRoswlmfXYJfJ
 CPXJmisom/DC7Yx3DSNGNyxj4HkSIz4K5UWOP3okzfCmglw2L4fJp9M4qyYQ2cmhYqjN2ZHlZ
 IK1RLQhGJ5DrutjVYP6S2FePuh8PMAyIADUT5EjNucF0T8puWjhDiuNnboHJumNpaEg22q03e
 clkDjliPj1L/mfY+ss9jH0YZdpl43Tv3AmK9x8qkklOw8ji08GvrS3iQXW5trkQ3yYER/kXC2
 HL0GBPVtZX7BJHJmFM7tc+YItv1mU3pV2NgsvS3O/WEv999cgrocSCbH46oU2qqPwHvikjuak
 gwofHANIRwoY8uf4NI2YH5aNu//gxMKcnwCoOmR2zLD8LQLiwiblsFE55YgduFeJsEKNMKdm8
 Ix7t+zkSlxjAe6mf3r91u0nN7PJl5vREt86w8N0XODk8djrcN7Ju8/Vjryq8tw9zmGhUN3uRR
 1nviya1VtaMTw9NH8qeMX6TVSU8bEddTNYDE0u0AnFHdBahLhwlX47Kdi/0fghwo++yvRxhcL
 6pjW1hiJpwQDyLf931TiuWlmlmlvARQ3gRIIij1SBtrhnT9Pj1wmePqy26qQFUj7t6Akl4bKY
 kaNPdPLv9IO38ewtKTraCRnba4l2vp4/zINYHg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason, the conversion of the VFS code away from 'struct timespec'
left one function behind that still uses it, for absolutely no reason.

Using timespec64 will make the atime update logic work correctly past
y2038.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index e9d97add2b36..f8ed7144c3dd 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1601,7 +1601,7 @@ EXPORT_SYMBOL(bmap);
  * passed since the last atime update.
  */
 static int relatime_need_update(struct vfsmount *mnt, struct inode *inode,
-			     struct timespec now)
+			     struct timespec64 now)
 {
 
 	if (!(mnt->mnt_flags & MNT_RELATIME))
@@ -1702,7 +1702,7 @@ bool atime_needs_update(const struct path *path, struct inode *inode)
 
 	now = current_time(inode);
 
-	if (!relatime_need_update(mnt, inode, timespec64_to_timespec(now)))
+	if (!relatime_need_update(mnt, inode, now))
 		return false;
 
 	if (timespec64_equal(&inode->i_atime, &now))
-- 
2.20.0

