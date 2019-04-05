Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C652C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C00021855
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfDEVpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:45:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:51874 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbfDEVo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 17:44:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 14:44:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,313,1549958400"; 
   d="scan'208";a="140486251"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.181])
  by fmsmga007.fm.intel.com with ESMTP; 05 Apr 2019 14:44:55 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] docs: sphinx: Add support :nosymbols: to exclude specific symbols
Date:   Fri,  5 Apr 2019 14:44:53 -0700
Message-Id: <20190405214453.18768-5-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190405214453.18768-1-sean.j.christopherson@intel.com>
References: <20190405214453.18768-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add :nosymbols: so that documentation of symbols can be organized in the
final output of makedocs.  For example, files that define a large number
of symbols may want to categorize their symbols.  Another example is
SGX, which introduces a uapi header that defines structs for ioctls and
for a new vDSO function[1].  Ideally, the documentation for the vDSO
struct will be placed into a different section.

[1] https://lkml.kernel.org/r/20190320162119.4469-25-jarkko.sakkinen@linux.intel.com

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 Documentation/sphinx/kerneldoc.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index c52b6caac356..d1eb1907858b 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -48,6 +48,7 @@ class KernelDocDirective(Directive):
     option_spec = {
         'doc': directives.unchanged_required,
         'functions': directives.unchanged,
+        'nosymbols': directives.unchanged,
         'export': directives.unchanged,
         'internal': directives.unchanged,
     }
@@ -81,6 +82,10 @@ class KernelDocDirective(Directive):
                     cmd += ['-symbol', f]
             else:
                 cmd += ['-no-doc-sections']
+        elif 'nosymbols' in self.options:
+            symbols = self.options.get('nosymbols').split()
+            for s in symbols:
+                cmd += ['-nosymbol', s]
 
         for pattern in export_file_patterns:
             for f in glob.glob(env.config.kerneldoc_srctree + '/' + pattern):
-- 
2.21.0

