Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FCDC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC4724742
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559657984;
	bh=b5hFl5vAfjcYfUqYbkXGPwpc5uXOpV8PfYs6WkEgXAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oELwAq94opOww7kO/XKBL8HFNcMTIf1aEfmqXQBIRa2USxi8+0X35lTAlTp0WQnvj
	 ccu3hdXTQ8vTYFTX22dumPMUgLEWodOp6yTSQJhYX3k7Q/q3e+Ut0BxT14mKg9TPVh
	 b63OuvC+OUHfmonAekIGynsEGpb0Jwt+mLSWo+Qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfFDOTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:19:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727408AbfFDOSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iin/rdSO0fH26p9LlU038nNL9Jh7a8Qf/HGkBqoFdvo=; b=XgN7w3B42kFk+jBxuEN+zaNJMv
        LwUzSxEeX3iaiIhuMKPlDVHB7aHJrFFOAD3EkLQTAnprmAnSFMMvDH6PjOIeSB2VqiHabPCCgUXBa
        jcaCFh23Znibn7aP8/l7vnOxSH+CkQ/jbZW0RXrHNMzkCupSyqiTzlnBRnMDg1HMoDBtJrpxvJCz5
        3m5qfZP6+O1kSuYwYVQgAAPclyTjvTVxKercof2Ss9qqgTkQr/O+OU2pzUms+5regIjePb2EuIFbq
        y6zIf7N2clssAUPFtxFC7p3Fh8WkGwJ8vrjwdMzE1dw5iV5lx3lv1Y2f9Dgvu54wcfRmrxz20mvMf
        dqYmiMyA==;
Received: from [179.182.172.34] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYAGH-0001Rx-U6; Tue, 04 Jun 2019 14:18:01 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hYAGF-0002mK-2i; Tue, 04 Jun 2019 11:17:59 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 22/22] docs: Kbuild/Makefile: allow check for missing docs at build time
Date:   Tue,  4 Jun 2019 11:17:56 -0300
Message-Id: <a092d6340a59425593355fb456435208389bc9b0.1559656538.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559656538.git.mchehab+samsung@kernel.org>
References: <cover.1559656538.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While this doesn't make sense for production Kernels, in order to
avoid regressions when new documents are added, let's add a
check target at the make file.

For now, the only check it does is to verify if there isn't
any documents with a broken link.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/Kconfig                | 13 +++++++++++++
 Documentation/Makefile               |  5 +++++
 Kconfig                              |  2 ++
 scripts/documentation-file-ref-check |  9 +++++++++
 4 files changed, 29 insertions(+)
 create mode 100644 Documentation/Kconfig

diff --git a/Documentation/Kconfig b/Documentation/Kconfig
new file mode 100644
index 000000000000..66046fa1c341
--- /dev/null
+++ b/Documentation/Kconfig
@@ -0,0 +1,13 @@
+config WARN_MISSING_DOCUMENTS
+
+	bool "Warn if there's a missing documentation file"
+	depends on COMPILE_TEST
+	help
+	   It is not uncommon that a document gets renamed.
+	   This option makes the Kernel to check for missing dependencies,
+	   warning when something is missing. Works only if the Kernel
+	   is built from a git tree.
+
+	   If unsure, select 'N'.
+
+
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2edd03b1dad6..89857285a024 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -4,6 +4,11 @@
 
 subdir-y := devicetree/bindings/
 
+# Check for broken documentation file references
+ifeq ($(CONFIG_WARN_MISSING_DOCUMENTS),y)
+$(shell $(srctree)/scripts/documentation-file-ref-check --warn)
+endif
+
 # You can set these variables from the command line.
 SPHINXBUILD   = sphinx-build
 SPHINXOPTS    =
diff --git a/Kconfig b/Kconfig
index 48a80beab685..990b0c390dfc 100644
--- a/Kconfig
+++ b/Kconfig
@@ -30,3 +30,5 @@ source "crypto/Kconfig"
 source "lib/Kconfig"
 
 source "lib/Kconfig.debug"
+
+source "Documentation/Kconfig"
diff --git a/scripts/documentation-file-ref-check b/scripts/documentation-file-ref-check
index ff16db269079..440227bb55a9 100755
--- a/scripts/documentation-file-ref-check
+++ b/scripts/documentation-file-ref-check
@@ -22,9 +22,16 @@ $scriptname =~ s,.*/([^/]+/),$1,;
 # Parse arguments
 my $help = 0;
 my $fix = 0;
+my $warn = 0;
+
+if (! -d ".git") {
+	printf "Warning: can't check if file exists, as this is not a git tree";
+	exit 0;
+}
 
 GetOptions(
 	'fix' => \$fix,
+	'warn' => \$warn,
 	'h|help|usage' => \$help,
 );
 
@@ -139,6 +146,8 @@ while (<IN>) {
 			if (!($ref =~ m/(scripts|Kconfig|Kbuild)/)) {
 				$broken_ref{$ref}++;
 			}
+		} elsif ($warn) {
+			print STDERR "Warning: $f references a file that doesn't exist: $fulref\n";
 		} else {
 			print STDERR "$f: $fulref\n";
 		}
-- 
2.21.0

