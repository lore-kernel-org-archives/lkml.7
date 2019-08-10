Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EFFC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 20:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2432220B7C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 20:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfHJUqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 16:46:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55342 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726899AbfHJUoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 16:44:07 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hwYDc-00053r-92; Sat, 10 Aug 2019 21:44:04 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hwYDK-0003cq-Un; Sat, 10 Aug 2019 21:43:46 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Max Filippov" <jcmvbkbc@gmail.com>
Date:   Sat, 10 Aug 2019 21:40:07 +0100
Message-ID: <lsq.1565469607.887281316@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 067/157] xtensa: fix return_address
In-Reply-To: <lsq.1565469607.188083258@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.72-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Max Filippov <jcmvbkbc@gmail.com>

commit ada770b1e74a77fff2d5f539bf6c42c25f4784db upstream.

return_address returns the address that is one level higher in the call
stack than requested in its argument, because level 0 corresponds to its
caller's return address. Use requested level as the number of stack
frames to skip.

This fixes the address reported by might_sleep and friends.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/xtensa/kernel/stacktrace.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/xtensa/kernel/stacktrace.c
+++ b/arch/xtensa/kernel/stacktrace.c
@@ -107,10 +107,14 @@ static int return_address_cb(struct stac
 	return 1;
 }
 
+/*
+ * level == 0 is for the return address from the caller of this function,
+ * not from this function itself.
+ */
 unsigned long return_address(unsigned level)
 {
 	struct return_addr_data r = {
-		.skip = level + 1,
+		.skip = level,
 	};
 	walk_stackframe(stack_pointer(NULL), return_address_cb, &r);
 	return r.addr;

