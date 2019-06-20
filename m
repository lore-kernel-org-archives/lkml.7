Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596A9C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316CF2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561051537;
	bh=PEKZLitVhbwDreRAf3ZsyL/kr7CdyykeP6MBfLvsZTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mSxVmmq3wdL8pedtykMCs+pWOJGYMY94YmmZ2E7l6EoNQhvx2Ty4toPWd2LCzeSuY
	 VagyoGJNaq8q1YTGqa7epm2ScT0YEqxzNLf/lNDFGLgpAMI2BT5t5EF3oG+kbYMpEp
	 br26OH3TM2tsvZR9SVOfYGRHrcMblWNiq466Bp0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbfFTRZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:25:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52562 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFTRXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+TcnVW4oc5Non+1YyDCeuAoLNOkHuIVoRYv61A8PqOA=; b=fys93Vkq4CBY5OFP8T6LD4eE21
        k3+beOPwAxKRwDu+cn/+/TQ+BwKhhkQpBIV9p9rPgN+TV0uyyHn+YOdnp8FPtdlZnfCHJYYZkEBsZ
        y7iKSiGllpq1Dgw8t7LdW13j5BTw4lJ3iwA02A/pfKHpTUSpG+FUtUkrrRcmAdb8PddqwaXT4pNPv
        n3bDrT2Nh8f/MHXkxcGxPY9ob2HPD7y8XODfpnSnJsGMiwknAkKqD0YvSv52qu4Shsu3phqfiGBiD
        +2LnMsf79NWcbZ5dCorAsMCbbBOJ/B7IVVmY79lz8BXvvHBitcMpuvq/l9VURaOIHzwIFPC0OQmrL
        4cXQIWJA==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he0mM-0008S0-A8; Thu, 20 Jun 2019 17:23:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1he0mJ-0000D4-N4; Thu, 20 Jun 2019 14:23:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 07/22] scripts/get_abi.pl: add support for searching for ABI symbols
Date:   Thu, 20 Jun 2019 14:22:59 -0300
Message-Id: <72051952d8eac5a5aff20998909aeb52aeb4d773.1561050806.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561050806.git.mchehab+samsung@kernel.org>
References: <cover.1561050806.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change its syntax to allow switching between ReST output mode
and a new search mode, with allows to seek for ABI symbols
using regex.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_abi.pl | 112 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 103 insertions(+), 9 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index f84d321a72bb..ecf6b91df7c4 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -9,9 +9,11 @@ use Fcntl ':mode';
 my $help;
 my $man;
 my $debug;
+my $prefix="Documentation/ABI";
 
 GetOptions(
 	"debug|d+" => \$debug,
+	"dir=s" => \$prefix,
 	'help|?' => \$help,
 	man => \$man
 ) or pod2usage(2);
