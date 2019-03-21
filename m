Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C52C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675B721916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbfCUSnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:43:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:6550 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728649AbfCUSnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:43:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 11:43:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,253,1549958400"; 
   d="scan'208";a="124718149"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.181])
  by orsmga007.jf.intel.com with ESMTP; 21 Mar 2019 11:43:20 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: [PATCH v2] docs: Clarify the usage and sign-off requirements for Co-developed-by
Date:   Thu, 21 Mar 2019 11:43:16 -0700
Message-Id: <20190321184316.8525-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.21.0
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

Lack of explicit direciton has resulted in developers taking a variety
of approaches, often lacking any intent whatsoever, e.g. scattering SOBs
willy-nilly, collecting them all at the end or the beginning, etc...

Tweak the wording to make it clear that multiple co-authors are allowed,
and document the expectation that standard sign-off procedures are to
be followed.  Provide examples to (hopefully) eliminate any ambiguity.

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

v1: https://lkml.kernel.org/r/20190320151140.32432-1-sean.j.christopherson@intel.com
v2: Rewrite the blurb to state standard sign-off procedure should be
    followed as opposed to dictating the original author's SOB be last.

 Documentation/process/submitting-patches.rst | 24 +++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index be7d1829c3af..a7a9da68a384 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -545,10 +545,28 @@ person it names - but it should indicate that this person was copied on the
 patch.  This tag documents that potentially interested parties
 have been included in the discussion.
 
-A Co-developed-by: states that the patch was also created by another developer
+A Co-developed-by: states that the patch was co-created by other developer(s)
 along with the original author.  This is useful at times when multiple people
-work on a single patch.  Note, this person also needs to have a Signed-off-by:
-line in the patch as well.
+work on a single patch.  Every Co-developed-by: must be immediately followed by
+a Signed-off-by: of the co-author.  Standard sign-off procedure applies, i.e.
+the ordering of Co-developed-by:/Signed-off-by: pairs should reflect the
+chronological history of the patch insofar as possible.  Notably, the last
+Signed-off-by: must always be that of the developer submitting the patch,
+regardless of whether they are the original author or a co-author.
+
+Example of a patch with multiple co-authors, submitted by the original author::
+
+	Co-developed-by: First Co-Author <first@coauthor.example.org>
+	Signed-off-by: First Co-Author <first@coauthor.example.org>
+	Co-developed-by: Second Co-Author <second@coauthor.example.org>
+	Signed-off-by: Second Co-Author <second@coauthor.example.org>
+	Signed-off-by: Original Author <original@author.example.org>
+
+Example of a patch submitted by a co-author::
+
+	Signed-off-by: Original Author <original@author.example.org>
+	Co-developed-by: Submitting Co-Author <sub@coauthor.example.org>
+	Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>
 
 
 13) Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:
-- 
2.21.0

