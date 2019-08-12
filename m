Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB65C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10AA0214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfHLUH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:07:29 -0400
Received: from smtprelay0109.hostedemail.com ([216.40.44.109]:39257 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727185AbfHLUH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:07:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 016E718224082;
        Mon, 12 Aug 2019 20:07:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bread11_4113924106557
X-Filterd-Recvd-Size: 2101
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon, 12 Aug 2019 20:07:27 +0000 (UTC)
Message-ID: <60cac6896503a0c47d849507cf5666add7d1c57f.camel@perches.com>
Subject: [PATCH] checkpatch: Prefer __section over
 __attribute__((section(...)))
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 12 Aug 2019 13:07:25 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add another test for __attribute__((section("foo"))) uses
that should be __section(foo)

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Joe Perches <joe@perches.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com> # post PEBKAC <smile>
---
 scripts/checkpatch.pl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1cdacb4fd207..d4153b81b1eb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5901,6 +5901,18 @@ sub process {
 			     "__aligned(size) is preferred over __attribute__((aligned(size)))\n" . $herecurr);
 		}
 
+# Check for __attribute__ section, prefer __section
+		if ($realfile !~ m@\binclude/uapi/@ &&
+		    $line =~ /\b__attribute__\s*\(\s*\(.*_*section_*\s*\(\s*("[^"]*")/) {
+			my $old = substr($rawline, $-[1], $+[1] - $-[1]);
+			my $new = substr($old, 1, -1);
+			if (WARN("PREFER_SECTION",
+				 "__section($new) is preferred over __attribute__((section($old)))\n" . $herecurr) &&
+			    $fix) {
+				$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*_*section_*\s*\(\s*\Q$old\E\s*\)\s*\)/__section($new)/;
+			}
+		}
+
 # Check for __attribute__ format(printf, prefer __printf
 		if ($realfile !~ m@\binclude/uapi/@ &&
 		    $line =~ /\b__attribute__\s*\(\s*\(\s*format\s*\(\s*printf/) {


