Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0835AC10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 03:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C286F20685
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 03:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbfDUD0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 23:26:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfDUD0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 23:26:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B41A485543;
        Sun, 21 Apr 2019 03:26:04 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7084819C4F;
        Sun, 21 Apr 2019 03:26:01 +0000 (UTC)
Date:   Sun, 21 Apr 2019 11:25:57 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: mute SOB warning in case SOB exists but without
 From header
Message-ID: <20190421032557.GA9025@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sun, 21 Apr 2019 03:26:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch.pl report below warning but the SOB line is correct:
$ ./scripts/checkpatch.pl patches/test.patch
WARNING: Missing Signed-off-by: line by nominal patch author ''

Actually checkpatch.pl assumes every patch includes "From:" line,
this is true for a git formated patch, some saved mail format patch.

But the warning is boring for people who do not use git formated patch.
Change the script only print warning in case "From:" line exists.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 scripts/checkpatch.pl |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-x86.orig/scripts/checkpatch.pl
+++ linux-x86/scripts/checkpatch.pl
@@ -2283,7 +2283,7 @@ sub process {
 	our $clean = 1;
 	my $signoff = 0;
 	my $author = '';
-	my $authorsignoff = 0;
+	my $authorsignoff = -1;
 	my $is_patch = 0;
 	my $is_binding_patch = -1;
 	my $in_header_lines = $file ? 0 : 1;
@@ -2609,6 +2609,8 @@ sub process {
 				$l =~ s/"//g;
 				if ($l =~ /^\s*signed-off-by:\s*\Q$author\E/i) {
 				    $authorsignoff = 1;
+				} else {
+				    $authorsignoff = 0;
 				}
 			}
 		}
@@ -6649,7 +6651,7 @@ sub process {
 		if ($signoff == 0) {
 			ERROR("MISSING_SIGN_OFF",
 			      "Missing Signed-off-by: line(s)\n");
-		} elsif (!$authorsignoff) {
+		} elsif ($authorsignoff == 0) {
 			WARN("NO_AUTHOR_SIGN_OFF",
 			     "Missing Signed-off-by: line by nominal patch author '$author'\n");
 		}
