Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D6EC4D2C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D08246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfLMUyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:54:33 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:42315 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMUyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 15:54:32 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MgNQd-1i4aSD2T9D-00huUn; Fri, 13 Dec 2019 21:54:18 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-um@lists.infradead.org
Subject: [PATCH v2 10/24] hostfs: pass 64-bit timestamps to/from user space
Date:   Fri, 13 Dec 2019 21:53:38 +0100
Message-Id: <20191213205417.3871055-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213204936.3643476-1-arnd@arndb.de>
References: <20191213204936.3643476-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:a6AdbmdDziwYGHu+FLwRLl9xFjl6ntLHucVI0g7wMYChjz0a15h
 smNUqa7abfPVyLZDEicFzc+kxaoNSdsVsBhb2C3KoKHnF4X8drVpnzEeQwBcbSTwVrbA4ZE
 l/jIyoAGeOSrx0BHpxPkM9AhZOahh3h/KMQdhAQJBgsQmtKP1NyFUKIJaAQ9SbK3m9M929y
 ljS3RSrIpKC/5sFEyqAAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b1QJuSoZs2Y=:1GUnlu2dF2dprRPCt31Clf
 Kv1y3O8o9ERlAkl4V0Fe0QrmFl1eJGcoNbAP0shJliOwxb439vJP2ESzT6Q6LmTMB/1OUgg9L
 E8Eo8/uwZZx5ox+EFguRWTmeEqyers2S/DSkAwyHIIrMAzFr8MyXCyhm009u6VdNeqCkCZFk4
 e1QPQn3EmkzHcdqZUu7o5eZFrT7OWWdmJQrWh68tRPsSPlHGqTn19fa4eHLmlpExQ8JxzgArD
 t8eCWD9AwqyNgGiMB7tiqzu5ddMtDEFtWuXgss4ODnuNNPpz2g8dUGsqKO1W5yFO+B8zffSMs
 iTkexflWc1Ypsz4//U87m4Xu3OVdSBxRG1m+/lYHw1KEoDAUwJfg5+k256HLY6TjdHxZCABIL
 GI64J+yahQXalgJZAXy5iwZA8cLeJWtJC8ByybbPqW8PUjSD76HnNYIHjBufaflMJ0guhkC+4
 sYwivnoImJE9ADg5/9YBzIESX7pRf/SUfjiLs9A15TqtB4NlVfNeFDoRZbBpFScRWO+4PbQbD
 FqLeH63FvQfoifJVe4Qfae2M9f6G0FKaqVFof3e5uDC3Zyv1KgHQN0YLphROlOsL7ZRuoNaE6
 DQDZGX8LVOCgHnoleFFuqaASFjkLl69bGmbUCy+2H1d8KVZa9J/AMKydajYxybqMjHt1Ac6CS
 SZtUewPJGvklOSadqpjRJquJhKDiz9Vmq6zZRh13oCELpbJlrQTDjJmO0dRcdr1YKe+j/gM2d
 gWZN+GMeXDsvdTyYfsux7MOfX/hcSZ9O8F95amXeLAxhJJR322Q3FWab15NoFKliM0HGKZEzb
 vYWwoCO7nFofkOIokJhiMcWeRAvAGdQYpyCKuveyQ8wLV4bDaHIIIEvxvEVnG0HowsDZgTSO5
 LWDJ78F7la/VYdUw7G1w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of 'struct timespec' is deprecated in the kernel, so we
want to avoid the conversions from/to the proper timespec64
structure.

On the user space side, we have a 'struct timespec' that is defined
by the C library and that will be incompatible with the kernel's
view on 32-bit architectures once they move to a 64-bit time_t,
breaking the shared binary layout of hostfs_iattr and hostfs_stat.

This changes the two structures to use a new hostfs_timespec structure
with fixed 64-bit seconds/nanoseconds for passing the timestamps
between hostfs_kern.c and hostfs_user.c. With a new enough user
space side, this will allow timestamps beyond year 2038.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/hostfs/hostfs.h      | 22 +++++++++++++---------
 fs/hostfs/hostfs_kern.c | 15 +++++++++------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/fs/hostfs/hostfs.h b/fs/hostfs/hostfs.h
