Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99543C341C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C615424689
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLMUxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 15:53:05 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:45503 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfLMUxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 15:53:04 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MSqbe-1iI6wz0KPG-00UKf7; Fri, 13 Dec 2019 21:52:47 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Alex Dewar <alex.dewar@gmx.co.uk>,
        Jens Axboe <axboe@kernel.dk>, linux-um@lists.infradead.org
Subject: [PATCH v2 05/24] um: ubd: use 64-bit time_t where possible
Date:   Fri, 13 Dec 2019 21:52:10 +0100
Message-Id: <20191213205221.3787308-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191213204936.3643476-1-arnd@arndb.de>
References: <20191213204936.3643476-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mLyO11lzsTki85ngmdRuvZQpffJE2UOI4zLl+uc1b6gL7mCwrB9
 c4BgVt5uCUzPtnrvPR47NFtCTQDbqK683AKz1oOVgkq1Ekn5QNnTb1ut06woz/k2ZQC0VGj
 oK9OwugHAi5tHUSZe5Suajf52pVQAEIFogivdYkNfobGxUDXRSqRAqJMt6v1s4DxoODHhav
 NLcxeYqWv0+1bUYscHkYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lpUtqwLVCdA=:kSwfzyihbAiqRgvELZEZgw
 ofiAbMScdf0/jQ3hSJSbhdbyxxp+89hmduPl29UJkD3j5yjZIA2oA3utstDuUPtm30kcNJ2NI
 AEpPoyKYgCNnf97kHPdp1Uf/8oQaNKSuL2GSU7i1kanybJcWX92AmB7WnD8qEDsFhNMa+qvNh
 34zxoGTz9YXc71+JnkFdEzavB8jJ71oGjZQEyIqmVJul7tkc2xaHpvdaYzvZJtqizzuYywi9b
 pmARFGfViQU2mhSrJBpKFBrCKLb0wWNmF0m5aRNkRDJwVd/3z0KNMOf0BI1jwHOgRzSEdQVco
 ADciMXWq4KfrjGF0EEwGeCtpqnzNQDgvUFTcPeCidp9+0adoL4ix/8b93qp9QHTvWWAhA4/FA
 6JvEn8s91+CGmsJHeiaYENY0Jv8agE7mfyl3oBL5Mb58IBlisMXxcuC+9rg4n5p748+CJeOGz
 qTtkI6v8tx4SYiqCYJj8XUaj8ngKL+61rXJ179AupfW54rlYDICkwor5FIlIPNlAkuLI08Zyi
 hH3QuzvF6ZnbyifOy8xqY7TowWpvLvkO9Kf0VpmcUQiaSqBfasmMKGqZx/aqTRu8wPdqfGtxp
 jdhCKQzx1dqD+Y2etSM1KPr1abmF+GoPrusLcbicfouDBPZ/ixNoXiz1OgyI/+YcTVoTSk9za
 0Az7W/wQ5bG+RSNvuyrwEEmmxrnCMXsC0gQ1MKUz7BonL1WklSo8HDdkDymkbhnNY/hsSij1f
 AmTRuwuSKiFQreqJXHEUlB8/vhXxvRMQd1j0oU3MZWbX8iTx/wFv4KtanhxyeN15RwYaoon6c
 qBciYRn8Rg9RNO8tUTbLHNCvyJhk+73r5JopIHEvYsY5Pk8ZyaEeVloh7InU3IvkdRVd3deDg
 cjYxvXEdMto71IAA8WdQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ubd code suffers from a possible y2038 overflow on 32-bit
architectures, both for the cow header and the os_file_modtime()
function.

Replace time_t with time64_t to extend the ubd_kern side as much
as possible.

Whether this makes a difference for the user side depends on
the host libc implementation that may use either 32-bit or 64-bit
time_t.

