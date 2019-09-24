Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B7EC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 10:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13641214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 10:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569319716;
	bh=Xw+SO74iPwJyzyRP/c5391ed1ZZq99jE6PsZ6fQTCns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lmPtyPdqLXasVHDBRl0xIOwsXT/mkPpMS13DzRArpZN8Blk4HEEoVorQFNo1vb9rs
	 93xm5yCtti8Byt/iivG0+RvjPcO0QEed2tVzXhZuJGgT+YmgYZDOrnzqTKawycg9bL
	 uUkhkaMfrOqk0+sFeJ6h+JBxPoqfQUP9YX6VP0kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504458AbfIXKIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 06:08:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504442AbfIXKIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 06:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nw+BjlnfOqg2fByI6D3h61cOMIFM4qFyOiqC602LuwA=; b=op5sUoARncFXCdBLAO7Mta7aB
        IcSxLih/AZB9xx8aogXGZd+Py2Bt6xBAgOS28y8sgbgOKYHGnER4h9TU48YCkik9wsHGpKqcw/Sv3
        yHHPvYj2rBMugrpR/KC0bPUoq2PcPCCWMASFNDPrSVm0aMnAAbKUqqDdnLjtF+gHLZitAFkIugTwJ
        5Pnq60iD06maR8HcLKSEKZyJml5vVqesu2n1gJOydQ0EikPTvykGB14FFFmwVT9VO2oS98+8rxT63
        4tJt6RaNGxOr7qc2fs+iEZvjXoYhmF3k8S8lk4FivSwkB1O7EHctVF2HNRgdk/zIoI4cRt1bRmyDJ
        dLdUiFS0A==;
Received: from [177.96.206.173] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iChkG-00017y-UQ; Tue, 24 Sep 2019 10:08:33 +0000
Date:   Tue, 24 Sep 2019 07:08:19 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] docs: Programmatically render MAINTAINERS into
 ReST
Message-ID: <20190924070819.0a7b6658@coco.lan>
In-Reply-To: <201909231534.E8BE691@keescook>
References: <201909231534.E8BE691@keescook>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 23 Sep 2019 15:43:45 -0700
Kees Cook <keescook@chromium.org> escreveu:

