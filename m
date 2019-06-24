Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFFCC4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04AC20665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbfFXUmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 16:42:17 -0400
Received: from smtprelay0138.hostedemail.com ([216.40.44.138]:42241 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726920AbfFXUmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:42:16 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id D213A18225E07;
        Mon, 24 Jun 2019 20:42:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: patch08_8809e2ec12838
X-Filterd-Recvd-Size: 4125
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Jun 2019 20:42:14 +0000 (UTC)
Message-ID: <02324731bac2da6ef30b3812edaf213ecf626fe4.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: Add --cc option
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 13:42:13 -0700
In-Reply-To: <20190624202512.GK3436@hirez.programming.kicks-ass.net>
References: <20190624130323.14137-1-bigeasy@linutronix.de>
         <20190624133333.GW3419@hirez.programming.kicks-ass.net>
         <9528bb2c4455db9e130576120c8b985b9dd94e3d.camel@perches.com>
         <20190624202512.GK3436@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-24 at 22:25 +0200, Peter Zijlstra wrote:
> On Mon, Jun 24, 2019 at 07:27:47AM -0700, Joe Perches wrote:
> > On Mon, 2019-06-24 at 15:33 +0200, Peter Zijlstra wrote:
> > > On Mon, Jun 24, 2019 at 03:03:23PM +0200, Sebastian Andrzej Siewior wrote:
> > > > The --cc adds a Cc: prefix infront of the email address so it can be
> > > > used by other Scripts directly instead of adding another wrapper for
> > > > this.
> > 
> > Not sure I like the "--cc" option naming.
> > Maybe "--prefix [string]" to be a bit more generic.
> > 
> > > Would it make sense to make '--cc' imply --no-roles --no-rolestats ?
> > 
> > Maybe.
> > 
> > It's also unlikely to be sensibly used with mailing
> > lists so maybe --nol too.
> 
> Is there also an option to exclude moderated lists?

Nope.  Not yet ;)

>  --no-s doesn't seem to do that.

I suppose a --nomoderated could work. (-m is already maintainers)

> I hate it when people cross-post to moderated lists, and
> this thing just made me do it :-(

Maybe:
---
 scripts/get_maintainer.pl | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index c1c088ef1420..8c2fc22f3a11 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -27,6 +27,7 @@ my $email_usename = 1;
 my $email_maintainer = 1;
 my $email_reviewer = 1;
 my $email_list = 1;
+my $email_moderated_list = 1;
 my $email_subscriber_list = 0;
 my $email_git_penguin_chiefs = 0;
 my $email_git = 0;
@@ -248,6 +249,7 @@ if (!GetOptions(
 		'r!' => \$email_reviewer,
 		'n!' => \$email_usename,
 		'l!' => \$email_list,
+		'moderated!' => \$email_moderated_list,
 		's!' => \$email_subscriber_list,
 		'multiline!' => \$output_multiline,
 		'roles!' => \$output_roles,
@@ -1023,7 +1025,8 @@ MAINTAINER field selection options:
     --r => include reviewer(s) if any
     --n => include name 'Full Name <addr\@domain.tld>'
     --l => include list(s) if any
-    --s => include subscriber only list(s) if any
+    --moderated => include moderated lists(s) if any (default: true)
+    --s => include subscriber only list(s) if any (default: false)
     --remove-duplicates => minimize duplicate email names/addresses
     --roles => show roles (status:subsystem, git-signer, list, etc...)
     --rolestats => show roles and statistics (commits/total_commits, %)
@@ -1313,11 +1316,14 @@ sub add_categories {
 		} else {
 		    if ($email_list) {
 			if (!$hash_list_to{lc($list_address)}) {
-			    $hash_list_to{lc($list_address)} = 1;
 			    if ($list_additional =~ m/moderated/) {
-				push(@list_to, [$list_address,
-						"moderated list${list_role}"]);
+				if ($email_moderated_list) {
+				    $hash_list_to{lc($list_address)} = 1;
+				    push(@list_to, [$list_address,
+						    "moderated list${list_role}"]);
+				}
 			    } else {
+				$hash_list_to{lc($list_address)} = 1;
 				push(@list_to, [$list_address,
 						"open list${list_role}"]);
 			    }


