Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D80C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E677320861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfFQMkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:40:10 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:56871 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfFQMkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:40:09 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1My3In-1iYGfA14mt-00zT27; Mon, 17 Jun 2019 14:39:51 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ovl: fix bogus -Wmaybe-unitialized warning
Date:   Mon, 17 Jun 2019 14:39:29 +0200
Message-Id: <20190617123947.941417-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VMmghNLouvOr+K+bfJY6ktXiz4LQF0Tgkc4VipMMdMlj5hSYiFF
 Kuz66NlT5mfIqkDPhs0INSQ6W5g7xUrO2VsXRfwdGPxJOsGvfzMD+KQu0gn6YEeyv4ZocKA
 giMzsF6/brReIyLfXmyw+qIqq1isbPE3LsIeV1zF2HP56PR9ww3lPYirQ+nC8kFYr+g0ooB
 ijAEtaOXzCcbLycDzSvmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2GlMJfBsJmw=:TbCQHBQlR61T4n2//VMNhP
 uQrwe3wS78ihWQNEXlV2DpY6WUp3/2RaICX+TzXcILt0j0WWfXItn1YP4zGhLbtHYLdHaf4T7
 u7OHs+uSiYmveKvqpKHUsBYv1SntgZFaeeElviUYU/WCeg11R0KnLngxfMHY7z1NzbNXfQqAn
 cRhQEYphUVlq4Nib+DJng2SWY+PU5g2WpjKzn1itu3zi8Yo61ZwXnzbcx2beK2x9VuScJFP1c
 6zxplSj8LgRCoBX+xpL7BtWQcWna7Mw5P1fOs7EuaQcZ68agqXssjSm4MWkTiC1A0nw3tDqoh
 m3B+WWb1WHexcmq24f2pCWEDkqDr6QUq63Ljs5KUEjojK/tENLCwfictWEMIUdu4J5XdxdKq0
 BDIQuj/Sng8Gpy9iJdGBDNKafgECoI045CtLN+X73Ml+z8CA1V2AMbikvE8GK66I3W1KFU8Vf
 2MwR2ydLQj7RbcjvH46VcUaM4lweB+cLzQegTnZtZg+fHfbRGIjTalQwdjg3YNsx47bBtkHMn
 xpnkWWyJSC39/MTMZo9BDN9vFMkLNrPX4ObkMHHHyalEZYnULbWoT7S5GvlC6E4EhALXYx1HM
 1+bVB4aJi05SkI/IyzR3olWI3a7/+CPZhZejqI8baKLkO247QlCXYsYOHjPlutjmVHiIDqjR5
 DRO9D1wupUxQdG7IbxNDlaZ1sQdTwfcUmCtLhpNLyoq3W3/hL9kpnaVEn2ky23FFZIG5vqZJu
 eRqfNfdtlcvh55d/3Ei3CxEH2OPWgcb29gz2Tw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc gets a bit confused by the logic in ovl_setup_trap() and
can't figure out whether the local 'trap' variable in the caller
was initialized or not:

fs/overlayfs/super.c: In function 'ovl_fill_super':
fs/overlayfs/super.c:1333:4: error: 'trap' may be used uninitialized in this function [-Werror=maybe-uninitialized]
    iput(trap);
    ^~~~~~~~~~
fs/overlayfs/super.c:1312:17: note: 'trap' was declared here

Reword slightly to make it easier for the compiler to understand.

Fixes: 146d62e5a586 ("ovl: detect overlapping layers")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/overlayfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 746ea36f3171..d150ad6dba94 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -995,8 +995,8 @@ static int ovl_setup_trap(struct super_block *sb, struct dentry *dir,
 	int err;
 
 	trap = ovl_get_trap_inode(sb, dir);
-	err = PTR_ERR(trap);
-	if (IS_ERR(trap)) {
+	err = PTR_ERR_OR_ZERO(trap);
+	if (err) {
 		if (err == -ELOOP)
 			pr_err("overlayfs: conflicting %s path\n", name);
 		return err;
-- 
2.20.0