index f4295aa19350..69cb796f6270 100644
--- a/fs/hostfs/hostfs.h
+++ b/fs/hostfs/hostfs.h
@@ -37,16 +37,20 @@
  * is on, and remove the appropriate bits from attr->ia_mode (attr is a
  * "struct iattr *"). -BlaisorBlade
  */
+struct hostfs_timespec {
+	long long tv_sec;
+	long long tv_nsec;
+};
 
 struct hostfs_iattr {
-	unsigned int	ia_valid;
-	unsigned short	ia_mode;
-	uid_t		ia_uid;
-	gid_t		ia_gid;
-	loff_t		ia_size;
-	struct timespec	ia_atime;
-	struct timespec	ia_mtime;
-	struct timespec	ia_ctime;
+	unsigned int		ia_valid;
+	unsigned short		ia_mode;
+	uid_t			ia_uid;
+	gid_t			ia_gid;
+	loff_t			ia_size;
+	struct hostfs_timespec	ia_atime;
+	struct hostfs_timespec	ia_mtime;
+	struct hostfs_timespec	ia_ctime;
 };
 
 struct hostfs_stat {
@@ -56,7 +60,7 @@ struct hostfs_stat {
 	unsigned int uid;
 	unsigned int gid;
 	unsigned long long size;
-	struct timespec atime, mtime, ctime;
+	struct hostfs_timespec atime, mtime, ctime;
 	unsigned int blksize;
 	unsigned long long blocks;
 	unsigned int maj;
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 5a7eb0c79839..e6b8c49076bb 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -549,9 +549,9 @@ static int read_name(struct inode *ino, char *name)
 	set_nlink(ino, st.nlink);
 	i_uid_write(ino, st.uid);
 	i_gid_write(ino, st.gid);
-	ino->i_atime = timespec_to_timespec64(st.atime);
-	ino->i_mtime = timespec_to_timespec64(st.mtime);
-	ino->i_ctime = timespec_to_timespec64(st.ctime);
+	ino->i_atime = (struct timespec64){ st.atime.tv_sec, st.atime.tv_nsec };
+	ino->i_mtime = (struct timespec64){ st.mtime.tv_sec, st.mtime.tv_nsec };
+	ino->i_ctime = (struct timespec64){ st.ctime.tv_sec, st.ctime.tv_nsec };
 	ino->i_size = st.size;
 	ino->i_blocks = st.blocks;
 	return 0;
@@ -820,15 +820,18 @@ static int hostfs_setattr(struct dentry *dentry, struct iattr *attr)
 	}
 	if (attr->ia_valid & ATTR_ATIME) {
 		attrs.ia_valid |= HOSTFS_ATTR_ATIME;
-		attrs.ia_atime = timespec64_to_timespec(attr->ia_atime);
+		attrs.ia_atime = (struct hostfs_timespec)
+			{ attr->ia_atime.tv_sec, attr->ia_atime.tv_nsec };
 	}
 	if (attr->ia_valid & ATTR_MTIME) {
 		attrs.ia_valid |= HOSTFS_ATTR_MTIME;
-		attrs.ia_mtime = timespec64_to_timespec(attr->ia_mtime);
+		attrs.ia_mtime = (struct hostfs_timespec)
+			{ attr->ia_mtime.tv_sec, attr->ia_mtime.tv_nsec };
 	}
 	if (attr->ia_valid & ATTR_CTIME) {
 		attrs.ia_valid |= HOSTFS_ATTR_CTIME;
-		attrs.ia_ctime = timespec64_to_timespec(attr->ia_ctime);
+		attrs.ia_ctime = (struct hostfs_timespec)
+			{ attr->ia_ctime.tv_sec, attr->ia_ctime.tv_nsec };
 	}
 	if (attr->ia_valid & ATTR_ATIME_SET) {
 		attrs.ia_valid |= HOSTFS_ATTR_ATIME_SET;
-- 
2.20.0

