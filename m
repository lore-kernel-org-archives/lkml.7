Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7612C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C699D21848
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfJBVgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 17:36:37 -0400
Received: from smtprelay0175.hostedemail.com ([216.40.44.175]:48736 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729042AbfJBVgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 17:36:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 18FDF18024AE5;
        Wed,  2 Oct 2019 21:36:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cake40_1c3454dfe8209
X-Filterd-Recvd-Size: 2626
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed,  2 Oct 2019 21:36:33 +0000 (UTC)
Message-ID: <6436567dd141e5528a5363dd3aaad21815a1c111.camel@perches.com>
Subject: Re: [PATCH 3.16 29/87] staging: iio: cdc: Don't put an else right
 after a return
From:   Joe Perches <joe@perches.com>
To:     Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        Catalina Mocanu <catalina.mocanu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed, 02 Oct 2019 14:36:32 -0700
In-Reply-To: <lsq.1570043211.136218297@decadent.org.uk>
References: <lsq.1570043211.136218297@decadent.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-02 at 20:06 +0100, Ben Hutchings wrote:
> 3.16.75-rc1 review patch.  If anyone has any objections, please let me know.

This doesn't look necessary.

> ------------------
> 
> From: Catalina Mocanu <catalina.mocanu@gmail.com>
> 
> commit 288903f6b91e759b0a813219acd376426cbb8f14 upstream.
> 
> This fixes the following checkpatch.pl warning:
> WARNING: else is not generally useful after a break or return.
> 
> While at it, remove new line for symmetry with the rest of the code.
> 
> Signed-off-by: Catalina Mocanu <catalina.mocanu@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  drivers/staging/iio/cdc/ad7150.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> --- a/drivers/staging/iio/cdc/ad7150.c
> +++ b/drivers/staging/iio/cdc/ad7150.c
> @@ -143,19 +143,15 @@ static int ad7150_read_event_config(stru
>  	case IIO_EV_TYPE_MAG_ADAPTIVE:
>  		if (dir == IIO_EV_DIR_RISING)
>  			return adaptive && (threshtype == 0x1);
> -		else
> -			return adaptive && (threshtype == 0x0);
> +		return adaptive && (threshtype == 0x0);
>  	case IIO_EV_TYPE_THRESH_ADAPTIVE:
>  		if (dir == IIO_EV_DIR_RISING)
>  			return adaptive && (threshtype == 0x3);
> -		else
> -			return adaptive && (threshtype == 0x2);
> -
> +		return adaptive && (threshtype == 0x2);
>  	case IIO_EV_TYPE_THRESH:
>  		if (dir == IIO_EV_DIR_RISING)
>  			return !adaptive && (threshtype == 0x1);
> -		else
> -			return !adaptive && (threshtype == 0x0);
> +		return !adaptive && (threshtype == 0x0);
>  	default:
>  		break;
>  	}
> 

