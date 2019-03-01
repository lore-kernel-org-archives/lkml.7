Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50649C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251A82070B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 19:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfCATbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:31:19 -0500
Received: from smtprelay0050.hostedemail.com ([216.40.44.50]:38988 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725934AbfCATbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 14:31:19 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 8AC8C180A8141;
        Fri,  1 Mar 2019 19:31:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: nest56_627c0156c4315
X-Filterd-Recvd-Size: 2065
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri,  1 Mar 2019 19:31:16 +0000 (UTC)
Message-ID: <29a040d31a84dd24618096e2776a66c23880f2d7.camel@perches.com>
Subject: Re: [PATCH] scripts: checkpatch: Check multiple blank lines when
 deleting code
From:   Joe Perches <joe@perches.com>
To:     Alexandre Ghiti <alex@ghiti.fr>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 01 Mar 2019 11:31:15 -0800
In-Reply-To: <20190228181531.18530-1-alex@ghiti.fr>
References: <20190228181531.18530-1-alex@ghiti.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-28 at 13:15 -0500, Alexandre Ghiti wrote:
> By matching only current line starting with '+', we miss the case
> when deleting code makes consecutive blank lines appear: this patch
> then makes it possible to detect this case by also matching current
> line starting with ' ', which is an already existing blank line.
> 
> On the following example, checkpatch --subjective now complains about
> multiple blank lines:
> 
>  static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
>  {
>  	long ret = delta;
> 
> -	if (!spool)
> -		return ret;
> 
>  	spin_lock(&spool->lock);
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3298,7 +3298,7 @@ sub process {
>  
>  # check for multiple consecutive blank lines
>  		if ($prevline =~ /^[\+ ]\s*$/ &&
> -		    $line =~ /^\+\s*$/ &&
> +		    $line =~ /^[\+ ]\s*$/ &&
>  		    $last_blank_line != ($linenr - 1)) {
>  			if (CHK("LINE_SPACING",
>  				"Please don't use multiple blank lines\n" . $hereprev) &&

I believe this screws up the --fix option just below this
if the line does not start with +





