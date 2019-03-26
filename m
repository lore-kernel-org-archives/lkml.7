Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7966C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778942075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 20:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732670AbfCZUSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:18:14 -0400
Received: from smtprelay0159.hostedemail.com ([216.40.44.159]:41006 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731701AbfCZUSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 16:18:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 33014100E86C9;
        Tue, 26 Mar 2019 20:18:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rake32_475d28ad75e5f
X-Filterd-Recvd-Size: 2202
Received: from XPS-9350 (unknown [108.199.229.0])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 26 Mar 2019 20:18:10 +0000 (UTC)
Message-ID: <c08956873f4dfd7dc8bd918bf59443de9c2c7b33.camel@perches.com>
Subject: Re: [PATCH v2 6/6] lib/vsprintf: Add %pfw conversion specifier for
 printing fwnode names
From:   Joe Perches <joe@perches.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Date:   Tue, 26 Mar 2019 13:18:09 -0700
In-Reply-To: <20190326124106.27694-7-sakari.ailus@linux.intel.com>
References: <20190326124106.27694-1-sakari.ailus@linux.intel.com>
         <20190326124106.27694-7-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-26 at 14:41 +0200, Sakari Ailus wrote:
> Add support for %pfw conversion specifier (with "f" and "P" modifiers) to
> support printing full path of the node, including its name ("f") and only
> the node's name ("P") in the printk family of functions. The two flags
> have equivalent functionality to existing %pOF with the same two modifiers
> ("f" and "P") on OF based systems. The ability to do the same on ACPI
> based systems is added by this patch.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5977,7 +5977,8 @@ sub process {
>  				while ($fmt =~ /(\%[\*\d\.]*p(\w))/g) {
>  					$specifier = $1;
>  					$extension = $2;
> -					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOx]/) {
> +					if ($extension !~ /[SsBKRraEhMmIiUDdgVCbGNOxf]/ ||
> +					    $extension =~ /f[^w]/) {
>  						$bad_specifier = $specifier;
>  						last;
>  					}

You also need to remove the bit about using %pF or %pf below this

					if ($bad_specifier =~ /p[Ff]/) {
						$ext_type = "Deprecated";
						$use = " - use %pS instead";
						$use =~ s/pS/ps/ if ($bad_specifier =~ /pf/);
					}


