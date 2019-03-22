Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD33C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E882190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfCVVLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:11:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:26211 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfCVVLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:11:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 14:11:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="329837773"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.181])
  by fmsmga006.fm.intel.com with ESMTP; 22 Mar 2019 14:11:38 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Tobin C . Harding" <me@tobin.cc>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH v5 1/2] docs: Clarify the usage and sign-off requirements for Co-developed-by
Date:   Fri, 22 Mar 2019 14:11:36 -0700
Message-Id: <20190322211137.18241-2-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322211137.18241-1-sean.j.christopherson@intel.com>
References: <20190322211137.18241-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation for Co-developed-by is a bit light on details, e.g. it
doesn't explicitly state that:

  - Multiple Co-developed-by tags are perfectly acceptable
  - Co-developed-by and Signed-off-by must be paired together
  - SOB ordering should still follow standard sign-off procedure

Lack of explicit direction has resulted in developers taking a variety
of approaches, often lacking any intent whatsoever, e.g. scattering SOBs
willy-nilly, collecting them all at the end or the beginning, etc...
Tweak the wording to make it clear that multiple co-authors are allowed,
and document the expectation that standard sign-off procedures are to
be followed.

The use of "original author" has also led to confusion as many patches
don't have just one "original" author, e.g. when multiple developers
are involved from the genesis of the patch.  Remove all usage of
"original" and instead call out that Co-developed-by is simply a way to
provide attribution in addition to the From tag, i.e. neither tag is
intended to imply anything with regard to who did what.

Provide examples to (hopefully) eliminate any ambiguity.

Cc: Tobin C. Harding <me@tobin.cc>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Joe Perches <joe@perches.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Niklas Cassel <niklas.cassel@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 Documentation/process/5.Posting.rst          | 10 +++--
 Documentation/process/submitting-patches.rst | 40 +++++++++++++++++---
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/Documentation/process/5.Posting.rst b/Documentation/process/5.Posting.rst
index 4213e580f273..855a70b80269 100644
--- a/Documentation/process/5.Posting.rst
+++ b/Documentation/process/5.Posting.rst
@@ -216,10 +216,12 @@ The tags in common use are:
    which can be found in :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
    Code without a proper signoff cannot be merged into the mainline.
 
- - Co-developed-by: states that the patch was also created by another developer
-   along with the original author.  This is useful at times when multiple
-   people work on a single patch.  Note, this person also needs to have a
-   Signed-off-by: line in the patch as well.
+ - Co-developed-by: states that the patch was co-created by several developers;
+   it is a used to give attribution to co-authors (in addition to the author
+   attributed by the From: tag) when multiple people work on a single patch.
+   Every Co-developed-by: must be immediately followed by a Signed-off-by: of
+   the associated co-author.  Details and examples can be found in
+   :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`.
 
  - Acked-by: indicates an agreement by another developer (often a
    maintainer of the relevant code) that the patch is appropriate for
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index be7d1829c3af..06db26b12495 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -545,10 +545,40 @@ person it names - but it should indicate that this person was copied on the
 patch.  This tag documents that potentially interested parties
 have been included in the discussion.
 
-A Co-developed-by: states that the patch was also created by another developer
-along with the original author.  This is useful at times when multiple people
-work on a single patch.  Note, this person also needs to have a Signed-off-by:
-line in the patch as well.
+Co-developed-by: states that the patch was co-created by multiple developers;
+it is a used to give attribution to co-authors (in addition to the author
+attributed by the From: tag) when several people work on a single patch.  Since
+Co-developed-by: denotes authorship, every Co-developed-by: must be immediately
+followed by a Signed-off-by: of the associated co-author.  Standard sign-off
+procedure applies, i.e. the ordering of Signed-off-by: tags should reflect the
+chronological history of the patch insofar as possible, regardless of whether
+the author is attributed via From: or Co-developed-by:.  Notably, the last
+Signed-off-by: must always be that of the developer submitting the patch.
+
+Note, the From: tag is optional when the From: author is also the person (and
+email) listed in the From: line of the email header.
+
+Example of a patch submitted by the From: author::
+
+	<changelog>
+
+	Co-developed-by: First Co-Author <first@coauthor.example.org>
+	Signed-off-by: First Co-Author <first@coauthor.example.org>
+	Co-developed-by: Second Co-Author <second@coauthor.example.org>
+	Signed-off-by: Second Co-Author <second@coauthor.example.org>
+	Signed-off-by: From Author <from@author.example.org>
+
+Example of a patch submitted by a Co-developed-by: author::
+
+	From: From Author <from@author.example.org>
+
+	<changelog>
+
+	Co-developed-by: Random Co-Author <random@coauthor.example.org>
+	Signed-off-by: Random Co-Author <random@coauthor.example.org>
+	Signed-off-by: From Author <from@author.example.org>
+	Co-developed-by: Submitting Co-Author <sub@coauthor.example.org>
+	Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>
 
 
 13) Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:
@@ -696,7 +726,7 @@ A couple of example Subjects::
 The ``from`` line must be the very first line in the message body,
 and has the form:
 
-        From: Original Author <author@example.com>
+        From: Patch Author <author@example.com>
 
 The ``from`` line specifies who will be credited as the author of the
 patch in the permanent changelog.  If the ``from`` line is missing,
-- 
2.21.0

