Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29774C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA5121D71
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569928380;
	bh=cnuOxNodwOH0CfHGXqU1aCRAO2ZeJL4advytOcl2tWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L2GZRwyGB7SdHP+u3oHzf7AErtSqBj9HKDGTjg6+2g6TiD3N7WAsILXRmdOjw0nql
	 B/jQSS0ntbFF9sVSJBLEWnO8+DTRmHvTUpaR0oSUJ7tQEgmKSWWnJs26HJ96FMqdSt
	 akZyppc7HwSz7kbQJwLCBJQrtulQK7XlIkI2YmD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbfJALM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:12:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731480AbfJALM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:12:57 -0400
Received: from quaco.ghostprotocols.net (177.206.223.101.dynamic.adsl.gvt.net.br [177.206.223.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21FFB21A4A;
        Tue,  1 Oct 2019 11:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569928375;
        bh=cnuOxNodwOH0CfHGXqU1aCRAO2ZeJL4advytOcl2tWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EQ6idbzUA3FHFAZ+ftOY9qCKI14ZZFbuoWV94XIjnxv8NhR7sF4ubBwwNa5FFA1pn
         JHST+7W0hDsIeSAZDxs1Ia9p3KPCNdmPUnFqAYuaiSoAdLc9drLJomSBqNxItV13tP
         1samyT1VoJeLn5bZ3papLcQJm+lPNs3RVs9eEGcw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 07/24] tools headers uapi: Sync linux/fs.h with the kernel sources
Date:   Tue,  1 Oct 2019 08:11:59 -0300
Message-Id: <20191001111216.7208-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the changes from:

  78a1b96bcf7a ("fscrypt: add FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS ioctl")
  23c688b54016 ("fscrypt: allow unprivileged users to add/remove keys for v2 policies")
  5dae460c2292 ("fscrypt: v2 encryption policy support")
  5a7e29924dac ("fscrypt: add FS_IOC_GET_ENCRYPTION_KEY_STATUS ioctl")
  b1c0ec3599f4 ("fscrypt: add FS_IOC_REMOVE_ENCRYPTION_KEY ioctl")
  22d94f493bfb ("fscrypt: add FS_IOC_ADD_ENCRYPTION_KEY ioctl")
  3b6df59bc4d2 ("fscrypt: use FSCRYPT_* definitions, not FS_*")
  2336d0deb2d4 ("fscrypt: use FSCRYPT_ prefix for uapi constants")
  7af0ab0d3aab ("fs, fscrypt: move uapi definitions to new header <linux/fscrypt.h>")

That don't trigger any changes in tooling, as it so far is used only
for:

  $ grep -l 'fs\.h' tools/perf/trace/beauty/*.sh | xargs grep regex=
  tools/perf/trace/beauty/rename_flags.sh:regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+RENAME_([[:alnum:]_]+)[[:space:]]+\(1[[:space:]]*<<[[:space:]]*([[:xdigit:]]+)[[:space:]]*\)[[:space:]]*.*'
  tools/perf/trace/beauty/sync_file_range.sh:regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+SYNC_FILE_RANGE_([[:alnum:]_]+)[[:space:]]+([[:xdigit:]]+)[[:space:]]*.*'
  tools/perf/trace/beauty/usbdevfs_ioctl.sh:regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)(\(\w+\))?[[:space:]]+_IO[CWR]{0,2}\([[:space:]]*(_IOC_\w+,[[:space:]]*)?'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
  tools/perf/trace/beauty/usbdevfs_ioctl.sh:regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)[[:space:]]+_IO[WR]{0,2}\([[:space:]]*'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
  $

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/fs.h' differs from latest version at 'include/uapi/linux/fs.h'
  diff -u tools/include/uapi/linux/fs.h include/uapi/linux/fs.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-44g48exl9br9ba0t64chqb4i@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/fs.h      |  55 +--------
 tools/include/uapi/linux/fscrypt.h | 181 +++++++++++++++++++++++++++++
 tools/perf/check-headers.sh        |   1 +
 3 files changed, 186 insertions(+), 51 deletions(-)
 create mode 100644 tools/include/uapi/linux/fscrypt.h

diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index 2a616aa3f686..379a612f8f1d 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -13,6 +13,9 @@
 #include <linux/limits.h>
 #include <linux/ioctl.h>
 #include <linux/types.h>
+#ifndef __KERNEL__
+#include <linux/fscrypt.h>
+#endif
 
 /* Use of MS_* flags within the kernel is restricted to core mount(2) code. */
 #if !defined(__KERNEL__)
@@ -212,57 +215,6 @@ struct fsxattr {
 #define FS_IOC_GETFSLABEL		_IOR(0x94, 49, char[FSLABEL_MAX])
 #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
 
-/*
- * File system encryption support
- */
-/* Policy provided via an ioctl on the topmost directory */
-#define FS_KEY_DESCRIPTOR_SIZE	8
-
-#define FS_POLICY_FLAGS_PAD_4		0x00
-#define FS_POLICY_FLAGS_PAD_8		0x01
-#define FS_POLICY_FLAGS_PAD_16		0x02
-#define FS_POLICY_FLAGS_PAD_32		0x03
-#define FS_POLICY_FLAGS_PAD_MASK	0x03
-#define FS_POLICY_FLAG_DIRECT_KEY	0x04	/* use master key directly */
-#define FS_POLICY_FLAGS_VALID		0x07
-
-/* Encryption algorithms */
-#define FS_ENCRYPTION_MODE_INVALID		0
-#define FS_ENCRYPTION_MODE_AES_256_XTS		1
-#define FS_ENCRYPTION_MODE_AES_256_GCM		2
-#define FS_ENCRYPTION_MODE_AES_256_CBC		3
-#define FS_ENCRYPTION_MODE_AES_256_CTS		4
-#define FS_ENCRYPTION_MODE_AES_128_CBC		5
-#define FS_ENCRYPTION_MODE_AES_128_CTS		6
-#define FS_ENCRYPTION_MODE_SPECK128_256_XTS	7 /* Removed, do not use. */
-#define FS_ENCRYPTION_MODE_SPECK128_256_CTS	8 /* Removed, do not use. */
-#define FS_ENCRYPTION_MODE_ADIANTUM		9
-
-struct fscrypt_policy {
-	__u8 version;
-	__u8 contents_encryption_mode;
-	__u8 filenames_encryption_mode;
-	__u8 flags;
-	__u8 master_key_descriptor[FS_KEY_DESCRIPTOR_SIZE];
-};
-
-#define FS_IOC_SET_ENCRYPTION_POLICY	_IOR('f', 19, struct fscrypt_policy)
-#define FS_IOC_GET_ENCRYPTION_PWSALT	_IOW('f', 20, __u8[16])
-#define FS_IOC_GET_ENCRYPTION_POLICY	_IOW('f', 21, struct fscrypt_policy)
-
-/* Parameters for passing an encryption key into the kernel keyring */
-#define FS_KEY_DESC_PREFIX		"fscrypt:"
-#define FS_KEY_DESC_PREFIX_SIZE		8
-
-/* Structure that userspace passes to the kernel keyring */
-#define FS_MAX_KEY_SIZE			64
-
-struct fscrypt_key {
-	__u32 mode;
-	__u8 raw[FS_MAX_KEY_SIZE];
-	__u32 size;
-};
-
 /*
  * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
  *
@@ -306,6 +258,7 @@ struct fscrypt_key {
 #define FS_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
 #define FS_HUGE_FILE_FL			0x00040000 /* Reserved for ext4 */
 #define FS_EXTENT_FL			0x00080000 /* Extents */
+#define FS_VERITY_FL			0x00100000 /* Verity protected inode */
 #define FS_EA_INODE_FL			0x00200000 /* Inode used for large EA */
 #define FS_EOFBLOCKS_FL			0x00400000 /* Reserved for ext4 */
 #define FS_NOCOW_FL			0x00800000 /* Do not cow file */
diff --git a/tools/include/uapi/linux/fscrypt.h b/tools/include/uapi/linux/fscrypt.h
new file mode 100644
index 000000000000..39ccfe9311c3
--- /dev/null
+++ b/tools/include/uapi/linux/fscrypt.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * fscrypt user API
+ *
+ * These ioctls can be used on filesystems that support fscrypt.  See the
+ * "User API" section of Documentation/filesystems/fscrypt.rst.
+ */
+#ifndef _UAPI_LINUX_FSCRYPT_H
+#define _UAPI_LINUX_FSCRYPT_H
+
+#include <linux/types.h>
+
+/* Encryption policy flags */
+#define FSCRYPT_POLICY_FLAGS_PAD_4		0x00
+#define FSCRYPT_POLICY_FLAGS_PAD_8		0x01
+#define FSCRYPT_POLICY_FLAGS_PAD_16		0x02
+#define FSCRYPT_POLICY_FLAGS_PAD_32		0x03
+#define FSCRYPT_POLICY_FLAGS_PAD_MASK		0x03
+#define FSCRYPT_POLICY_FLAG_DIRECT_KEY		0x04
+#define FSCRYPT_POLICY_FLAGS_VALID		0x07
+
+/* Encryption algorithms */
+#define FSCRYPT_MODE_AES_256_XTS		1
+#define FSCRYPT_MODE_AES_256_CTS		4
+#define FSCRYPT_MODE_AES_128_CBC		5
+#define FSCRYPT_MODE_AES_128_CTS		6
+#define FSCRYPT_MODE_ADIANTUM			9
+#define __FSCRYPT_MODE_MAX			9
+
+/*
+ * Legacy policy version; ad-hoc KDF and no key verification.
+ * For new encrypted directories, use fscrypt_policy_v2 instead.
+ *
+ * Careful: the .version field for this is actually 0, not 1.
+ */
+#define FSCRYPT_POLICY_V1		0
+#define FSCRYPT_KEY_DESCRIPTOR_SIZE	8
+struct fscrypt_policy_v1 {
+	__u8 version;
+	__u8 contents_encryption_mode;
+	__u8 filenames_encryption_mode;
+	__u8 flags;
+	__u8 master_key_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
+};
+#define fscrypt_policy	fscrypt_policy_v1
+
+/*
+ * Process-subscribed "logon" key description prefix and payload format.
+ * Deprecated; prefer FS_IOC_ADD_ENCRYPTION_KEY instead.
+ */
+#define FSCRYPT_KEY_DESC_PREFIX		"fscrypt:"
+#define FSCRYPT_KEY_DESC_PREFIX_SIZE	8
+#define FSCRYPT_MAX_KEY_SIZE		64
+struct fscrypt_key {
+	__u32 mode;
+	__u8 raw[FSCRYPT_MAX_KEY_SIZE];
+	__u32 size;
+};
+
+/*
+ * New policy version with HKDF and key verification (recommended).
+ */
+#define FSCRYPT_POLICY_V2		2
+#define FSCRYPT_KEY_IDENTIFIER_SIZE	16
+struct fscrypt_policy_v2 {
+	__u8 version;
+	__u8 contents_encryption_mode;
+	__u8 filenames_encryption_mode;
+	__u8 flags;
+	__u8 __reserved[4];
+	__u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
+};
+
+/* Struct passed to FS_IOC_GET_ENCRYPTION_POLICY_EX */
+struct fscrypt_get_policy_ex_arg {
+	__u64 policy_size; /* input/output */
+	union {
+		__u8 version;
+		struct fscrypt_policy_v1 v1;
+		struct fscrypt_policy_v2 v2;
+	} policy; /* output */
+};
+
+/*
+ * v1 policy keys are specified by an arbitrary 8-byte key "descriptor",
+ * matching fscrypt_policy_v1::master_key_descriptor.
+ */
+#define FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR	1
+
+/*
+ * v2 policy keys are specified by a 16-byte key "identifier" which the kernel
+ * calculates as a cryptographic hash of the key itself,
+ * matching fscrypt_policy_v2::master_key_identifier.
+ */
+#define FSCRYPT_KEY_SPEC_TYPE_IDENTIFIER	2
+
+/*
+ * Specifies a key, either for v1 or v2 policies.  This doesn't contain the
+ * actual key itself; this is just the "name" of the key.
+ */
+struct fscrypt_key_specifier {
+	__u32 type;	/* one of FSCRYPT_KEY_SPEC_TYPE_* */
+	__u32 __reserved;
+	union {
+		__u8 __reserved[32]; /* reserve some extra space */
+		__u8 descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
+		__u8 identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
+	} u;
+};
+
+/* Struct passed to FS_IOC_ADD_ENCRYPTION_KEY */
+struct fscrypt_add_key_arg {
+	struct fscrypt_key_specifier key_spec;
+	__u32 raw_size;
+	__u32 __reserved[9];
+	__u8 raw[];
+};
+
+/* Struct passed to FS_IOC_REMOVE_ENCRYPTION_KEY */
+struct fscrypt_remove_key_arg {
+	struct fscrypt_key_specifier key_spec;
+#define FSCRYPT_KEY_REMOVAL_STATUS_FLAG_FILES_BUSY	0x00000001
+#define FSCRYPT_KEY_REMOVAL_STATUS_FLAG_OTHER_USERS	0x00000002
+	__u32 removal_status_flags;	/* output */
+	__u32 __reserved[5];
+};
+
+/* Struct passed to FS_IOC_GET_ENCRYPTION_KEY_STATUS */
+struct fscrypt_get_key_status_arg {
+	/* input */
+	struct fscrypt_key_specifier key_spec;
+	__u32 __reserved[6];
+
+	/* output */
+#define FSCRYPT_KEY_STATUS_ABSENT		1
+#define FSCRYPT_KEY_STATUS_PRESENT		2
+#define FSCRYPT_KEY_STATUS_INCOMPLETELY_REMOVED	3
+	__u32 status;
+#define FSCRYPT_KEY_STATUS_FLAG_ADDED_BY_SELF   0x00000001
+	__u32 status_flags;
+	__u32 user_count;
+	__u32 __out_reserved[13];
+};
+
+#define FS_IOC_SET_ENCRYPTION_POLICY		_IOR('f', 19, struct fscrypt_policy)
+#define FS_IOC_GET_ENCRYPTION_PWSALT		_IOW('f', 20, __u8[16])
+#define FS_IOC_GET_ENCRYPTION_POLICY		_IOW('f', 21, struct fscrypt_policy)
+#define FS_IOC_GET_ENCRYPTION_POLICY_EX		_IOWR('f', 22, __u8[9]) /* size + version */
+#define FS_IOC_ADD_ENCRYPTION_KEY		_IOWR('f', 23, struct fscrypt_add_key_arg)
+#define FS_IOC_REMOVE_ENCRYPTION_KEY		_IOWR('f', 24, struct fscrypt_remove_key_arg)
+#define FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS	_IOWR('f', 25, struct fscrypt_remove_key_arg)
+#define FS_IOC_GET_ENCRYPTION_KEY_STATUS	_IOWR('f', 26, struct fscrypt_get_key_status_arg)
+
+/**********************************************************************/
+
+/* old names; don't add anything new here! */
+#ifndef __KERNEL__
+#define FS_KEY_DESCRIPTOR_SIZE		FSCRYPT_KEY_DESCRIPTOR_SIZE
+#define FS_POLICY_FLAGS_PAD_4		FSCRYPT_POLICY_FLAGS_PAD_4
+#define FS_POLICY_FLAGS_PAD_8		FSCRYPT_POLICY_FLAGS_PAD_8
+#define FS_POLICY_FLAGS_PAD_16		FSCRYPT_POLICY_FLAGS_PAD_16
+#define FS_POLICY_FLAGS_PAD_32		FSCRYPT_POLICY_FLAGS_PAD_32
+#define FS_POLICY_FLAGS_PAD_MASK	FSCRYPT_POLICY_FLAGS_PAD_MASK
+#define FS_POLICY_FLAG_DIRECT_KEY	FSCRYPT_POLICY_FLAG_DIRECT_KEY
+#define FS_POLICY_FLAGS_VALID		FSCRYPT_POLICY_FLAGS_VALID
+#define FS_ENCRYPTION_MODE_INVALID	0	/* never used */
+#define FS_ENCRYPTION_MODE_AES_256_XTS	FSCRYPT_MODE_AES_256_XTS
+#define FS_ENCRYPTION_MODE_AES_256_GCM	2	/* never used */
+#define FS_ENCRYPTION_MODE_AES_256_CBC	3	/* never used */
+#define FS_ENCRYPTION_MODE_AES_256_CTS	FSCRYPT_MODE_AES_256_CTS
+#define FS_ENCRYPTION_MODE_AES_128_CBC	FSCRYPT_MODE_AES_128_CBC
+#define FS_ENCRYPTION_MODE_AES_128_CTS	FSCRYPT_MODE_AES_128_CTS
+#define FS_ENCRYPTION_MODE_SPECK128_256_XTS	7	/* removed */
+#define FS_ENCRYPTION_MODE_SPECK128_256_CTS	8	/* removed */
+#define FS_ENCRYPTION_MODE_ADIANTUM	FSCRYPT_MODE_ADIANTUM
+#define FS_KEY_DESC_PREFIX		FSCRYPT_KEY_DESC_PREFIX
+#define FS_KEY_DESC_PREFIX_SIZE		FSCRYPT_KEY_DESC_PREFIX_SIZE
+#define FS_MAX_KEY_SIZE			FSCRYPT_MAX_KEY_SIZE
+#endif /* !__KERNEL__ */
+
+#endif /* _UAPI_LINUX_FSCRYPT_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index e2e0f06c97d0..cea13cb987d0 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -8,6 +8,7 @@ include/uapi/drm/i915_drm.h
 include/uapi/linux/fadvise.h
 include/uapi/linux/fcntl.h
 include/uapi/linux/fs.h
+include/uapi/linux/fscrypt.h
 include/uapi/linux/kcmp.h
 include/uapi/linux/kvm.h
 include/uapi/linux/in.h
-- 
2.21.0

