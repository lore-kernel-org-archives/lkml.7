Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D557C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F762075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfDVKij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:38:39 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:42728 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfDVKii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 06:38:38 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id CB1E59E863A;
        Mon, 22 Apr 2019 11:38:36 +0100 (BST)
Date:   Mon, 22 Apr 2019 11:38:35 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <andriy.shevchenko@linux.intel.com>,
        <namhyung@kernel.org>, <mingo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] iio: Handle enumerated properties with gaps
Message-ID: <20190422113835.445b3acd@archlinux>
In-Reply-To: <20190422083257.21805-2-alexandru.ardelean@analog.com>
References: <20190422083257.21805-1-alexandru.ardelean@analog.com>
        <20190422083257.21805-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2019 11:32:57 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> Some enums might have gaps or reserved values in the middle of their value
> range. E.g. consider a 2-bit enum where the values 0, 1 and 3 have a
> meaning, but 2 is a reserved value and can not be used.
> 
> Add support for such enums to the IIO enum helper functions. A reserved
> values is marked by setting its entry in the items array to NULL rather
> than the normal descriptive string value.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Looks good, subject to the whole gaps parameter discussion on patch
1.

Thanks,

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index f2ebca65f964..c141a29bf446 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -447,8 +447,11 @@ ssize_t iio_enum_available_read(struct iio_dev *indio_dev,
>  	if (!e->num_items)
>  		return 0;
>  
> -	for (i = 0; i < e->num_items; ++i)
> +	for (i = 0; i < e->num_items; ++i) {
> +		if (!e->items[i])
> +			continue;
>  		len += scnprintf(buf + len, PAGE_SIZE - len, "%s ", e->items[i]);
> +	}
>  
>  	/* replace last space with a newline */
>  	buf[len - 1] = '\n';
> @@ -469,7 +472,7 @@ ssize_t iio_enum_read(struct iio_dev *indio_dev,
>  	i = e->get(indio_dev, chan);
>  	if (i < 0)
>  		return i;
> -	else if (i >= e->num_items)
> +	else if (i >= e->num_items || !e->items[i])
>  		return -EINVAL;
>  
>  	return snprintf(buf, PAGE_SIZE, "%s\n", e->items[i]);
> @@ -486,7 +489,8 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
>  	if (!e->set)
>  		return -EINVAL;
>  
> -	ret = __sysfs_match_string(e->items, e->num_items, buf);
> +	ret = __sysfs_match_string_with_gaps(e->items, e->num_items,
> +					     buf, true);
>  	if (ret < 0)
>  		return ret;
>  

