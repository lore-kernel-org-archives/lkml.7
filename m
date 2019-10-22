Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53701CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E83A207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="MmHCB89C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389236AbfJVW3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 18:29:23 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:38535 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732684AbfJVW3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 18:29:23 -0400
Received: by mail-lj1-f169.google.com with SMTP id q78so3758948lje.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=9FOtoCFESHJi4wxTzN6IqBIN6ywWAlgMoghhNwhRpqM=;
        b=MmHCB89CJklZxCu7RA3AVIPVHrD3pzJXbkPORYa3HjFwqiJPCTkxBvQuhvsW2IfrFe
         5HEuCjOyed5FfpdhPxjYI6VSrQ9YDwG1mNmmcTVz7u6SYPobeqXP5PeuQ3nvNo9pZpFU
         8EEbgNiJymkvE2oWBuXpPC0Vprl/lFjvT1ALZq07LtleWptY0pZf/p0gRtBo5dLsHmEa
         N3KHQFZnRXR+j633ENPBwNPxuC9Y/Em9G5NUDrUJM6RrIclvlnCmd89D/94o10I9zti1
         lr99WphJoyUGhe1oDW+N1ZNhH/oZtBj8XU8lW6ZGTctX5+48ereaGKhtkfKzM6wlohje
         aAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=9FOtoCFESHJi4wxTzN6IqBIN6ywWAlgMoghhNwhRpqM=;
        b=SgU4fjhlheNraoHMH52nI8lJh5dH8jryZZXFXS4OZNvBvFuFglN5PKs8DCnfQKGc7C
         Cl98oDekThUwfebPAzI0veBWS79hXmTJk+7DM8lzIt7jpyJ7J3/d3g8Fb6NXR0IjNCzm
         CcvRc2zggf799jKWUH1FpGeyx1eTZucMpgL4m4OVziJJlXg02udzHC11U89a+Dprx5N9
         u7Hqs/1ZBrTXb4TDpkGfk0D93ijOBcg9jGv41ZDZofzBGjPW2tJO0Z434lLtzpQ0SqRF
         OXy1C8yhdn9NXn6kL+vDV41dlpw5sC2tT94ockGhV9pbAIhaMblfJ82DfZI21ITUfwbo
         zZgw==
X-Gm-Message-State: APjAAAXGyn1FFfpdEDJwgRo2IpKvL+x1/cBsKOE41mUAS7C42JDP39d2
        MM68aLgmkgRt4aCU8JQcJnveDg==
X-Google-Smtp-Source: APXvYqw9u+Fbae9zCZZJofKlkrDbCHtrHbcSTTrEc5Ccg3iiYwsVqWefC8WGWjEwghACsA+sUNYang==
X-Received: by 2002:a2e:3c05:: with SMTP id j5mr20619250lja.24.1571783361168;
        Tue, 22 Oct 2019 15:29:21 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id j26sm7660642lja.25.2019.10.22.15.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 15:29:20 -0700 (PDT)
Date:   Tue, 22 Oct 2019 15:29:14 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [V2] net: hwbm: if CONFIG_NET_HWBM unset, make stub
 functions static
Message-ID: <20191022152914.19790aea@cakuba.netronome.com>
In-Reply-To: <20191022152551.19730-1-ben.dooks@codethink.co.uk>
References: <20191022152551.19730-1-ben.dooks@codethink.co.uk>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 16:25:51 +0100, Ben Dooks (Codethink) wrote:
> If CONFIG_NET_HWBM is not set, then these stub functions in
> <net/hwbm.h> should be declared static to avoid trying to
> export them from any driver that includes this.
> 
> Fixes the following sparse warnings:
> 
> ./include/net/hwbm.h:24:6: warning: symbol 'hwbm_buf_free' was not declared. Should it be static?
> ./include/net/hwbm.h:25:5: warning: symbol 'hwbm_pool_refill' was not declared. Should it be static?
> ./include/net/hwbm.h:26:5: warning: symbol 'hwbm_pool_add' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>

Same story, going over 80 chars here, please fix and post v2.

>  include/net/hwbm.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/hwbm.h b/include/net/hwbm.h
> index 81643cf8a1c4..76a303b2925c 100644
> --- a/include/net/hwbm.h
> +++ b/include/net/hwbm.h
> @@ -21,9 +21,9 @@ void hwbm_buf_free(struct hwbm_pool *bm_pool, void *buf);
>  int hwbm_pool_refill(struct hwbm_pool *bm_pool, gfp_t gfp);
>  int hwbm_pool_add(struct hwbm_pool *bm_pool, unsigned int buf_num);
>  #else
> -void hwbm_buf_free(struct hwbm_pool *bm_pool, void *buf) {}
> -int hwbm_pool_refill(struct hwbm_pool *bm_pool, gfp_t gfp) { return 0; }
> -int hwbm_pool_add(struct hwbm_pool *bm_pool, unsigned int buf_num)
> +static inline void hwbm_buf_free(struct hwbm_pool *bm_pool, void *buf) {}
> +static inline int hwbm_pool_refill(struct hwbm_pool *bm_pool, gfp_t gfp) { return 0; }
> +static inline int hwbm_pool_add(struct hwbm_pool *bm_pool, unsigned int buf_num)
>  { return 0; }
>  #endif /* CONFIG_HWBM */
>  #endif /* _HWBM_H */

