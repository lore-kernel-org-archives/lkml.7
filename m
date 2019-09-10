Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFDAC49ED6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C754E206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbfIJKVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:21:32 -0400
Received: from smtprelay0089.hostedemail.com ([216.40.44.89]:57175 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726231AbfIJKVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:21:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 735C1180A8123;
        Tue, 10 Sep 2019 10:21:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: quilt67_8134ff3330428
X-Filterd-Recvd-Size: 3861
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Tue, 10 Sep 2019 10:21:27 +0000 (UTC)
Message-ID: <ef57a3fc72b548b7daf9257aacc596d57004199d.camel@perches.com>
Subject: Re: [PATCH v6 11/12] lib/vsprintf: Add %pfw conversion specifier
 for printing fwnode names
From:   Joe Perches <joe@perches.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date:   Tue, 10 Sep 2019 03:21:26 -0700
In-Reply-To: <20190910084707.18380-12-sakari.ailus@linux.intel.com>
References: <20190910084707.18380-1-sakari.ailus@linux.intel.com>
         <20190910084707.18380-12-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-10 at 11:47 +0300, Sakari Ailus wrote:
> Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> support printing full path of the node, including its name ("f") and only
> the node's name ("P") in the printk family of functions. The two flags
> have equivalent functionality to existing %pOF with the same two modifiers
> ("f" and "P") on OF based systems. The ability to do the same on ACPI
> based systems is added by this patch.

checkpatch comment below:
   A. 
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
[]
> @@ -418,6 +418,30 @@ Examples::
>  
>  Passed by reference.
>  
> +Fwnode handles
> +--------------
> +
> +::
> +
> +	%pfw[fP]
> +
> +For printing information on fwnode handles. The default is to print the full
> +node name, including the path. The modifiers are functionally equivalent to
> +%pOF above.
> +
> +	- f - full name of the node, including the path
> +	- P - the name of the node including an address (if there is one)
> +
> +Examples (ACPI)::
> +
> +	%pfwf	\_SB.PCI0.CIO2.port@1.endpoint@0	- Full node name
> +	%pfwP	endpoint@0				- Node name
> +
> +Examples (OF)::
> +
> +	%pfwf	/ocp@68000000/i2c@48072000/camera@10/port/endpoint - Full name
> +	%pfwP	endpoint				- Node name
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5988,14 +5988,17 @@ sub process {
>  		        for (my $count = $linenr; $count <= $lc; $count++) {
>  				my $specifier;
>  				my $extension;
> +				my $qualifier;
>  				my $bad_specifier = "";
>  				my $fmt = get_quoted_string($lines[$count - 1], raw_line($count, 0));
>  				$fmt =~ s/%%//g;
>  
> -				while ($fmt =~ /(\%[\*\d\.]*p(\w))/g) {
> +				while ($fmt =~ /(\%[\*\d\.]*p(\w)(\w?))/g) {

This is not generic enough to allow all possible qualifiers
to be captured.

This should be something like:

			while ($fmt =~ /(\%[\*\d\.]*p(\w)(\w*))/g) {
	
>  					$specifier = $1;
>  					$extension = $2;
> -					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxt]/) {
> +					$qualifier = $3;
> +					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxtf]/ ||
> +					    ($extension eq "f" && $qualifier ne "w")) {


And this should likely test
					    (defined $qualifier &&
					     $extension eq 'f' && $qualifier =~ /^w/))

>  						$bad_specifier = $specifier;
>  						last;
>  					}

And here the 'f' isn't really a bad $specifier,
it does not have the correct 'w' $extension.

The valid extensions may change in the future and
this code isn't particularly manageable, so I
think the $specifier/$extension pair should likely
have some additional testing after validating
the $specifier.



