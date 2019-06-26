Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C8AC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FE12086D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 20:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksFc/o6T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfFZUKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 16:10:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38659 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZUKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 16:10:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id y15so60963pfn.5;
        Wed, 26 Jun 2019 13:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fr7i/ENp7aGYYEF02skQlZfDr8p6MJ5Q3iZjfvmtRP4=;
        b=ksFc/o6T+8+Qstfi+VZY39IJmvUmwK0Cbp/zhCtIQ5URgsW1CXdEXIR0rWsZ/5NNJX
         iEJphcITi+swWG55ImBd2UMi5R1BL9NYQ+GaI/vDvUSfgSmKPmaHEXIGM5XCcVySc+m/
         louqizTFTFaWODzkwtsSSa5DXpjUMmwMcR3BgWhDchBghzB39Ynr6FymVJ79kDAntlW/
         Bk3dIu3+k+uf81+Whsa9Se9z97qlbwuMUo5AxORE7mO0KFDxWz1Z4fodVbDRnTGfFkKA
         4IxPTcHI1wI1BFjuiWcUFn2JNend7VniCds6894A7VbSLGNWZ6xkwhQm0HnwcouPhr4X
         lGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fr7i/ENp7aGYYEF02skQlZfDr8p6MJ5Q3iZjfvmtRP4=;
        b=Y5p8jme7grFtQ5f26pvSsi0CESKz4UuXqpNSernz42fFyrCnwyfw/GevUtx3ZXROn5
         BVzxgRbrFI0MIb4Sp1saEPYp/CZacC7NMY6Y79/bp5ODJS1cijY3CaI5ltKIDw0SuqqS
         qDwBnyO4kpNCiMufaVKbZ0e7TdvOklaBb3DA3SlER+3xSlzs6swS30L+3fi8Oi+Ja7er
         Y0xc9JZco+TdszkcVvldqwXzIzDk8zxS5RfQGRBc04cLPOzBfBtPm5mRxCkBgPK9GSeS
         yksS2NCSo7loxibE4WRrDWKkwsnC433KwW0OorqiztGtAI+MvJOXJBR+diItIGdLrpnZ
         svsg==
X-Gm-Message-State: APjAAAWKjyAI6f4qEV81izhoi1ytmoLAzWTXUl38rRIrxlrgpRuZ6G1f
        r0+AhxTpOdka659jW1rkp48=
X-Google-Smtp-Source: APXvYqy+8INAblpkK4j8kdIICVT4WVXnbuGleyKIkOyO4NQmLhPWsTX94aJyxQR0X1SfCpecwrZ5qg==
X-Received: by 2002:a65:5144:: with SMTP id g4mr4658877pgq.116.1561579843302;
        Wed, 26 Jun 2019 13:10:43 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id y12sm5054pgi.10.2019.06.26.13.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 13:10:42 -0700 (PDT)
Date:   Thu, 27 Jun 2019 05:10:39 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH][next] nvme-trace: fix spelling mistake "spcecific" ->
 "specific"
Message-ID: <20190626201039.GA4934@minwooim-desktop>
References: <20190626124323.5925-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190626124323.5925-1-colin.king@canonical.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-26 13:43:23, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are two spelling mistakes in trace_seq_printf messages, fix these.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/nvme/host/trace.c   | 2 +-
>  drivers/nvme/target/trace.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
> index f01ad0fd60bb..6980ab827233 100644
> --- a/drivers/nvme/host/trace.c
> +++ b/drivers/nvme/host/trace.c
> @@ -178,7 +178,7 @@ static const char *nvme_trace_fabrics_common(struct trace_seq *p, u8 *spc)
>  {
>  	const char *ret = trace_seq_buffer_ptr(p);
>  
> -	trace_seq_printf(p, "spcecific=%*ph", 24, spc);
> +	trace_seq_printf(p, "specific=%*ph", 24, spc);
>  	trace_seq_putc(p, 0);
>  	return ret;
>  }
> diff --git a/drivers/nvme/target/trace.c b/drivers/nvme/target/trace.c
> index cdcdd14c6408..6af11d493271 100644
> --- a/drivers/nvme/target/trace.c
> +++ b/drivers/nvme/target/trace.c
> @@ -146,7 +146,7 @@ static const char *nvmet_trace_fabrics_common(struct trace_seq *p, u8 *spc)
>  {
>  	const char *ret = trace_seq_buffer_ptr(p);
>  
> -	trace_seq_printf(p, "spcecific=%*ph", 24, spc);
> +	trace_seq_printf(p, "specific=%*ph", 24, spc);
>  	trace_seq_putc(p, 0);
>  	return ret;
>  }
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

*facepalm*..

Thanks for fixing this, Colin!

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
