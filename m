Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1890BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC04420851
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbfEVRQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 13:16:47 -0400
Received: from smtprelay0007.hostedemail.com ([216.40.44.7]:37669 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729915AbfEVRQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 13:16:46 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 689BF18011ADF;
        Wed, 22 May 2019 17:16:45 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 799BB180A887B;
        Wed, 22 May 2019 17:16:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sock87_3abe498a27f2d
X-Filterd-Recvd-Size: 2531
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 May 2019 17:16:43 +0000 (UTC)
Message-ID: <2b4878de1404e71d3085ee4832a5abc3526f2cdf.camel@perches.com>
Subject: Re: [PATCH] checkpatch.pl: Update DT vendor prefix check
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org
Date:   Wed, 22 May 2019 10:16:41 -0700
In-Reply-To: <20190522151238.25176-1-robh@kernel.org>
References: <20190522151238.25176-1-robh@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-22 at 10:12 -0500, Rob Herring wrote:
> In commit 8122de54602e ("dt-bindings: Convert vendor prefixes to
> json-schema"), vendor-prefixes.txt has been converted to a DT schema.
> Update the checkpatch.pl DT check to extract vendor prefixes from the new
> vendor-prefixes.yaml file.
> 
> Fixes: 8122de54602e ("dt-bindings: Convert vendor prefixes to json-schema")
> Cc: Joe Perches <joe@perches.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index bb28b178d929..073051a4471b 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3027,7 +3027,7 @@ sub process {
>  			my @compats = $rawline =~ /\"([a-zA-Z0-9\-\,\.\+_]+)\"/g;
>  
>  			my $dt_path = $root . "/Documentation/devicetree/bindings/";
> -			my $vp_file = $dt_path . "vendor-prefixes.txt";
> +			my $vp_file = $dt_path . "vendor-prefixes.yaml";
>  
>  			foreach my $compat (@compats) {
>  				my $compat2 = $compat;
> @@ -3042,7 +3042,7 @@ sub process {
>  
>  				next if $compat !~ /^([a-zA-Z0-9\-]+)\,/;
>  				my $vendor = $1;
> -				`grep -Eq "^$vendor\\b" $vp_file`;
> +				`grep -oE "\\"\\^[a-zA-Z0-9]+" $vp_file | grep -q "$vendor"`;

I think this does't work well as it loses the -
in various vendor prefixes:

  "^active-semi,.*":
  "^asahi-kasei,.*":
  "^ebs-systart,.*":
  "^inside-secure,.*":
  "^multi-inno,.*":
  "^netron-dy,.*":
  "^si-en,.*":
  "^si-linux,.*":
  "^tbs-biometrics,.*":
  "^u-blox,.*":
  "^x-powers,.*":

Perhaps the grep should be something like: (untested)

	`grep -Eq "\\"\\^\Q$vendor\E,\\.\\*\\":" $vp_file`;

