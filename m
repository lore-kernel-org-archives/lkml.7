Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75DAC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 18:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C044321738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 18:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfGDSzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 14:55:43 -0400
Received: from smtprelay0103.hostedemail.com ([216.40.44.103]:35395 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726404AbfGDSzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 14:55:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id EE55F180A8158;
        Thu,  4 Jul 2019 18:55:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spy10_4eb8e4a98aa28
X-Filterd-Recvd-Size: 1962
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu,  4 Jul 2019 18:55:40 +0000 (UTC)
Message-ID: <7f2c01da182551a043a049bb0b367924ee073358.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: add *_NOTIFIER_HEAD as var definition
From:   Joe Perches <joe@perches.com>
To:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ofir Drang <ofir.drang@arm.com>, linux-kernel@vger.kernel.org
Date:   Thu, 04 Jul 2019 11:55:39 -0700
In-Reply-To: <20190704104457.30045-1-gilad@benyossef.com>
References: <20190704104457.30045-1-gilad@benyossef.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-04 at 13:44 +0300, Gilad Ben-Yossef wrote:
> Add *_NOTIFIER_HEAD as variable definition to avoid code like this:
> 
> ATOMIC_NOTIFIER_HEAD(foo);
> EXPORT_SYMBOL_GPL(foo);
> 
> From triggering the the following warning:
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> ---
> 
> Changes from v1:
> - Better RegExp as suggested by Joe Perches.

Seems fine thanks.

>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 342c7c781ba5..9cadda7024ae 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3864,6 +3864,7 @@ sub process {
>  				^.DEFINE_$Ident\(\Q$name\E\)|
>  				^.DECLARE_$Ident\(\Q$name\E\)|
>  				^.LIST_HEAD\(\Q$name\E\)|
> +				^.{$Ident}_NOTIFIER_HEAD\(\Q$name\E\)|
>  				^.(?:$Storage\s+)?$Type\s*\(\s*\*\s*\Q$name\E\s*\)\s*\(|
>  				\b\Q$name\E(?:\s+$Attribute)*\s*(?:;|=|\[|\()
>  			    )/x) {

