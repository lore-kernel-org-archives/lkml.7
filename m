Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577BDC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156312084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561051412;
	bh=pPdwJ3GnFnyO5Hq/BuiViCRoBB/e+KG4OtyofDzPXeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oWmW77nYUAWaf9PgAlr48nf/4jp9qoiu8DHnDSzgMtFmL9+yn5p81Z1TC76baA9iD
	 esvS4HrcgOVkMJmQ9Y2KcBpWeTohlSQwHcHLFzpxr7l8nDH0HszKVjCsykeMcmuPQF
	 fDvmC2Bs7vlkJJIevW3HZgH9SrJbwQ7v6ZvQjCCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbfFTRXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:23:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732134AbfFTRXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0lowo67jUcjW6gtI8vv9NQmn3mxBn6HmDf49u8xK9FM=; b=HwsgEQMOVL4JyEpcFMJBx8tNjU
        O2PKB7g4dKb0idvqktVJHz+8LW/tHrTHUJUj4JBR+/CO1ZQtzr4dXj2ZyKLx++x2aQgg8cm9npMC8
        MtlHZEmn7T2lFmA3schMDlIlqvL8vT+lFdsRIvqkRnfyrMn+zKamSWGlnZU/THQ7X2Kmhby8sC9QC
        0N6mSS8FMX5OzZvCb3MMi3YZvPyYf8+nIKZJPMfpz6MOvWgX92A3TWr+RIdca0EhSqttIyN7j/jjc
        VTZ/lVSR8rYc/+Y80iR6mFukgg2zYGowBxS/XOG+iVJfM3gxARu74y1WQtCzoVCDkGre3BVP6rb7z
        pwPf621w==;
Received: from [177.97.20.138] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1he0mM-0008Ry-9w; Thu, 20 Jun 2019 17:23:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1he0mK-0000Dt-0b; Thu, 20 Jun 2019 14:23:16 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 19/22] scripts: add a script to handle Documentation/features
Date:   Thu, 20 Jun 2019 14:23:11 -0300
Message-Id: <02e7a3eb6ec8b86cda74b4b12355c50d746fc6f6.1561050806.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561050806.git.mchehab+samsung@kernel.org>
References: <cover.1561050806.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Documentation/features contains a set of parseable files.
It is not worth converting them to ReST format, as they're
useful the way it is. It is, however, interesting to parse
them and produce output on different formats:

1) Output the contents of a feature in ReST format;

2) Output what features a given architecture supports;

3) Output a matrix with features x architectures.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/get_feat.pl | 472 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 472 insertions(+)
 create mode 100755 scripts/get_feat.pl