@@ -19,9 +21,12 @@ GetOptions(
 pod2usage(1) if $help;
 pod2usage(-exitstatus => 0, -verbose => 2) if $man;
 
-pod2usage(2) if (scalar @ARGV != 1);
+pod2usage(2) if (scalar @ARGV < 1 || @ARGV > 2);
 
-my ($prefix) = @ARGV;
+my ($cmd, $arg) = @ARGV;
+
+pod2usage(2) if ($cmd ne "search" && $cmd ne "rest");
+pod2usage(2) if ($cmd eq "search" && !$arg);
 
 require Data::Dumper if ($debug);
 
@@ -53,6 +58,7 @@ sub parse_abi {
 	$data{$nametag}->{what} = "File $name";
 	$data{$nametag}->{type} = "File";
 	$data{$nametag}->{file} = $name;
+	$data{$nametag}->{filepath} = $file;
 	$data{$nametag}->{is_file} = 1;
 
 	my $type = $file;
@@ -115,6 +121,7 @@ sub parse_abi {
 
 					$data{$what}->{type} = $type;
 					$data{$what}->{file} = $name;
+					$data{$what}->{filepath} = $file;
 					print STDERR "\twhat: $what\n" if ($debug > 1);
 				}
 
@@ -183,7 +190,9 @@ sub parse_abi {
 	close IN;
 }
 
-# Outputs the output on ReST format
+#
+# Outputs the book on ReST format
+#
 sub output_rest {
 	foreach my $what (sort keys %data) {
 		my $type = $data{$what}->{type};
@@ -262,6 +271,45 @@ sub output_rest {
 	}
 }
 
+#
+# Searches for ABI symbols
+#
+sub search_symbols {
+	foreach my $what (sort keys %data) {
+		next if (!($what =~ m/($arg)/));
+
+		my $type = $data{$what}->{type};
+		next if ($type eq "File");
+
+		my $file = $data{$what}->{filepath};
+
+		my $bar = $what;
+		$bar =~ s/./-/g;
+
+		print "\n$what\n$bar\n\n";
+
+		my $kernelversion = $data{$what}->{kernelversion};
+		my $contact = $data{$what}->{contact};
+		my $users = $data{$what}->{users};
+		my $date = $data{$what}->{date};
+		my $desc = $data{$what}->{description};
+		$kernelversion =~ s/^\s+//;
+		$contact =~ s/^\s+//;
+		$users =~ s/^\s+//;
+		$users =~ s/\n//g;
+		$date =~ s/^\s+//;
+		$desc =~ s/^\s+//;
+
+		printf "Kernel version:\t\t%s\n", $kernelversion if ($kernelversion);
+		printf "Date:\t\t\t%s\n", $date if ($date);
+		printf "Contact:\t\t%s\n", $contact if ($contact);
+		printf "Users:\t\t\t%s\n", $users if ($users);
+		print "Defined on file:\t$file\n\n";
+		print "Description:\n\n$desc";
+	}
+}
+
+
 #
 # Parses all ABI files located at $prefix dir
 #
@@ -270,9 +318,13 @@ find({wanted =>\&parse_abi, no_chdir => 1}, $prefix);
 print STDERR Data::Dumper->Dump([\%data], [qw(*data)]) if ($debug);
 
 #
-# Outputs an ReST file with the ABI contents
+# Handles the command
 #
-output_rest
+if ($cmd eq "rest") {
+	output_rest;
+} else {
+	search_symbols;
+}
 
 
 __END__
@@ -283,12 +335,27 @@ abi_book.pl - parse the Linux ABI files and produce a ReST book.
 
 =head1 SYNOPSIS
 
-B<abi_book.pl> [--debug] <ABI_DIR>]
+B<abi_book.pl> [--debug] <COMAND> [<ARGUMENT>]
+
+Where <COMMAND> can be:
+
+=over 8
+
+B<search> [SEARCH_REGEX] - search for [SEARCH_REGEX] inside ABI
+
+B<rest>   - output the ABI in ReST markup language
+
+=back
 
 =head1 OPTIONS
 
 =over 8
 
+=item B<--dir>
+
+Changes the location of the ABI search. By default, it uses
+the Documentation/ABI directory.
+
 =item B<--debug>
 
 Put the script in verbose mode, useful for debugging. Can be called multiple
@@ -306,8 +373,35 @@ Prints the manual page and exits.
 
 =head1 DESCRIPTION
 
-Parse the Linux ABI files from ABI DIR (usually located at Documentation/ABI)
-and produce a ReST book containing the Linux ABI.
+Parse the Linux ABI files from ABI DIR (usually located at Documentation/ABI),
+allowing to search for ABI symbols or to produce a ReST book containing
+the Linux ABI documentation.
+
+=head1 EXAMPLES
+
+Search for all stable symbols with the word "usb":
+
+=over 8
+
+$ scripts/get_abi.pl search usb --dir Documentation/ABI/stable
+
+=back
+
+Search for all symbols that match the regex expression "usb.*cap":
+
+=over 8
+
+$ scripts/get_abi.pl search usb.*cap
+
+=back
+
+Output all obsoleted symbols in ReST format
+
+=over 8
+
+$ scripts/get_abi.pl rest --dir Documentation/ABI/obsolete
+
+=back
 
 =head1 BUGS
 
@@ -315,7 +409,7 @@ Report bugs to Mauro Carvalho Chehab <mchehab@s-opensource.com>
 
 =head1 COPYRIGHT
 
-Copyright (c) 2016 by Mauro Carvalho Chehab <mchehab@s-opensource.com>.
+Copyright (c) 2016-2017 by Mauro Carvalho Chehab <mchehab@s-opensource.com>.
 
 License GPLv2: GNU GPL version 2 <http://gnu.org/licenses/gpl.html>.
 
-- 
2.21.0

