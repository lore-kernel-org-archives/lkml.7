Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F12C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0F42465B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="e/zfhcrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfLEOBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:01:54 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:10787 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfLEOBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:01:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575554511; x=1607090511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3V/slw6i8lEhvkIzZyT6X8o1Z4Oo4kiWfC2gC+XC92E=;
  b=e/zfhcrUs8YBDAcPMluZdoedp8ptazW6MdTWmvv2n3Gp2I5YgJvGgH2M
   OB/zj+lT2rtlUaewmWpgAYpSIZJnmQ+tu6XhvuLlyCvjbaVLY9DczknB4
   nEiD7Aw0hg3TGgQKqVC5m1fHPhyoA9TCsGiKtgHHwbEUG5FChFofWLHA1
   8=;
IronPort-SDR: jZ7e9uzRrTtrcEfwO8IvA3gzi/yT0CgX020KZM87+W0LUhDIm/3rcRxMA2UpgNXRQmt4BPG2e6
 WcmrHkejHKfA==
X-IronPort-AV: E=Sophos;i="5.69,281,1571702400"; 
   d="scan'208";a="11809799"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 05 Dec 2019 14:01:42 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id F0512A283A;
        Thu,  5 Dec 2019 14:01:41 +0000 (UTC)
Received: from EX13D32EUC001.ant.amazon.com (10.43.164.159) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 14:01:41 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D32EUC001.ant.amazon.com (10.43.164.159) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 14:01:39 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 5 Dec 2019 14:01:38 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>
CC:     Paul Durrant <pdurrant@amazon.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>
Subject: [PATCH 3/4] xen/interface: don't discard pending work in FRONT/BACK_RING_ATTACH
Date:   Thu, 5 Dec 2019 14:01:22 +0000
Message-ID: <20191205140123.3817-4-pdurrant@amazon.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191205140123.3817-1-pdurrant@amazon.com>
References: <20191205140123.3817-1-pdurrant@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently these macros will skip over any requests/responses that are
added to the shared ring whilst it is detached. This, in general, is not
a desirable semantic since most frontend implementations will eventually
block waiting for a response which would either never appear or never be
processed.

NOTE: These macros are currently unused. BACK_RING_ATTACH(), however, will
      be used in a subsequent patch.

Signed-off-by: Paul Durrant <pdurrant@amazon.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
---
 include/xen/interface/io/ring.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/xen/interface/io/ring.h b/include/xen/interface/io/ring.h
index 3f40501fc60b..405adfed87e6 100644
--- a/include/xen/interface/io/ring.h
+++ b/include/xen/interface/io/ring.h
@@ -143,14 +143,14 @@ struct __name##_back_ring {						\
 #define FRONT_RING_ATTACH(_r, _s, __size) do {				\
     (_r)->sring = (_s);							\
     (_r)->req_prod_pvt = (_s)->req_prod;				\
-    (_r)->rsp_cons = (_s)->rsp_prod;					\
+    (_r)->rsp_cons = (_s)->req_prod;					\
     (_r)->nr_ents = __RING_SIZE(_s, __size);				\
 } while (0)
 
 #define BACK_RING_ATTACH(_r, _s, __size) do {				\
     (_r)->sring = (_s);							\
     (_r)->rsp_prod_pvt = (_s)->rsp_prod;				\
-    (_r)->req_cons = (_s)->req_prod;					\
+    (_r)->req_cons = (_s)->rsp_prod;					\
     (_r)->nr_ents = __RING_SIZE(_s, __size);				\
 } while (0)
 
-- 
2.20.1

