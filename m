Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1815C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8983121841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoWRQRmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfCTTI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:08:59 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41866 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfCTTIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:08:55 -0400
Received: by mail-ed1-f68.google.com with SMTP id a25so2964054edc.8;
        Wed, 20 Mar 2019 12:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3j7+CoBE5moNxDmBNVzkQjsnY/Mbp7RYB6a+PG6v6fU=;
        b=GoWRQRmOacd6Ukw9KEdU4F4crc8IuyOUhrSODQ4JUqZekUsnDTgZHapA84HneT3IYd
         jVDDnFBJuWEBIkgl7ZbsiAK1fAnm2hgf4Xzuf6o9hQMrV1v/QTfNfqxNE7AO7oUUvqe9
         FUphrFHNma4N5mhJOftC5LxK1/E7mPbRLBaqgtLP9WsaKNeuAYe6lkGFryNbTLiJwB0b
         TYCe/NpetT8+/T76SyfYwtFBanWtvKvcGT3kY5RnmUlPbuX67gYxgAaWEJln411r+dK+
         5fLNWLer0adYYVc+Qx1HWaa7LdlzJaxbkUpHu6JJc/5vUxE4vovHtLJ/DsHjVvTLyXcl
         hZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3j7+CoBE5moNxDmBNVzkQjsnY/Mbp7RYB6a+PG6v6fU=;
        b=CBA6p/XYnAqe76pucWbTLmTSvtwonvGfU4OKUUbP6xHp4RaJiF1nQnvnAxNEgo9P6Q
         muAQC73Py0HgYbXNCSo3dmyPGlRlRgJa1mb5hzP5yo0SctZjscqs6dxeAjXrjMN/ve/j
         mBt4vF7BYoXpPvrumIombQY04FfjGHRO1UaaQ08lljCA8GtEQ5gdMMpJJ/ESpvAIWriK
         O8alk2W2oyNX7YAJL9zDiR0D0yxZISkXe0NAKI8SkXJUbFFUa6d9tyw7mhi/S3oQ8AKl
         9FC7ZuokoFkOsWW305fbOgTJu3xd8FpHdbrV2g/4VKCUhkdX0xRsfzhh0W2CuHLunfvn
         s3Lw==
X-Gm-Message-State: APjAAAVBefryaMCTTAkQ6bXq+WzFTzD6eCd+8CATfwci1Y5v4RxNpvF+
        SRlI4FdXb8O3H30GY2ZuXKs=
X-Google-Smtp-Source: APXvYqzXX9bZ/0QJZQDVBwESuMx9ZpCq32lP6xPUynvI3K7miStx9SEJFK0t6a3E3xpa6xr47ANfTw==
X-Received: by 2002:a17:906:1299:: with SMTP id k25mr17674642ejb.80.1553108932886;
        Wed, 20 Mar 2019 12:08:52 -0700 (PDT)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id x3sm882219ede.25.2019.03.20.12.08.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 20 Mar 2019 12:08:51 -0700 (PDT)
Date:   Wed, 20 Mar 2019 12:08:49 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: -Wsometimes-uninitialized Clang warning in
 drivers/net/ethernet/broadcom/bnxt/bnxt.c
Message-ID: <20190320190849.GB28744@archlinux-ryzen>
References: <20190308005735.GA4122@archlinux-ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308005735.GA4122@archlinux-ryzen>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 05:57:35PM -0700, Nathan Chancellor wrote:
> Hi all,
> 
> We are trying to get Clang's -Wsometimes-uninitialized turned on for the
> kernel as it can catch some bugs that GCC can't. This warning came up:
> 
> drivers/net/ethernet/broadcom/bnxt/bnxt.c:1612:6: warning: variable 'len' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>         if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/broadcom/bnxt/bnxt.c:1703:19: note: uninitialized use occurs here
>         cpr->rx_bytes += len;
>                          ^~~
> drivers/net/ethernet/broadcom/bnxt/bnxt.c:1612:2: note: remove the 'if' if its condition is always false
>         if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/net/ethernet/broadcom/bnxt/bnxt.c:1540:18: note: initialize the variable 'len' to silence this warning
>         unsigned int len;
>                         ^
>                          = 0
> 1 warning generated.
> 
> It seems like the logical change to make is this; however, I am not sure
> if this has any other unintended consequences since this is a rather
> dense function. I would much appreciate your input, especially if there
> is a better way to fix it.
> 
> Cheers,
> Nathan
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 0bb9d7b3a2b6..7d3d206c2e86 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -1615,7 +1615,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
>                         bnxt_reuse_rx_agg_bufs(cpr, cp_cons, agg_bufs);
>  
>                 rc = -EIO;
> -               goto next_rx;
> +               goto next_rx_no_prod_no_len;
>         }
>  
>         len = le32_to_cpu(rxcmp->rx_cmp_len_flags_type) >> RX_CMP_LEN_SHIFT;

Gentle ping (if there was a response to this, I didn't receive it). I
know I sent it in the middle of a merge window so I get if it slipped
through the cracks.

Thanks,
Nathan
