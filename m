Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1241C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5AB217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbfDHPLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:11:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:46978 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfDHPLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:11:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 08:11:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,325,1549958400"; 
   d="scan'208";a="159264058"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by fmsmga002.fm.intel.com with ESMTP; 08 Apr 2019 08:11:49 -0700
Date:   Mon, 8 Apr 2019 08:11:49 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] kernel-doc: Rename -function to -symbol
Message-ID: <20190408151148.GC25880@linux.intel.com>
References: <20190405214453.18768-1-sean.j.christopherson@intel.com>
 <20190405214453.18768-4-sean.j.christopherson@intel.com>
 <87pnpwizju.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnpwizju.fsf@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 01:03:49PM +0300, Jani Nikula wrote:
> On Fri, 05 Apr 2019, Sean Christopherson <sean.j.christopherson@intel.com> wrote:
> > The -function option applies to all symbol types, not just functions.
> > Rename it and update its help text and comments to reflect reality.
> >
> > Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> > ---
> >  Documentation/sphinx/kerneldoc.py | 4 ++--
> >  scripts/kernel-doc                | 8 ++++----
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
> > index 9d0a7f08f93b..c52b6caac356 100644
> > --- a/Documentation/sphinx/kerneldoc.py
> > +++ b/Documentation/sphinx/kerneldoc.py
> > @@ -73,12 +73,12 @@ class KernelDocDirective(Directive):
> >              cmd += ['-internal']
> >              export_file_patterns = str(self.options.get('internal')).split()
> >          elif 'doc' in self.options:
> > -            cmd += ['-function', str(self.options.get('doc'))]
> > +            cmd += ['-symbol', str(self.options.get('doc'))]
> >          elif 'functions' in self.options:
> >              functions = self.options.get('functions').split()
> >              if functions:
> >                  for f in functions:
> > -                    cmd += ['-function', f]
> > +                    cmd += ['-symbol', f]
> >              else:
> >                  cmd += ['-no-doc-sections']
> >  
> > diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> > index 9190110b9802..60ef90222a51 100755
> > --- a/scripts/kernel-doc
> > +++ b/scripts/kernel-doc
> > @@ -63,10 +63,10 @@ Output selection (mutually exclusive):
> >    -internal		Only output documentation for symbols that have NOT been
> >  			exported using EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL()
> >                          in any input FILE or -export-file FILE.
> > -  -function NAME	Only output documentation for the given function(s)
> > -			or DOC: section title(s). All other functions and DOC:
> > +  -symbols	NAME	Only output documentation for the given symbol(s)
> > +			or DOC: section title(s). All other symbols and DOC:
> >  			sections are ignored. May be specified multiple times.
> > -  -nosymbol NAME	Do NOT output documentation for the given symbol(s);
> > +  -nosymbol	NAME	Do NOT output documentation for the given symbol(s);
> >  			only output documentation for the other symbols and
> >  			DOC: sections. May be specified multiple times.
> 
> Please decide whether to use singular or prular, and stick to it
> throughout.

"-symbols NAME" is a typo, should be "-symbol NAME".


Any preference on keeping or removing the "(s)" in the description, e.g.

  Only output documentation for the given function(s) or DOC: section title(s).

versus:

  Only output documentation for the given symbol or DOC: section title.

I think it makes sense to drop the "(s)" as each option can only specify a
single symbole, i.e. the "(s)" behavior is covered by "May be specified
multiple times."

> 
> BR,
> Jani.
> 
> 
> >  
> > @@ -409,7 +409,7 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
> >  	$output_mode = "none";
> >      } elsif ($cmd eq "module") { # not needed for XML, inherits from calling document
> >  	$modulename = shift @ARGV;
> > -    } elsif ($cmd eq "function") { # to only output specific function
> > +    } elsif ($cmd eq "symbol") { # to only output specific symbol
> >  	$output_selection = OUTPUT_INCLUDE;
> >  	$function = shift @ARGV;
> >  	$function_table{$function} = 1;
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center
