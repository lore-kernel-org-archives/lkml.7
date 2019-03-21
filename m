Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0369AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB862218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="qlDI6KyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfCUWM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:12:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43222 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfCUWM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:12:28 -0400
Received: by mail-pf1-f193.google.com with SMTP id c8so36121pfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 15:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bDO7jv4jcX5R4r9WpeQ3kY3anawmNf2lYHqYDopjEMU=;
        b=qlDI6KyRaNIjaBVgrzA5EIrjkeATi+FLJH/DoZu1q41HCyHSozHubMmPtOCwj3ekAX
         +DOU2kNP6pAwZek+oAlmuRnXq8o6GTpUWmujiF9dLPaO9BFTIAd+B4jx76ZmSRjm/2Ho
         mUbYA6yIoDwAAs1bnl7ED/qLJF0kDZ75yz8daoyW3bRtIBDuPHtBuDOekkOXcc20VdTj
         vz4CrtK89g+vMXpY2FZb2ejCwDs9oeJtumXQyprK4EaDZmS8DBERF0hRGdlAdMIM8vUx
         4mIvnyEXFumu54f2OejOGPstpYxz0zI5JbAwA4x1THbXZkpPu7AkVvQXGwsRRc3D1p08
         nHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bDO7jv4jcX5R4r9WpeQ3kY3anawmNf2lYHqYDopjEMU=;
        b=A95quy5k2wod63PWvnH8XeaZybmRrzhAsGr5gzZzS6olrQOCMxvQ9r4yO2FfMhJ4rh
         mu3wT6Yc9Y2h/r9mhjz4TSlzhC5YgC2t/RIuEsgf67Z//j7qDytp8mzcio8Y08QKR3+e
         RtlpRJ7hiR5xGzroO3LWj9+cj2luKFLLJSAziz5A7kbkkLtWA5YAtJlzzf6hqY9vK3gd
         o+g4DffUJnIFTzE2+Yo2AftliWsIkbvOCT+Z9858YakXwQZoIxUqEjnFdnjTxiFngc/T
         k0Sj6IGpLsMWRBmG0TqkFG4uFyZ0txrzcealckxp2j+lyZ0+Wb5Efd5kCzb5gJPDkBUe
         LJ/Q==
X-Gm-Message-State: APjAAAXs+eAO73UqiXH/xa9vaojTpdw8IH0DhrqT3PVtE1Iw3nBKAraD
        m5VpcJaTE2sJoY0l6b3B4vybQw==
X-Google-Smtp-Source: APXvYqzMKo0hn7p+qL+VBS1b4eOUAlXqgiya1L4jJS7Dbx5yc5SdZO0soP0hwP1UzIZ1xo6e3aov+w==
X-Received: by 2002:a65:6085:: with SMTP id t5mr5660931pgu.257.1553206347617;
        Thu, 21 Mar 2019 15:12:27 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:1643])
        by smtp.gmail.com with ESMTPSA id i135sm2028160pgd.41.2019.03.21.15.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 15:12:26 -0700 (PDT)
Date:   Thu, 21 Mar 2019 15:12:26 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Shenghui Wang <shhuiw@foxmail.com>
Cc:     axboe@kernel.dk, osandov@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sbitmap: trivial - update comment for
 sbitmap_deferred_clear_bit
Message-ID: <20190321221226.GC20838@vader>
References: <20190316082437.2766-1-shhuiw@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316082437.2766-1-shhuiw@foxmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 04:24:37PM +0800, Shenghui Wang wrote:
> "sbitmap_batch_clear" should be "sbitmap_deferred_clear"

Acked-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
> ---
>  include/linux/sbitmap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index 14d558146aea..20f3e3f029b9 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -330,7 +330,7 @@ static inline void sbitmap_clear_bit(struct sbitmap *sb, unsigned int bitnr)
>  /*
>   * This one is special, since it doesn't actually clear the bit, rather it
>   * sets the corresponding bit in the ->cleared mask instead. Paired with
> - * the caller doing sbitmap_batch_clear() if a given index is full, which
> + * the caller doing sbitmap_deferred_clear() if a given index is full, which
>   * will clear the previously freed entries in the corresponding ->word.
>   */
>  static inline void sbitmap_deferred_clear_bit(struct sbitmap *sb, unsigned int bitnr)
> -- 
> 2.20.1
> 
> 
> 
