Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E685C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D6721929
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfCVVLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:11:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:26211 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfCVVLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:11:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 14:11:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="329837775"
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
Subject: [PATCH v5 2/2] checkpatch: Warn on improper usage of Co-developed-by
Date:   Fri, 22 Mar 2019 14:11:37 -0700
Message-Id: <20190322211137.18241-3-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322211137.18241-1-sean.j.christopherson@intel.com>
References: <20190322211137.18241-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of Co-developed-by: is to give attribution to authors who
aren't already attributed by the From: tag, i.e. who aren't the nominal
patch author.  Because Co-developed-by: is essentially a variation of
From:, it must be accompanied by a Signed-off-by: of the associated
co-author.  To ease the burden of determining whether or not co-authors
have signed off, Co-developed-by and Signed-off-by: must be explicitly
paired, i.e. on consecutive lines for a given co-author.

Suggested-by: Joe Perches <joe@perches.com>
Cc: Tobin C. Harding <me@tobin.cc>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Niklas Cassel <niklas.cassel@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 scripts/checkpatch.pl | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 5b756278df13..bbe71f017f6d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2687,6 +2687,24 @@ sub process {
 			} else {
 				$signatures{$sig_nospace} = 1;
 			}
+
+# Check Co-developed-by: immediately followed by Signed-off-by: with same name and email
+			if ($sign_off =~ /^co-developed-by:$/i) {
+				if ($email eq $author) {
+					WARN("BAD_SIGN_OFF",
+					      "Co-developed-by: should not be used to attribute nominal patch author '$author'\n" . "$here\n" . $rawline);
+				}
+				if (!defined $lines[$linenr]) {
+					WARN("BAD_SIGN_OFF",
+                                             "Co-developed-by: must be immediately followed by Signed-off-by:\n" . "$here\n" . $rawline);
+				} elsif ($rawlines[$linenr] !~ /^\s*signed-off-by:\s*(.*)/i) {
+					WARN("BAD_SIGN_OFF",
+					     "Co-developed-by: must be immediately followed by Signed-off-by:\n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
+				} elsif ($1 ne $email) {
+					WARN("BAD_SIGN_OFF",
+					     "Co-developed-by and Signed-off-by: name/email do not match \n" . "$here\n" . $rawline . "\n" .$rawlines[$linenr]);
+				}
+			}
 		}
 
 # Check email subject for common tools that don't need to be mentioned
-- 
2.21.0

