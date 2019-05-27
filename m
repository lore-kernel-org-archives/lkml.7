Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB113C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8F021530
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBnrlXd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfE0OLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 10:11:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37289 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfE0OLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:11:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id a23so9668876pff.4;
        Mon, 27 May 2019 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HxaKb923UGKkDjt3DLQ0Jhkyn8a6WOxpMEKsse04C8E=;
        b=OBnrlXd5G29eMqV4+0yXDWnEeT++ZbAqT1wdTjAeVuTS63grxnGXjhr5MSjqhVXvyY
         jz6tSjnDH+L5UjfNSv6+a/zHBNdYnfyVpN1pUO/Vv9U3YSV3gRfn4QUEosN/s8BwCf57
         1A959Lr6qXZm+bpnKQo6/nW5iR620Rhz5EXlbX5lR/ieC1uTaEYhtop0pltJMXRO6bUu
         N7CRpTGrFH7/Q+N6uzpHjEaR94AHKC4qTrh1KqJsO8yQKCewceEgR57cJzixCY9OMmry
         ix+6mM8cpkRQuQB/2ZH3iD1I27bfTVpZuwyefxkU87T+3TdJGvsiXuAijvZX/S1khvL0
         A/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HxaKb923UGKkDjt3DLQ0Jhkyn8a6WOxpMEKsse04C8E=;
        b=S1ksZk3jBvt53MnB/zAR82u9AaowFrgtlIttAvNrNga9fzRJxUl0U0HD1VqIejHunL
         OQgN6sxwj3Kmre6SGPrL7D5ZC+8mLzaOCpYtV1P/5X2A7v+sR95kLtP0JZUTg/9UlBQE
         vKYtiAxl6Uk10tHZSxOfDHSqDGD3VkP9gYjhnmF8KIZ0H5M9ekNs/KPqVqUTd/UGZFcU
         ozI0X6oR5vtGP3j0jNNJTnaK6y9VvbWPktDzgp1sc8Ro/5zothAKyoR9Dhu16Oek6Pud
         z1igC1ynq6siyY7PrGfkRKGpUv8uH3hdwDG4FvZ3aCpP6CJN9pOGQf+DqUMt428WEy3n
         Nw5g==
X-Gm-Message-State: APjAAAVRwN64pIBd+SgQJNNACAkkhtFalrdPHKsh6VMCDc9CWFxq6LuI
        rEN8cJd+0MK81MBBfkw7Qbc=
X-Google-Smtp-Source: APXvYqzH7T1rjCD57DmmwmMS6qj+W9QUOwMpdAZek65o4EgfX7VbEYG6Em0XK5nA8CQUW55sHYA5KA==
X-Received: by 2002:aa7:9a99:: with SMTP id w25mr43033747pfi.249.1558966259731;
        Mon, 27 May 2019 07:10:59 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id m6sm13744807pgr.18.2019.05.27.07.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 07:10:59 -0700 (PDT)
Date:   Mon, 27 May 2019 22:10:38 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] tegra-hsp: fix a missing-check bug in
 tegra_hsp_doorbell_create()
Message-ID: <20190527141038.GA6453@zhanggen-UX430UQ>
References: <20190527130430.GA5367@zhanggen-UX430UQ>
 <20190527140549.GA7202@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527140549.GA7202@ulmo>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 04:05:49PM +0200, Thierry Reding wrote:
> On Mon, May 27, 2019 at 09:04:30PM +0800, Gen Zhang wrote:
> > In tegra_hsp_doorbell_create(), 'db->name' is allocated by 
> > devm_kstrdup_const(). It returns NULL when fails. So 'db->name' should
> > be checked.
> > 
> > Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> > ---
> > diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
> > index 11fc9fd..b613c46 100644
> > --- a/drivers/mailbox/tegra-hsp.c
> > +++ b/drivers/mailbox/tegra-hsp.c
> > @@ -292,6 +292,8 @@ tegra_hsp_doorbell_create(struct tegra_hsp *hsp, const char *name,
> >  	db->channel.hsp = hsp;
> >  
> >  	db->name = devm_kstrdup_const(hsp->dev, name, GFP_KERNEL);
> > +	if (!db->name)
> > +		return ERR_PTR(-ENOMEM);
> 
> I don't think this could ever happen, since name is always from .rodata
> and hence devm_kstrdup_const() never returns NULL. But formally this is
> correct, so:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
Thanks for your reply, Thierry.

Thanks
Gen
