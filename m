Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D929FC31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B53C82183E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560534767;
	bh=PEKZLitVhbwDreRAf3ZsyL/kr7CdyykeP6MBfLvsZTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gVUrG1JkLBX/NyvmgZ7bmtuGR/Tkz2KMi7BTHkv7bnqDZXTrWWCI9HGizsCGIGWLU
	 Jhl7X8wyacFyBocqcCYk4Y3BzwhAuJkEMcq71kEAhda+OGel9LZhycJYG6wMZRMqUX
	 Ufq2XmU3LRLlHs4wjLADAWmnNHeWlE8/MkwcQpU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfFNRwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:52:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfFNRwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+TcnVW4oc5Non+1YyDCeuAoLNOkHuIVoRYv61A8PqOA=; b=mALbH27cMUVp6ssHLz0uY8O+8A
        vVLY/DnzdZU8mJsEPcW7JMA4IQQO/dlgf8gJid2lz6rH/umU9Sn+8Mgkrlsgrnib/hJqdlJKBu31i
        s/TDkhy60+E3rMWKR7BWgvQ6am4spwt1a5cNcvokQBDxqnKj8fn2VckgarvPN2sdDXd927PNnlJ26
        CVQTKIYwFVvcYL75Xf8K9WJMi+Nj/GsLa9phF8AcDIZrBK6S/i42nVlWMGODOlW+ijW89hQEAcH0v
        zJ0fLVRrohj97GaqFTbdDl1xhPUNB16yKcBTRvvAo/ajtcobxF/KoCW9LcUQzbxaIeL2PXrbq8gEq
        347HdX6g==;
Received: from 177.133.85.52.dynamic.adsl.gvt.net.br ([177.133.85.52] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbqNT-0000Pg-Cw; Fri, 14 Jun 2019 17:52:39 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbqNL-0002Oq-SQ; Fri, 14 Jun 2019 14:52:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 07/16] scripts/get_abi.pl: add support for searching for ABI symbols
Date:   Fri, 14 Jun 2019 14:52:21 -0300
Message-Id: <72051952d8eac5a5aff20998909aeb52aeb4d773.1560534648.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
References: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
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

