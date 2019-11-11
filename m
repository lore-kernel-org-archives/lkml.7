Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB801C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFC120818
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 17:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hRd+mz4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKKRvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 12:51:03 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39592 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfKKRvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 12:51:03 -0500
Received: by mail-oi1-f193.google.com with SMTP id v138so12228411oif.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 09:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tn39DxU04+DSsZr8kND2VIZkOzQxYXWDgGYNHU/AaPM=;
        b=hRd+mz4f8xgu9UGqp+JB5w2XVjuC6AM5vJq8lX54ZYlKOZy/nB7PDAOXGqjR0F84eY
         YqAgormfY5752xJQkwv8SeEGwVgpQseunydRopDDDUgbojrTBH+WtiGpq8YsF228P8Hz
         ZwGnV06TT9wni26K8ZyoHr2ketlmDOV4AdnSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tn39DxU04+DSsZr8kND2VIZkOzQxYXWDgGYNHU/AaPM=;
        b=JXjThfn22intjI2WZKmIR2df4KOQqhSFmeP0dDKn7rW36DFQoR0ZLVwNqfeg8+ZOvX
         3TksfITusa7z6p9cX2BdpIO2Hl0KoA1/HahlCisXohjaS9Sca4Rd7chPoRGpIAmYU64A
         UPPNmkSo0+eQbx/PF7zeJRMofqRTANtxAdLTxFlzal0SQxWMXp3Ys5uMI8Rp13gy1S6H
         xfsMOurOyOJ8NmR1M+Ol16dNbchl5jELObQ53YDNpYQJiDMmko8BDyPfpLiBS88XXm6x
         gew7x8f3i/uj1W6HooR29CbTVFmCB9+H5YyVZUQpnTxUKqGEaWU/SRr1jldEjEAFVufq
         qJWQ==
X-Gm-Message-State: APjAAAUq3B40rw3eZ/UC0bhP4rXEkGfx7y8b3siCCVZRkUEhhD3WAfTB
        nQgiteLMUPc7ThGkD4jXPd69LmA5dLg+iG178J+sAw==
X-Google-Smtp-Source: APXvYqytxCcqPCMEqfFAueO6g/FMl4IwXESWckL/rgEvXl+6gdqL56xWWUP+3VFZtWrCD9a4CTyjsObDDXrAZcFYYrM=
X-Received: by 2002:aca:5cd5:: with SMTP id q204mr199928oib.14.1573494661964;
 Mon, 11 Nov 2019 09:51:01 -0800 (PST)
MIME-Version: 1.0
References: <20191111020855.20775-1-olof@lixom.net>
In-Reply-To: <20191111020855.20775-1-olof@lixom.net>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Mon, 11 Nov 2019 09:50:51 -0800
Message-ID: <CACKFLim64Yd=yp+P5FTFmVh3w-s1rWMROO_cbn940TkzKOFUCw@mail.gmail.com>
Subject: Re: [PATCH] net: bnxt_en: Fix array overrun in bnxt_fill_l2_rewrite_fields()
To:     Olof Johansson <olof@lixom.net>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 6:09 PM Olof Johansson <olof@lixom.net> wrote:
>
> This is caused by what seems to be a fragile typing approach by
> the Broadcom firmware/driver:
>
> /* FW expects smac to be in u16 array format */
>
> So the driver uses eth_addr and eth_addr_mask as u16[6] instead of u8[12],
> so the math in bnxt_fill_l2_rewrite_fields does a [6] deref of the u16
> pointer, it goes out of bounds on the array.
>
> Just a few lines below, they use ETH_ALEN/2, so this must have been
> overlooked. I'm surprised original developers didn't notice the compiler
> warnings?!
>
> Fixes: 90f906243bf6 ("bnxt_en: Add support for L2 rewrite")
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
> index 174412a55e53c..cde2b81f6fe54 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
> @@ -149,29 +149,32 @@ static void bnxt_set_l2_key_mask(u32 part_key, u32 part_mask,
>
>  static int
>  bnxt_fill_l2_rewrite_fields(struct bnxt_tc_actions *actions,
> -                           u16 *eth_addr, u16 *eth_addr_mask)
> +                           u8 *eth_addr, u8 *eth_addr_mask)
>  {
>         u16 *p;
> +       u8 *am;
>         int j;
>
>         if (unlikely(bnxt_eth_addr_key_mask_invalid(eth_addr, eth_addr_mask)))
>                 return -EINVAL;
>
> -       if (!is_wildcard(&eth_addr_mask[0], ETH_ALEN)) {
> -               if (!is_exactmatch(&eth_addr_mask[0], ETH_ALEN))
> +       am = eth_addr_mask;
> +       if (!is_wildcard(am, ETH_ALEN)) {
> +               if (!is_exactmatch(am, ETH_ALEN))
>                         return -EINVAL;
>                 /* FW expects dmac to be in u16 array format */
> -               p = eth_addr;
> -               for (j = 0; j < 3; j++)
> +               p = (u16 *)am;

Wouldn't this cause unaligned access?  am may not be u16 aligned, right?

> +               for (j = 0; j < ETH_ALEN / 2; j++)
>                         actions->l2_rewrite_dmac[j] = cpu_to_be16(*(p + j));
>         }
>
