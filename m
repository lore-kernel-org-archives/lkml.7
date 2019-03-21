Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45D3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA48A218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfCUWBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:01:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:53197 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbfCUWAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:00:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 15:00:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="216357243"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga001.jf.intel.com with ESMTP; 21 Mar 2019 15:00:23 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 6088030217F; Thu, 21 Mar 2019 15:00:23 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     x86@kernel.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>, dhowells@redhat.com,
        viro@zeniv.linux.org.uk
Subject: [PATCH 12/17] afs: Avoid section confusion in CM_NAME
Date:   Thu, 21 Mar 2019 15:00:04 -0700
Message-Id: <20190321220009.29334-13-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321220009.29334-1-andi@firstfloor.org>
References: <20190321220009.29334-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

__tracepoint_str cannot be const because the tracepoint_str
section is not read-only. Remove the stray const.

Cc: dhowells@redhat.com
Cc: viro@zeniv.linux.org.uk
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 fs/afs/cmservice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
index 8ee5972893ed..2f8acb4c556d 100644
--- a/fs/afs/cmservice.c
+++ b/fs/afs/cmservice.c
@@ -34,7 +34,7 @@ static void SRXAFSCB_TellMeAboutYourself(struct work_struct *);
 static int afs_deliver_yfs_cb_callback(struct afs_call *);
 
 #define CM_NAME(name) \
-	const char afs_SRXCB##name##_name[] __tracepoint_string =	\
+	char afs_SRXCB##name##_name[] __tracepoint_string =	\
 		"CB." #name
 
 /*
-- 
2.20.1

