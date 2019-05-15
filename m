Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE167C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB23020818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 16:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfEOQ0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 12:26:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45388 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbfEOQ0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 12:26:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ECAB728207;
        Wed, 15 May 2019 16:26:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20BDC5C28E;
        Wed, 15 May 2019 16:26:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 07/15] Add wait_var_event_interruptible()
From:   David Howells <dhowells@redhat.com>
To:     linux-afs@lists.infradead.org
Cc:     Peter Zijlstra <peterz@infradead.org>, dhowells@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 15 May 2019 17:26:28 +0100
Message-ID: <155793758837.31671.13765813674309502991.stgit@warthog.procyon.org.uk>
In-Reply-To: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
References: <155793753724.31671.7034451837854752319.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 15 May 2019 16:26:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add wait_var_event_interruptible() to allow interruptible waits for events.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Peter Zijlstra <peterz@infradead.org>
---

 include/linux/wait_bit.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 2b0072fa5e92..7dec36aecbd9 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -305,6 +305,19 @@ do {									\
 	__ret;								\
 })
 
+#define __wait_var_event_interruptible(var, condition)			\
+	___wait_var_event(var, condition, TASK_INTERRUPTIBLE, 0, 0,	\
+			  schedule())
+
+#define wait_var_event_interruptible(var, condition)			\
+({									\
+	int __ret = 0;							\
+	might_sleep();							\
+	if (!(condition))						\
+		__ret = __wait_var_event_interruptible(var, condition);	\
+	__ret;								\
+})
+
 /**
  * clear_and_wake_up_bit - clear a bit and wake up anyone waiting on that bit
  *

