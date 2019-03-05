Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392B7C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCD820661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 23:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfCEXI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 18:08:28 -0500
Received: from smtprelay0176.hostedemail.com ([216.40.44.176]:60421 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726217AbfCEXI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 18:08:28 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 8D3BD100E86C3;
        Tue,  5 Mar 2019 23:08:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ring38_2c814995d2c38
X-Filterd-Recvd-Size: 2297
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Mar 2019 23:08:25 +0000 (UTC)
Message-ID: <4b86da69fc4460a9992a5d90fe2a1673c2fa4f37.camel@perches.com>
Subject: Re: [PATCH] scripts: checkpatch: Check block comments start with /*
 empty line outside net
From:   Joe Perches <joe@perches.com>
To:     Alexandre Ghiti <alex@ghiti.fr>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Mar 2019 15:08:24 -0800
In-Reply-To: <20190305180238.32630-1-alex@ghiti.fr>
References: <20190305180238.32630-1-alex@ghiti.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-05 at 13:02 -0500, Alexandre Ghiti wrote:
> This patch ensures that apart from net code, block comments start with an
> empty /* line.

I'm not sure it's useful to try to eliminate these types
of lines as there are ~20K of them in the kernel

$ git grep -P "^\/\*\s*\S" | \
  grep -v "\*/\s*$" | \
  grep -vP "^(drivers/net|net/)" | \
  grep -vP "\/\*\**$" | \
  wc -l
19437

Also, perhaps the code would be simpler using something like:
---
 scripts/checkpatch.pl | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d0001fd1112d..c62dbd440c50 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3262,6 +3262,17 @@ sub process {
 			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
 		}
 
+# Block comments use an initial blank /* unless self contained single line
+# or a continuous header line like /**********************
+# This also allows for introductory kernel-doc /** lines
+		if ($realfile !~ m@(?:drivers/net|net/)@ &&
+		    $rawline =~ m@^\+\s*/\*(?:\s*\*++)?\s*\S@ &&
+		    $rawline !~ m@\*/\s*$@ &&
+		    $realline > 2) {
+			WARN("BLOCK_COMMENT_STYLE",
+			     "Block comments start with only /* on an otherwise blank line\n" . $herecurr);
+		}
+
 # Block comments use * on subsequent lines
 		if ($prevline =~ /$;[ \t]*$/ &&			#ends in comment
 		    $prevrawline =~ /^\+.*?\/\*/ &&		#starting /*