> In order to have the MAINTAINERS file visible in the rendered ReST
> output, this makes some small changes to the existing MAINTAINERS file
> to allow for better machine processing, and adds a tool to perform the
> rendering.
>=20
> Features include:
> - Per-subsystem reference links: subsystem maintainer entries can be
>   trivially linked to both internally and external. For example:
>   https://www.kernel.org/doc/html/latest/process/maintainers.html#secure-=
computing
>=20
> - Internally referenced .rst files are linked so they can be followed
>   when browsing the resulting rendering. This allows, for example, the
>   future addition of maintainer profiles to be automatically linked.
>=20
> - Field name expansion: instead of the short fields (e.g. "M", "F",
>   "K"), use the indicated inline "full names" for the fields (which are
>   marked with "*"s in MAINTAINERS) so that a rendered subsystem entry
>   is more human readable. For example:
>=20
>     SECURE COMPUTING
> 	Mail:	  Kees Cook <keescook@chromium.org>
> 	Reviewer: Andy Lutomirski <luto@amacapital.net>
> 		  Will Drewry <wad@chromium.org>
> 	SCM:	  git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git =
seccomp
> 	Status:	  Supported
> 	Files:	  kernel/seccomp.c include/uapi/linux/seccomp.h
> 		  include/linux/seccomp.h tools/testing/selftests/seccomp/*
> 		  tools/testing/selftests/kselftest_harness.h
> 		  userspace-api/seccomp_filter
> 	Content regex:	\bsecure_computing \bTIF_SECCOMP\b

Output looks almost OK on my eyes.

It probably makes sense to change some things there, as, right now, it=20
is considering multiple lines as continuation. So, for example, if
it has multiple M: entries, it will produce this at MAINTAINERS.rst
output:


	:Mail:
		Juergen Gross <jgross@suse.com>
		Thomas Hellstrom <thellstrom@vmware.com>
		"VMware, Inc." <pv-drivers@vmware.com>

With would be displayed as:

	Mail
	    Juergen Gross <jgross@suse.com> Thomas Hellstrom <thellstrom@vmware.co=
m> =E2=80=9CVMware, Inc.=E2=80=9D <pv-drivers@vmware.com>

It would probably be better to output it as:

	:Mail:
		- Juergen Gross <jgross@suse.com>
		- Thomas Hellstrom <thellstrom@vmware.com>
		- "VMware, Inc." <pv-drivers@vmware.com>

or:
	:Mail:
		Juergen Gross <jgross@suse.com>

		Thomas Hellstrom <thellstrom@vmware.com>

		"VMware, Inc." <pv-drivers@vmware.com>

or, eventually:

	:Mail:
		Juergen Gross <jgross@suse.com>,
		Thomas Hellstrom <thellstrom@vmware.com>,
		"VMware, Inc." <pv-drivers@vmware.com>

(Using commas is probably a bad idea, as DT file names may have a
comma in the middle)

Same applies to other fields.

>=20
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
>=20
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 16116d038161..6ebe99edfbad 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -9,6 +9,8 @@ ifeq ($(CONFIG_WARN_MISSING_DOCUMENTS),y)
>  $(shell $(srctree)/scripts/documentation-file-ref-check --warn)
>  endif
> =20
> +DOC_DEPS      =3D $(BUILDDIR)/MAINTAINERS.rst
> +
>  # You can set these variables from the command line.
>  SPHINXBUILD   =3D sphinx-build
>  SPHINXOPTS    =3D
> @@ -77,14 +79,14 @@ quiet_cmd_sphinx =3D SPHINX  $@ --> file://$(abspath =
$(BUILDDIR)/$3/$4)
>  	$(abspath $(srctree)/$(src)/$5) \
>  	$(abspath $(BUILDDIR)/$3/$4)
> =20
> -htmldocs:
> +htmldocs: $(DOC_DEPS)
>  	@$(srctree)/scripts/sphinx-pre-install --version-check
>  	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var=
)))
> =20
> -linkcheckdocs:
> +linkcheckdocs: $(DOC_DEPS)
>  	@$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,linkcheck,$(var),,$=
(var)))
> =20
> -latexdocs:
> +latexdocs: $(DOC_DEPS)
>  	@$(srctree)/scripts/sphinx-pre-install --version-check
>  	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,latex,$(var),latex=
,$(var)))
> =20
> @@ -102,11 +104,11 @@ pdfdocs: latexdocs
> =20
>  endif # HAVE_PDFLATEX
> =20
> -epubdocs:
> +epubdocs: $(DOC_DEPS)
>  	@$(srctree)/scripts/sphinx-pre-install --version-check
>  	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,epub,$(var),epub,$=
(var)))
> =20
> -xmldocs:
> +xmldocs: $(DOC_DEPS)
>  	@$(srctree)/scripts/sphinx-pre-install --version-check
>  	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,xml,$(var),xml,$(v=
ar)))
> =20
> @@ -115,7 +117,11 @@ endif # HAVE_SPHINX
>  # The following targets are independent of HAVE_SPHINX, and the rules sh=
ould
>  # work or silently pass without Sphinx.
> =20
> -refcheckdocs:
> +$(BUILDDIR)/MAINTAINERS.rst: $(srctree)/MAINTAINERS $(srctree)/Documenta=
tion/sphinx/convert-maintainers.py
> +	$(Q)mkdir -p $(BUILDDIR)
> +	$(Q)$(shell python3 $(srctree)/Documentation/sphinx/convert-maintainers=
.py $< > $@ || rm -f $@)
> +

No need to use "python3" here, as the script has a shebang markup. Just
ensure that it has 755 permission, and call it directly.

> +refcheckdocs: $(DOC_DEPS)
>  	$(Q)cd $(srctree);scripts/documentation-file-ref-check
> =20
>  cleandocs:
> diff --git a/Documentation/process/index.rst b/Documentation/process/inde=
x.rst
> index e2c9ffc682c5..e2fb0c9652ac 100644
> --- a/Documentation/process/index.rst
> +++ b/Documentation/process/index.rst
> @@ -46,6 +46,7 @@ Other guides to the community that are of interest to m=
ost developers are:
>     kernel-docs
>     deprecated
>     embargoed-hardware-issues
> +   maintainers
> =20
>  These are some overall technical guides that have been put here for now =
for
>  lack of a better place.
> diff --git a/Documentation/process/maintainers.rst b/Documentation/proces=
s/maintainers.rst
> new file mode 100644


> index 000000000000..32267a1666ff
> --- /dev/null
> +++ b/Documentation/process/maintainers.rst
> @@ -0,0 +1 @@
> +.. kernel-include:: $BUILDDIR/MAINTAINERS.rst
> diff --git a/Documentation/sphinx-static/theme_overrides.css b/Documentat=
ion/sphinx-static/theme_overrides.css
> index e21e36cd6761..459ec5b29d68 100644
> --- a/Documentation/sphinx-static/theme_overrides.css
> +++ b/Documentation/sphinx-static/theme_overrides.css
> @@ -53,6 +53,16 @@ div[class^=3D"highlight"] pre {
>      line-height: normal;
>  }
> =20
> +/* Keep fields from being strangely far apart due to inheirited table CS=
S. */
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
> =20
>      /* content column

I would place this on a separate patch, as this is a layout change that
may affect other files.

Btw, what does this change?

> diff --git a/Documentation/sphinx/convert-maintainers.py b/Documentation/=
sphinx/convert-maintainers.py
> new file mode 100644
> index 000000000000..86cfce7b70c7
> --- /dev/null
> +++ b/Documentation/sphinx/convert-maintainers.py
> @@ -0,0 +1,92 @@
> +#!/usr/bin/env python3

While using python3 is actually OK from my side, as Jon pointed on another
e-mail, we're still discussing if we should either force python3 or not.

So, I would change:

	python3 -> python

but that's just my 2 cents.

> +# SPDX-License-Identifier: GPL-2.0
> +import os, sys, re
> +
> +print(".. _maintainers:\n")
> +
> +# Poor man's state machine.
> +descriptions =3D False
> +maintainers =3D False
> +subsystems =3D False
> +
> +# Field letter to field name mapping.
> +field_letter =3D None
> +fields =3D dict()
> +
> +prev =3D None
> +for line in open(sys.argv[1]):
> +	# Have we reached the end of the preformatted Descriptions text?
> +	if descriptions and line.startswith('Maintainers'):
> +		descriptions =3D False
> +		# Ensure a blank line following the last "|"-prefixed line.
> +		print("")
> +
> +	# Start subsystem processing? This is to skip processing the text
> +	# between the Maintainers heading and the first subsystem name.
> +	if maintainers and not subsystems:
> +		if re.search('^[A-Z0-9]', line):
> +			subsystems =3D True
> +
> +	# Drop needless input whitespace.
> +	line =3D line.rstrip()
> +
> +	# Linkify all non-wildcard references to ReST files in Documentation/.
> +	pat =3D '(Documentation/([^\s\?\*]*)\.rst)'
> +	m =3D re.search(pat, line)
> +	if m:
> +		# maintainers.rst is in a subdirectory, so include "../".
> +		line =3D re.sub(pat, ':doc:`%s <../%s>`' % (m.group(2), m.group(2)), l=
ine)
> +
> +	# Check state machine for output rendering behavior.
> +	output =3D ""
> +	if descriptions:
> +		output =3D "| %s" % (line)
> +		# Look for and record field letter to field name mappings:
> +		#   R: Designated *reviewer*: FullName <address@domain>
> +		m =3D re.search("\s(\S):\s", line)
> +		if m:
> +			field_letter =3D m.group(1)
> +		if field_letter and not field_letter in fields:
> +			m =3D re.search("\*([^\*]+)\*", line)
> +			if m:
> +				fields[field_letter] =3D m.group(1)
> +	elif subsystems and len(line) > 1:
> +		if line[1] !=3D ':':
> +			# Render a subsystem entry as:
> +			#   SUBSYSTEM NAME
> +			#   ~~~~~~~~~~~~~~
> +			heading =3D re.sub("\s+", " ", line)
> +			output =3D "%s\n%s" % (heading, "~" * len(heading))
> +			field_prev =3D ""
> +		else:
> +			# Render a subsystem field as:
> +			#   :Field: entry
> +			#   	entry...
> +			field, details =3D line.split(':', 1)
> +			details =3D details.strip()
> +
> +			# Mark paths as literal text for readability.
> +			if field in ['F', 'N', 'X', 'K']:
> +				# But only if not already marked :)
> +				if not ':doc:' in details:
> +					details =3D '``%s``' % (details)
> +
> +			# Do not repeat field names, so that field entries
> +			# will be collapsed together.
> +			if field !=3D field_prev:
> +				output =3D ":%s:\n" % (fields.get(field, field))
> +			output =3D output + "\t%s" % (details)
> +			field_prev =3D field
> +	else:
> +		output =3D line
> +	print(output)
> +
> +	# Update the state machine when we find heading separators.
> +	if line.startswith('----------'):
> +		if prev.startswith('Descriptions'):
> +			descriptions =3D True
> +		if prev.startswith('Maintainers'):
> +			maintainers =3D True
> +
> +	# Retain previous line for state machine transitions.
> +	prev =3D line
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b6f10ea1573..fbaf09210647 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1,12 +1,14 @@
> -
> -
> -	List of maintainers and how to submit kernel changes
> +List of maintainers and how to submit kernel changes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> =20
>  Please try to follow the guidelines below.  This will make things
>  easier on the maintainers.  Not all of these guidelines matter for every
>  trivial patch so apply some common sense.
> =20
> -1.	Always _test_ your changes, however small, on at least 4 or
> +Tips for patch submitters
> +-------------------------
> +
> +1.	Always *test* your changes, however small, on at least 4 or
>  	5 people, preferably many more.
> =20
>  2.	Try to release a few ALPHA test versions to the net. Announce
> @@ -25,7 +27,7 @@ trivial patch so apply some common sense.
>  	testing and await feedback.
> =20
>  5.	Make a patch available to the relevant maintainer in the list. Use
> -	'diff -u' to make the patch easy to merge. Be prepared to get your
> +	``diff -u`` to make the patch easy to merge. Be prepared to get your
>  	changes sent back with seemingly silly requests about formatting
>  	and variable names.  These aren't as silly as they seem. One
>  	job the maintainers (and especially Linus) do is to keep things
> @@ -38,7 +40,7 @@ trivial patch so apply some common sense.
>  	See Documentation/process/coding-style.rst for guidance here.
> =20
>  	PLEASE CC: the maintainers and mailing lists that are generated
> -	by scripts/get_maintainer.pl.  The results returned by the
> +	by ``scripts/get_maintainer.pl.`` The results returned by the
>  	script will be best if you have git installed and are making
>  	your changes in a branch derived from Linus' latest git tree.
>  	See Documentation/process/submitting-patches.rst for details.
> @@ -74,22 +76,22 @@ trivial patch so apply some common sense.
> =20
>  8.	Happy hacking.
> =20
> -Descriptions of section entries:
> +Descriptions of section entries
> +-------------------------------
> =20
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
> =20
> -Note: For the hard of thinking, this list is meant to remain in alphabet=
ical
> -order. If you could add yourselves to it in alphabetical order that woul=
d be
> -so much easier [Ed]
> -
> -Maintainers List (try to look for most precise areas first)
> +Maintainers List
> +----------------
> =20
> -		-----------------------------------
> +.. note:: When reading this list, please look for the most precise areas
> +          first. When adding to this list, please keep the entries in
> +          alphabetical order.
> =20
>  3C59X NETWORK DRIVER
>  M:	Steffen Klassert <klassert@kernel.org>



Thanks,
Mauro
