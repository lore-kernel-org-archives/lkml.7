Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B58FC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EEBE206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P7x6iRL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfG3RHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:07:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46266 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfG3RHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:07:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id c3so7028137pfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ij5IHsIz5m1k/TZ9G+k0vjjrXKuI8zvs4XWvYMUv6xA=;
        b=P7x6iRL+potI/UXe2GL2bGfRW6KNMvSV5ppccdYt283WmoDUkRdzp4koQgOgunvvzl
         snnlVm7+LveboI+FEM9Sxiqv4tsYw40jcdadwsRQ4ypLgBK/XrqJnb9wZOPcxftcsBwJ
         DqurscVqXfKuZu8Sjv4SL2ydKIbof4EZcvndE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ij5IHsIz5m1k/TZ9G+k0vjjrXKuI8zvs4XWvYMUv6xA=;
        b=LmwEiOS9Xy8XyOvqZPe8puowwQEUo+fDTHSCfAJPQEMMBTod/BSdirKpxV3jmi69I6
         OpchNDoXsfvMmwvp77F/H1wdeyDF7L9dtAuaRz9n5goanhvzQUYmo5z0g++/JacfzRsq
         oCmnTw6U/LRASe5Bkzo5nNgLjZfIocLhvHtGt8Gh1iCCawp8TWPmJ6M5ZqVIPnxODmgw
         fhIhoxkfkiCef6jPLnUmY6BAD8RacSVlLafGeunAR567a2nRNZmZvhuHx4TxkA1w1pqF
         ytGLiPXy7X3Rt+GFkeRQwP6Ki08hETzCZRyzIe1LE/iYbzLiooRus0QnblOxJ+o2MLSS
         PHnQ==
X-Gm-Message-State: APjAAAW/1DpPHhqs90aOmaY+6/G6PyUdJq9LothkhjGQrv5UuoKxmEgA
        B8CnQezAPsx2OsY8oNjRm8dO7TECAlQ=
X-Google-Smtp-Source: APXvYqxJ+yRT5SoyqEcmrG5qDLkr0gEeD/gtdMxDd4IXybXkd0K5WhnE3L10kkcRHqj8qn91kuZIng==
X-Received: by 2002:aa7:9298:: with SMTP id j24mr41520880pfa.58.1564506470984;
        Tue, 30 Jul 2019 10:07:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f6sm67441648pga.50.2019.07.30.10.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jul 2019 10:07:50 -0700 (PDT)
Date:   Tue, 30 Jul 2019 10:07:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/macintosh/smu.c: Mark expected switch
 fall-through
Message-ID: <201907301005.0661E63CF@keescook>
References: <20190730143704.060a2606@canb.auug.org.au>
 <878ssfzjdk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878ssfzjdk.fsf@concordia.ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 12:28:55AM +1000, Michael Ellerman wrote:
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> > Mark switch cases where we are expecting to fall through.
> >
> > This patch fixes the following warning (Building: powerpc):
> >
> > drivers/macintosh/smu.c: In function 'smu_queue_i2c':
> > drivers/macintosh/smu.c:854:21: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    cmd->info.devaddr &= 0xfe;
> >    ~~~~~~~~~~~~~~~~~~^~~~~~~
> > drivers/macintosh/smu.c:855:2: note: here
> >   case SMU_I2C_TRANSFER_STDSUB:
> >   ^~~~
> >
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/macintosh/smu.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
> > index 276065c888bc..23f1f41c8602 100644
> > --- a/drivers/macintosh/smu.c
> > +++ b/drivers/macintosh/smu.c
> > @@ -852,6 +852,7 @@ int smu_queue_i2c(struct smu_i2c_cmd *cmd)
> >  		break;
> >  	case SMU_I2C_TRANSFER_COMBINED:
> >  		cmd->info.devaddr &= 0xfe;
> > +		/* fall through */
> >  	case SMU_I2C_TRANSFER_STDSUB:
> >  		if (cmd->info.sublen > 3)
> >  			return -EINVAL;
> 
> Why do we think it's an expected fall through? I can't really convince
> myself from the surrounding code that it's definitely intentional.

Yeah, good question. Just now when I went looking for who
used SMU_I2C_TRANSFER_COMBINED, I found the only caller in
arch/powerpc/platforms/powermac/low_i2c.c and it is clearly using a
fall-through for building the command for "stdsub" and "combined",
so I think that's justification enough:

        switch(bus->mode) {
        case pmac_i2c_mode_std:
                if (subsize != 0)
                        return -EINVAL;
                cmd->info.type = SMU_I2C_TRANSFER_SIMPLE;
                break;
        case pmac_i2c_mode_stdsub:
        case pmac_i2c_mode_combined:
                if (subsize > 3 || subsize < 1)
                        return -EINVAL;
                cmd->info.sublen = subsize;
                /* that's big-endian only but heh ! */
                memcpy(&cmd->info.subaddr, ((char *)&subaddr) + (4 - subsize),
                       subsize);
                if (bus->mode == pmac_i2c_mode_stdsub)
                        cmd->info.type = SMU_I2C_TRANSFER_STDSUB;
                else
                        cmd->info.type = SMU_I2C_TRANSFER_COMBINED;


Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
