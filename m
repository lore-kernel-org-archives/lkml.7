Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B8BC4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7EBE222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 21:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYDCFMDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbfJDVir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 17:38:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41531 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfJDViq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 17:38:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id q7so4663507pfh.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 14:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K4kHrV8jU2TVoF4kHr19Jv4WsfKT1BHs16YW11NNnXg=;
        b=EYDCFMDfMXy1id7PSLkBMxwGv7DD6lIydzM5R1mcgZIE6GPb2kAYX1bNNM0DY6uhM/
         sPmJowRbmtJPNROzpR9AHsesvgFwDkRXC3z4NLuAIqfHkm5mK3E8HrDtvbYJmblJF9JJ
         1USPZi6RMndprcUHM+XsVSteNQs/wojv81igKL0DXivsWUBKYLfZMnZYDDt2S5Ju+Pe/
         RYS2O87cCs6quW+R93DHfIjMNzk1UltroT32K+/Pi9CdgEOmE6qV40vtmaC1Ad/j0Nwy
         IdxX/ro/oLYyaIrulCUIjXJ4SmTJ+d7/QmDY3tQqYZrLRJ9eCf4EfVGP1NhIBYc8IYUb
         VCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=K4kHrV8jU2TVoF4kHr19Jv4WsfKT1BHs16YW11NNnXg=;
        b=fBZIAKpN5Fi45y8km/XJAvu3hP5h2f1V4ikUAvn+Ot4x6Eg4J2XmbhT+EL22+Vm1cO
         SXq1M10AEPtm5Ae9UXZkG4X2CJMXX4LSpGV0B0w4nj8AAxGiMnIzOkmvYXOS9S+n9jVY
         D7W4wl8M3Jpnk1rZjQ+dbAU78vHpvQAFg9PEk8R+lwb1RXsIhYc0+TkRqzxtv3i0U7Rv
         zocBnmijGj4fsSKpBSSl1KDFiG/EAxqGBqvg3uvphtKJhIKPfuQ7KtVVW64ue5L0aLJd
         /kjPyI7rEAn/pxORR/e9f/28JoLpwKm9cNz4h3AxaveJ/xb1XpBACTelPkKMzlF15kOf
         r9LA==
X-Gm-Message-State: APjAAAX7TQ8ReRjpcCHW8ywUjJOxRe4mRqqiwM7TulfuHq3nlgGAt07Y
        yjsV3ml7InLnFNu8rp2u7kY=
X-Google-Smtp-Source: APXvYqyRJCnaQ8xZymQJhUPbbLvkJzmYO9ZW6s1FzNKEJKhCfN17zFJihDw4h0J2ePTA0cvSeBjd/w==
X-Received: by 2002:a62:86cf:: with SMTP id x198mr19694357pfd.234.1570225125139;
        Fri, 04 Oct 2019 14:38:45 -0700 (PDT)
Received: from [10.67.50.53] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s1sm7030372pjs.31.2019.10.04.14.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 14:38:44 -0700 (PDT)
Subject: Re: [PATCH v2] dma-mapping: Move vmap address checks into
 dma_map_single()
To:     Kees Cook <keescook@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Laura Abbott <labbott@redhat.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org
References: <201910041420.F6E55D29A@keescook>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <61277054-873e-7b1c-1424-871d023c8e3b@gmail.com>
Date:   Fri, 4 Oct 2019 14:38:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <201910041420.F6E55D29A@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/19 2:28 PM, Kees Cook wrote:
> As we've seen from USB and other areas, we need to always do runtime
> checks for DMA operating on memory regions that might be remapped. This
> moves the existing checks from USB into dma_map_single(), but leaves
> the slightly heavier checks as they are.
> 
> Suggested-by: Laura Abbott <labbott@redhat.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Nearly the same might be necessary for
drivers/usb/gadget/udc/core.c::usb_gadget_map_request_by_dev(). You
might also want to check other subsystems, SPI tries to be fairly smart
about vmalloc'd and kmap'd buffer, some I2C drivers have explicit checks
(they should probably rely on the core), and finally MTD is an area
where this has also been historically dealt with.

> ---
> v2: Only add is_vmalloc_addr()
> v1: https://lore.kernel.org/lkml/201910021341.7819A660@keescook
> ---
>  drivers/usb/core/hcd.c      | 8 +-------
>  include/linux/dma-mapping.h | 7 +++++++
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index f225eaa98ff8..281568d464f9 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -1410,10 +1410,7 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
>  		if (hcd->self.uses_pio_for_control)
>  			return ret;
>  		if (hcd_uses_dma(hcd)) {
> -			if (is_vmalloc_addr(urb->setup_packet)) {
> -				WARN_ONCE(1, "setup packet is not dma capable\n");
> -				return -EAGAIN;
> -			} else if (object_is_on_stack(urb->setup_packet)) {
> +			if (object_is_on_stack(urb->setup_packet)) {
>  				WARN_ONCE(1, "setup packet is on stack\n");
>  				return -EAGAIN;
>  			}
> @@ -1479,9 +1476,6 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
>  					ret = -EAGAIN;
>  				else
>  					urb->transfer_flags |= URB_DMA_MAP_PAGE;
> -			} else if (is_vmalloc_addr(urb->transfer_buffer)) {
> -				WARN_ONCE(1, "transfer buffer not dma capable\n");
> -				ret = -EAGAIN;
>  			} else if (object_is_on_stack(urb->transfer_buffer)) {
>  				WARN_ONCE(1, "transfer buffer is on stack\n");
>  				ret = -EAGAIN;
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 4a1c4fca475a..12dbd07f74f2 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -583,6 +583,13 @@ static inline unsigned long dma_get_merge_boundary(struct device *dev)
>  static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs)
>  {
> +	/* DMA must never operate on areas that might be remapped. */
> +	if (WARN_ONCE(is_vmalloc_addr(ptr),
> +		      "%s %s: driver maps %lu bytes from vmalloc area\n",
> +		      dev ? dev_driver_string(dev) : "unknown driver",
> +		      dev ? dev_name(dev) : "unknown device", size))
> +		return DMA_MAPPING_ERROR;
> +
>  	debug_dma_map_single(dev, ptr, size);
>  	return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
>  			size, dir, attrs);
> 


-- 
Florian
