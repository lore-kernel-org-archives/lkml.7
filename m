Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDAAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D9520854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfCSGTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:19:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:36887 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfCSGTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 02:19:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 23:19:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,496,1544515200"; 
   d="scan'208";a="132778389"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga008.fm.intel.com with ESMTP; 18 Mar 2019 23:19:15 -0700
Subject: [PATCH 4/6] security/keys/ecryptfs: Drop direct dependency on
 key_type_encrypted
From:   Dan Williams <dan.j.williams@intel.com>
To:     keyrings@vger.kernel.org
Cc:     Tyler Hicks <tyhicks@canonical.com>, ecryptfs@vger.kernel.org,
        vishal.l.verma@intel.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Mar 2019 23:06:36 -0700
Message-ID: <155297559625.2276575.11539296499176067525.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155297557534.2276575.16264199708584900090.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lookup the key type by name and protect ecryptfs from encrypted_keys.ko
module load failures, and cleanup the configuration dependencies on the
definition of the ecryptfs_get_encrypted_key() helper.

Cc: Tyler Hicks <tyhicks@canonical.com>
Cc: <ecryptfs@vger.kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 fs/ecryptfs/ecryptfs_kernel.h |   22 +---------------------
 fs/ecryptfs/keystore.c        |   12 ++++++++++++
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/fs/ecryptfs/ecryptfs_kernel.h b/fs/ecryptfs/ecryptfs_kernel.h
index e74cb2a0b299..3106d23d95f0 100644
--- a/fs/ecryptfs/ecryptfs_kernel.h
+++ b/fs/ecryptfs/ecryptfs_kernel.h
@@ -87,13 +87,12 @@ struct ecryptfs_page_crypt_context {
 	} param;
 };
 
-#if defined(CONFIG_ENCRYPTED_KEYS) || defined(CONFIG_ENCRYPTED_KEYS_MODULE)
 static inline struct ecryptfs_auth_tok *
 ecryptfs_get_encrypted_key_payload_data(struct key *key)
 {
 	struct encrypted_key_payload *payload;
 
-	if (key->type != &key_type_encrypted)
+	if (strcmp(key->type->name, "encrypted") != 0)
 		return NULL;
 
 	payload = key->payload.data[0];
@@ -103,25 +102,6 @@ ecryptfs_get_encrypted_key_payload_data(struct key *key)
 	return (struct ecryptfs_auth_tok *)payload->payload_data;
 }
 
-static inline struct key *ecryptfs_get_encrypted_key(char *sig)
-{
-	return request_key(&key_type_encrypted, sig, NULL);
-}
-
-#else
-static inline struct ecryptfs_auth_tok *
-ecryptfs_get_encrypted_key_payload_data(struct key *key)
-{
-	return NULL;
-}
-
-static inline struct key *ecryptfs_get_encrypted_key(char *sig)
-{
-	return ERR_PTR(-ENOKEY);
-}
-
-#endif /* CONFIG_ENCRYPTED_KEYS */
-
 static inline struct ecryptfs_auth_tok *
 ecryptfs_get_key_payload_data(struct key *key)
 {
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index e74fe84d0886..52a01dd57f4a 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -1619,6 +1619,17 @@ parse_tag_11_packet(unsigned char *data, unsigned char *contents,
 	return rc;
 }
 
+static struct key *ecryptfs_get_encrypted_key(char *sig)
+{
+	struct key_type *type;
+	struct key *key;
+
+	type = key_type_lookup("encrypted");
+	if (IS_ERR(type))
+		return (struct key *) type;
+	return request_key(type, sig, NULL);
+}
+
 int ecryptfs_keyring_auth_tok_for_sig(struct key **auth_tok_key,
 				      struct ecryptfs_auth_tok **auth_tok,
 				      char *sig)
@@ -2542,3 +2553,4 @@ ecryptfs_add_global_auth_tok(struct ecryptfs_mount_crypt_stat *mount_crypt_stat,
 	return 0;
 }
 
+MODULE_SOFTDEP("pre: encrypted_keys");

