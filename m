Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5487AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BB820663
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dtYrwZZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfLJLeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:34:36 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:35284 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfLJLec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575977672; x=1607513672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SKfQoX2A8rZ0EnP2XkyIWyJjMF/So/eVFwUYzJEpgTw=;
  b=dtYrwZZkF/0xOh/4jeA7vHw3mTCAqC9RmbNcNXqhi1bAUHt5+ylULzw+
   zGA8JghD+nq+kwj7JtoZE1ofrwryd5CxM5d2eMhVq4mvJ8lwb30LwHWy7
   dq+wz+S35R2kRMGAfyhsxYxQUVdpX/PzzSqXMFybDHmKEpDY5fNGhYy+L
   Y=;
IronPort-SDR: vewG7bUB+/omNwoB9Ygkc4A38bNyqW2e/VrOCzOaaGd4TY8FDadyuilEJ/ZdAM7WPMm0aG8e+l
 FNzqIDT2rUYQ==
X-IronPort-AV: E=Sophos;i="5.69,299,1571702400"; 
   d="scan'208";a="14008117"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 10 Dec 2019 11:34:13 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id EC26DA11A3;
        Tue, 10 Dec 2019 11:34:12 +0000 (UTC)
Received: from EX13D32EUC001.ant.amazon.com (10.43.164.159) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Dec 2019 11:34:12 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D32EUC001.ant.amazon.com (10.43.164.159) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Dec 2019 11:34:11 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 10 Dec 2019 11:34:09 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
CC:     Paul Durrant <pdurrant@amazon.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>
Subject: [PATCH v2 3/4] xen/interface: re-define FRONT/BACK_RING_ATTACH()
Date:   Tue, 10 Dec 2019 11:33:46 +0000
Message-ID: <20191210113347.3404-4-pdurrant@amazon.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210113347.3404-1-pdurrant@amazon.com>
References: <20191210113347.3404-1-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently these macros are defined to re-initialize a front/back ring
(respectively) to values read from the shared ring in such a way that any
requests/responses that are added to the shared ring whilst the front/back
is detached will be skipped over. This, in general, is not a desirable
semantic since most frontend implementations will eventually block waiting
for a response which would either never appear or never be processed.

Since the macros are currently unused, take this opportunity to re-define
them to re-initialize a front/back ring using specified values. This also
allows FRONT/BACK_RING_INIT() to be re-defined in terms of
FRONT/BACK_RING_ATTACH() using a specified value of 0.

NOTE: BACK_RING_ATTACH() will be used directly in a subsequent patch.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>

A patch to add the FRONT/BACK_RING_ATTACH() macros to the canonical
ring.h in xen.git will be sent once the definitions have been agreed.

v2:
 - change definitions to take explicit initial index values
---
 include/xen/interface/io/ring.h | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/include/xen/interface/io/ring.h b/include/xen/interface/io/ring.h
index 3f40501fc60b..2af7a1cd6658 100644
--- a/include/xen/interface/io/ring.h
+++ b/include/xen/interface/io/ring.h
@@ -125,35 +125,24 @@ struct __name##_back_ring {						\
     memset((_s)->pad, 0, sizeof((_s)->pad));				\
 } while(0)
 
-#define FRONT_RING_INIT(_r, _s, __size) do {				\
-    (_r)->req_prod_pvt = 0;						\
-    (_r)->rsp_cons = 0;							\
+#define FRONT_RING_ATTACH(_r, _s, _i, __size) do {			\
+    (_r)->req_prod_pvt = (_i);						\
+    (_r)->rsp_cons = (_i);						\
     (_r)->nr_ents = __RING_SIZE(_s, __size);				\
     (_r)->sring = (_s);							\
 } while (0)
 
-#define BACK_RING_INIT(_r, _s, __size) do {				\
-    (_r)->rsp_prod_pvt = 0;						\
-    (_r)->req_cons = 0;							\
-    (_r)->nr_ents = __RING_SIZE(_s, __size);				\
-    (_r)->sring = (_s);							\
-} while (0)
+#define FRONT_RING_INIT(_r, _s, __size) FRONT_RING_ATTACH(_r, _s, 0, __size)
 
-/* Initialize to existing shared indexes -- for recovery */
-#define FRONT_RING_ATTACH(_r, _s, __size) do {				\
-    (_r)->sring = (_s);							\
-    (_r)->req_prod_pvt = (_s)->req_prod;				\
-    (_r)->rsp_cons = (_s)->rsp_prod;					\
+#define BACK_RING_ATTACH(_r, _s, _i, __size) do {			\
+    (_r)->rsp_prod_pvt = (_i);						\
+    (_r)->req_cons = (_i);						\
     (_r)->nr_ents = __RING_SIZE(_s, __size);				\
-} while (0)
-
-#define BACK_RING_ATTACH(_r, _s, __size) do {				\
     (_r)->sring = (_s);							\
-    (_r)->rsp_prod_pvt = (_s)->rsp_prod;				\
-    (_r)->req_cons = (_s)->req_prod;					\
-    (_r)->nr_ents = __RING_SIZE(_s, __size);				\
 } while (0)
 
+#define BACK_RING_INIT(_r, _s, __size) BACK_RING_ATTACH(_r, _s, 0, __size)
+
 /* How big is this ring? */
 #define RING_SIZE(_r)							\
     ((_r)->nr_ents)
-- 
2.20.1

