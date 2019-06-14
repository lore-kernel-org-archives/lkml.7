Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF120C31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1D921537
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 02:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560477907;
	bh=MkNcpndd8UzoZlbXh4k7kKrXltEm7kMg92CBYSy6qe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JRy48k8NtK2J4MSwwdn0dOBUTvWmABqHka+I8jeAfY/Jb5oGBFSASfCHCOBv6WuGn
	 LxUTR7h7TXokIZ8n77kMcoEiBUafEYps0ZqqZx+s2x8EHX5jr6rCwbh0J2w6JxmRqB
	 H7Jp1mosTDNDWrH5xxB8kSgYmuIr6Bt7RjL49E2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfFNCE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 22:04:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52874 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfFNCE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 22:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4WfH3WvA3aZdEU2vnsQylDIgSyaOvEi4N8Ko1jrRcs4=; b=PEwK1zmIeYoZJMuF3+kyVaK/lo
        374rH5MV5bn/OgWuMlyqPttGCSu7FTc1/4emjSRrcC+9G6M+b9k8HSz+JoGa7gjLRXYK3omM/xj8+
        hFX70iRlXKrk7S3G3Z0NApNxM1UoUNEjYwFCJ+fAp8CdDrfG2pokGZ/leMk+TVJWsUvQjy3LYGwqr
        BzA3y4AX0CS6e4ruHRDQopGGvRIbezXumDZC8nVAye9o6fd+dQW2vOKGHULTvUKSOOrXZDHHP9KPd
        EYiRJlepRnZ+usvKQBY1NCfSWoAHEchiBTz/6B2PPl6RpN4Vd+qG/6gifEWSboMWDu5xPs0iBtD2s
        icVaDPeA==;
Received: from 201.86.169.251.dynamic.adsl.gvt.net.br ([201.86.169.251] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbbZr-0000E6-Dy; Fri, 14 Jun 2019 02:04:27 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbbZn-0002o4-Tu; Thu, 13 Jun 2019 23:04:23 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 09/14] scripts/get_abi.pl: add support for searching for ABI symbols
Date:   Thu, 13 Jun 2019 23:04:15 -0300
Message-Id: <8a21e26ab9d3a67433f7d5fddf227a8562e48adb.1560477540.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560477540.git.mchehab+samsung@kernel.org>
References: <cover.1560477540.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

Change its syntax to allow switching between ReST output mode
and a new search mode, with allows to seek for ABI symbols
using regex.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_abi.pl | 112 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 103 insertions(+), 9 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index d437e148b1c0..c202292af1a2 100755
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

