Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A0CC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76E052077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfH0LOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:14:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:4154 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfH0LOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 07:14:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 04:14:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; 
   d="scan'208";a="197290955"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Aug 2019 04:14:38 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] modpost: add guid_t type definition
Date:   Tue, 27 Aug 2019 14:14:37 +0300
Message-Id: <20190827111437.22000-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since guid_t is the recommended data type for UUIDs in
kernel (and I guess uuid_le is meant to be ultimately
replaced with it), it should be made available here as
well.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 scripts/mod/file2alias.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index e17a29ae2e97..c91eba751804 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -34,6 +34,11 @@ typedef Elf64_Addr	kernel_ulong_t;
 typedef uint32_t	__u32;
 typedef uint16_t	__u16;
 typedef unsigned char	__u8;
+typedef struct {
+	__u8 b[16];
+} guid_t;
+
+/* backwards compatibility, don't use in new code */
 typedef struct {
 	__u8 b[16];
 } uuid_le;
-- 
2.23.0.rc1

