Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B268BC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8194021873
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730968AbfHHFuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 01:50:51 -0400
Received: from smtprelay0022.hostedemail.com ([216.40.44.22]:44146 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730884AbfHHFuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 01:50:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 7C45F1802ED78;
        Thu,  8 Aug 2019 05:50:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: space68_414ad160ef10c
X-Filterd-Recvd-Size: 1711
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Thu,  8 Aug 2019 05:50:48 +0000 (UTC)
Message-ID: <33e3b8748959b2f56b906b0bfd790df322f1ed3c.camel@perches.com>
Subject: Re: [PATCH] scripts/checkpatch.pl - fix *_NOTIFIER_HEAD handling
From:   Joe Perches <joe@perches.com>
To:     Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 07 Aug 2019 22:50:47 -0700
In-Reply-To: <33485.1565228181@turing-police>
References: <33485.1565228181@turing-police>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-08-07 at 21:36 -0400, Valdis Klētnieks wrote:
> commit 81398d99e9de80d9dbe65dfe7aadec9497f88242
> Author: Gilad Ben-Yossef <gilad@benyossef.com>
> Date:   Wed Jul 31 14:44:23 2019 +1000
> 
>     checkpatch: add *_NOTIFIER_HEAD as var definition
> 
> has a typo, resulting in a truly amazing error message:

Ouch, thanks.

> Unescaped left brace in regex is passed through in regex; marked by <-- HERE in m/(?:
[]
> Fix the typo.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3891,7 +3891,7 @@ sub process {
>  				^.DEFINE_$Ident\(\Q$name\E\)|
>  				^.DECLARE_$Ident\(\Q$name\E\)|
>  				^.LIST_HEAD\(\Q$name\E\)|
> -				^.{$Ident}_NOTIFIER_HEAD\(\Q$name\E\)|
> +				^.${Ident}_NOTIFIER_HEAD\(\Q$name\E\)|

Perhaps also better to convert all the '\Q$name\E' to '\s*\Q$name\E\s*'



