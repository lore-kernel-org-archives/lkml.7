Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF16C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855932083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561051544;
	bh=mx1IPJaByRyXo6N/K0E5Wwivjbb2OEqj4aKhN2KPJ18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D24szBaIoMEhGILWJzQoBz4d+9eJgHlgtYKCGq8I+Bn6sPXduhBCNctWGizuNH7EJ
	 pSFEZhJ8VuDVyUUa6nQdL3FRVRNkdNSZLrv7gNCgqaqrC7l8JvWPKB5R9+eDlFGB8L
	 bU+3IxrzeBu82xFrImRwJYm9GrGZ6SAAotS+s8TI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732561AbfFTRZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:25:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52566 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732140AbfFTRXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iyGlSzfmPRPhgV34seTobe5HD+h41lRl2+Yc0sW70Vk=; b=mkKnngnjrv232x+6XGdzBF6gOs
        g8zlvWU5lUDgPM/UgxTW5aEtEcRUiOCr+gQoEgjVaVYsz7VX72vz2uVFmHXdeXu82Hn1sTC9tew/0
        bBO8BoB2H7gszzSn2hQ1V1pIhf5oAAEAz9zHDr+ZnoaXQEo7Y5Xv2BtMBMYht3yAQ7rKxSmXqzt7v
        o0bRd4zLsNMUdjG+Spxlo7v/agsWkCc17Yku2vHZw/LxgSeTRbtcK7iCWitv3FdEV0HHZZmK5Y/PZ
        1Doem/k79Yte7fMRJUE1grbU7ebz5AN06LAb1kPr7z+9/wxyy++BsleaRF1Edfkn/W/OflLQWxTYJ
        G43cZmZw==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he0mM-0008Rq-8O; Thu, 20 Jun 2019 17:23:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1he0mJ-0000Co-Jd; Thu, 20 Jun 2019 14:23:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 03/22] scripts: add an script to parse the ABI files
Date:   Thu, 20 Jun 2019 14:22:55 -0300
Message-Id: <680fb978ef9322c705eca9927c79b220cd3ccc4a.1561050806.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561050806.git.mchehab+samsung@kernel.org>
References: <cover.1561050806.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a script to parse the Documentation/ABI files and produce
an output with all entries inside an ABI (sub)directory.