For the cow file format, the header contains an unsigned 32-bit
timestamp, which is good until y2106, passing this through a
'long long' gives us a consistent interpretation between 32-bit
and 64-bit um kernels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/um/drivers/cow.h       |  2 +-
 arch/um/drivers/cow_user.c  |  7 ++++---
 arch/um/drivers/ubd_kern.c  | 10 +++++-----
 arch/um/include/shared/os.h |  2 +-
 arch/um/os-Linux/file.c     |  2 +-
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/um/drivers/cow.h b/arch/um/drivers/cow.h
index 760c507dd5b6..103adac691ed 100644
--- a/arch/um/drivers/cow.h
+++ b/arch/um/drivers/cow.h
@@ -11,7 +11,7 @@ extern int init_cow_file(int fd, char *cow_file, char *backing_file,
 extern int file_reader(__u64 offset, char *buf, int len, void *arg);
 extern int read_cow_header(int (*reader)(__u64, char *, int, void *),
 			   void *arg, __u32 *version_out,
-			   char **backing_file_out, time_t *mtime_out,
+			   char **backing_file_out, long long *mtime_out,
 			   unsigned long long *size_out, int *sectorsize_out,
 			   __u32 *align_out, int *bitmap_offset_out);
 
diff --git a/arch/um/drivers/cow_user.c b/arch/um/drivers/cow_user.c
index 74b0c2686c95..29b46581ddd1 100644
--- a/arch/um/drivers/cow_user.c
+++ b/arch/um/drivers/cow_user.c
@@ -17,6 +17,7 @@
 
 #define PATH_LEN_V1 256
 
+/* unsigned time_t works until year 2106 */
 typedef __u32 time32_t;
 
 struct cow_header_v1 {
@@ -197,7 +198,7 @@ int write_cow_header(char *cow_file, int fd, char *backing_file,
 		     int sectorsize, int alignment, unsigned long long *size)
 {
 	struct cow_header_v3 *header;
-	unsigned long modtime;
+	long long modtime;
 	int err;
 
 	err = cow_seek_file(fd, 0);
@@ -276,7 +277,7 @@ int file_reader(__u64 offset, char *buf, int len, void *arg)
 
 int read_cow_header(int (*reader)(__u64, char *, int, void *), void *arg,
 		    __u32 *version_out, char **backing_file_out,
-		    time_t *mtime_out, unsigned long long *size_out,
+		    long long *mtime_out, unsigned long long *size_out,
 		    int *sectorsize_out, __u32 *align_out,
 		    int *bitmap_offset_out)
 {
@@ -363,7 +364,7 @@ int read_cow_header(int (*reader)(__u64, char *, int, void *), void *arg,
 
 		/*
 		 * this was used until Dec2005 - 64bits are needed to represent
-		 * 2038+. I.e. we can safely do this truncating cast.
+		 * 2106+. I.e. we can safely do this truncating cast.
 		 *
 		 * Additionally, we must use be32toh() instead of be64toh(), since
 		 * the program used to use the former (tested - I got mtime
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 6627d7c30f37..dcabb463e011 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -561,7 +561,7 @@ static inline int ubd_file_size(struct ubd *ubd_dev, __u64 *size_out)
 	__u32 version;
 	__u32 align;
 	char *backing_file;
-	time_t mtime;
+	time64_t mtime;
 	unsigned long long size;
 	int sector_size;
 	int bitmap_offset;
@@ -600,9 +600,9 @@ static int read_cow_bitmap(int fd, void *buf, int offset, int len)
 	return 0;
 }
 
-static int backing_file_mismatch(char *file, __u64 size, time_t mtime)
+static int backing_file_mismatch(char *file, __u64 size, time64_t mtime)
 {
-	unsigned long modtime;
+	time64_t modtime;
 	unsigned long long actual;
 	int err;
 
@@ -628,7 +628,7 @@ static int backing_file_mismatch(char *file, __u64 size, time_t mtime)
 		return -EINVAL;
 	}
 	if (modtime != mtime) {
-		printk(KERN_ERR "mtime mismatch (%ld vs %ld) of COW header vs "
+		printk(KERN_ERR "mtime mismatch (%lld vs %lld) of COW header vs "
 		       "backing file\n", mtime, modtime);
 		return -EINVAL;
 	}
@@ -671,7 +671,7 @@ static int open_ubd_file(char *file, struct openflags *openflags, int shared,
 		  unsigned long *bitmap_len_out, int *data_offset_out,
 		  int *create_cow_out)
 {
-	time_t mtime;
+	time64_t mtime;
 	unsigned long long size;
 	__u32 version, align;
 	char *backing_file;
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 506bcd1bca68..0f30204b6afa 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -150,7 +150,7 @@ extern int os_sync_file(int fd);
 extern int os_file_size(const char *file, unsigned long long *size_out);
 extern int os_pread_file(int fd, void *buf, int len, unsigned long long offset);
 extern int os_pwrite_file(int fd, const void *buf, int count, unsigned long long offset);
-extern int os_file_modtime(const char *file, unsigned long *modtime);
+extern int os_file_modtime(const char *file, long long *modtime);
 extern int os_pipe(int *fd, int stream, int close_on_exec);
 extern int os_set_fd_async(int fd);
 extern int os_clear_fd_async(int fd);
diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index 5133e3afb96f..fbda10535dab 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -341,7 +341,7 @@ int os_file_size(const char *file, unsigned long long *size_out)
 	return 0;
 }
 
-int os_file_modtime(const char *file, unsigned long *modtime)
+int os_file_modtime(const char *file, long long *modtime)
 {
 	struct uml_stat buf;
 	int err;
-- 
2.20.0

