Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED41C74A3F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 23:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250B021019
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 23:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfGJXmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 19:42:21 -0400
Received: from smtprelay0155.hostedemail.com ([216.40.44.155]:37444 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727220AbfGJXmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 19:42:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id AC286180115DE;
        Wed, 10 Jul 2019 23:42:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: straw32_14309c62bb12e
X-Filterd-Recvd-Size: 3096
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jul 2019 23:42:18 +0000 (UTC)
Message-ID: <1918c98b8f25207dc45d46492944f2bcb464cd5d.camel@perches.com>
Subject: Re: [PATCH] checkpatch.pl: warn on invalid commit hash
From:   Joe Perches <joe@perches.com>
To:     Matteo Croce <mcroce@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 10 Jul 2019 16:42:17 -0700
In-Reply-To: <20190710231919.9631-1-mcroce@redhat.com>
References: <20190710231919.9631-1-mcroce@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-11 at 01:19 +0200, Matteo Croce wrote:
> It can happen that a commit message refers to an invalid hash, because
> the referenced hash changed following a rebase, or simply by mistake.
> Add a check in checkpatch.pl which checks that an hash referenced by a Fixes
> tag or just cited in the commit message is a valid commit hash.

Hi Matteo

>     $ scripts/checkpatch.pl <<'EOF'
>     Subject: [PATCH] test commit
> 
>     Sample test commit to test checkpatch.pl
>     Commit 1da177e4c3f4 ("Linux-2.6.12-rc2") really exists,
>     commit 0bba044c4ce7 ("tree") is valid but not a commit,
>     while commit b4cc0b1c0cca ("unknown") is invalid.
> 
>     Fixes: f0cacc14cade ("unknown")
>     Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>     EOF
>     WARNING: Invalid hash 0bba044c4ce7
>     WARNING: Invalid hash b4cc0b1c0cca
>     WARNING: Invalid hash f0cacc14cade
>     total: 0 errors, 3 warnings, 4 lines checked

[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2898,6 +2898,13 @@ sub process {
>  			}
>  		}
>  
> +# check for invalid hashes
> +		if ($in_commit_log && $line =~ /(^fixes:|commit)\s+([0-9a-f]{6,40})\b/i) {
> +			if (`git cat-file -t $2 2>/dev/null` ne "commit\n") {
> +				WARN('INVALID_COMMIT_HASH', "Invalid commit hash $2");

This seems fine as a concept, but this should use a
'\n' and . $herecurr like:

> 				WARN('INVALID_COMMIT_HASH', "Invalid commit hash $2\n" . $herecurr);

And while a single quote around the identifier works, please
use the double quote style like all the other uses of WARN.

Maybe call it "UNKNOWN_COMMIT_ID" too as it might be valid
for someone else's tree that has not yet been pulled and all
other references in checkpatch use ID rather than hash.

				WARN("UNKNOWN_COMMIT_HASH",
				     "Unknown commit id '$2', maybe rebased or not pulled?\n" . $herecurr);

Finally, why wouldn't the existing git_commit_info subroutine
be used instead of an independent 'git cat-file' which may not
even run if git is not available?

Perhaps use something like:

		my $id;
		my $description;
		($id, $description) = git_commit_info($2, undef, undef);
		if (!defined($id)) {
			WARN(etc...);
		}


