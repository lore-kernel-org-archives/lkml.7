Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C346C606BA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F9120844
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731480AbfGHNtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:49:19 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:43821 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfGHNtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:49:19 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MJW5G-1i4CkC2B8y-00Js0c; Mon, 08 Jul 2019 15:48:24 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Luis Henriques <lhenriques@suse.com>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] ceph: fix uninitialized return code
Date:   Mon,  8 Jul 2019 15:48:08 +0200
Message-Id: <20190708134821.587398-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:j9WuTzznNib1eqFqYiDaL4gyRPc7QzL4NZ/bydGzytMcRzEQWWK
 1pfqAtiy4q5IanUhQ9tbckly/jv44kLphwurVdExoHEQsGWJ+Z4NZxg7kCC5PghpPWCo8Zb
 NbqHurMOI0cgLCrHaTuSvWpITh9lqB1KJXAVataxPXbQjzmwgQSYlUAatKHcX0lhBQAFMZu
 BBrK8kwdiMyfsMqLatOCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MxxQnbkvXE8=:TMJta/lJz0aLSAbBBndGLO
 mcIHI6ma3NwEw2ZFBeNkx+gNiu2g7Ku28dtW59kaFE+5v7q6QClShdY4dfTqsxCbJn49W6AUG
 EXD1G7BLeTx45pa2eB3qeT/1P/kNYacCRWfalVZC/qhNmSfFvlL+lWoYlMXu3mJPHKc7sKFa8
 1bE9Av3mK2ONfwdipFvjo9FdjAR35CXkXd6wAV4o4+YuSBNDzG3gZhPY7vDui1Bib1efF4OYM
 kl9GUpLApjYW+h2B547FwjavClw3MqXSj3WCwnb/Jq7l5REq9jn/mDzi4qIwYthTz1Xbhs/D3
 vkm5rTjp0HtalvtWo94e4jgGA4uFJM4vq4doUAtgw5XvsJ0jzRV9zDrcp/CexUMRRly3BVxhD
 6UbMl1n8ocIyv1WrJD5mNxJJ1+4TerOU2O+/gLKQrtMANifkVr+HRZAFXevQrDP81f6eRxzgb
 Zlt1VeubJUzML8lLAN0Z6EEwH9ES+DqjyW7xqYFlpKCwIX/ABOs3tJ2bIn5Ref1YKKkQ3FmJI
 1C01aAZXtM8UTbTpSgnLnU7UBv0DlbDMVUWcxobYIoZI/fCsqZ4qVRp4A1jPzsyiat5NiMjAc
 0YgdAyQKd+6c6xrxxRbkgvoy6wCMzITwby1WROyLepGVGOMX+5EOO/GWtL18nnr/R8Zr05AsA
 a7Jti8FX4rf8PfX8Y4Po92v0Kas6bYoG0U61VYHZ9wc+Ffxy6W4ufZ4hOGesYgXp3FQbeIn1r
 3NiLkvooYtr34YQrCApGaL/MI19hkqOTZpl3wA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang points out a -Wsometimed-uninitized bug in the modified
ceph_real_mount() function:

fs/ceph/super.c:850:6: error: variable 'err' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
        if (!fsc->sb->s_root) {
            ^~~~~~~~~~~~~~~~
fs/ceph/super.c:885:9: note: uninitialized use occurs here
        return err;
               ^~~
fs/ceph/super.c:850:2: note: remove the 'if' if its condition is always true
        if (!fsc->sb->s_root) {
        ^~~~~~~~~~~~~~~~~~~~~~
fs/ceph/super.c:843:9: note: initialize the variable 'err' to silence this warning
        int err;
               ^
                = 0

Set it to zero if the condition is false.

Fixes: 108f95bfaa56 ("vfs: Convert ceph to use the new mount API")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ceph/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 0d23903ddfa5..d663aa1286f6 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -876,6 +876,8 @@ static int ceph_real_mount(struct fs_context *fc, struct ceph_fs_client *fsc)
 			goto out;
 		}
 		fsc->sb->s_root = root;
+	} else {
+		err = 0;
 	}
 
 	fc->root = dget(fsc->sb->s_root);
-- 
2.20.0

