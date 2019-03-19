Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E1EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C983120854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfCSGT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:19:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:14405 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfCSGT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 02:19:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 23:19:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,496,1544515200"; 
   d="scan'208";a="156246127"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga001.fm.intel.com with ESMTP; 18 Mar 2019 23:19:26 -0700
Subject: [PATCH 6/6] security/keys/encrypted: Drop export of
 key_type_encrypted
From:   Dan Williams <dan.j.williams@intel.com>
To:     keyrings@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, vishal.l.verma@intel.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Mon, 18 Mar 2019 23:06:47 -0700
Message-ID: <155297560738.2276575.13044997734939158888.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Now that all users lookup the key type by name, drop the export and the
direct module dependency.

Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/keys/encrypted-type.h            |    2 --
 security/keys/encrypted-keys/encrypted.c |    3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/keys/encrypted-type.h b/include/keys/encrypted-type.h
index 1d4541370a64..dd509835b4a4 100644
--- a/include/keys/encrypted-type.h
+++ b/include/keys/encrypted-type.h
@@ -33,6 +33,4 @@ struct encrypted_key_payload {
 	u8 payload_data[0];	/* payload data + datablob + hmac */
 };
 
-extern struct key_type key_type_encrypted;
-
 #endif /* _KEYS_ENCRYPTED_TYPE_H */
diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 06925d3b30c9..c3999d5e2a19 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -1012,7 +1012,7 @@ static void encrypted_destroy(struct key *key)
 	kzfree(key->payload.data[0]);
 }
 
-struct key_type key_type_encrypted = {
+static struct key_type key_type_encrypted = {
 	.name = "encrypted",
 	.instantiate = encrypted_instantiate,
 	.update = encrypted_update,
@@ -1020,7 +1020,6 @@ struct key_type key_type_encrypted = {
 	.describe = user_describe,
 	.read = encrypted_read,
 };
-EXPORT_SYMBOL_GPL(key_type_encrypted);
 
 static int __init init_encrypted(void)
 {

