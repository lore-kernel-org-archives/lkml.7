Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940B8C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A3D2077C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 16:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389345AbfKGQzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 11:55:23 -0500
Received: from smtprelay0157.hostedemail.com ([216.40.44.157]:59225 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726877AbfKGQzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 11:55:22 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 1733C18022F3A;
        Thu,  7 Nov 2019 16:55:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wool61_68cbd436e7d14
X-Filterd-Recvd-Size: 2188
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 Nov 2019 16:55:20 +0000 (UTC)
Message-ID: <b982566a2b9b4825badce36fdfc3032bd0005151.camel@perches.com>
Subject: [PATCH] checkpatch: Reduce is_maintained_obsolete lookup runtime
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 07 Nov 2019 08:55:07 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The is_maintained_obsolete function can be called twice
using the same filename.  This function spawns a process
using get_maintainer.pl.  Store the status of each filename
when spawned and use the stored result to eliminate the
spawning of unnecessary duplicate child processes.

Example:

old:

$ time ./scripts/checkpatch.pl hp100-Move-to-staging.patch > /dev/null

real	0m1.767s
user	0m1.634s
sys	0m0.141s

new:

$ time ./scripts/checkpatch.pl hp100-Move-to-staging.patch > /dev/null

real	0m1.184s
user	0m1.085s
sys	0m0.103s

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a85d719..8756c2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -888,14 +888,18 @@ sub seed_camelcase_file {
 	}
 }
 
+our %maintained_status = ();
+
 sub is_maintained_obsolete {
 	my ($filename) = @_;
 
 	return 0 if (!$tree || !(-e "$root/scripts/get_maintainer.pl"));
 
-	my $status = `perl $root/scripts/get_maintainer.pl --status --nom --nol --nogit --nogit-fallback -f $filename 2>&1`;
+	if (!exists($maintained_status{$filename})) {
+		$maintained_status{$filename} = `perl $root/scripts/get_maintainer.pl --status --nom --nol --nogit --nogit-fallback -f $filename 2>&1`;
+	}
 
-	return $status =~ /obsolete/i;
+	return $maintained_status{$filename} =~ /obsolete/i;
 }
 
 sub is_SPDX_License_valid {


