Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF2AC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499A7216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 13:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="lT3K8iGu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfGENGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 09:06:13 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:55808 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfGENGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 09:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1562331970; x=1593867970;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=gr+jHs2P9slbOJzlaTIBJ8oHFdN9MnXXYOlvOopA2Lw=;
  b=lT3K8iGuLYgUW7lVQ7m6OeuElmRwFO8BxdvnkVayGxnxgM3bo2WiF+GN
   aUJ3f/o8np5S5nTKyZnFONZola68C9zTPZSHBQNlM/Iw8aiaH9LbtXu/1
   rQQH5VXbWN+RycHnv2fs1d2vti17uRJUUyoBg6xnPpCkQ/fSA3XLGvwGX
   g=;
X-IronPort-AV: E=Sophos;i="5.62,455,1554768000"; 
   d="scan'208";a="683899861"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 05 Jul 2019 13:06:08 +0000
Received: from EX13MTAUEB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 89365221B7C;
        Fri,  5 Jul 2019 13:06:09 +0000 (UTC)
Received: from EX13D08UEB002.ant.amazon.com (10.43.60.107) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.96) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 5 Jul 2019 13:06:09 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D08UEB002.ant.amazon.com (10.43.60.107) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 5 Jul 2019 13:06:08 +0000
Received: from uc1a35a69ae4659.ant.amazon.com (10.95.119.169) by
 mail-relay.amazon.com (10.43.60.129) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Fri, 5 Jul 2019 13:06:07 +0000
From:   Norbert Manthey <nmanthey@amazon.de>
To:     Norbert Manthey <nmanthey@amazon.de>,
        <linux-kernel@vger.kernel.org>
CC:     David Woodhouse <dwmw@amazon.co.uk>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        "Tony Luck" <tony.luck@intel.com>
Subject: [PATCH pstore fix v1] pstore: fix use after free
Date:   Fri, 5 Jul 2019 15:06:00 +0200
Message-ID: <1562331960-26198-1-git-send-email-nmanthey@amazon.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pstore_mkfile() function is passed a pointer to a struct
pstore_record. On success it consumes this 'record' pointer and
references it from the created inode.

On failure, however, it may or may not free the record. There are even
two different code paths which return -ENOMEM -- one of which does and
the other doesn't free the record.

Make the behaviour deterministic by never consuming and freeing the
record when returning failure, allowing the caller to do the cleanup
consistently.

Signed-off-by: Norbert Manthey <nmanthey@amazon.de>

---
 fs/pstore/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -333,7 +333,6 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	private = kzalloc(sizeof(*private), GFP_KERNEL);
 	if (!private)
 		goto fail_alloc;
-	private->record = record;
 
 	switch (record->type) {
 	case PSTORE_TYPE_DMESG:
@@ -387,6 +386,8 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
 	if (!dentry)
 		goto fail_private;
 
+	private->record = record;
+
 	inode->i_size = private->total_size = size;
 
 	inode->i_private = private;
-- 
2.7.4




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Ralf Herbrich
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



