Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C334C4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 20:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47ECF20856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 20:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfILUzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 16:55:16 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:49112 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727862AbfILUzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 16:55:16 -0400
Received: (qmail 6533 invoked by uid 2102); 12 Sep 2019 16:55:15 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Sep 2019 16:55:15 -0400
Date:   Thu, 12 Sep 2019 16:55:15 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
cc:     Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] checkpatch.pl: Don't complain about nominal authors if there
 isn't one
Message-ID: <Pine.LNX.4.44L0.1909121651180.1305-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch.pl shouldn't warn about a "Missing Signed-off-by: line by
nominal patch author" if there is no nominal patch author.  Without
this change, checkpatch always gives me the following warning:

	WARNING: Missing Signed-off-by: line by nominal patch author ''

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

 scripts/checkpatch.pl |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: usb-devel/scripts/checkpatch.pl
===================================================================
--- usb-devel.orig/scripts/checkpatch.pl
+++ usb-devel/scripts/checkpatch.pl
@@ -6673,7 +6673,7 @@ sub process {
 		if ($signoff == 0) {
 			ERROR("MISSING_SIGN_OFF",
 			      "Missing Signed-off-by: line(s)\n");
-		} elsif (!$authorsignoff) {
+		} elsif ($author ne '' && !$authorsignoff) {
 			WARN("NO_AUTHOR_SIGN_OFF",
 			     "Missing Signed-off-by: line by nominal patch author '$author'\n");
 		}

