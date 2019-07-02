Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EBBC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC51E2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfGBNLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:11:49 -0400
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:48448 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726623AbfGBNLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:11:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 60C83100E86CA;
        Tue,  2 Jul 2019 13:11:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: grip38_f90b2bb5cc18
X-Filterd-Recvd-Size: 1636
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue,  2 Jul 2019 13:11:46 +0000 (UTC)
Message-ID: <613b7f1dd7244df22f677777cc946758cbd7e61c.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add *_NOTIFIER_HEAD as var definition
From:   Joe Perches <joe@perches.com>
To:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Ofir Drang <ofir.drang@arm.com>, linux-kernel@vger.kernel.org
Date:   Tue, 02 Jul 2019 06:11:45 -0700
In-Reply-To: <20190702123037.28174-1-gilad@benyossef.com>
References: <20190702123037.28174-1-gilad@benyossef.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-02 at 15:30 +0300, Gilad Ben-Yossef wrote:
> Add *_NOTIFIER_HEAD as variable definition to avoid code like this:
> 
> ATOMIC_NOTIFIER_HEAD(foo);
> EXPORT_SYMBOL_GPL(foo);
> 
> From triggering the the following warning:
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3864,6 +3864,7 @@ sub process {
>  				^.DEFINE_$Ident\(\Q$name\E\)|
>  				^.DECLARE_$Ident\(\Q$name\E\)|
>  				^.LIST_HEAD\(\Q$name\E\)|
> +				^.$Ident._NOTIFIER_HEAD\(\Q$name\E\)|

I think you want "${Ident}_NOTIFIER_HEAD\(\Q$name\E\)

>  				^.(?:$Storage\s+)?$Type\s*\(\s*\*\s*\Q$name\E\s*\)\s*\(|
>  				\b\Q$name\E(?:\s+$Attribute)*\s*(?:;|=|\[|\()
>  			    )/x) {

