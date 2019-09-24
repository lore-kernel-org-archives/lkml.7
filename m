Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BEEC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3264214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 07:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409255AbfIXHQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:16:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:28746 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409243AbfIXHQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 03:16:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 00:16:24 -0700
X-IronPort-AV: E=Sophos;i="5.64,543,1559545200"; 
   d="scan'208";a="182826277"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 00:16:21 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] docs: Programmatically render MAINTAINERS into ReST
In-Reply-To: <201909231534.E8BE691@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <201909231534.E8BE691@keescook>
Date:   Tue, 24 Sep 2019 10:16:18 +0300
Message-ID: <87mueutb99.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019, Kees Cook <keescook@chromium.org> wrote:
> In order to have the MAINTAINERS file visible in the rendered ReST
> output, this makes some small changes to the existing MAINTAINERS file
> to allow for better machine processing, and adds a tool to perform the
> rendering.
>
> Features include:
> - Per-subsystem reference links: subsystem maintainer entries can be
>   trivially linked to both internally and external. For example:
>   https://www.kernel.org/doc/html/latest/process/maintainers.html#secure-computing
>
> - Internally referenced .rst files are linked so they can be followed
>   when browsing the resulting rendering. This allows, for example, the
>   future addition of maintainer profiles to be automatically linked.
>
> - Field name expansion: instead of the short fields (e.g. "M", "F",
>   "K"), use the indicated inline "full names" for the fields (which are
>   marked with "*"s in MAINTAINERS) so that a rendered subsystem entry
>   is more human readable. For example:
>
>     SECURE COMPUTING
> 	Mail:	  Kees Cook <keescook@chromium.org>
> 	Reviewer: Andy Lutomirski <luto@amacapital.net>
> 		  Will Drewry <wad@chromium.org>
> 	SCM:	  git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git seccomp
> 	Status:	  Supported
> 	Files:	  kernel/seccomp.c include/uapi/linux/seccomp.h
> 		  include/linux/seccomp.h tools/testing/selftests/seccomp/*
> 		  tools/testing/selftests/kselftest_harness.h
> 		  userspace-api/seccomp_filter
> 	Content regex:	\bsecure_computing \bTIF_SECCOMP\b
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/Makefile                        | 18 ++--
>  Documentation/process/index.rst               |  1 +
>  Documentation/process/maintainers.rst         |  1 +
>  .../sphinx-static/theme_overrides.css         | 10 ++
>  Documentation/sphinx/convert-maintainers.py   | 92 +++++++++++++++++++
>  MAINTAINERS                                   | 59 ++++++------
>  6 files changed, 146 insertions(+), 35 deletions(-)
>  create mode 100644 Documentation/process/maintainers.rst
>  create mode 100644 Documentation/sphinx/convert-maintainers.py
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 16116d038161..6ebe99edfbad 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -9,6 +9,8 @@ ifeq ($(CONFIG_WARN_MISSING_DOCUMENTS),y)
>  $(shell $(srctree)/scripts/documentation-file-ref-check --warn)
>  endif
>  
> +DOC_DEPS      = $(BUILDDIR)/MAINTAINERS.rst
> +
>  # You can set these variables from the command line.
>  SPHINXBUILD   = sphinx-build
>  SPHINXOPTS    =
> @@ -77,14 +79,14 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
>  	$(abspath $(srctree)/$(src)/$5) \
>  	$(abspath $(BUILDDIR)/$3/$4)
>  
> -htmldocs:
> +htmldocs: $(DOC_DEPS)
>  	@$(srctree)/scripts/sphinx-pre-install --version-check
>  	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
>  
> -linkcheckdocs:
> +linkcheckdocs: $(DOC_DEPS)
>  	@$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,linkcheck,$(var),,$(var)))
>  
> -latexdocs:
> +latexdocs: $(DOC_DEPS)
>  	@$(srctree)/scripts/sphinx-pre-install --version-check
>  	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,latex,$(var),latex,$(var)))
>  
> @@ -102,11 +104,11 @@ pdfdocs: latexdocs
>  
>  endif # HAVE_PDFLATEX
>  
> -epubdocs:
> +epubdocs: $(DOC_DEPS)
>  	@$(srctree)/scripts/sphinx-pre-install --version-check
>  	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,epub,$(var),epub,$(var)))
>  
> -xmldocs:
> +xmldocs: $(DOC_DEPS)
>  	@$(srctree)/scripts/sphinx-pre-install --version-check
>  	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,xml,$(var),xml,$(var)))
>  
> @@ -115,7 +117,11 @@ endif # HAVE_SPHINX
>  # The following targets are independent of HAVE_SPHINX, and the rules should
>  # work or silently pass without Sphinx.
>  
> -refcheckdocs:
> +$(BUILDDIR)/MAINTAINERS.rst: $(srctree)/MAINTAINERS $(srctree)/Documentation/sphinx/convert-maintainers.py
> +	$(Q)mkdir -p $(BUILDDIR)
> +	$(Q)$(shell python3 $(srctree)/Documentation/sphinx/convert-maintainers.py $< > $@ || rm -f $@)

I'd suggest making convert-maintainers.py a Sphinx extension, and
handling all of this in Sphinx.

BR,
Jani.


> +
> +refcheckdocs: $(DOC_DEPS)
>  	$(Q)cd $(srctree);scripts/documentation-file-ref-check
>  
>  cleandocs:
> diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
> index e2c9ffc682c5..e2fb0c9652ac 100644
> --- a/Documentation/process/index.rst
> +++ b/Documentation/process/index.rst
> @@ -46,6 +46,7 @@ Other guides to the community that are of interest to most developers are:
>     kernel-docs
>     deprecated
>     embargoed-hardware-issues
> +   maintainers
>  
>  These are some overall technical guides that have been put here for now for
>  lack of a better place.
> diff --git a/Documentation/process/maintainers.rst b/Documentation/process/maintainers.rst
> new file mode 100644
> index 000000000000..32267a1666ff
> --- /dev/null
> +++ b/Documentation/process/maintainers.rst
> @@ -0,0 +1 @@
> +.. kernel-include:: $BUILDDIR/MAINTAINERS.rst
> diff --git a/Documentation/sphinx-static/theme_overrides.css b/Documentation/sphinx-static/theme_overrides.css
> index e21e36cd6761..459ec5b29d68 100644
> --- a/Documentation/sphinx-static/theme_overrides.css
> +++ b/Documentation/sphinx-static/theme_overrides.css
> @@ -53,6 +53,16 @@ div[class^="highlight"] pre {
>      line-height: normal;
>  }
>  
> +/* Keep fields from being strangely far apart due to inheirited table CSS. */
> +.rst-content table.field-list th.field-name {
> +    padding-top: 1px;
> +    padding-bottom: 1px;
> +}
> +.rst-content table.field-list td.field-body {
> +    padding-top: 1px;
> +    padding-bottom: 1px;
> +}
> +
>  @media screen {
>  
>      /* content column
> diff --git a/Documentation/sphinx/convert-maintainers.py b/Documentation/sphinx/convert-maintainers.py
> new file mode 100644
> index 000000000000..86cfce7b70c7
> --- /dev/null
> +++ b/Documentation/sphinx/convert-maintainers.py
> @@ -0,0 +1,92 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +import os, sys, re
> +
> +print(".. _maintainers:\n")
> +
> +# Poor man's state machine.
> +descriptions = False
> +maintainers = False
> +subsystems = False
> +
> +# Field letter to field name mapping.
> +field_letter = None
> +fields = dict()
> +
> +prev = None
> +for line in open(sys.argv[1]):
> +	# Have we reached the end of the preformatted Descriptions text?
> +	if descriptions and line.startswith('Maintainers'):
> +		descriptions = False
> +		# Ensure a blank line following the last "|"-prefixed line.
> +		print("")
> +
> +	# Start subsystem processing? This is to skip processing the text
> +	# between the Maintainers heading and the first subsystem name.
> +	if maintainers and not subsystems:
> +		if re.search('^[A-Z0-9]', line):
> +			subsystems = True
> +
> +	# Drop needless input whitespace.
> +	line = line.rstrip()
> +
> +	# Linkify all non-wildcard references to ReST files in Documentation/.
> +	pat = '(Documentation/([^\s\?\*]*)\.rst)'
> +	m = re.search(pat, line)
> +	if m:
> +		# maintainers.rst is in a subdirectory, so include "../".
> +		line = re.sub(pat, ':doc:`%s <../%s>`' % (m.group(2), m.group(2)), line)
> +
> +	# Check state machine for output rendering behavior.
> +	output = ""
> +	if descriptions:
> +		output = "| %s" % (line)
> +		# Look for and record field letter to field name mappings:
> +		#   R: Designated *reviewer*: FullName <address@domain>
> +		m = re.search("\s(\S):\s", line)
> +		if m:
> +			field_letter = m.group(1)
> +		if field_letter and not field_letter in fields:
> +			m = re.search("\*([^\*]+)\*", line)
> +			if m:
> +				fields[field_letter] = m.group(1)
> +	elif subsystems and len(line) > 1:
> +		if line[1] != ':':
> +			# Render a subsystem entry as:
> +			#   SUBSYSTEM NAME
> +			#   ~~~~~~~~~~~~~~
> +			heading = re.sub("\s+", " ", line)
> +			output = "%s\n%s" % (heading, "~" * len(heading))
> +			field_prev = ""
> +		else:
> +			# Render a subsystem field as:
> +			#   :Field: entry
> +			#   	entry...
> +			field, details = line.split(':', 1)
> +			details = details.strip()
> +
> +			# Mark paths as literal text for readability.
> +			if field in ['F', 'N', 'X', 'K']:
> +				# But only if not already marked :)
> +				if not ':doc:' in details:
> +					details = '``%s``' % (details)
> +
> +			# Do not repeat field names, so that field entries
> +			# will be collapsed together.
> +			if field != field_prev:
> +				output = ":%s:\n" % (fields.get(field, field))
> +			output = output + "\t%s" % (details)
> +			field_prev = field
> +	else:
> +		output = line
> +	print(output)
> +
> +	# Update the state machine when we find heading separators.
> +	if line.startswith('----------'):
> +		if prev.startswith('Descriptions'):
> +			descriptions = True
> +		if prev.startswith('Maintainers'):
> +			maintainers = True
> +
> +	# Retain previous line for state machine transitions.
> +	prev = line
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b6f10ea1573..fbaf09210647 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1,12 +1,14 @@
> -
> -
> -	List of maintainers and how to submit kernel changes
> +List of maintainers and how to submit kernel changes
> +====================================================
>  
>  Please try to follow the guidelines below.  This will make things
>  easier on the maintainers.  Not all of these guidelines matter for every
>  trivial patch so apply some common sense.
>  
> -1.	Always _test_ your changes, however small, on at least 4 or
> +Tips for patch submitters
> +-------------------------
> +
> +1.	Always *test* your changes, however small, on at least 4 or
>  	5 people, preferably many more.
>  
>  2.	Try to release a few ALPHA test versions to the net. Announce
> @@ -25,7 +27,7 @@ trivial patch so apply some common sense.
>  	testing and await feedback.
>  
>  5.	Make a patch available to the relevant maintainer in the list. Use
> -	'diff -u' to make the patch easy to merge. Be prepared to get your
> +	``diff -u`` to make the patch easy to merge. Be prepared to get your
>  	changes sent back with seemingly silly requests about formatting
>  	and variable names.  These aren't as silly as they seem. One
>  	job the maintainers (and especially Linus) do is to keep things
> @@ -38,7 +40,7 @@ trivial patch so apply some common sense.
>  	See Documentation/process/coding-style.rst for guidance here.
>  
>  	PLEASE CC: the maintainers and mailing lists that are generated
> -	by scripts/get_maintainer.pl.  The results returned by the
> +	by ``scripts/get_maintainer.pl.`` The results returned by the
>  	script will be best if you have git installed and are making
>  	your changes in a branch derived from Linus' latest git tree.
>  	See Documentation/process/submitting-patches.rst for details.
> @@ -74,22 +76,22 @@ trivial patch so apply some common sense.
>  
>  8.	Happy hacking.
>  
> -Descriptions of section entries:
> +Descriptions of section entries
> +-------------------------------
>  
> -	P: Person (obsolete)
> -	M: Mail patches to: FullName <address@domain>
> -	R: Designated reviewer: FullName <address@domain>
> +	M: *Mail* patches to: FullName <address@domain>
> +	R: Designated *Reviewer*: FullName <address@domain>
>  	   These reviewers should be CCed on patches.
> -	L: Mailing list that is relevant to this area
> -	W: Web-page with status/info
> -	B: URI for where to file bugs. A web-page with detailed bug
> +	L: *Mailing list* that is relevant to this area
> +	W: *Web-page* with status/info
> +	B: URI for where to file *bugs*. A web-page with detailed bug
>  	   filing info, a direct bug tracker link, or a mailto: URI.
> -	C: URI for chat protocol, server and channel where developers
> +	C: URI for *chat* protocol, server and channel where developers
>  	   usually hang out, for example irc://server/channel.
> -	Q: Patchwork web based patch tracking system site
> -	T: SCM tree type and location.
> +	Q: *Patchwork* web based patch tracking system site
> +	T: *SCM* tree type and location.
>  	   Type is one of: git, hg, quilt, stgit, topgit
> -	S: Status, one of the following:
> +	S: *Status*, one of the following:
>  	   Supported:	Someone is actually paid to look after this.
>  	   Maintained:	Someone actually looks after it.
>  	   Odd Fixes:	It has a maintainer but they don't have time to do
> @@ -99,13 +101,13 @@ Descriptions of section entries:
>  	   Obsolete:	Old code. Something tagged obsolete generally means
>  			it has been replaced by a better system and you
>  			should be using that.
> -	F: Files and directories with wildcard patterns.
> +	F: *Files* and directories wildcard patterns.
>  	   A trailing slash includes all files and subdirectory files.
>  	   F:	drivers/net/	all files in and below drivers/net
>  	   F:	drivers/net/*	all files in drivers/net, but not below
>  	   F:	*/net/*		all files in "any top level directory"/net
>  	   One pattern per line.  Multiple F: lines acceptable.
> -	N: Files and directories with regex patterns.
> +	N: Files and directories *Regex* patterns.
>  	   N:	[^a-z]tegra	all files whose path contains the word tegra
>  	   One pattern per line.  Multiple N: lines acceptable.
>  	   scripts/get_maintainer.pl has different behavior for files that
> @@ -113,14 +115,14 @@ Descriptions of section entries:
>  	   get_maintainer will not look at git log history when an F: pattern
>  	   match occurs.  When an N: match occurs, git log history is used
>  	   to also notify the people that have git commit signatures.
> -	X: Files and directories that are NOT maintained, same rules as F:
> -	   Files exclusions are tested before file matches.
> +	X: *Excluded* files and directories that are NOT maintained, same
> +	   rules as F:. Files exclusions are tested before file matches.
>  	   Can be useful for excluding a specific subdirectory, for instance:
>  	   F:	net/
>  	   X:	net/ipv6/
>  	   matches all files in and below net excluding net/ipv6/
> -	K: Keyword perl extended regex pattern to match content in a
> -	   patch or file.  For instance:
> +	K: *Content regex* (perl extended) pattern match in a patch or file.
> +	   For instance:
>  	   K: of_get_profile
>  	      matches patches or files that contain "of_get_profile"
>  	   K: \b(printk|pr_(info|err))\b
> @@ -128,13 +130,12 @@ Descriptions of section entries:
>  	      printk, pr_info or pr_err
>  	   One regex pattern per line.  Multiple K: lines acceptable.
>  
> -Note: For the hard of thinking, this list is meant to remain in alphabetical
> -order. If you could add yourselves to it in alphabetical order that would be
> -so much easier [Ed]
> -
> -Maintainers List (try to look for most precise areas first)
> +Maintainers List
> +----------------
>  
> -		-----------------------------------
> +.. note:: When reading this list, please look for the most precise areas
> +          first. When adding to this list, please keep the entries in
> +          alphabetical order.
>  
>  3C59X NETWORK DRIVER
>  M:	Steffen Klassert <klassert@kernel.org>
> -- 
> 2.17.1

-- 
Jani Nikula, Intel Open Source Graphics Center
