Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697E7C33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3471D206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlI4isnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgAGV3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:29:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52547 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbgAGV3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:29:19 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so353848wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 13:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=il47Qaoxkofy17X7+bzOZWDigRYu2X2xwLI0Lansj0w=;
        b=FlI4isnQ6IJqUxyJO4HzXV+32BNwtv1l+iSc986DO2DP2YJcJxaSvp4j/PyqcYxjH8
         LThTT+IN92k4fkuDSUf/XBI00ElmHB6IDNWQ2+UBXUUkLlozzlccpnj1Pl3rUSRLJUzp
         w9QTluYfa0U7Kon8YJPjdLrbEc9Ydtk04pMYb0Jab6ZtVMEQEn71WI/0mZ5T8U4cEhQJ
         chxicRrSDP8Y0bMp7jbMRcWN5XFRiSIKHo662zhRVGOo1TpMZxDIlcfSP13LvqnE2RTk
         nntbyB1P1RX7w8nX5zlmLyDX0/FFK4ow7drrSd4pv36erIbYnoLVzmO3d2lw0ZC6p3o7
         VfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=il47Qaoxkofy17X7+bzOZWDigRYu2X2xwLI0Lansj0w=;
        b=PZGoK0CdAyYVeQcBLlwUWyJwx/ea9A/11sTztv9RSI/sIIdJJw69Ssw3cLWz5h/5Fd
         1ZW/c6UbRQ7EMbpSstZ+CFzwh0i5suOdVUPZPld4SQ7HYIyg0Q5TrjAHFIUIyPWzKQG5
         HKdNBEr/ODcIyyfU2E9MgDf7ehokr7WEMoOwFpxu5eywxh6g1ynC0PFjO5c9bTWG9UfS
         riBpd13ysmp6szf6qeuxHlvaejaXdvWe2Hf8mUKePv7x4AJldKJ8ood0BuMXQBX7+Gh3
         0GFoBB1nr/Ti0cHnQcfSioPAjhjiwsNFrrQLLYoODC836CVLjOg/8g5Cc1QM8wnTJd9Z
         /SOA==
X-Gm-Message-State: APjAAAWvtvo1kb3/EotNMIW2qWJvUNIT/U2dppYyPJOtWnbe8ySqR8At
        EIDMO/KQGIHVIvBxzxjgyua4Q8xn
X-Google-Smtp-Source: APXvYqx14OaLtbMbD+U3ZI4s5ajyafmbheRbOz7pvmkvfH39jBHtlunbwUHbSEMf9+/Y4IyHsHDZzA==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr328533wmi.166.1578432556841;
        Tue, 07 Jan 2020 13:29:16 -0800 (PST)
Received: from Pali-Latitude.lan (ip-89-103-160-142.net.upcbroadband.cz. [89.103.160.142])
        by smtp.gmail.com with ESMTPSA id f1sm1449144wru.6.2020.01.07.13.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 13:29:16 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: [PATCH 2/3] udf: Move OSTA Identifier Suffix macros from ecma_167.h to osta_udf.h
Date:   Tue,  7 Jan 2020 22:29:03 +0100
Message-Id: <20200107212904.30471-2-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200107212904.30471-1-pali.rohar@gmail.com>
References: <20200107134425.GE25547@quack2.suse.cz>
 <20200107212904.30471-1-pali.rohar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename structure name and its members to match naming convention and fix
endianity type for UDFRevision member. Also remove duplicate definition of
UDF_ID_COMPLIANT which is already in osta_udf.h.

Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
---
 fs/udf/ecma_167.h | 14 --------------
 fs/udf/osta_udf.h | 10 ++++++++--
 fs/udf/super.c    |  8 ++++----
 3 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/fs/udf/ecma_167.h b/fs/udf/ecma_167.h
index e7b889e01..c98d5dc90 100644
--- a/fs/udf/ecma_167.h
+++ b/fs/udf/ecma_167.h
@@ -88,20 +88,6 @@ struct regid {
 #define ENTITYID_FLAGS_DIRTY		0x00
 #define ENTITYID_FLAGS_PROTECTED	0x01
 
-/* OSTA UDF 2.1.5.2 */
-#define UDF_ID_COMPLIANT "*OSTA UDF Compliant"
-
-/* OSTA UDF 2.1.5.3 */
-struct domainEntityIDSuffix {
-	uint16_t	revision;
-	uint8_t		flags;
-	uint8_t		reserved[5];
-};
-
-/* OSTA UDF 2.1.5.3 */
-#define ENTITYIDSUFFIX_FLAGS_HARDWRITEPROTECT 0
-#define ENTITYIDSUFFIX_FLAGS_SOFTWRITEPROTECT 1
-
 /* Volume Structure Descriptor (ECMA 167r3 2/9.1) */
 #define VSD_STD_ID_LEN			5
 struct volStructDesc {
diff --git a/fs/udf/osta_udf.h b/fs/udf/osta_udf.h
index a4da59e38..c9117eb41 100644
--- a/fs/udf/osta_udf.h
+++ b/fs/udf/osta_udf.h
@@ -62,8 +62,14 @@
 #define UDF_ID_METADATA			"*UDF Metadata Partition"
 
 /* Identifier Suffix (UDF 2.50 2.1.5.3) */
-#define IS_DF_HARD_WRITE_PROTECT	0x01
-#define IS_DF_SOFT_WRITE_PROTECT	0x02
+#define DOMAIN_FLAGS_HARD_WRITE_PROTECT	0x01
+#define DOMAIN_FLAGS_SOFT_WRITE_PROTECT	0x02
+
+struct domainIdentSuffix {
+	__le16		UDFRevision;
+	uint8_t		domainFlags;
+	uint8_t		reserved[5];
+} __packed;
 
 struct UDFIdentSuffix {
 	__le16		UDFRevision;
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 8c28e93e9..2d0b90800 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -767,7 +767,7 @@ static int udf_check_vsd(struct super_block *sb)
 static int udf_verify_domain_identifier(struct super_block *sb,
 					struct regid *ident, char *dname)
 {
-	struct domainEntityIDSuffix *suffix;
+	struct domainIdentSuffix *suffix;
 
 	if (memcmp(ident->ident, UDF_ID_COMPLIANT, strlen(UDF_ID_COMPLIANT))) {
 		udf_warn(sb, "Not OSTA UDF compliant %s descriptor.\n", dname);
@@ -778,9 +778,9 @@ static int udf_verify_domain_identifier(struct super_block *sb,
 			 dname);
 		goto force_ro;
 	}
-	suffix = (struct domainEntityIDSuffix *)ident->identSuffix;
-	if (suffix->flags & (1 << ENTITYIDSUFFIX_FLAGS_HARDWRITEPROTECT) ||
-	    suffix->flags & (1 << ENTITYIDSUFFIX_FLAGS_SOFTWRITEPROTECT)) {
+	suffix = (struct domainIdentSuffix *)ident->identSuffix;
+	if ((suffix->domainFlags & DOMAIN_FLAGS_HARD_WRITE_PROTECT) ||
+	    (suffix->domainFlags & DOMAIN_FLAGS_SOFT_WRITE_PROTECT)) {
 		if (!sb_rdonly(sb)) {
 			udf_warn(sb, "Descriptor for %s marked write protected."
 				 " Forcing read only mount.\n", dname);
-- 
2.20.1