Right now, it outputs its contents on ReST format. It shouldn't
be hard to make it produce other kind of outputs, since the ABI
file parser is implemented in separate than the output generator.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_abi.pl | 212 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 212 insertions(+)
 create mode 100755 scripts/get_abi.pl

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
new file mode 100755
index 000000000000..f7c9944a833c
--- /dev/null
+++ b/scripts/get_abi.pl
@@ -0,0 +1,212 @@
+#!/usr/bin/perl
+
+use strict;
+use Pod::Usage;
+use Getopt::Long;
+use File::Find;
+use Fcntl ':mode';
+
+my $help;
+my $man;
+my $debug;
+
+GetOptions(
+	"debug|d+" => \$debug,
+	'help|?' => \$help,
+	man => \$man
+) or pod2usage(2);
+
+pod2usage(1) if $help;
+pod2usage(-exitstatus => 0, -verbose => 2) if $man;
+
+pod2usage(2) if (scalar @ARGV != 1);
+
+my ($prefix) = @ARGV;
+
+require Data::Dumper if ($debug);
+
+my %data;
+
+#
+# Displays an error message, printing file name and line
+#
+sub parse_error($$$$) {
+	my ($file, $ln, $msg, $data) = @_;
+
+	print STDERR "file $file#$ln: $msg at\n\t$data";
+}
+
+#
+# Parse an ABI file, storing its contents at %data
+#
+sub parse_abi {
+	my $file = $File::Find::name;
+
+	my $mode = (stat($file))[2];
+	return if ($mode & S_IFDIR);
+	return if ($file =~ m,/README,);
+
+	my $name = $file;
+	$name =~ s,.*/,,;
+
+	my $type = $file;
+	$type =~ s,.*/(.*)/.*,$1,;
+
+	my $what;
+	my $new_what;
+	my $tag;
+	my $ln;
+
+	print STDERR "Opening $file\n" if ($debug > 1);
+	open IN, $file;
+	while(<IN>) {
+		$ln++;
+		if (m/^(\S+):\s*(.*)/i) {
+			my $new_tag = lc($1);
+			my $content = $2;
+
+			if (!($new_tag =~ m/(what|date|kernelversion|contact|description|users)/)) {
+				if ($tag eq "description") {
+					$data{$what}->{$tag} .= "\n$content";;
+					$data{$what}->{$tag} =~ s/\n+$//;
+					next;
+				} else {
+					parse_error($file, $ln, "tag '$tag' is invalid", $_);
+				}
+			}
+
+			if ($new_tag =~ m/what/) {
+				if ($tag =~ m/what/) {
+					$what .= ", " . $content;
+				} else {
+					$what = $content;
+					$new_what = 1;
+				}
+				$tag = $new_tag;
+				next;
+			}
+
+			$tag = $new_tag;
+
+			if ($new_what) {
+				$new_what = 0;
+
+				$data{$what}->{type} = $type;
+				$data{$what}->{file} = $name;
+				print STDERR "\twhat: $what\n" if ($debug > 1);
+			}
+
+			if (!$what) {
+				parse_error($file, $ln, "'What:' should come first:", $_);
+				next;
+			}
+			$data{$what}->{$tag} = $content;
+			next;
+		}
+
+		# Silently ignore any headers before the database
+		next if (!$tag);
+
+		if (m/^\s*(.*)/) {
+			$data{$what}->{$tag} .= "\n$1";
+			$data{$what}->{$tag} =~ s/\n+$//;
+			next;
+		}
+
+		# Everything else is error
+		parse_error($file, $ln, "Unexpected line:", $_);
+	}
+	close IN;
+}
+
+# Outputs the output on ReST format
+sub output_rest {
+	foreach my $what (sort keys %data) {
+		my $type = $data{$what}->{type};
+		my $file = $data{$what}->{file};
+
+		my $w = $what;
+		$w =~ s/([\(\)\_\-\*\=\^\~\\])/\\$1/g;
+
+		print "$w\n\n";
+		print "- defined on file $file (type: $type)\n\n::\n\n";
+
+		my $desc = $data{$what}->{description};
+		$desc =~ s/^\s+//;
+
+		# Remove title markups from the description, as they won't work
+		$desc =~ s/\n[\-\*\=\^\~]+\n/\n/g;
+
+		# put everything inside a code block
+		$desc =~ s/\n/\n /g;
+
+
+		if (!($desc =~ /^\s*$/)) {
+			print " $desc\n\n";
+		} else {
+			print " DESCRIPTION MISSING\n\n";
+		}
+	}
+}
+
+#
+# Parses all ABI files located at $prefix dir
+#
+find({wanted =>\&parse_abi, no_chdir => 1}, $prefix);
+
+print STDERR Data::Dumper->Dump([\%data], [qw(*data)]) if ($debug);
+
+#
+# Outputs an ReST file with the ABI contents
+#
+output_rest
+
+
+__END__
+
+=head1 NAME
+
+abi_book.pl - parse the Linux ABI files and produce a ReST book.
+
+=head1 SYNOPSIS
+
+B<abi_book.pl> [--debug] <ABI_DIR>]
+
+=head1 OPTIONS
+
+=over 8
+
+=item B<--debug>
+
+Put the script in verbose mode, useful for debugging. Can be called multiple
+times, to increase verbosity.
+
+=item B<--help>
+
+Prints a brief help message and exits.
+
+=item B<--man>
+
+Prints the manual page and exits.
+
+=back
+
+=head1 DESCRIPTION
+
+Parse the Linux ABI files from ABI DIR (usually located at Documentation/ABI)
+and produce a ReST book containing the Linux ABI.
+
+=head1 BUGS
+
+Report bugs to Mauro Carvalho Chehab <mchehab@s-opensource.com>
+
+=head1 COPYRIGHT
+
+Copyright (c) 2016 by Mauro Carvalho Chehab <mchehab@s-opensource.com>.
+
+License GPLv2: GNU GPL version 2 <http://gnu.org/licenses/gpl.html>.
+
+This is free software: you are free to change and redistribute it.
+There is NO WARRANTY, to the extent permitted by law.
+
+=cut
-- 
2.21.0

