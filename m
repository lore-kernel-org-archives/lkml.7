Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668F7C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A65620674
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfKYPuz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:50:55 -0500
Received: from ms.lwn.net ([45.79.88.28]:57028 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728592AbfKYPuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:50:54 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0E7202E7;
        Mon, 25 Nov 2019 15:50:53 +0000 (UTC)
Date:   Mon, 25 Nov 2019 08:50:52 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joe Perches <joe@perches.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steve French <stfrench@microsoft.com>,
        Olof Johansson <olof@lixom.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Maintainer Entry Profiles
Message-ID: <20191125085052.05cfe063@lwn.net>
In-Reply-To: <157462918268.1729495.10257190766638995699.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157462918268.1729495.10257190766638995699.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Nov 2019 12:59:42 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Changes since v2 [1]:
> - Drop any consideration for coding style concerns in the profile. It
>   was a minor aspect of the proposal that generated the bulk of the
>   feedback on v2. Lets make progress on the rest.
> 
> - Clarify that the "Submit Checklist Addendum" can also include details
>   that submitters need to take into account before even beginning to
>   craft a patch. This is in response to the RISC-V use case of
>   declaring specification readiness as a patch gate, and is now also used
>   by the libnvdimm subsystem to clarify details about ACPI NVDIMM Device
>   Specific Method specifications. (Paul)
> 
> - Non-change from v2: Kees had asked for a common directory for all
>   profiles to live, but Mauro noted that this could be handled later
>   with some scripting to post-process the MAINTAINERS file, or otherwise
>   converting MAINTAINERS to ReST.
> 
> - Clarify the cover letter to focus on the contributor focused
>   Maintainer Entry Profiles, and defer discussion of a maintainer
>   focused Handbook.

OK, some notes...

I wish you'd done this against docs-next, that would have saved me
resolving a few conflicts on the MAINTAINERS file.

I thought we'd agreed to move this to the process book?  That said, I now
wonder about that...today I read the document as information for
maintainers on how to create their profile, so its location in the
maintainers manual is appropriate.

There were a number RST issues and warnings that I fixed up with the
following add-on patch; it was mostly a matter of adding blank lines where
needed.

One other warning resulted from the nvdimm profile document not being
linked into the TOC tree.  I've added a TOC section to the new document to
bring these things together for now.  This is almost certainly not what we
want in the longer term.

It was tempting to ask for this stuff to be fixed up, but I didn't want to
delay this work any longer.  So it's applied to docs-next; unless something
explodes in the very near future, I intend to push this for 5.5.

Thanks,

jon

From 0bfa52a43ec085c2f5eb2c35fcc6cf73bb802eae Mon Sep 17 00:00:00 2001
From: Jonathan Corbet <corbet@lwn.net>
Date: Mon, 25 Nov 2019 08:42:12 -0700
Subject: [PATCH 2/2] docs: fix up the maintainer profile document

Add blank lines where needed to get the document to render properly.  Also
add a TOC of existing profiles just so that the nvdimm profile is linked
into the toctree, is discoverable, and doesn't generate a warning.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 .../maintainer/maintainer-entry-profile.rst       | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/maintainer/maintainer-entry-profile.rst b/Documentation/maintainer/maintainer-entry-profile.rst
index 51de3b9e606d..3eaddc8ac56d 100644
--- a/Documentation/maintainer/maintainer-entry-profile.rst
+++ b/Documentation/maintainer/maintainer-entry-profile.rst
@@ -18,7 +18,9 @@ Provide an introduction to how the subsystem operates. While MAINTAINERS
 tells the contributor where to send patches for which files, it does not
 convey other subsystem-local infrastructure and mechanisms that aid
 development.
+
 Example questions to consider:
+
 - Are there notifications when patches are applied to the local tree, or
   merged upstream?
 - Does the subsystem have a patchwork instance? Are patchwork state
@@ -55,6 +57,7 @@ be settled in soaking in linux-next in advance of the merge window
 opening. Clarify for the submitter the key dates (in terms rc release
 week) that patches might considered for merging and when patches need to
 wait for the next -rc. At a minimum:
+
 - Last -rc for new feature submissions:
   New feature submissions targeting the next merge window should have
   their first posting for consideration before this point. Patches that
@@ -72,6 +75,7 @@ wait for the next -rc. At a minimum:
   resubmit for the following merge window.
 
 Optional:
+
 - First -rc at which the development baseline branch, listed in the
   overview section, should be considered ready for new submissions.
 
@@ -85,3 +89,14 @@ section can also indicate a preferred style of update like, resend the
 full series, or privately send a reminder email. This section might also
 list how review works for this code area and methods to get feedback
 that are not directly from the maintainer.
+
+Existing profiles
+-----------------
+
+For now, existing maintainer profiles are listed here; we will likely want
+to do something different in the near future.
+
+.. toctree::
+   :maxdepth: 1
+
+   ../nvdimm/maintainer-entry-profile
-- 
2.21.0

