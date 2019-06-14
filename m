Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9508C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A226921841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560534818;
	bh=wti4Kd0LTzvG/Fj8Loxd3SwW/zAKqXnojYMq9XwjLnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FR5VQHqSwAk707IhgwdyPnfzt+SEG6iT5AHU3daZFX/17B3rbFEzz032QYiSi5v1Y
	 IqwOl3oYejec/sDAL8A8jD4bijqXmXatJIxNKBv8dY9fsuVA1FiISPYDkoeJNrWKHg
	 X3xYIf8HljVKX7DZuQNYWmAd6PVu32hgTcosnB7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfFNRxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:53:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38698 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfFNRwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/v1AAw7om1V/odGoZszjgQFtzJKsLoAGR/3cdXZzrpw=; b=lTpUvIAd/F8l4cCpDxm3Dq4sjh
        Ss68Yohhl2qG8EJztKjSqfoUlYBHWNDVsCiCO3BLyOn8hVpXsprhxRCYjxX8GpVMet/i1wti7MGfa
        qUeF3L8a8x/X3I6J32o65HqV14Qro88ua3DhEJdbd2ja0mQ8eRSwaDBdkUsEZ5HZBS7ij1B93fZ2u
        2wnhL2Xs8Yhw0byrSeSlFNzIcMHaczC3W7Eh2kCxvCxjo3Sl8Hc7safqWHMuQ1QIKBhViMJo0qFCP
        bCwiHKtUZ85aDaMOAMwddgnCLQuHxnlWa4VRULVlFITTnbqDa4fZG9iCiwsB+SvYDGxCIO9NK938T
        X4RhDe3w==;
Received: from 177.133.85.52.dynamic.adsl.gvt.net.br ([177.133.85.52] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbqNO-0000Pk-Sr; Fri, 14 Jun 2019 17:52:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbqNM-0002PS-3h; Fri, 14 Jun 2019 14:52:32 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Changbin Du <changbin.du@intel.com>
Subject: [PATCH v2 16/16] docs: Kconfig/Makefile: add a check for broken ABI files
Date:   Fri, 14 Jun 2019 14:52:30 -0300
Message-Id: <9ad24385565c0395e06ccb0e058184744f6e4c3b.1560534648.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
References: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The files under Documentation/ABI should follow the syntax
as defined at Documentation/ABI/README.

Allow checking if they're following the syntax by running
the ABI parser script on COMPILE_TEST.

With that, when there's a problem with a file under
Documentation/ABI, it would produce a warning like:

	Warning: file ./Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats#14:
		What '/sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_cor' doesn't have a description
	Warning: file ./Documentation/ABI/testing/sysfs-bus-pci-devices-aer_stats#21:
		What '/sys/bus/pci/devices/<dev>/aer_stats/aer_rootport_total_err_fatal' doesn't have a description

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/Kconfig  | 11 +++++++++++
 Documentation/Makefile |  5 +++++
 lib/Kconfig.debug      |  2 ++
 scripts/get_abi.pl     | 14 +++++++++++---
 4 files changed, 29 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/Kconfig

diff --git a/Documentation/Kconfig b/Documentation/Kconfig
new file mode 100644
index 000000000000..a8b0701c1422
--- /dev/null
+++ b/Documentation/Kconfig
@@ -0,0 +1,11 @@
+config WARN_ABI_ERRORS
+	bool "Warn if there are errors at ABI files"
+	depends on COMPILE_TEST
+	help
+	   The files under Documentation/ABI should follow what's
+	   described at Documentation/ABI/README. Yet, as they're manually
+	   written, it would be possible that some of those files would
+	   have errors that would break them for being parsed by
+	   scripts/get_abi.pl. Add a check to verify them.
+
+	   If unsure, select 'N'.
diff --git a/Documentation/Makefile b/Documentation/Makefile
index e889e7cb8511..c6480ed22884 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -4,6 +4,11 @@
 
 subdir-y := devicetree/bindings/
 
+# Check for broken ABI files
+ifeq ($(CONFIG_WARN_ABI_ERRORS),y)
+$(shell $(srctree)/scripts/get_abi.pl validate --dir $(srctree)/Documentation/ABI)
+endif
+
 # You can set these variables from the command line.
 SPHINXBUILD   = sphinx-build
 SPHINXOPTS    =
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cbdfae379896..b1b7e141ca99 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2110,4 +2110,6 @@ config IO_STRICT_DEVMEM
 
 source "arch/$(SRCARCH)/Kconfig.debug"
 
+source "Documentation/Kconfig"
+
 endmenu # Kernel hacking
diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 774e9b809ead..25248c012eb3 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -38,7 +38,15 @@ my %data;
 sub parse_error($$$$) {
 	my ($file, $ln, $msg, $data) = @_;
 
-	print STDERR "file $file#$ln: $msg at\n\t$data";
+	$data =~ s/\s+$/\n/;
+
+	print STDERR "Warning: file $file#$ln:\n\t$msg";
+
+	if ($data ne "") {
+		print STDERR ". Line\n\t\t$data";
+	} else {
+	    print STDERR "\n";
+	}
 }
 
 #
@@ -94,7 +102,7 @@ sub parse_abi {
 
 			# Invalid, but it is a common mistake
 			if ($new_tag eq "where") {
-				parse_error($file, $ln, "tag 'Where' is invalid. Should be 'What:' instead", $_);
+				parse_error($file, $ln, "tag 'Where' is invalid. Should be 'What:' instead", "");
 				$new_tag = "what";
 			}
 
@@ -190,7 +198,7 @@ sub parse_abi {
 		}
 
 		# Everything else is error
-		parse_error($file, $ln, "Unexpected line:", $_);
+		parse_error($file, $ln, "Unexpected content", $_);
 	}
 	$data{$nametag}->{description} =~ s/^\n+//;
 	close IN;
-- 
2.21.0

