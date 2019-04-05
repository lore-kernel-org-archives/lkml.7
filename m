Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA33BC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776DD2173C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfDEVSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:18:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:26008 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbfDEVSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 17:18:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 14:18:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,313,1549958400"; 
   d="scan'208";a="148469708"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.181])
  by orsmga002.jf.intel.com with ESMTP; 05 Apr 2019 14:18:21 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel-doc: Let backtick and backslash escape percent sign
Date:   Fri,  5 Apr 2019 14:18:20 -0700
Message-Id: <20190405211820.17617-1-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a handful of instances where kernel doc comments want an
actual '%' in the final output, e.g. vsnprintf() wants to display "%n"
and "%p" to document format specifiers, and assembly functions that use
a custom call ABI may want to document their register usage, e.g. %eax.

Because kernel-doc unconditionally interprets '%' followed by a word
character as a constant definition, i.e. %CONST, it's impossible to get
an actual '%\w' when kernel-doc is used to translate comments into rst
format.  Treat backtick and backlash as escaping '%', the former to
handle '%' in a ``LITERAL``, and the latter to allow '%' when using
standard formatting.

An alternative option would be to define a fancier set of rules for
interpreting '%' so that explicit escaping would not be required.  For
example, require "%CONST" to be preceded by a recognized set of
characters, e.g. whitespace, opening parenthesis, etc...  But the list
of recognized characters is quite large even in the current code base,
and using '\' to escape is more common and intuitive, i.e. most people
will naturally try doing "\%..." to get the desired formatting, whereas
losing %CONST formatting because of an unrecognized character is likely
to cause confusion.

Except for the aforementioned vsnprintf(), all .html output files from
`make htmldocs` are identical before and after this change.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 scripts/kernel-doc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 3350e498b4ce..1890deb16725 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -210,7 +210,7 @@ my $anon_struct_union = 0;
 
 # match expressions used to find embedded type information
 my $type_constant = '\b``([^\`]+)``\b';
-my $type_constant2 = '\%([-_\w]+)';
+my $type_constant2 = '(^|[^\`\\\])\%([-_\w]+)';
 my $type_func = '(\w+)\(\)';
 my $type_param = '\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
 my $type_fp_param = '\@(\w+)\(\)';  # Special RST handling for func ptr params
@@ -229,7 +229,7 @@ my $type_member_func = $type_member . '\(\)';
 # these are pretty rough
 my @highlights_man = (
                       [$type_constant, "\$1"],
-                      [$type_constant2, "\$1"],
+                      [$type_constant2, "\$1\$2"],
                       [$type_func, "\\\\fB\$1\\\\fP"],
                       [$type_enum, "\\\\fI\$1\\\\fP"],
                       [$type_struct, "\\\\fI\$1\\\\fP"],
@@ -244,7 +244,7 @@ my $blankline_man = "";
 # rst-mode
 my @highlights_rst = (
                        [$type_constant, "``\$1``"],
-                       [$type_constant2, "``\$1``"],
+                       [$type_constant2, "\$1``\$2``"],
                        # Note: need to escape () to avoid func matching later
                        [$type_member_func, "\\:c\\:type\\:`\$1\$2\$3\\\\(\\\\) <\$1>`"],
                        [$type_member, "\\:c\\:type\\:`\$1\$2\$3 <\$1>`"],
-- 
2.21.0