diff --git a/scripts/get_feat.pl b/scripts/get_feat.pl
new file mode 100755
index 000000000000..401cbc820caa
--- /dev/null
+++ b/scripts/get_feat.pl
@@ -0,0 +1,472 @@
+#!/usr/bin/perl
+# SPDX-License-Identifier: GPL-2.0
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
+my $arch;
+my $feat;
+my $prefix="Documentation/features";
+
+GetOptions(
+	"debug|d+" => \$debug,
+	"dir=s" => \$prefix,
+	'help|?' => \$help,
+	'arch=s' => \$arch,
+	'feat=s' => \$feat,
+	man => \$man
+) or pod2usage(2);
+
+pod2usage(1) if $help;
+pod2usage(-exitstatus => 0, -verbose => 2) if $man;
+
+pod2usage(2) if (scalar @ARGV < 1 || @ARGV > 2);
+
+my ($cmd, $arg) = @ARGV;
+
+pod2usage(2) if ($cmd ne "current" && $cmd ne "rest" && $cmd ne "validate");
+
+require Data::Dumper if ($debug);
+
+my %data;
+my %archs;
+
+#
+# Displays an error message, printing file name and line
+#
+sub parse_error($$$$) {
+	my ($file, $ln, $msg, $data) = @_;
+
+	$data =~ s/\s+$/\n/;
+
+	print STDERR "Warning: file $file#$ln:\n\t$msg";
+
+	if ($data ne "") {
+		print STDERR ". Line\n\t\t$data";
+	} else {
+	    print STDERR "\n";
+	}
+}
+
+#
+# Parse a features file, storing its contents at %data
+#
+
+my $h_name = "Feature";
+my $h_kconfig = "Kconfig";
+my $h_description = "Description";
+my $h_subsys = "Subsystem";
+my $h_status = "Status";
+my $h_arch = "Architecture";
+
+my $max_size_name = length($h_name);
+my $max_size_kconfig = length($h_kconfig);
+my $max_size_description = length($h_description);
+my $max_size_subsys = length($h_subsys);
+my $max_size_status = length($h_status);
+my $max_size_arch = length($h_arch);
+
+sub parse_feat {
+	my $file = $File::Find::name;
+
+	my $mode = (stat($file))[2];
+	return if ($mode & S_IFDIR);
+	return if ($file =~ m,($prefix)/arch-support.txt,);
+	return if (!($file =~ m,arch-support.txt$,));
+
+	my $subsys = "";
+	$subsys = $2 if ( m,.*($prefix)/([^/]+).*,);
+
+	if (length($subsys) > $max_size_subsys) {
+		$max_size_subsys = length($subsys);
+	}
+
+	my $name;
+	my $kconfig;
+	my $description;
+	my $comments = "";
+	my $last_status;
+	my $ln;
+	my %arch_table;
+
+	print STDERR "Opening $file\n" if ($debug > 1);
+	open IN, $file;
+
+	while(<IN>) {
+		$ln++;
+
+		if (m/^\#\s+Feature\s+name:\s*(.*\S)/) {
+			$name = $1;
+			if (length($name) > $max_size_name) {
+				$max_size_name = length($name);
+			}
+			next;
+		}
+		if (m/^\#\s+Kconfig:\s*(.*\S)/) {
+			$kconfig = $1;
+			if (length($kconfig) > $max_size_kconfig) {
+				$max_size_kconfig = length($kconfig);
+			}
+			next;
+		}
+		if (m/^\#\s+description:\s*(.*\S)/) {
+			$description = $1;
+			if (length($description) > $max_size_description) {
+				$max_size_description = length($description);
+			}
+			next;
+		}
+		next if (m/^\\s*$/);
+		next if (m/^\s*\-+\s*$/);
+		next if (m/^\s*\|\s*arch\s*\|\s*status\s*\|\s*$/);
+
+		if (m/^\#\s*(.*)/) {
+			$comments .= "$1\n";
+			next;
+		}
+		if (m/^\s*\|\s*(\S+):\s*\|\s*(\S+)\s*\|\s*$/) {
+			my $a = $1;
+			my $status = $2;
+
+			if (length($status) > $max_size_status) {
+				$max_size_status = length($status);
+			}
+			if (length($a) > $max_size_arch) {
+				$max_size_arch = length($a);
+			}
+
+			$archs{$a} = 1;
+			$arch_table{$a} = $status;
+			next;
+		}
+
+		#Everything else is an error
+		parse_error($file, $ln, "line is invalid", $_);
+	}
+	close IN;
+
+	if (!$name) {
+		parse_error($file, $ln, "Feature name not found", "");
+		return;
+	}
+
+	parse_error($file, $ln, "Subsystem not found", "") if (!$subsys);
+	parse_error($file, $ln, "Kconfig not found", "") if (!$kconfig);
+	parse_error($file, $ln, "Description not found", "") if (!$description);
+
+	if (!%arch_table) {
+		parse_error($file, $ln, "Architecture table not found", "");
+		return;
+	}
+
+	$data{$name}->{where} = $file;
+	$data{$name}->{subsys} = $subsys;
+	$data{$name}->{kconfig} = $kconfig;
+	$data{$name}->{description} = $description;
+	$data{$name}->{comments} = $comments;
+	$data{$name}->{table} = \%arch_table;
+}
+
+#
+# Output feature(s) for a given architecture
+#
+sub output_arch_table {
+	my $title = "Feature status on $arch architecture";
+
+	print "=" x length($title) . "\n";
+	print "$title\n";
+	print "=" x length($title) . "\n\n";
+
+	print "=" x $max_size_subsys;
+	print "  ";
+	print "=" x $max_size_name;
+	print "  ";
+	print "=" x $max_size_kconfig;
+	print "  ";
+	print "=" x $max_size_status;
+	print "  ";
+	print "=" x $max_size_description;
+	print "\n";
+	printf "%-${max_size_subsys}s  ", $h_subsys;
+	printf "%-${max_size_name}s  ", $h_name;
+	printf "%-${max_size_kconfig}s  ", $h_kconfig;
+	printf "%-${max_size_status}s  ", $h_status;
+	printf "%-${max_size_description}s\n", $h_description;
+	print "=" x $max_size_subsys;
+	print "  ";
+	print "=" x $max_size_name;
+	print "  ";
+	print "=" x $max_size_kconfig;
+	print "  ";
+	print "=" x $max_size_status;
+	print "  ";
+	print "=" x $max_size_description;
+	print "\n";
+
+	foreach my $name (sort {
+				($data{$a}->{subsys} cmp $data{$b}->{subsys}) ||
+				($data{$a}->{name} cmp $data{$b}->{name})
+			       } keys %data) {
+		next if ($feat && $name ne $feat);
+
+		my %arch_table = %{$data{$name}->{table}};
+		printf "%-${max_size_subsys}s  ", $data{$name}->{subsys};
+		printf "%-${max_size_name}s  ", $name;
+		printf "%-${max_size_kconfig}s  ", $data{$name}->{kconfig};
+		printf "%-${max_size_status}s  ", $arch_table{$arch};
+		printf "%-${max_size_description}s\n", $data{$name}->{description};
+	}
+
+	print "=" x $max_size_subsys;
+	print "  ";
+	print "=" x $max_size_name;
+	print "  ";
+	print "=" x $max_size_kconfig;
+	print "  ";
+	print "=" x $max_size_status;
+	print "  ";
+	print "=" x $max_size_description;
+	print "\n";
+}
+
+#
+# Output a feature on all architectures
+#
+sub output_feature {
+	my $title = "Feature $feat";
+
+	print "=" x length($title) . "\n";
+	print "$title\n";
+	print "=" x length($title) . "\n\n";
+
+	print ":Subsystem: $data{$feat}->{subsys} \n" if ($data{$feat}->{subsys});
+	print ":Kconfig: $data{$feat}->{kconfig} \n" if ($data{$feat}->{kconfig});
+
+	my $desc = $data{$feat}->{description};
+	$desc =~ s/^([a-z])/\U$1/;
+	$desc =~ s/\.?\s*//;
+	print "\n$desc.\n\n";
+
+	my $com = $data{$feat}->{comments};
+	$com =~ s/^\s+//;
+	$com =~ s/\s+$//;
+	if ($com) {
+		print "Comments\n";
+		print "--------\n\n";
+		print "$com\n\n";
+	}
+
+	print "=" x $max_size_arch;
+	print "  ";
+	print "=" x $max_size_status;
+	print "\n";
+
+	printf "%-${max_size_arch}s  ", $h_arch;
+	printf "%-${max_size_status}s", $h_status . "\n";
+
+	print "=" x $max_size_arch;
+	print "  ";
+	print "=" x $max_size_status;
+	print "\n";
+
+	my %arch_table = %{$data{$feat}->{table}};
+	foreach my $arch (sort keys %arch_table) {
+		printf "%-${max_size_arch}s  ", $arch;
+		printf "%-${max_size_status}s\n", $arch_table{$arch};
+	}
+
+	print "=" x $max_size_arch;
+	print "  ";
+	print "=" x $max_size_status;
+	print "\n";
+}
+
+#
+# Output all features for all architectures
+#
+
+sub matrix_lines {
+	print "=" x $max_size_subsys;
+	print "  ";
+	print "=" x $max_size_name;
+	print "  ";
+
+	foreach my $arch (sort keys %archs) {
+		my $len = $max_size_status;
+
+		$len = length($arch) if ($len < length($arch));
+
+		print "=" x $len;
+		print "  ";
+	}
+	print "=" x $max_size_kconfig;
+	print "  ";
+	print "=" x $max_size_description;
+	print "\n";
+}
+
+sub output_matrix {
+
+	my $title = "Feature List (feature x architecture)";
+
+	print "=" x length($title) . "\n";
+	print "$title\n";
+	print "=" x length($title) . "\n\n";
+
+	matrix_lines;
+
+	printf "%-${max_size_subsys}s  ", $h_subsys;
+	printf "%-${max_size_name}s  ", $h_name;
+
+	foreach my $arch (sort keys %archs) {
+		printf "%-${max_size_status}s  ", $arch;
+	}
+	printf "%-${max_size_kconfig}s  ", $h_kconfig;
+	printf "%-${max_size_description}s\n", $h_description;
+
+	matrix_lines;
+
+	foreach my $name (sort {
+				($data{$a}->{subsys} cmp $data{$b}->{subsys}) ||
+				($data{$a}->{name} cmp $data{$b}->{name})
+			       } keys %data) {
+		printf "%-${max_size_subsys}s  ", $data{$name}->{subsys};
+		printf "%-${max_size_name}s  ", $name;
+
+		my %arch_table = %{$data{$name}->{table}};
+
+		foreach my $arch (sort keys %arch_table) {
+			my $len = $max_size_status;
+
+			$len = length($arch) if ($len < length($arch));
+
+			printf "%-${len}s  ", $arch_table{$arch};
+		}
+		printf "%-${max_size_kconfig}s  ", $data{$name}->{kconfig};
+		printf "%-${max_size_description}s\n", $data{$name}->{description};
+	}
+
+	matrix_lines;
+}
+
+
+#
+# Parses all feature files located at $prefix dir
+#
+find({wanted =>\&parse_feat, no_chdir => 1}, $prefix);
+
+print STDERR Data::Dumper->Dump([\%data], [qw(*data)]) if ($debug);
+
+#
+# Handles the command
+#
+if ($cmd eq "current") {
+	$arch = qx(uname -m | sed 's/x86_64/x86/' | sed 's/i386/x86/');
+	$arch =~s/\s+$//;
+}
+
+if ($cmd ne "validate") {
+	if ($arch) {
+		output_arch_table;
+	} elsif ($feat) {
+		output_feature;
+	} else {
+		output_matrix;
+	}
+}
+
+__END__
+
+=head1 NAME
+
+get_feat.pl - parse the Linux Feature files and produce a ReST book.
+
+=head1 SYNOPSIS
+
+B<get_feat.pl> [--debug] [--man] [--help] [--dir=<dir>]
+	       [--arch=<arch>] [--feat=<feature>] <COMAND> [<ARGUMENT>]
+
+Where <COMMAND> can be:
+
+=over 8
+
+B<current>               - output features for this machine's architecture
+
+B<rest>                  - output features in ReST markup language
+
+B<validate>              - validate the feature contents
+
+=back
+
+=head1 OPTIONS
+
+=over 8
+
+=item B<--arch>
+
+Output features for an specific architecture, optionally filtering for
+a single specific feature.
+
+=item B<--feat>
+
+Output features for a single specific architecture.
+
+=item B<--dir>
+
+Changes the location of the Feature files. By default, it uses
+the Documentation/features directory.
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
+Parse the Linux feature files from Documentation/features (by default),
+optionally producing results at ReST format.
+
+It supports output data per architecture, per feature or a
+feature x arch matrix.
+
+When used with B<rest> command, it will use either one of the tree formats:
+
+If neither B<--arch> or B<--feature> arguments are used, it will output a
+matrix with features per architecture.
+
+If B<--arch> argument is used, it will output the features availability for
+a given architecture.
+
+If B<--feat> argument is used, it will output the content of the feature
+file using ReStructured Text markup.
+
+=head1 BUGS
+
+Report bugs to Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
+
+=head1 COPYRIGHT
+
+Copyright (c) 2019 by Mauro Carvalho Chehab <mchehab+samsung@kernel.org>.
+
+License GPLv2: GNU GPL version 2 <http://gnu.org/licenses/gpl.html>.
+
+This is free software: you are free to change and redistribute it.
+There is NO WARRANTY, to the extent permitted by law.
+
+=cut
-- 
2.21.0

