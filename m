Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6430BC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397902084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 15:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561130897;
	bh=1VBJpmC6sadiYep3SUdoKulshPSblr5E8TdsRr3Jpi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GI1/FYHMgo7RcGWobfjnRWKc3DEuE14upumizYZnFZH4kWCyZ5P3r9GBbN8WJrWFx
	 oRE2aLGDSlqn0gypZ8ZbJl7T0m+XKxKr/a5eDNyTDmABLeaMfZ4XnF3LPovTFPqsjk
	 WvLXSN8TEzyptDDku7DXonLyNpUog0bTneJ/Efrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfFUP2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 11:28:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53292 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFUP2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dfnoVNT3V7SYvYtsn9Bs6s7MUJu5ylj7M4ocTJKuFPw=; b=iEvd+xSq7niAE59MOOzJX8jdAx
        oRxFd1hYSYtb06ntz0iKVE1A0ykBGRQBUpUnNxZryPDjhyB53aNTctGI2cNY9p0g6fz/R0M9VmaRq
        pl/4tBj6TmIdD+iWo+XeIn6Xs65FQpur9Yb72zhFk1eZ1UA+7+eTiA3TcTrQ0TFmPyOtJoicpnQi6
        wksPo0+/IhOc1si1TPcmLyQOhhYEuBTGiuwOzu/tJD+2eDK2uOFDwVpJkZv0rKvTV4eIttz+AgU6+
        +qtVBFGV+rvI2xrM70nbIgC07AMWFk6y+gabmXebpr02PvX0xq3EerBYoHRj5duSIABK36hqN4LXG
        YhN6smHA==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1heLSR-0006Au-LP; Fri, 21 Jun 2019 15:28:07 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1heLSO-0005iB-Ik; Fri, 21 Jun 2019 12:28:04 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        gregkh@linuxfoundation.org
Subject: [PATCH 1/2] get_abi.pl: Allow optionally record from where a line came from
Date:   Fri, 21 Jun 2019 12:28:01 -0300
Message-Id: <00646c61f64f84f49c37d270b4c10511b0605c67.1561130657.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561130657.git.mchehab+samsung@kernel.org>
References: <cover.1561130657.git.mchehab+samsung@kernel.org>
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
 scripts/get_abi.pl | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 03f3c57af7ab..45453b7586bc 100755
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
@@ -134,6 +136,8 @@ sub parse_abi {
 			if ($tag ne "" && $new_tag) {
 				$tag = $new_tag;
 
+				$data{$what}->{line_no} = $ln;
+
 				if ($new_what) {
 					@{$data{$what}->{label}} = @labels if ($data{$nametag}->{what});
 					@labels = ();
@@ -229,6 +233,12 @@ sub output_rest {
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
 
@@ -377,6 +387,10 @@ sub search_symbols {
 	}
 }
 
+# Ensure that the prefix will always end with a slash
+# While this is not needed for find, it makes the patch nicer
+# with --enable-lineno
+$prefix =~ s,/?$,/,;
 
 #
 # Parses all ABI files located at $prefix dir
@@ -403,7 +417,8 @@ abi_book.pl - parse the Linux ABI files and produce a ReST book.
 
 =head1 SYNOPSIS
 
-B<abi_book.pl> [--debug] [--man] [--help] --[(no-)rst-source] [--dir=<dir>] <COMAND> [<ARGUMENT>]
+B<abi_book.pl> [--debug] [--enable-lineno] [--man] [--help]
+	       [--(no-)rst-source] [--dir=<dir>] <COMAND> [<ARGUMENT>]
 
 Where <COMMAND> can be:
 
@@ -433,6 +448,10 @@ selecting between a rst-compliant source ABI (--rst-source), or a
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

