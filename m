Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D2EC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C4F21841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560534805;
	bh=mx1IPJaByRyXo6N/K0E5Wwivjbb2OEqj4aKhN2KPJ18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WaNutO98OgXYHJP7xCuyAMcgGVH1dR+4Wz54UmGx/khkTsJS3P6EwxtGxl+dQQGTE
	 iC4kMGnZO8B68vpprT4KRtmlie/vlZKXGONeS3x7ph2voPttDAYUTT9SkuNGTBoZLB
	 EuLxEpBRFag0mqOZgGIsUbwlxiGgbq39wB7fK0yY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfFNRwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:52:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38652 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfFNRwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iyGlSzfmPRPhgV34seTobe5HD+h41lRl2+Yc0sW70Vk=; b=U7/wfDVfv6bAW/KOTxLszc2Lc0
        3Izya+hxW7iR+l8INo6WWVSeUwABUQ2oKSw0UE2eXh9kAZNsMg04HuYWuxGFn1i2F38T7RHZz2yz6
        X5SGGldIh8u8DKz2+IlSDQbZuwrIB7aNG7lZqQ7WriYJ/A+UMvFnT/iUTR5MlfD8XfG3Rl40X1qfd
        m9Yfdke2B1c43+sejTicflnDyauIwZ3UmoLodPY81smEZR8gByke8TS3imy682x2viNepRi/LqFFv
        5Spx1aSzsscQEasuK+DpvCD+X9L5XrZfixLGLEGQsL3jiQtIEDvXWcoAduwqjYOamOXMuTNHuKdEI
        KHOXq+SQ==;
Received: from 177.133.85.52.dynamic.adsl.gvt.net.br ([177.133.85.52] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbqNO-0000Pf-PW; Fri, 14 Jun 2019 17:52:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hbqNL-0002Oa-OW; Fri, 14 Jun 2019 14:52:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 03/16] scripts: add an script to parse the ABI files
Date:   Fri, 14 Jun 2019 14:52:17 -0300
Message-Id: <680fb978ef9322c705eca9927c79b220cd3ccc4a.1560534648.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
References: <3b8d7c64f887ddea01df3c4eeabc745c8ec45406.1560534648.git.mchehab+samsung@kernel.org>
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

