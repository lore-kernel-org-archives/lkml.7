Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E43C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9F92054F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557247979;
	bh=GdKPdzZvNFEeTzSudxFIsmofgOSTEEiUgX8dNm+O/+U=;
	h=Date:From:To:Subject:List-ID:From;
	b=ndpBPSByEJDrTYwQK9poTLu70RxtOWxRrD50qFD9AvHjSYBcZ5yihQXn5wFFRocC9
	 1fYgllDOMAE5khuMteddRnJk+hv7lkM6HF27VuskVUZN9ToK/47X3xYaitZcUe+PLl
	 5//9koRE7HQ7qH1oocBeK9fEJ1Ee0aYTu97kjlDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfEGQw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:52:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbfEGQw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:52:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 686CB2054F;
        Tue,  7 May 2019 16:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557247976;
        bh=GdKPdzZvNFEeTzSudxFIsmofgOSTEEiUgX8dNm+O/+U=;
        h=Date:From:To:Subject:From;
        b=EcCQjjUj2QmQDZXNafbJhcTK4CWQrzNc9oeSLv4S/axn7Otc17EZ6sa53gx1SWKgj
         RhxtwxXfh5Spv4Gg2+fJo3qFlFsJc3YLqovlQm6tu1IjkhXExtmCU1dEg+VKFRWfey
         aO3GBPURYHxfXlFk5Ytu2reHDZiKTI1MYBK1id4I=
Date:   Tue, 7 May 2019 18:52:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: usbutils 011 and 012 release
Message-ID: <20190507165254.GA28250@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Continuing the "one release a year" normal progression for the usbutils
package, I would like to announce the 011 and 012 release of usbutils.

There was 2 releases because we have now changed the way usbutils is
distributed, and it took me a second try to get it "correct".

More details on that below, if you are curious, below the shortlog,
here's the highlights of the latest release over the last 010 release:

 - more USB descriptor extensions added
 - python3 support for lsusb.py so those distros dropping python2
   support can be happy.
 - loads of cleanups of lsusb.py by Mantas Mikulėnas and Kurt Garloff
 - SPDX bill-of-materials support, as defined by the REUSE project, to
   make distro packagers happier
 - libusb requirement settled down, again to make some distros happier
 - usbhid-dump moved into the usbutils main

Here's the "shortlog" for those interested:

usbutils 012
============

Greg Kroah-Hartman:
	Merge usbhid-dump into main usbutils repository


usbutils 011
============

Clemens Fruhwirth (1):
      Add usbreset.c as noinst_PROGRAMS target.

Daniel Schaefer (1):
      lsusb: Read unkown names from sysfs device desc.

Darsey Litzenberger (3):
      Remove a small hack that no longer has any effect.
      Cleanup grammar
      lsusb-t: Emit USB IDs and other handy info when verbosity is increased

Emmanuele Bassi (1):
      Require newer version of libusb

Georg Brandl (1):
      lsusb.py: fix up Python 3 conversion

Greg Kroah-Hartman (10):
      SPDX bill-of-material is supposed to be project_name.spdx
      usbutils.spdx: rerun report, it is properly sorted.
      desc-dump.c: fix compiler warning about unused variable
      add usbreset to .gitignore
      usbreset: fix some build warnings
      usbhid-dump: update to latest version
      fix up standard int types
      update usbhid-dump git id
      usbhid-dump: update to a newer version of usbhid-dump again.
      usbutils.spdx: update with latest information

Kurt Garloff (4):
      lsusb.py: Search multiple paths for usb.ids.
      lsusb.py: Usb enum for parser state machine.
      lsusb.py: Add driver names for usbhid.
      lsusb.py: python2 compatibility

Lukas Nykryn (1):
      Makefile.am: add files with licenses to archive

