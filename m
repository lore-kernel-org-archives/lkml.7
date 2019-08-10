Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AE1C32756
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 21:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FD42086A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 21:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfHJVCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 17:02:06 -0400
Received: from smtprelay0013.hostedemail.com ([216.40.44.13]:48350 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726377AbfHJVCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 17:02:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D4B0D8368EFE;
        Sat, 10 Aug 2019 21:02:04 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rings78_8660776233603
X-Filterd-Recvd-Size: 2510
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat, 10 Aug 2019 21:02:03 +0000 (UTC)
Message-ID: <b8a167bfb3731a665ba54b4fa4ccf899a31d9644.camel@perches.com>
Subject: Re: [PATCH 3.16 004/157] iio: Use kmalloc_array() in
 iio_scan_mask_set()
From:   Joe Perches <joe@perches.com>
To:     Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Jonathan Cameron <jic23@kernel.org>
Date:   Sat, 10 Aug 2019 14:02:02 -0700
In-Reply-To: <lsq.1565469607.57202441@decadent.org.uk>
References: <lsq.1565469607.57202441@decadent.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-08-10 at 21:40 +0100, Ben Hutchings wrote:
> 3.16.72-rc1 review patch.  If anyone has any objections, please let me know.

Unless to enable applying further patches,
I doubt there is ever a need to have any
of Markus Elfring's patches applied to any
-stable kernel.

> ------------------
> 
> From: Markus Elfring <elfring@users.sourceforge.net>
> 
> commit 057ac1acdfc4743f066fcefe359385cad00549eb upstream.
> 
> A multiplication for the size determination of a memory allocation
> indicated that an array data structure should be processed.
> Thus use the corresponding function "kmalloc_array".
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  drivers/iio/industrialio-buffer.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -836,10 +836,9 @@ int iio_scan_mask_set(struct iio_dev *in
>  	const unsigned long *mask;
>  	unsigned long *trialmask;
>  
> -	trialmask = kmalloc(sizeof(*trialmask)*
> -			    BITS_TO_LONGS(indio_dev->masklength),
> -			    GFP_KERNEL);
> -
> +	trialmask = kmalloc_array(BITS_TO_LONGS(indio_dev->masklength),
> +				  sizeof(*trialmask),
> +				  GFP_KERNEL);
>  	if (trialmask == NULL)
>  		return -ENOMEM;
>  	if (!indio_dev->masklength) {
> 

