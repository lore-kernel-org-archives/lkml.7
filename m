Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9A0C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421E520851
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 13:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfFNN3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:29:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:23818 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbfFNN3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 09:29:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2019 06:29:00 -0700
X-ExtLoop1: 1
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jun 2019 06:28:58 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 05/14] scripts: add an script to parse the ABI files
In-Reply-To: <196fb3c497546f923bf5d156c3fddbe74a4913bc.1560477540.git.mchehab+samsung@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1560477540.git.mchehab+samsung@kernel.org> <196fb3c497546f923bf5d156c3fddbe74a4913bc.1560477540.git.mchehab+samsung@kernel.org>
Date:   Fri, 14 Jun 2019 16:31:56 +0300
Message-ID: <87r27wuwc3.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
>
> Add a script to parse the Documentation/ABI files and produce
> an output with all entries inside an ABI (sub)directory.
>
> Right now, it outputs its contents on ReST format. It shouldn't
> be hard to make it produce other kind of outputs, since the ABI
> file parser is implemented in separate than the output generator.

Hum, or just convert the ABI files to rst directly.

BR,
Jani.



>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  scripts/get_abi.pl | 212 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 212 insertions(+)
>  create mode 100755 scripts/get_abi.pl
>
> diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
> new file mode 100755
> index 000000000000..f7c9944a833c
> --- /dev/null
> +++ b/scripts/get_abi.pl
> @@ -0,0 +1,212 @@
> +#!/usr/bin/perl
> +
> +use strict;
> +use Pod::Usage;
> +use Getopt::Long;
> +use File::Find;
> +use Fcntl ':mode';
> +
> +my $help;
> +my $man;
> +my $debug;
> +
> +GetOptions(
> +	"debug|d+" => \$debug,
> +	'help|?' => \$help,
> +	man => \$man
> +) or pod2usage(2);
> +
> +pod2usage(1) if $help;
> +pod2usage(-exitstatus => 0, -verbose => 2) if $man;
> +
> +pod2usage(2) if (scalar @ARGV != 1);
> +
> +my ($prefix) = @ARGV;
> +
> +require Data::Dumper if ($debug);
> +
> +my %data;
> +
> +#
> +# Displays an error message, printing file name and line
> +#
> +sub parse_error($$$$) {
> +	my ($file, $ln, $msg, $data) = @_;
> +
> +	print STDERR "file $file#$ln: $msg at\n\t$data";
> +}
> +
> +#
> +# Parse an ABI file, storing its contents at %data
> +#
> +sub parse_abi {
> +	my $file = $File::Find::name;
> +
> +	my $mode = (stat($file))[2];
> +	return if ($mode & S_IFDIR);
> +	return if ($file =~ m,/README,);
> +
> +	my $name = $file;
> +	$name =~ s,.*/,,;
> +
> +	my $type = $file;
> +	$type =~ s,.*/(.*)/.*,$1,;
> +
> +	my $what;
> +	my $new_what;
> +	my $tag;
> +	my $ln;
> +
> +	print STDERR "Opening $file\n" if ($debug > 1);
> +	open IN, $file;
> +	while(<IN>) {
> +		$ln++;
> +		if (m/^(\S+):\s*(.*)/i) {
> +			my $new_tag = lc($1);
> +			my $content = $2;
> +
> +			if (!($new_tag =~ m/(what|date|kernelversion|contact|description|users)/)) {
> +				if ($tag eq "description") {
> +					$data{$what}->{$tag} .= "\n$content";;
> +					$data{$what}->{$tag} =~ s/\n+$//;
> +					next;
> +				} else {
> +					parse_error($file, $ln, "tag '$tag' is invalid", $_);
> +				}
> +			}
> +
> +			if ($new_tag =~ m/what/) {
> +				if ($tag =~ m/what/) {
> +					$what .= ", " . $content;
> +				} else {
> +					$what = $content;
> +					$new_what = 1;
> +				}
> +				$tag = $new_tag;
> +				next;
> +			}
> +
> +			$tag = $new_tag;
> +
> +			if ($new_what) {
> +				$new_what = 0;
> +
> +				$data{$what}->{type} = $type;
> +				$data{$what}->{file} = $name;
> +				print STDERR "\twhat: $what\n" if ($debug > 1);
> +			}
> +
> +			if (!$what) {
> +				parse_error($file, $ln, "'What:' should come first:", $_);
> +				next;
> +			}
> +			$data{$what}->{$tag} = $content;
> +			next;
> +		}
> +
> +		# Silently ignore any headers before the database
> +		next if (!$tag);
> +
> +		if (m/^\s*(.*)/) {
> +			$data{$what}->{$tag} .= "\n$1";
> +			$data{$what}->{$tag} =~ s/\n+$//;
> +			next;
> +		}
> +
> +		# Everything else is error
> +		parse_error($file, $ln, "Unexpected line:", $_);
> +	}
> +	close IN;
> +}
> +
> +# Outputs the output on ReST format
> +sub output_rest {
> +	foreach my $what (sort keys %data) {
> +		my $type = $data{$what}->{type};
> +		my $file = $data{$what}->{file};
> +
> +		my $w = $what;
> +		$w =~ s/([\(\)\_\-\*\=\^\~\\])/\\$1/g;
> +
> +		print "$w\n\n";
> +		print "- defined on file $file (type: $type)\n\n::\n\n";
> +
> +		my $desc = $data{$what}->{description};
> +		$desc =~ s/^\s+//;
> +
> +		# Remove title markups from the description, as they won't work
> +		$desc =~ s/\n[\-\*\=\^\~]+\n/\n/g;
> +
> +		# put everything inside a code block
> +		$desc =~ s/\n/\n /g;
> +
> +
> +		if (!($desc =~ /^\s*$/)) {
> +			print " $desc\n\n";
> +		} else {
> +			print " DESCRIPTION MISSING\n\n";
> +		}
> +	}
> +}
> +
> +#
> +# Parses all ABI files located at $prefix dir
> +#
> +find({wanted =>\&parse_abi, no_chdir => 1}, $prefix);
> +
> +print STDERR Data::Dumper->Dump([\%data], [qw(*data)]) if ($debug);
> +
> +#
> +# Outputs an ReST file with the ABI contents
> +#
> +output_rest
> +
> +
> +__END__
> +
> +=head1 NAME
> +
> +abi_book.pl - parse the Linux ABI files and produce a ReST book.
> +
> +=head1 SYNOPSIS
> +
> +B<abi_book.pl> [--debug] <ABI_DIR>]
> +
> +=head1 OPTIONS
> +
> +=over 8
> +
> +=item B<--debug>
> +
> +Put the script in verbose mode, useful for debugging. Can be called multiple
> +times, to increase verbosity.
> +
> +=item B<--help>
> +
> +Prints a brief help message and exits.
> +
> +=item B<--man>
> +
> +Prints the manual page and exits.
> +
> +=back
> +
> +=head1 DESCRIPTION
> +
> +Parse the Linux ABI files from ABI DIR (usually located at Documentation/ABI)
> +and produce a ReST book containing the Linux ABI.
> +
> +=head1 BUGS
> +
> +Report bugs to Mauro Carvalho Chehab <mchehab@s-opensource.com>
> +
> +=head1 COPYRIGHT
> +
> +Copyright (c) 2016 by Mauro Carvalho Chehab <mchehab@s-opensource.com>.
> +
> +License GPLv2: GNU GPL version 2 <http://gnu.org/licenses/gpl.html>.
> +
> +This is free software: you are free to change and redistribute it.
> +There is NO WARRANTY, to the extent permitted by law.
> +
> +=cut

-- 
Jani Nikula, Intel Open Source Graphics Center
