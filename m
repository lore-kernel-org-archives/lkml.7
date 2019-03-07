Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EE2C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5460620840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeOazCmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfCGPRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:17:48 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33323 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfCGPRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:17:47 -0500
Received: by mail-ed1-f65.google.com with SMTP id c55so13787168edb.0;
        Thu, 07 Mar 2019 07:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FDxJlGvA6UoZM0AuNbRuKofOJ7eEzo0HhNxl/qpIeKk=;
        b=SeOazCmA3rZqhfv5brNRFtmjRP4KmMIODX76vYHtmLEteIPUidnMRoRvowAnqWFcwk
         OTmZUC8uTF543OrPLzYWd2tXxF3d3QhUTfCH0DnleksJV9ekH/gTuYLwoRJUW8nSoHF9
         MzgB54hBZLtF6F+QuR3Smc9VC5WT95FDcyhVzD6VPOCDN27+/Lq9BqzUzjXP2ta8M5TT
         sCLj2Sv8hilXhR1OPQWNuh+5YxBUTgsJWtt/uLX23ULYQj4gsQN/vGR3tsodB8AFIshy
         2gWbtZiAaLEqBXJ4dIJJOpjRsnOpOn9Vn532u4aJ+Ut+vQQyLYOEpcb0EXPBv+lo98we
         UKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FDxJlGvA6UoZM0AuNbRuKofOJ7eEzo0HhNxl/qpIeKk=;
        b=ar3YiPNCaiUAxgQpiAw51+/kXbHANnbK6PckczcaEWpJJwEQa1y5yqoeEWC8Jwl5wf
         UMTpGWAETgta+aOtZIqaNmQrU8Uayf1kvJBLKYAZo103b7RNJPLSDrWU/Ih+anPsr/tQ
         vcIBXLUOTWAaT4VIYKQbQuedvOjEJtmdEUYB8U8GRdd1WubsCA0mF0OkVMQFh7BSps4V
         Or/QOMeU7B3xALK1YG/AWs2Z6gR/TavtlyVudtfbzURRORitDDGRTziF12CChVo2Xgv4
         0OzTZni15LnDdEc00r2qo4OyvOjHrSN/T6dDRH0rY03XfMBRORqZxD3rVfcQS/igbvs/
         O+pw==
X-Gm-Message-State: APjAAAUwSXrARyP1byuLdKQGGYKwQDpmVHcWfK3sChkmiAT/0p9NgA+F
        TamRWRZ6HOUbrsz6161RRFE=
X-Google-Smtp-Source: APXvYqwxf3jp62rjUnJUVlwIRdw8i4+j6lfw+rcZNHFOPzKFqyo1vraeT3ew6+XWtBByJnUEAP5U6g==
X-Received: by 2002:a50:b56c:: with SMTP id z41mr29033183edd.160.1551971865471;
        Thu, 07 Mar 2019 07:17:45 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id r1sm1374890eds.39.2019.03.07.07.17.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Mar 2019 07:17:44 -0800 (PST)
Date:   Thu, 7 Mar 2019 08:17:42 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Karsten Keil <isdn@linux-pingi.de>,
        "David S. Miller" <davem@davemloft.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isdn: isdnloop: fix pointer dereference bug
Message-ID: <20190307151742.GC20201@archlinux-ryzen>
References: <20190307093241.3380715-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307093241.3380715-1-arnd@arndb.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 10:32:07AM +0100, Arnd Bergmann wrote:
> clang has spotted an ancient code bug and warns about it with:
> 
> drivers/isdn/isdnloop/isdnloop.c:573:12: error: address of array 'card->rcard' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]
> 
> This is an array of pointers, so we should check if a specific
> pointer exists in the array before using it, not whether the
> array itself exists.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  drivers/isdn/isdnloop/isdnloop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/isdn/isdnloop/isdnloop.c b/drivers/isdn/isdnloop/isdnloop.c
> index f4253d468ae1..755c6bbc9553 100644
> --- a/drivers/isdn/isdnloop/isdnloop.c
> +++ b/drivers/isdn/isdnloop/isdnloop.c
> @@ -570,7 +570,7 @@ isdnloop_atimeout(isdnloop_card *card, int ch)
>  	char buf[60];
>  
>  	spin_lock_irqsave(&card->isdnloop_lock, flags);
> -	if (card->rcard) {
> +	if (card->rcard[ch]) {
>  		isdnloop_fake(card->rcard[ch], "DDIS_I", card->rch[ch] + 1);
>  		card->rcard[ch]->rcard[card->rch[ch]] = NULL;
>  		card->rcard[ch] = NULL;
> -- 
> 2.20.0
> 
