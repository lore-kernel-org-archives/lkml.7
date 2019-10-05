Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434A7C4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C04222CE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 16:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbfJEQrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 12:47:10 -0400
Received: from smtprelay0060.hostedemail.com ([216.40.44.60]:45621 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725826AbfJEQrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 12:47:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id A315E18224D63;
        Sat,  5 Oct 2019 16:47:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: air95_36932f87d112
X-Filterd-Recvd-Size: 28894
Received: from joe-laptop.perches.com (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sat,  5 Oct 2019 16:47:03 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>, x86@kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux@googlegroups.com
Subject: [PATCH 4/4] scripts/cvt_style.pl: Tool to reformat sources in various ways
Date:   Sat,  5 Oct 2019 09:46:44 -0700
Message-Id: <4a904777303fbaea75fe0875b7984c33824f4b68.1570292505.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1570292505.git.joe@perches.com>
References: <cover.1570292505.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial tool to reformat source code in various ways.

This is an old tool that was recently updated to convert /* fallthrough */
style comments to the new pseudo-keyword fallthrough;

Typical command line use is:
    $ perl scripts/cvt_style --convert=fallthrough <file list>

Available conversions:
	all
	printk_to_pr_level
	printk_KERN_DEBUG_to_pr_debug
	dev_printk_to_dev_level
	dev_printk_KERN_DEBUG_to_dev_dbg
	sdev_printk_to_sdev_level
	sdev_printk_KERN_DEBUG_to_sdev_dbg
	coalesce_formats
	cuddle_open_brace
	cuddle_else
	deparenthesize_returns
	space_after_KERN_level
	space_after_if_while_for_switch
	space_after_for_semicolons
	space_after_comma
	space_before_pointer
	space_around_trigraph
	leading_spaces_to_tabs
	coalesce_semicolons
	remove_trailing_whitespace
	remove_whitespace_before_quoted_newline
	remove_whitespace_before_trailing_semicolon
	remove_whitespace_before_bracket
	remove_parenthesis_whitespace
	remove_single_statement_braces
	remove_whitespace_after_cast
	hoist_assigns_from_if
	convert_c99_comments
	remove_private_data_casts
	remove_static_initializations_to_0
	remove_true_false_comparisons
	remove_NULL_comparisons
	remove_trailing_if_semicolons
	network_comments
	remove_switchforwhileif_semicolons
	detab_else_return
	remove_while_while
	fallthrough
Additional conversions which may not work well:
	(enable individually or with --convert=all --broken)
	move_labels_to_column_1
	space_around_logical_tests
	space_around_assign
	space_around_arithmetic
	CamelCase_to_camel_case

Use --convert=(comma separated list)
   ie: --convert=printk_to_pr_level,coalesce_formats

Output file:
  --overwrite => write the changes to the source file
  --suffix => suffix to append to new file (default: .style)

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/cvt_style.pl | 808 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 808 insertions(+)
 create mode 100755 scripts/cvt_style.pl

diff --git a/scripts/cvt_style.pl b/scripts/cvt_style.pl
new file mode 100755
index 000000000000..fcbda0b1c67a
--- /dev/null
+++ b/scripts/cvt_style.pl
@@ -0,0 +1,808 @@
+#!/usr/bin/perl -w
+
+# Change some style elements of a source file
+# An imperfect source code formatter.
+# Might make trivial patches a bit easier.
+#
+# usage: perl scripts/cvt_kernel_style.pl <files>
+#
+# Licensed under the terms of the GNU GPL License version 2
+
+use strict;
+use Getopt::Long qw(:config no_auto_abbrev);
+
+my $P = $0;
+my $V = '0.4';
+
+my $source_indent = 8;
+my $quiet = 0;
+my $stats = 1;
+my $overwrite = 0;
+my $modified = 0;
+my $suffix = ".style";
+my $convert_options = "";
+my $broken = 0;
+
+my @std_options = (
+    "all",
+    "printk_to_pr_level",
+    "printk_KERN_DEBUG_to_pr_debug",
+    "dev_printk_to_dev_level",
+    "dev_printk_KERN_DEBUG_to_dev_dbg",
+    "sdev_printk_to_sdev_level",
+    "sdev_printk_KERN_DEBUG_to_sdev_dbg",
+    "coalesce_formats",
+    "cuddle_open_brace",
+    "cuddle_else",
+    "deparenthesize_returns",
+    "space_after_KERN_level",
+    "space_after_if_while_for_switch",
+    "space_after_for_semicolons",
+    "space_after_comma",
+    "space_before_pointer",
+    "space_around_trigraph",
+    "leading_spaces_to_tabs",
+    "coalesce_semicolons",
+    "remove_trailing_whitespace",
+    "remove_whitespace_before_quoted_newline",
+    "remove_whitespace_before_trailing_semicolon",
+    "remove_whitespace_before_bracket",
+    "remove_parenthesis_whitespace",
+    "remove_single_statement_braces",
+    "remove_whitespace_after_cast",
+    "hoist_assigns_from_if",
+    "convert_c99_comments",
+    "remove_private_data_casts",
+    "remove_static_initializations_to_0",
+    "remove_true_false_comparisons",
+    "remove_NULL_comparisons",
+    "remove_trailing_if_semicolons",
+    "network_comments",
+    "remove_switchforwhileif_semicolons",
+    "detab_else_return",
+    "remove_while_while",
+    "fallthrough",
+);
+
+my @other_options = (
+    "move_labels_to_column_1",
+    "space_around_logical_tests",
+    "space_around_assign",
+    "space_around_arithmetic",
+    "CamelCase_to_camel_case"
+);
+
+my $version = 0;
+my $help = 0;
+
+my $logFunctions = qr{(?x:
+	printk|
+	([a-z0-9_]+)_(debug|dbg|vdbg|devel|info|warn|warning|err|notice|alert|crit|emerg|cont)|
+	WARN|
+	panic
+)};
+
+my $match_balanced_parentheses = qr/(\((?:[^\(\)]++|(?-1))*\))/;
+my $match_balanced_braces      = qr/(\{(?:[^\{\}]++|(?-1))*\})/;
+my $do_cvt;
+
+my %hash;
+
+sub set_all_options {
+    my ($enabled) = @_;
+
+    foreach my $opt (@std_options) {
+	$hash{$opt} = $enabled;
+    }
+
+    if ($broken > 0 || $enabled == -1) {
+	foreach my $opt (@other_options) {
+	    $hash{$opt} = $enabled;
+	}
+    }
+
+}
+
+if (!GetOptions(
+		'source-indent=i' => \$source_indent,
+		'convert=s' => \$convert_options,
+		'broken!' => \$broken,
+		'stats!' => \$stats,
+		'o|overwrite!' => \$overwrite,
+		'q|quiet!' => \$quiet,
+		'v|version' => \$version,
+		'h|help|usage' => \$help,
+		)) {
+    die "$P: invalid argument - use --help if necessary\n";
+}
+
+if ($help) {
+    usage();
+    exit 0;
+}
+
+if ($version) {
+    print "$P: v$V\n";
+    exit 0;
+}
+
+my $max_spaces_before_tab = $source_indent - 1;
+my $spaces_to_tab = sprintf("%*s", $source_indent, "");
+
+set_all_options(-1);
+
+my @actual_options = split(',', $convert_options);
+foreach my $opt (@actual_options) {
+    if ($opt eq "all") {
+	set_all_options(0);
+    }
+    if (exists($hash{$opt})) {
+	$hash{$opt} = 0;
+    } else {
+	print "Invalid --convert option: '$opt', ignored\n";
+    }
+}
+
+sub usage {
+    print <<EOT;
+usage: $P [options] <files>
+version: $V
+
+EOT
+    print "Available conversions:\n";
+    foreach my $convert (@std_options) {
+	print "\t$convert\n";
+    }
+    print "Additional conversions which may not work well:\n";
+    print "\t(enable individually or with --convert=all --broken)\n";
+    foreach my $convert (@other_options) {
+	print "\t$convert\n";
+    }
+    print "\n";
+    print "Use --convert=(comma separated list)\n";
+    print "   ie: --convert=printk_to_pr_level,coalesce_formats\n";
+    print <<EOT;
+
+Input source file descriptions:
+  --source-indent => How many spaces are used for an indent (default: 8)
+
+Output file:
+  --overwrite => write the changes to the source file
+  --suffix => suffix to append to new file (default: .style)
+
+Other options:
+  --quiet => don't show conversion warning messages (default: disabled)
+  --stats => show conversions done (default: enabled)
+  --version => show version
+  --help => show this help information
+EOT
+}
+
+sub check_label {
+    my ($leading, $label) = @_;
+
+    if ($label == "default") {
+	return "$leading$label:";
+    }
+    return "$label:";
+}
+
+sub check_for {
+    my ($leading, $test1, $test2, $test3) = @_;
+
+    $test1 =~ s/^\s+|\s+$//g;
+    $test2 =~ s/^\s+|\s+$//g;
+    $test3 =~ s/^\s+|\s+$//g;
+
+    return "${leading}for ($test1; $test2; $test3)";
+}
+
+sub tabify {
+    my ($leading) = @_;
+
+#convert leading spaces to tabs
+    1 while $leading =~ s@^([\t]*)$spaces_to_tab@$1\t@g;
+#Remove spaces before a tab
+    1 while $leading =~ s@^([\t]*)([ ]{1,$max_spaces_before_tab})\t@$1\t@g;
+
+    return "$leading";
+}
+
+sub expand_tabs {
+    my ($str) = @_;
+
+    my $res = '';
+    my $n = 0;
+    for my $c (split(//, $str)) {
+	if ($c eq "\t") {
+	    $res .= ' ';
+	    $n++;
+	    for (; ($n % 8) != 0; $n++) {
+		$res .= ' ';
+	    }
+	    next;
+	}
+	$res .= $c;
+	$n++;
+    }
+
+    return $res;
+}
+
+sub default_substitute {
+    my ($argument) = @_;
+
+    return "$argument";
+}
+
+sub subst_line_mode_fn {
+    my ($lines, $match, $fn, $args) = @_;
+
+    my $function = \&$fn;
+    my @lines = split("\n", $lines);
+    my $count = 0;
+
+    foreach my $line (@lines) {
+	my $oldline = $line;
+	$line =~ s@$match@&$function(eval $args)@ge;
+	$count++ if ($oldline ne $line);
+    }
+
+    return ($count, join("\n", @lines) . "\n");
+}
+
+sub subst_line_mode {
+    my ($lines, $match, $substitute) = @_;
+
+    return subst_line_mode_fn($lines, $match, "default_substitute", $substitute);
+}
+
+sub convert {
+    my ($check) = @_;
+
+    return 1 if ($hash{$check} >= 0);
+
+    return 0;
+}
+
+sub strip_leading_paren {
+    my ($string) = @_;
+    $string =~ s@^\(\s*@@g;
+    return $string;
+}
+
+sub strip_outer_paren {
+    my ($string) = @_;
+    $string =~ s@^\(\s*@@g;
+    $string =~ s@\s*\)$@@g;
+    return $string;
+}
+
+sub trim_trail {
+    my ($string) = @_;
+    $string =~ s@\s*$@@g;
+    return $string;
+}
+
+
+foreach my $file (@ARGV) {
+    my $f;
+    my $text;
+    my $oldtext;
+
+# read the file
+
+    next if ((-d $file));
+
+    open($f, '<', $file)
+	or die "$P: Can't open $file for read\n";
+    $oldtext = do { local($/) ; <$f> };
+    close($f);
+
+    next if ($oldtext eq "");
+
+    $text = $oldtext;
+
+# Convert printk(KERN_<level> to pr_<level>(
+    $do_cvt = "printk_to_pr_level";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s@\bprintk\s*\(\s*KERN_(INFO|WARNING|ERR|ALERT|CRIT|EMERG|NOTICE|CONT)\s*@pr_\L$1\(@g;
+	$text =~ s@\bpr_warning\b@pr_warn@g;
+
+	$hash{$do_cvt} += $text =~ s@\bprintk_ratelimited\s*\(\s*KERN_(INFO|WARNING|ERR|ALERT|CRIT|EMERG|NOTICE|CONT)\s*@pr_\L$1_ratelimited\(@g;
+	$text =~ s@\bpr_warning_ratelimited\b@pr_warn_ratelimited@g;
+
+	$hash{$do_cvt} += $text =~ s@\bprintk_once\s*\(\s*KERN_(INFO|WARNING|ERR|ALERT|CRIT|EMERG|NOTICE|CONT)\s*@pr_\L$1_once\(@g;
+	$text =~ s@\bpr_warning_once\b@pr_warn_once@g;
+    }
+
+# Convert printk(KERN_DEBUG to pr_debug(
+    $do_cvt = "printk_KERN_DEBUG_to_pr_debug";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s@\bprintk\s*\(\s*KERN_(DEBUG)\s*@pr_\L$1\(@g;
+    }
+
+# Convert dev_printk(KERN_<level> to dev_<level>(
+    $do_cvt = "dev_printk_to_dev_level";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s@\bdev_printk\s*\(\s*KERN_(INFO|WARNING|ERR|ALERT|CRIT|EMERG|NOTICE)\s*,\s*@dev_\L$1\(@g;
+	$text =~ s@\bdev_warning\b@dev_warn@g;
+
+	$hash{$do_cvt} += $text =~ s@\bdev_printk_ratelimited\s*\(\s*KERN_(INFO|WARNING|ERR|ALERT|CRIT|EMERG|NOTICE|CONT)\s*,\s*@dev_\L$1_ratelimited\(@g;
+	$text =~ s@\bdev_warning_ratelimited\b@dev_warn_ratelimited@g;
+
+	$hash{$do_cvt} += $text =~ s@\bdev_printk_once\s*\(\s*KERN_(INFO|WARNING|ERR|ALERT|CRIT|EMERG|NOTICE|CONT)\s*,\s*@dev_\L$1_once\(@g;
+	$text =~ s@\bdev_warning_once\b@dev_warn_once@g;
+    }
+
+# Convert dev_printk(KERN_DEBUG to dev_dbg(
+    $do_cvt = "dev_printk_KERN_DEBUG_to_dev_dbg";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s@\bdev_printk\s*\(\s*KERN_(DEBUG)\s*,\s*@dev_dbg\(@g;
+    }
+
+# Convert sdev_printk(KERN_<level> to sdev_<level>(
+    $do_cvt = "sdev_printk_to_sdev_level";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s@\bsdev_printk\s*\(\s*KERN_(INFO|WARNING|ERR|ALERT|CRIT|EMERG|NOTICE)\s*,\s*@sdev_\L$1\(@g;
+	$text =~ s@\bsdev_warning\b@sdev_warn@g;
+
+	$hash{$do_cvt} += $text =~ s@\bsdev_printk_ratelimited\s*\(\s*KERN_(INFO|WARNING|ERR|ALERT|CRIT|EMERG|NOTICE|CONT)\s*,\s*@sdev_\L$1_ratelimited\(@g;
+	$text =~ s@\bsdev_warning_ratelimited\b@sdev_warn_ratelimited@g;
+
+	$hash{$do_cvt} += $text =~ s@\bsdev_printk_once\s*\(\s*KERN_(INFO|WARNING|ERR|ALERT|CRIT|EMERG|NOTICE|CONT)\s*,\s*@sdev_\L$1_once\(@g;
+	$text =~ s@\bsdev_warning_once\b@sdev_warn_once@g;
+    }
+
+# Convert sdev_printk(KERN_DEBUG to sdev_dbg(
+    $do_cvt = "sdev_printk_KERN_DEBUG_to_sdev_dbg";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s@\bsdev_printk\s*\(\s*KERN_(DEBUG)\s*,\s*@sdev_dbg\(@g;
+    }
+
+# Coalesce long formats
+    $do_cvt = "coalesce_formats";
+    if (convert($do_cvt)) {
+	my $count = 0;
+	do {
+	    $count = $text =~ s@\b(${logFunctions}\s*\([^;]+)(?!\\n)\"\s*\n\s*\"@$1@g;
+	    $hash{$do_cvt} += $count;
+	} while ($count > 0);
+    }
+
+# Add space between KERN_<LEVEL> and open quote
+    $do_cvt = "space_after_KERN_level";
+    if (convert($do_cvt)) {
+	my @matches = $text =~ m@\b(KERN_(DEBUG|INFO|WARNING|ERR|ALERT|CRIT|EMERG|NOTICE|CONT)) \"@g;
+	$hash{$do_cvt} -= @matches;
+	$hash{$do_cvt} += $text =~ s@\b(KERN_(DEBUG|INFO|WARNING|ERR|ALERT|CRIT|EMERG|NOTICE|CONT))[ \t]*\"@$1 \"@g;
+    }
+
+# Remove unnecessary parentheses around return
+    $do_cvt = "deparenthesize_returns";
+    if (convert($do_cvt)) {
+	my $count = 0;
+	do {
+	    $count = $text =~ s@\breturn\s*${match_balanced_parentheses}\s*;@"return " . scalar(strip_outer_paren($1)) . ";"@egx;
+	    $hash{$do_cvt} += $count;
+	} while ($count > 0);
+    }
+
+# This doesn't work very well, too many comments modified
+# Put labels (but not "default:") on column 1
+    $do_cvt = "move_labels_to_column_1";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s@^([ \t]+)([A-Za-z0-9_]+)\s*:[ \t]*:[ \t]*$@check_label($1, $2)@ge;
+    }
+
+# Add space after (if, while, for, switch) and open parenthesis
+    $do_cvt = "space_after_if_while_for_switch";
+    if (convert($do_cvt)) {
+	my @matches = $text =~ m@\b(if|while|for|switch) \(@g;
+	$hash{$do_cvt} -= @matches;
+	$hash{$do_cvt} += $text =~ s@\b(if|while|for|switch)[ \t]*\(@$1 \(@g;
+    }
+
+# Add space after comma
+    $do_cvt = "space_after_comma";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s@,(?=[\w\(])@, @g;
+    }
+
+# Add spaces around logical tests
+    $do_cvt = "space_around_logical_tests";
+    if (convert($do_cvt)) {
+	my $count = 0;
+	do {
+	    $count = $text =~ s@([\)\w]+)(==|!=|>|>=|<|<=|&&|\|\|)([\(\w\*\-])@$1 $2 $3@g;
+	    $hash{$do_cvt} += $count;
+	} while ($count > 0);
+    }
+
+# Add spaces around assign
+    $do_cvt = "space_around_assign";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s@([\)\w]+)(=|\+=|\-=|\*=|/=|>>=|<<=)([\(\w\*\-])@$1 $2 $3@g;
+    }
+
+# Add spaces around arithmetic
+    $do_cvt = "space_around_arithmetic";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s@([\)\w]+)(\+|\-)([\(\w\*])@$1 $2 $3@g;
+    }
+
+# Add spaces around trigraph
+    $do_cvt = "space_around_trigraph";
+    if (convert($do_cvt)) {
+	my @matches = $text =~ m@([\)\w\"]+) \? ([\(\)\[\]\w\*\" \t\.\>\-]*[^ \t]) \: ([\w\(\"\-])@g;
+	$hash{$do_cvt} -= @matches;
+	$hash{$do_cvt} += $text =~ s@([\)\w\"]+)[ \t]*\?[ \t]*([\(\)\[\]\w\*\" \t\.\>\-]*[^ \t])[ \t]*\:[ \t]*([\w\(\"\-])@$1 ? $2 : $3@g;
+    }
+
+# Use a space before a pointer,
+    $do_cvt = "space_before_pointer";
+    if (convert($do_cvt)) {
+	my @matches = $text =~ m@\bstruct \w+ \*@g;
+	$hash{$do_cvt} -= @matches;
+	$hash{$do_cvt} += $text =~ s@\bstruct\b\s+(\w+)([\t]+)\*[ \t]*@struct $1$2\*@g;
+	$hash{$do_cvt} += $text =~ s@\bstruct\b\s+(\w+) *\*[ \t]*@struct $1 \*@g;
+	$hash{$do_cvt} += $text =~ s@\bstruct\b\s+(\w+)([ \t]+)\*__@struct $1$2\* __@g;
+    }
+
+# Convert "for (foo;bar;baz)" to "for (foo; bar; baz)"
+    $do_cvt = "space_after_for_semicolons";
+    if (convert($do_cvt)) {
+	my $count;
+	($count, $text) = subst_line_mode_fn($text, '^([ \t]*)for\s*\([ \t]*([^;]+);[ \t]*([^;]+);[ \t]*([^\)]+)\)', 'check_for', '$1, $2, $3, $4');
+	$hash{$do_cvt} += $count;
+    }
+
+# cuddle open brace
+    $do_cvt = "cuddle_open_brace";
+    if (convert($do_cvt)) {
+	my @matches = $text =~ m@(\)|\belse\b) \{\n@g;
+	$hash{$do_cvt} -= @matches;
+	$hash{$do_cvt} += $text =~ s@(\)|\belse\b|\bcase\s+\w+\s*:|\b(?:struct|union)[ \t]*(?:\w+|))[ \t]*[ \t]*\n[ \t]+\{[ \t]*\n@$1 \{\n@g;
+    }
+
+# cuddle else
+    $do_cvt = "cuddle_else";
+    if (convert($do_cvt)) {
+	my @matches = $text =~ m@\} else\b@g;
+	$hash{$do_cvt} -= @matches;
+	$hash{$do_cvt} += $text =~ s@\}[ \t]*\n[ \t]+else\b@\} else@g;
+    }
+
+# Remove multiple semicolons at end-of-line
+    $do_cvt = "coalesce_semicolons";
+    if (convert($do_cvt)) {
+	my $count = 0;
+	do {
+	    $count = $text =~ s@;[ \t]*;[ \t]*\n@;\n@g;
+	    $hash{$do_cvt} += $count;
+	} while ($count > 0);
+    }
+
+# Remove spaces before open bracket
+    $do_cvt = "remove_whitespace_before_bracket";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s@[ \t]+\[@\[@g;
+    }
+
+# Remove spaces after open parenthesis and before close parenthesis
+    $do_cvt = "remove_parenthesis_whitespace";
+    if (convert($do_cvt)) {
+	$text =~ s@[ \t]*\)@\)@g;
+	$text =~ s@\([ \t]*@\(@g;
+    }
+
+# Convert leading spaces to tabs
+    $do_cvt = "leading_spaces_to_tabs";
+    if (convert($do_cvt)) {
+	my $count;
+	($count, $text) = subst_line_mode_fn($text, '(^[ \t]+)', 'tabify', '$1');
+	$hash{$do_cvt} += $count;
+    }
+
+# Remove trailing whitespace
+    $do_cvt = "remove_trailing_whitespace";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s@[ \t]+\n@\n@g;
+	$hash{$do_cvt} += $text =~ s@\n+$@\n@g;
+    }
+
+# Remove whitespace before quoted newlines
+    $do_cvt = "remove_whitespace_before_quoted_newline";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s@(\"[^\"\n]*[^ \t])[ \t]+\\n@$1\\n@g;
+    }
+
+# Remove whitespace before trailing semicolon
+    $do_cvt = "remove_whitespace_before_trailing_semicolon";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s@(\n[^\n]+)\s+;[ \t]*\n$@$1;\n@g;
+    }
+
+# Remove whitespace after cast
+    $do_cvt = "remove_whitespace_after_cast";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s@[ \t]*\*[ \t]*\)[ \t]+@ \*\)@g;
+    }
+
+# Convert c99 comments to /* */ (don't convert (http|ftp)://)
+    $do_cvt = "convert_c99_comments";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s@(?<!:)\/\/[ \t]*(.*)[ \t]*\n+@\/* $1 *\/\n@g;
+    }
+
+# Remove braces from single statements (not multiple-line single statements)
+    $do_cvt = "remove_single_statement_braces";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s@[ \t]*\{[ \t]*\n([^;\{\n]+;)[ \t]*\n[ \t]+\}[ \t]*\n@\n$1\n@g;
+    }
+
+# Hoist assigns from if
+    $do_cvt = "hoist_assigns_from_if";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s@\n([ \t]*)if\s*\(\s*([\!]{0,1})\s*\(\s*([\*\w\-\>\.\[\]]+)\s*=\s*(?=[^=])\s*([\w\-\>\.\* \t\[\]]*\s*${match_balanced_parentheses}*\s*(\?\:\&|\||\>\>|\<\<|\-|\+|\*|\/ \t)*\s*[\w\-\>\.\* \t\[\]]*\s*${match_balanced_parentheses}*)\s*\)@\n$1$3 = $4;\n$1if \($2$3@gx;
+    }
+
+# Remove casts of private_data
+    $do_cvt = "remove_private_data_casts";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s/=\s*\(\s*\w+\s*\w+\s*\*\s*\)\s*(\w+)->\s*private_data\b/= $1->private_data/g;
+    }
+
+# Remove static initializations to 0 or NULL
+
+    $do_cvt = "remove_static_initializations_to_0";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s/\b([ \t]*)static\s*([\w\t \*]+)\s*=\s*(0|NULL)\s*;/"$1static " . scalar(trim_trail($2)) . ";"/egx;
+    }
+
+# Convert "CamelCase" to "camel_case"
+    $do_cvt = "CamelCase_to_camel_case";
+    if (convert($do_cvt)) {
+	my $count = 0;
+	do {
+	    $count = $text =~ s/\b([A-Za-z])([a-z_]+)([A-Z])([a-zA-Z]+)\b/\L$1\E$2_\L$3\E$4/g;
+	    $hash{$do_cvt} += $count;
+	} while ($count > 0);
+    }
+
+# Remove comparisons to true or false
+    $do_cvt = "remove_true_false_comparisons";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s/(\([^\=\;\{\}\(]+)==\s*true\s*\)/"(" . scalar(strip_leading_paren(trim_trail($1))) . ")"/egx;
+	$hash{$do_cvt} += $text =~ s/(\([^\!\;\{\}\(]+)!=\s*true\s*\)/"(!" . scalar(strip_leading_paren(trim_trail($1))) . ")"/egx;
+	$hash{$do_cvt} += $text =~ s/(\([^\=\;\{\}\(]+)==\s*false\s*\)/"(!" . scalar(strip_leading_paren(trim_trail($1))) . ")"/egx;
+	$hash{$do_cvt} += $text =~ s/(\([^\!\;\{\}\(]+)!=\s*false\s*\)/"(" . scalar(strip_leading_paren(trim_trail($1))) . ")"/egx;
+    }
+
+# Remove comparisons to NULL
+    $do_cvt = "remove_NULL_comparisons";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s/(\([^\=\;\{\}\(]+)==\s*NULL\s*\)/"(!" . scalar(strip_leading_paren(trim_trail($1))) . ")"/egx;
+	$hash{$do_cvt} += $text =~ s/(\([^\!\;\{\}\(]+)!=\s*NULL\s*\)/"(" . scalar(strip_leading_paren(trim_trail($1))) . ")"/egx;
+    }
+
+# Remove trailing if semicolons
+    $do_cvt = "remove_trailing_if_semicolons";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s/\bif(\s*)($match_balanced_parentheses)\s*;(?!\s*(else|\/\*))/if$1$2/g;
+    }
+
+# Convert normal comments to network comments
+    $do_cvt = "network_comments";
+    if (convert($do_cvt)) {
+	$hash{$do_cvt} += $text =~ s@/\*[ \t]*\n[ \t]*\*@/*@g;
+	$hash{$do_cvt} += $text =~ s@/\*([ \t]*)([^\n]+)\n[ \t]*\*/@/\*$1$2 \*/@g;
+    }
+
+# Remove unnecessary semicolons after switch () {};
+    $do_cvt = "remove_switchforwhileif_semicolons";
+    if (convert($do_cvt)) {
+	my $count = 0;
+        do {
+	    $count = 0;
+	    $count += $text =~ s@\b((?:switch|for|while|if)\s*${match_balanced_parentheses}\s*)${match_balanced_braces}\s*;@"$1$3"@egx;
+	    $hash{$do_cvt} += $count;
+        } while ($count > 0);
+    }
+
+# detab_else_return
+    $do_cvt = "detab_else_return";
+    if (convert($do_cvt)) {
+	my $count = 0;
+        do {
+	    $count = 0;
+	    $count += $text =~ s@(?!else\s+)\b(if\s*${match_balanced_parentheses}\s*)${match_balanced_braces}\s*else\s*\{?\s*return\s+([^;]+;)\s*\}?@"$1$3"@egx;
+	    $hash{$do_cvt} += $count;
+        } while ($count > 0);
+    }
+
+# Remove while while loops
+    $do_cvt = "remove_while_while";
+    if (convert($do_cvt)) {
+	my $count = 0;
+        do {
+	    $count = 0;
+	    $count += $text =~ s@(while\s*(${match_balanced_parentheses})\s*${match_balanced_braces})\s*while\s*\2\s*;@$1@egx;
+	    $hash{$do_cvt} += $count;
+        } while ($count > 0);
+    }
+
+# Remove fallthrough comments and convert to fallthrough;
+    $do_cvt = "fallthrough";
+    if (convert($do_cvt)) {
+
+	# for style:
+
+	# /* <fallthrough comment> */
+	# case FOO:
+
+	# while (comment has fallthrough and next non-blank, non-continuation line is (case or default:)) {
+	#   remove newline, whitespace before, fallthrough comment and whitespace after
+	#   insert newline, adjusted spacing and fallthrough; newline
+	# }
+
+	my $count = 0;
+	my @fallthroughs = (
+	    'fallthrough',
+	    '@fallthrough@',
+	    'lint -fallthrough[ \t]*',
+	    '[ \t.!]*(?:ELSE,? |INTENTIONAL(?:LY)? )?',
+	    'intentional(?:ly)?[ \t]*fall(?:(?:s | |-)[Tt]|t)hr(?:ough|u|ew)',
+	    '(?:else,?\s*)?FALL(?:S | |-)?THR(?:OUGH|U|EW)[ \t.!]*(?:-[^\n\r]*)?',
+	    '[ \t.!]*(?:Else,? |Intentional(?:ly)? )?',
+	    'Fall(?:(?:s | |-)[Tt]|t)hr(?:ough|u|ew)[ \t.!]*(?:-[^\n\r]*)?',
+	    '[ \t.!]*(?:[Ee]lse,? |[Ii]ntentional(?:ly)? )?',
+	    'fall(?:s | |-)?thr(?:ough|u|ew)[ \t.!]*(?:-[^\n\r]*)?',
+	);
+	do {
+	    $count = 0;
+	    pos($text) = 0;
+	    foreach my $ft (@fallthroughs) {
+		my $regex = '(((?:[ \t]*\n)*[ \t]*)(/\*\s*(?!\*/)?\b' . "$ft" . '\s*(?!\*/)?\*/(?:[ \t]*\n)*)([ \t]*))(?:case\s+|default\s*:)';
+
+		while ($text =~ m{${regex}}i) {
+		    my $all_but_case = $1;
+		    my $space_before = $2;
+		    my $fallthrough = $3;
+		    my $space_after = $4;
+		    my $pos_before = $-[1];
+		    my $pos_after = $+[3];
+
+		    # try to maintain any additional comment on the same line
+		    my $comment = "";
+		    if ($regex =~ /\\r/) {
+			$comment = $fallthrough;
+			$comment =~ s@^/\*\s*@@;
+			$comment =~ s@\s*\*/\s*$@@;
+			$comment =~ s@^\s*(?:intentional(?:ly)?\s+|else,?\s*)?fall[s\-]*\s*thr(?:ough|u|ew)[\s\.\-]*@@i;
+			$comment =~ s@\s+$@@;
+			$comment =~ s@\.*$@@;
+			$comment = "\t/* $comment */" if ($comment ne "");
+		    }
+		    substr($text, $pos_before, $pos_after - $pos_before, "");
+		    substr($text, $pos_before, 0, "\n${space_after}\tfallthrough;${comment}\n");
+		    pos($text) = $pos_before;
+		    $count++;
+		}
+	    }
+	    $hash{$do_cvt} += $count;
+        } while ($count > 0);
+
+	# Reset the fallthroughs types to a single regex
+
+	@fallthroughs = (
+	    'fall(?:(?:s | |-)[Tt]|t)hr(?:ough|u|ew)'
+	);
+
+	# Convert the // <fallthrough> style comments followed by case/default:
+
+	do {
+	    $count = 0;
+	    pos($text) = 0;
+	    foreach my $ft (@fallthroughs) {
+		my $regex = '(((?:[ \t]*\n)*[ \t]*)(//[ \t]*(?!\n)?\b' . "$ft" . '[ \t]*(?!\n)?\n(?:[ \t]*\n)*)([ \t]*))(?:case\s+|default\s*:)';
+		while ($text =~ m{${regex}}i) {
+		    my $all_but_case = $1;
+		    my $space_before = $2;
+		    my $fallthrough = $3;
+		    my $space_after = $4;
+		    my $pos_before = $-[1];
+		    my $pos_after = $+[3];
+
+		    substr($text, $pos_before, $pos_after - $pos_before, "");
+		    substr($text, $pos_before, 0, "\n${space_after}\tfallthrough;\n");
+		    pos($text) = $pos_before;
+		    $count++;
+		}
+	    }
+	    $hash{$do_cvt} += $count;
+	} while ($count > 0);
+
+	# Convert /* fallthrough */ comment macro lines with trailing \
+
+	do {
+	    $count = 0;
+	    pos($text) = 0;
+	    foreach my $ft (@fallthroughs) {
+		my $regex = '((?:[ \t]*\\\\\n)*([ \t]*)(/\*[ \t]*\b' . "$ft" . '[ \t]*\*/)([ \t]*))\\\\\n*([ \t]*(?:case\s+|default\s*:))';
+
+		while ($text =~ m{${regex}}i) {
+		    my $all_but_case = $1;
+		    my $space_before = $2;
+		    my $fallthrough = $3;
+		    my $space_after = $4;
+		    my $pos_before = $-[2];
+		    my $pos_after = $+[4];
+
+		    my $oldline = "${space_before}${fallthrough}${space_after}";
+		    my $len = length(expand_tabs($oldline));
+
+		    my $newline = "${space_before}fallthrough;${space_after}";
+		    $newline .= "\t" while (length(expand_tabs($newline)) < $len);
+
+		    substr($text, $pos_before, $pos_after - $pos_before, "");
+		    substr($text, $pos_before, 0, "$newline");
+		    pos($text) = $pos_before;
+		    $count++;
+		}
+	    }
+	    $hash{$do_cvt} += $count;
+	} while ($count > 0);
+
+    }
+
+# write the file if something was changed
+
+    if ($text ne $oldtext) {
+	my $newfile = $file;
+
+	$modified = 1;
+
+	if (!$overwrite) {
+	    $newfile = "$newfile$suffix";
+	}
+	open($f, '>', $newfile)
+	    or die "$P: Can't open $newfile for write\n";
+	print $f $text;
+	close($f);
+
+	if (!$quiet || $stats) {
+	    if ($overwrite) {
+		print "Converted $file\n";
+	    } else {
+		print "Converted $file to $newfile\n";
+	    }
+	}
+
+	if ($stats) {
+	    while ((my $key, my $value) = each(%hash)) {
+		next if ($value <= 0);
+		print "$value\t$key\n" if $value;
+		$hash{$key} = 0;	#Reset for next file
+	    }
+	}
+    }
+}
+
+
+if ($modified && !$quiet) {
+    print <<EOT;
+
+Warning: these changes may not be correct.
+
+These changes should be carefully reviewed manually and not combined with
+any functional changes.
+
+Compile, build and test your changes.
+
+You should understand and be responsible for all object changes.
+
+Make sure you read Documentation/SubmittingPatches before sending
+any changes to reviewers, maintainers or mailing lists.
+EOT
+}
-- 
2.15.0

