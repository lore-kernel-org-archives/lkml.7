Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631FEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377B322CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfICP6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:58:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:42941 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728967AbfICP6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:58:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 08:58:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,463,1559545200"; 
   d="scan'208";a="184797992"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.41])
  by orsmga003.jf.intel.com with ESMTP; 03 Sep 2019 08:58:22 -0700
Date:   Tue, 3 Sep 2019 08:58:22 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch: Validate Fixes: tag using 'commit' checks
Message-ID: <20190903155822.GC10768@linux.intel.com>
References: <20190830163658.17043-1-sean.j.christopherson@intel.com>
 <20190831113939.7c2dad32@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831113939.7c2dad32@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2019 at 11:39:39AM +1000, Stephen Rothwell wrote:
> Hi Sean,
> 
> On Fri, 30 Aug 2019 09:36:58 -0700 Sean Christopherson <sean.j.christopherson@intel.com> wrote:
> >
> > @@ -2803,10 +2805,15 @@ sub process {
> >  			($id, $description) = git_commit_info($orig_commit,
> >  							      $id, $orig_desc);
> >  
> > -			if (defined($id) &&
> > -			   ($short || $long || $space || $case || ($orig_desc ne $description) || !$hasparens)) {
> > +
> > +			if (!defined($id)) {
> > +				if ($init_tag =~ /fixes:/i) {
> > +					ERROR("GIT_COMMIT_ID",
> > +					      "Target SHA1 '$orig_commit' does not exist\n" . $herecurr);
> > +				}
> 
> Unfortunately, git_commit_info() just returns the passed in $id (which
> is explicitly set earlier) if git is not available or you are not in a
> git repository (and that latter check is not entirely correct anyway).
> 
> Also, what you really need to test is if the specified commit is an
> ancestor of the place in the maintainer's tree where this patch is to
> be applied.  The commit may well exist in the developer's tree, but not
> be in the maintainer's tree :-(

True, but such an error would be caught if the maintainer or a reviewer
runs checkpatch after applying the commit, e.g. I'll run checkpatch as
part of reviewing a patch if I go through the effort of applying it,
which admittedly isn't all that often.
 
> This will, however, catch the cases where the SHA1 has been mistyped,
> but we should encourage people not to type them anyway, instead
> generating them using "git log".

What about adding an example formatting command to the error message, e.g.

  ERROR: Target SHA1 '265381004993' does not exist, use `git show -s
  --pretty='format:%h ("%s")'` or similar to verify and format the commit
  description


The same blurb could be also added to the error message for bad formatting

  ERROR: Please use git commit description style 'Fixes: <12+ chars of sha1>
  ("<title line>")', e.g. `git show -s --pretty='format:%h ("%s")'` -
  ie. 'Fixes: 265381004994 ("Merge tag '5.3-rc6-smb3-fixes' of
  git://git.samba.org/sfrench/cifs-2.6")
