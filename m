Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F68C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 02:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA9920820
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 02:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbD7UPsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390852AbfFKCUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 22:20:09 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41680 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390455AbfFKCUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 22:20:09 -0400
Received: by mail-qk1-f195.google.com with SMTP id c11so6697685qkk.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 19:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HwcJ3r4qabrGVVXT3iY3gOmdfuWxDoWG3l3kjwZI/qg=;
        b=JbD7UPswwn5ywFpJwjc6MZcPot3MXgCElgt/h9mEcNcNfGh3mRREOcvyQ7IiFQYJnB
         lR5G4McHWsw+XiZmzwxLMErj5nMRCtfV6b2n6bdg/AlUY2ZZUHUgsxUhorxW0G/oon+y
         tHYcZ5Mi+pZlLcfe9ylSE0YMjihR8fxQveqpNOQy5y2vnX5svpMXwsth1qchiroLOr2F
         B/2nOSovSkh3DOAyixuedTleeJHNCw6Tswjw+TStnT1L1OgNQaBVRGV5wouFn5iTfqlJ
         14gSvJuBnX+QZHMz2bWHvF1nWjml3tatpZGtFdeD1r3v4Xgzcma4S2QYkrMMI+6JFsNX
         nQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HwcJ3r4qabrGVVXT3iY3gOmdfuWxDoWG3l3kjwZI/qg=;
        b=Vdkfd2N38Ab7c1eEbtuS2KNMBZ4vsZfXvhW7hmtPXfv+H5Yx7RH8MPeKy2HoUI2vpc
         o6JRLo+sd4dAdXm3aT/Ml5GHWnL3NJCGlu6iB6BUrxhIk4381QMUgA/YXzlOpXPcV0SF
         BaXY5Jjrfu3Yt3CooWtBzwC9EGQQhRQ2EjsjShTlCAVI2vd39DSPUXrtnaIp6hh/f+H+
         okb5FlvhA2wD1fbb+6aHRbnqWGk8lZbTLAMhn2b2gljM5sNQYXLQmeUcJJUvTVG07Eh/
         kw0TaQS0QF+TW3vRJG3W4ozJad9360rOR9SjSAU0h7dSnZd6lco1aHZIo4pD5QQeFxgC
         498g==
X-Gm-Message-State: APjAAAXTATO1ZiLuLdTHrrmXTtcUys6ZGPH5VU+o/7Zi5MoKRXscjNFZ
        Ufj83Ls78Y0CVIfmBTl9MXI=
X-Google-Smtp-Source: APXvYqydHSDTfP8+mP7byc9A+TnBA+jZDFoUV2Gbt+iT9i15mhY627WLYZSDL04ly3BcnENyrL6rvw==
X-Received: by 2002:a05:620a:14ba:: with SMTP id x26mr38038141qkj.328.1560219607997;
        Mon, 10 Jun 2019 19:20:07 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id o33sm6728345qtk.67.2019.06.10.19.20.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 19:20:07 -0700 (PDT)
Date:   Mon, 10 Jun 2019 22:19:33 -0400
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Hao Xu <haoxu.linuxkernel@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: kpc2000: kpc_i2c: remove the macros inb_p
 and outb_p
Message-ID: <20190611021933.GA915@arch-01.home>
References: <1560152904-31894-1-git-send-email-haoxu.linuxkernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560152904-31894-1-git-send-email-haoxu.linuxkernel@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 03:48:24PM +0800, Hao Xu wrote:
> remove inb_p and outb_p to call readq/writeq directly.
> 
> Signed-off-by: Hao Xu <haoxu.linuxkernel@gmail.com>
> ---
> Changes in v2:
> - remove the macros inb_p/outb_p and use readq/writeq directly, per https://lkml.kernel.org/lkml/20190608134505.GA963@arch-01.home/
> ---
>  drivers/staging/kpc2000/kpc2000_i2c.c | 112 ++++++++++++++++------------------
>  1 file changed, 53 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/staging/kpc2000/kpc2000_i2c.c b/drivers/staging/kpc2000/kpc2000_i2c.c
> index 69e8773..246d5b3 100644
> --- a/drivers/staging/kpc2000/kpc2000_i2c.c
> +++ b/drivers/staging/kpc2000/kpc2000_i2c.c

> @@ -307,28 +301,28 @@ static int i801_block_transaction_byte_by_byte(struct i2c_device *priv, union i2
>  			else
>  				smbcmd = I801_BLOCK_DATA;
>  		}
> -		outb_p(smbcmd | ENABLE_INT9, SMBHSTCNT(priv));
> +		writeq(smbcmd | ENABLE_INT9, (void *)SMBHSTCNT(priv));
>  
>  		if (i == 1)
> -			outb_p(inb(SMBHSTCNT(priv)) | I801_START, SMBHSTCNT(priv));
> +			writeq(inb(SMBHSTCNT(priv)) | I801_START, (void *)SMBHSTCNT(priv));

This inb() call looks like a bug. We perform a 64-bit operation when
talking to this hardware register everywhere else in this driver. Anyone
have more insight into the hardware with which this driver interacts
such that they could shed some light on the subject?

Probably a separate issue, but I did notice it as a result of this patch.

Thanks,
Geordan
