Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5A1C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAB020684
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555333802;
	bh=hsDbWrgWQWPzN8Om4dZeUQ05A2hzINLkEXBG6Y7kOdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HBzCvHbZLZrt4el9vcddSY04gjL/hu0Uo5SipCD7cAvvyCfDvyg1Rt8kzws6bK79W
	 8VE9/Zf5413dOExraNnRdguqwD2o758T5JlusqZHcIxTTdjXTg/uBflOEaP1dWB0O/
	 YSQEYTIAXbdVi+mQ/4T8lvPY61uCBg8FlR2A6wrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfDONKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:10:00 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42607 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfDONKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:10:00 -0400
Received: by mail-lj1-f196.google.com with SMTP id v22so15567182lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 06:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CzafLQFxyk2VowKyPM/l0QmH8L3FCOM/SiYzzcJK+ok=;
        b=TMEWP0lnIuHIDhb5FDm5CLR3j+/LovsuvfrdPK5v3r+M9pdQvnPe3vpRoo5I7wdQKh
         DmfcA99pRf8XxA+YwHFtOin/jTB5K9nVevosWkQqeP3Xk17382hjekBXMUJcrnTl23SQ
         Mh7Lqx6tvcOegEi/Yc+5d4NPNa1kpW/1C2zOrUfNnVuZJ2JcxoU+dmABSj3GKpJRlixA
         2WaGhOaTi979gmgwilHopR4FU24Q0zpABg/8Qlzcb/1gEgkd9CymcEHzjRvvMIh7pSMr
         +X2TfEnCqRYre6v0oCZWO+WmMy4xMknuhcjm1AG6CLMHfeTolZEc5uhg3KOO3KBNSHJ0
         7N4g==
X-Gm-Message-State: APjAAAV79V9bP6L71/cewb/zse0QxvzeAw9CaBmKuXW6GCFt8YA/CPXo
        7KPRf8o/PsQEYmB8XjSLArPkUwNG
X-Google-Smtp-Source: APXvYqxJtTm07FbOSWLozK5QR9X6XPLCCH+PVz1uOWCqbGDTo99y4Dpqbzkxvqz0D8LgzvVeyLVFQQ==
X-Received: by 2002:a2e:9915:: with SMTP id v21mr8549347lji.154.1555333798524;
        Mon, 15 Apr 2019 06:09:58 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id y19sm2026066lfb.24.2019.04.15.06.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 06:09:57 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hG1N4-0000jK-3Q; Mon, 15 Apr 2019 15:10:02 +0200
Date:   Mon, 15 Apr 2019 15:10:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: greybus: Cleanup in header file control.h
Message-ID: <20190415131002.GC775@localhost>
References: <20190405201437.3689-1-madhumithabiw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405201437.3689-1-madhumithabiw@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 03:14:37PM -0500, Madhumitha Prabakaran wrote:
> Fix a blank line after function/struct/union/enum
> declarations. Also, convert to_gb_control()  macro into an inline
> function in order to maintain Linux kernel coding style based
> on which the inline function is preferable over the macro.

There are about 1200 macros wrapping container_of() in the kernel, so
this is a common pattern which does not need to be changed (by contrast,
only a handful container_of are wrapped by functions).

> Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> ---
>  drivers/staging/greybus/control.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/control.h b/drivers/staging/greybus/control.h
> index 3a29ec05f631..a681ef74e7fe 100644
> --- a/drivers/staging/greybus/control.h
> +++ b/drivers/staging/greybus/control.h
> @@ -24,7 +24,11 @@ struct gb_control {
>  	char *vendor_string;
>  	char *product_string;
>  };
> -#define to_gb_control(d) container_of(d, struct gb_control, dev)
> +

No need for a blank line either as the macro is closely related to the
preceding struct declaration.

> +static inline struct gb_control *to_gb_control(struct device *d)
> +{
> +	return container_of(d, struct gb_control, dev);
> +}

Johan
