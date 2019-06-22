Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C715CC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F77021537
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561222746;
	bh=Izwb3qneal9+mJvnMTUEsO4Pu+KlXL6Oy8lIDuzNy0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BvJ1BqeQC8GQmft8x2VLagNouk9E+aYfb1JPW4aswKRFcANiRMt76LSZms8w/TLUI
	 HTI9jlATMdhRoaNvP4OXuJ2pkOVsNSw+rp2BLYVTnFE+kBHjeiPoTKWPoZWuAOleCM
	 tXVpmIPr1Q3pOWci3dOViOY0Oqtx3QZgvsx2NjO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfFVQ7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 12:59:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42782 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfFVQ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 12:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wUOTS3HryG6x00ef7iH2jAuPJMzHPQ4G3RtuWtIiYCg=; b=K/xujI0hmZp0FjlKtLwZmemMjS
        1yNsp3HVxn0T5YhiyzjMZnyXmmRz7pm8EppALXyRjC0yWg7ZOh8DozbQjoakoK4kNEGipP1+3u/b/
        dQNHr8M0J1wBzz3f7ECrW1EYD8r57ub+kAsxggl7jlBuxck/r7TaQYi2xx8aZmiIP474TzNGcWLCu
        f+Ns0Vt+8RohGjUOj66Z/Ws/CoXgNeklqSycdItTN5lsrmnWAXZAV4m/BSOZPGIxRctnE2jUi5IaU
        ZWU0Lb6/QqOog1BtIXz2gUniZVk0uwqbBkQdlJ83lt7W2L6D522Zt7JmCth6p9XwK/nRYCmJ+4g4Z
        xAdaqJvw==;
Received: from [179.95.45.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hejLu-00054r-HC; Sat, 22 Jun 2019 16:58:58 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hejLr-0000vH-SE; Sat, 22 Jun 2019 13:58:55 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] scripts/get_abi.pl: Allow optionally record from where a line came from
Date:   Sat, 22 Jun 2019 13:58:44 -0300
Message-Id: <911c5307e1aea9a2a65f313497671b600efa834c.1561221403.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561221403.git.mchehab+samsung@kernel.org>
References: <cover.1561221403.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The get_abi.pl reads a lot of files and can join them on a
single output file. Store where each "What:" output came from,
in order to be able to optionally display it.

This is useful for the Sphinx extension, with can now be
able to blame what ABI file has issues, and on what line
the What: description with problems begin.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_abi.pl | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 0c403af86fd5..6a4d387ebf3b 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -10,6 +10,7 @@ use Fcntl ':mode';
 my $help;
 my $man;
 my $debug;
+my $enable_lineno;
 my $prefix="Documentation/ABI";
 
 #
@@ -19,6 +20,7 @@ my $description_is_rst = 0;
 
 GetOptions(
 	"debug|d+" => \$debug,
+	"enable-lineno" => \$enable_lineno,
 	"rst-source!" => \$description_is_rst,
 	"dir=s" => \$prefix,
 	'help|?' => \$help,
@@ -67,6 +69,7 @@ sub parse_abi {
 	$data{$nametag}->{file} = $name;
 	$data{$nametag}->{filepath} = $file;
 	$data{$nametag}->{is_file} = 1;
+	$data{$nametag}->{line_no} = 1;
 
 	my $type = $file;
 	$type =~ s,.*/(.*)/.*,$1,;
@@ -126,6 +129,8 @@ sub parse_abi {
 			if ($tag ne "" && $new_tag) {
 				$tag = $new_tag;
 
+				$data{$what}->{line_no} = $ln;
+
 				if ($new_what) {
 					@{$data{$what}->{label}} = @labels if ($data{$nametag}->{what});
 					@labels = ();
@@ -221,6 +226,12 @@ sub output_rest {
 		my $file = $data{$what}->{file};
 		my $filepath = $data{$what}->{filepath};
 
+		if ($enable_lineno) {
+			printf "#define LINENO %s%s#%s\n\n",
+			       $prefix, $data{$what}->{file},
+			       $data{$what}->{line_no};
+		}
+
 		my $w = $what;
 		$w =~ s/([\(\)\_\-\*\=\^\~\\])/\\$1/g;
 
@@ -369,6 +380,10 @@ sub search_symbols {
 	}
 }
 
+# Ensure that the prefix will always end with a slash
+# While this is not needed for find, it makes the patch nicer
+# with --enable-lineno
+$prefix =~ s,/?$,/,;
 
 #
 # Parses all ABI files located at $prefix dir
@@ -395,7 +410,8 @@ abi_book.pl - parse the Linux ABI files and produce a ReST book.
 
 =head1 SYNOPSIS
 
-B<abi_book.pl> [--debug] [--man] [--help] --[(no-)rst-source] [--dir=<dir>] <COMAND> [<ARGUMENT>]
+B<abi_book.pl> [--debug] [--enable-lineno] [--man] [--help]
+	       [--(no-)rst-source] [--dir=<dir>] <COMAND> [<ARGUMENT>]
 
 Where <COMMAND> can be:
 
@@ -425,6 +441,10 @@ selecting between a rst-compliant source ABI (--rst-source), or a
 plain text that may be violating ReST spec, so it requres some escaping
 logic (--no-rst-source).
 
+=item B<--enable-lineno>
+
+Enable output of #define LINENO lines.
+
 =item B<--debug>
 
 Put the script in verbose mode, useful for debugging. Can be called multiple
-- 
2.21.0

