Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2378C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A598A22CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfICQFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:05:53 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:55778 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729709AbfICQFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:05:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 650DD8368EE9;
        Tue,  3 Sep 2019 16:05:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: twist07_6d34be5b1f50c
X-Filterd-Recvd-Size: 3460
Received: from XPS-9350.home (unknown [47.151.137.30])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue,  3 Sep 2019 16:05:50 +0000 (UTC)
Message-ID: <0435c104093ca60cee5f0489e54af54b693fed10.camel@perches.com>
Subject: Re: [PATCH] scripts/checkpatch.pl - don't check for const structs
 if list is empty
From:   Joe Perches <joe@perches.com>
To:     Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Pablo Pellecchia <pablo9891@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 03 Sep 2019 09:05:48 -0700
In-Reply-To: <542749.1567507103@turing-police>
References: <542749.1567507103@turing-police>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-03 at 06:38 -0400, Valdis Klētnieks wrote:
> If the list of structures we expect to be const is empty (due to file permissions,
> or the file being empty, etc), we get odd complaints about structures:
> 
> [/usr/src/linux-next] scripts/checkpatch.pl -f drivers/staging/netlogic/platform_net.h
> No structs that should be const will be found - file '/usr/src/linux-next/scripts/const_structs.checkpatch': Permission denied
> WARNING: struct  should normally be const
> #9: FILE: drivers/staging/netlogic/platform_net.h:9:
> +struct xlr_net_data {
> 
> WARNING: struct  should normally be const
> #20: FILE: drivers/staging/netlogic/platform_net.h:20:
> +	struct xlr_fmn_info *gmac_fmn_info;
> 
> total: 0 errors, 2 warnings, 0 checks, 21 lines checked
> 
> Fix it so that it actually *obeys* what it said about not finding structures.
> 
> Reported-by: Pablo Pellecchia <pablo9891@gmail.com>
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> ---
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index f4b6127ff469..103c67665f61 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6497,7 +6497,7 @@ sub process {
>  
>  # check for various structs that are normally const (ops, kgdb, device_tree)
>  # and avoid what seem like struct definitions 'struct foo {'
> -		if ($line !~ /\bconst\b/ &&
> +		if ($line !~ /\bconst\b/ && $const_structs ne "" &&

Seems sensible, thanks.

I think this would read better with this test order reversed.

Maybe this should verify that const does not exist before the
specific struct found: (and is not also a forward declaration)
---
 scripts/checkpatch.pl | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f4b6127ff469..77d585950ab0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -6496,11 +6496,12 @@ sub process {
 		}
 
 # check for various structs that are normally const (ops, kgdb, device_tree)
-# and avoid what seem like struct definitions 'struct foo {'
-		if ($line !~ /\bconst\b/ &&
-		    $line =~ /\bstruct\s+($const_structs)\b(?!\s*\{)/) {
+# avoid struct definitions 'struct foo {' and forward declarations 'struct foo;'
+		if ($const_structs ne "" &&
+		    $line =~ /((\bstruct\s+($const_structs))\b(?!\s*[\{;]))/ &&
+		    $line !~ /\bconst\s+\Q$1\E/) {
 			WARN("CONST_STRUCT",
-			     "struct $1 should normally be const\n" . $herecurr);
+			     "struct $2 should normally be const\n" . $herecurr);
 		}
 
 # use of NR_CPUS is usually wrong


