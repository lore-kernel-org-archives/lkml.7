Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508D3C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D22A208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfFYQhH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:37:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43948 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfFYQhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:37:07 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hfoRJ-0003sY-Ib; Tue, 25 Jun 2019 18:37:01 +0200
Date:   Tue, 25 Jun 2019 18:37:01 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joe Perches <joe@perches.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] get_maintainer: Add --prefix option
Message-ID: <20190625163701.xcb2ue7phpskvfnz@linutronix.de>
References: <20190624130323.14137-1-bigeasy@linutronix.de>
 <20190624133333.GW3419@hirez.programming.kicks-ass.net>
 <9528bb2c4455db9e130576120c8b985b9dd94e3d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <9528bb2c4455db9e130576120c8b985b9dd94e3d.camel@perches.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --prefix option adds a Cc: prefix by default infront of the email
address so it can be used by other Scripts directly instead of adding
another wrapper for this.
The option takes an optional argument so "--prefix=Bcc: " is also valid.
Since it is expected to be output an email address it implies
"--no-roles --no-rolestats".

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
On 2019-06-24 07:27:47 [-0700], Joe Perches wrote:
> On Mon, 2019-06-24 at 15:33 +0200, Peter Zijlstra wrote:
> > Would it make sense to make '--cc' imply --no-roles --no-rolestats ?
> 
> Maybe.
> 
> It's also unlikely to be sensibly used with mailing
> lists so maybe --nol too.

I don't see a problem with lists but I think it would make sense to
imply also "--nomoderated" once available.

v1…v2:
	- use --prefix instead --cc with "Cc: " as the default argument
	  if not specified
	- imply --no-roles --no-rolestats

 scripts/get_maintainer.pl | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index c1c088ef1420e..60da8444d6667 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -46,6 +46,8 @@ my $output_multiline = 1;
 my $output_separator = ", ";
 my $output_roles = 0;
 my $output_rolestats = 1;
+my $output_prefix = undef;
+my $cc_prefix = "";
 my $output_section_maxlen = 50;
 my $scm = 0;
 my $tree = 1;
@@ -252,6 +254,7 @@ if (!GetOptions(
 		'multiline!' => \$output_multiline,
 		'roles!' => \$output_roles,
 		'rolestats!' => \$output_rolestats,
+		'prefix:s' => \$output_prefix,
 		'separator=s' => \$output_separator,
 		'subsystem!' => \$subsystem,
 		'status!' => \$status,
@@ -298,6 +301,16 @@ $output_multiline = 0 if ($output_separator ne ", ");
 $output_rolestats = 1 if ($interactive);
 $output_roles = 1 if ($output_rolestats);
 
+if (defined($output_prefix)) {
+    if ($output_prefix eq "") {
+         $cc_prefix = "Cc: ";
+    } else {
+         $cc_prefix = $output_prefix;
+    }
+    $output_rolestats = 0;
+    $output_roles = 0;
+}
+
 if ($sections || $letters ne "") {
     $sections = 1;
     $email = 0;
@@ -1037,6 +1050,7 @@ version: $V
   --separator [, ] => separator for multiple entries on 1 line
     using --separator also sets --nomultiline if --separator is not [, ]
   --multiline => print 1 entry per line
+  --prefix => prints a prefix infront of the entry. CC: is default if not specified
 
 Other options:
   --pattern-depth => Number of pattern directory traversals (default: 0 (all))
@@ -2462,9 +2476,9 @@ sub merge_email {
 	my ($address, $role) = @$_;
 	if (!$saw{$address}) {
 	    if ($output_roles) {
-		push(@lines, "$address ($role)");
+		push(@lines, "$cc_prefix" . "$address ($role)");
 	    } else {
-		push(@lines, $address);
+		push(@lines, "$cc_prefix" . "$address");
 	    }
 	    $saw{$address} = 1;
 	}
-- 
2.20.1

