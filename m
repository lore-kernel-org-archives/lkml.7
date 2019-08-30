Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FBCC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CF023407
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfH3RRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 13:17:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:29746 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727922AbfH3RRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:17:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 10:17:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="332917307"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga004.jf.intel.com with ESMTP; 30 Aug 2019 10:17:31 -0700
Date:   Fri, 30 Aug 2019 10:17:31 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch: Remove obsolete period from "ambiguous SHA1"
 query
Message-ID: <20190830171731.GB15405@linux.intel.com>
References: <20190830163103.15914-1-sean.j.christopherson@intel.com>
 <19c9b30b3d77a65c6c4289a2eeeb6cbe40594aab.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19c9b30b3d77a65c6c4289a2eeeb6cbe40594aab.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 09:37:51AM -0700, Joe Perches wrote:
> On Fri, 2019-08-30 at 09:31 -0700, Sean Christopherson wrote:
> > Git dropped the period from its "ambiguous SHA1" error message in commit
> > 0c99171ad2 ("get_short_sha1: mark ambiguity error for translation"),
> > circa 2016.  Drop the period from checkpatch's associated query so as to
> > match both the old and new error messages.
> > 
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > ---
> >  scripts/checkpatch.pl | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 93a7edfe0f05..ef3642c53100 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -962,7 +962,7 @@ sub git_commit_info {
> >  
> >  	return ($id, $desc) if ($#lines < 0);
> >  
> > -	if ($lines[0] =~ /^error: short SHA1 $commit is ambiguous\./) {
> > +	if ($lines[0] =~ /^error: short SHA1 $commit is ambiguous/) {
> >  # Maybe one day convert this block of bash into something that returns
> >  # all matching commit ids, but it's very slow...
> >  #
> 
> Thanks.
> 
> Did git ever change to actually support human readable
> messages in multiple languages?

Yep, e.g.:

  error: Kurzer SHA-1 745f ist mehrdeutig.

> If so, this won't work for non-english output.

Yep again.  The next check for 'fatal: ambiguous argument' obviously fails
as well and checkpatch ends up using git's error message as the id and
description.

  ERROR: Please use git ... - ie: 'commit error: Kurze ("")'
