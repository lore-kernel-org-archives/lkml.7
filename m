Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654E7C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7182075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfDVKhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:37:45 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:42718 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfDVKho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 06:37:44 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 545E19E8C28;
        Mon, 22 Apr 2019 11:37:42 +0100 (BST)
Date:   Mon, 22 Apr 2019 11:37:40 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <andriy.shevchenko@linux.intel.com>,
        <namhyung@kernel.org>, <mingo@kernel.org>
Subject: Re: [PATCH 1/2] lib: add __sysfs_match_string_with_gaps() helper
Message-ID: <20190422113740.6ef66205@archlinux>
In-Reply-To: <20190422083257.21805-1-alexandru.ardelean@analog.com>
References: <20190422083257.21805-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Apr 2019 11:32:56 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This helper is similar to __sysfs_match_string() with the exception that it
> ignores NULL elements within the array.
> It takes an extra parameter (called `gaps`) which when true will ignore
> the NULL elements. When false, this function behaves exactly like
> `__sysfs_match_string()`.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Hi Alex,

The existence of that gaps parameter does seem a little odd.
Why not just have the exposed _gaps form wrap a version that
takes that parameter and always set it to true?

Otherwise looks good to me.

Jonathan

> ---
>  include/linux/string.h |  9 ++++++++-
>  lib/string.c           | 14 ++++++++++----
>  2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 7927b875f80c..30595ed483dc 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -189,7 +189,14 @@ static inline int strtobool(const char *s, bool *res)
>  }
>  
>  int match_string(const char * const *array, size_t n, const char *string);
> -int __sysfs_match_string(const char * const *array, size_t n, const char *s);
> +int __sysfs_match_string_with_gaps(const char * const *array, size_t n,
> +				   const char *str, bool gaps);
> +
> +static inline int __sysfs_match_string(const char * const *array, size_t n,
> +				       const char *str)
> +{
> +	return __sysfs_match_string_with_gaps(array, n, str, false);
> +}
>  
>  /**
>   * sysfs_match_string - matches given string in an array
> diff --git a/lib/string.c b/lib/string.c
> index 38e4ca08e757..8ddac3cd292a 100644
> --- a/lib/string.c
> +++ b/lib/string.c
> @@ -659,30 +659,36 @@ int match_string(const char * const *array, size_t n, const char *string)
>  EXPORT_SYMBOL(match_string);
>  
>  /**
> - * __sysfs_match_string - matches given string in an array
> + * __sysfs_match_string_with_gaps - matches string in array ignoring NULLs
>   * @array: array of strings
>   * @n: number of strings in the array or -1 for NULL terminated arrays
>   * @str: string to match with
> + * @gaps: boolean to ignore NULL elements within the array
>   *
>   * Returns index of @str in the @array or -EINVAL, just like match_string().
>   * Uses sysfs_streq instead of strcmp for matching.
> + * Ignores NULL pointers within the @array if @gaps is true.
>   */
> -int __sysfs_match_string(const char * const *array, size_t n, const char *str)
> +int __sysfs_match_string_with_gaps(const char * const *array, size_t n,
> +				   const char *str, bool gaps)
>  {
>  	const char *item;
>  	int index;
>  
>  	for (index = 0; index < n; index++) {
>  		item = array[index];
> -		if (!item)
> +		if (!item) {
> +			if (gaps)
> +				continue;
>  			break;
> +		}
>  		if (sysfs_streq(item, str))
>  			return index;
>  	}
>  
>  	return -EINVAL;
>  }
> -EXPORT_SYMBOL(__sysfs_match_string);
> +EXPORT_SYMBOL(__sysfs_match_string_with_gaps);
>  
>  #ifndef __HAVE_ARCH_MEMSET
>  /**