Mantas Mikulėnas (33):
      lsusb.py: sort devices and interfaces numerically
      lsusb.py: sort toplevel entries
      lsusb.py: improve usage text
      lsusb.py: replace fake deepcopy()
      lsusb.py: remove -w (warn if usb.ids not sorted) option
      lsusb.py: ensure all error messages are written to stderr
      lsusb.py: support long options
      lsusb.py: use regular print() instead of hand-rolling the same thing
      lsusb.py: avoid shadowing Python's built-in 'str'
      lsusb.py: replace usb.ids binary search with dict lookup
      lsusb.py: remove now-unused bin_search()
      lsusb.py: avoid manual calls to __foo__()
      lsusb.py: replace __repr__() for USB IDs with __str__()
      lsusb.py: insert class FF:FF:FF into usbclasses to avoid special casing
      lsusb.py: entirely remove Usb* classes
      lsusb.py: cosmetic - replace tuples-as-"immutable lists" with regular lists
      lsusb.py: use 'elif' where suitable
      lsusb.py: remove dead code
      lsusb.py: move unrelated code out of try..except
      lsusb.py: allow - as well as _ when matching hci module names
      lsusb.py: use a constant for the magic class number 9
      lsusb.py: Usb* classes: call read() automatically from constructor
      lsusb.py: UsbEndpoint: indent is a class implementation detail
      lsusb.py: a few cosmetic changes
      lsusb.py: shorten find_usb_class()
      lsusb.py: give all Usb* objects a .path attribute
      lsusb.py: add an actual __repr__() to classes
      lsusb.py: give all Usb* classes a superclass
      lsusb.py: convert readattr() and readlink() to methods of the container
      lsusb.py: use color by default
      lsusb.py: rework output for more consistent indent of both columns
      lsusb.py: fix endpoint interval spacing
      lsusb.py: visually group USB-version-related fields

Michael Drake (4):
      lsusb: Split out routine that fetches value for given field.
      lsusb: Split out field name rendering.
      lsusb: Add support for descriptor extensions.
      lsusb: Add support for audio processing unit type-specific fields.

Philip Langdale (2):
      lsusb: Added support for Billboard Alternate Mode Capability descriptor
      lsusb.py: Fix formatting of 10Gbps speeds

Ross Burton (1):
      usb-devices: use /bin/sh hashbang

Solomon Peachy (1):
      lsusb:  Add support for decoding IPP printer descriptors

Stefan Tauner (1):
      Depend on libusb 1.0.14

Valerii Zapodovnikov (1):
      man pages: add information on verbosity levels of -t option

junjie (1):
      fix typo


------------


Now for the details of how the tarballs are released, if anyone is
interested.

Previously, to do a usbutils release, I would run 'make distcheck' on
the repository and upload the generated tarball, after signing it, to
kernel.org and it would do the correct compression and signatures and
all is good.  But that means a bunch of auto-generated files are added
to the tarball, which are pulled from my system based on any sort of
random choice of autotools that I happened to have installed.

So a tarball would not represent the actual files checked into the git
repo, you would just have to "trust" that the files in the tarball that
were not part of git, were "ok".  And that's fine, it's the way almost
all packages have ever been distributed for the past 30+ years, since
when autotools was created.

But now, kernel.org has the ability to create a signed tarball, based on
a signed git tag.  We have been using this ability for a while now to do
kernel releases (both the stable and Linus's releases.)  This means that
the git repo itself is the "true source" of all of the files, and what
is distributed and signed is the exact same thing that is in the
repository.

So now things can be properly verified.  You can check that the files in
the tarball are identical to the ones in the git repository at that same
point in time.

But what this means is that now to build from the tarball, you have to
run the 'autogen.sh' script, instead of running 'configure'.  This is
normally what a lot of distributions did anyway, as that way they would
"know" what version of autotools was building the package, because all
distros happen to use a different version.

Also, the other bad side affect was that the usbhid-dump repository,
which was a git submodule in usbutils, was not built at all as part of
the usbutils release.  This is the reason that the 011 release that
happened yesterday did not contain usbhid-dump, and why I did the 012
release today to make up for that missing tool.

So, in conclusion, if you are a distro packager, you now have a way to
verify that the tarball matches exactly the git repository at a specific
point in time, and you should feel safer packaging things up as you are
not relying on random scripts that are pulled from my personal machine.

If you are a user of usbutils, none of this matters at all, but thanks
for reading this far.

If there are any questions, about any of this, please let me know.

thanks,

greg k-h
