Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F0FC282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DFF2175B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 15:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME1ry+gK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404236AbfEXPBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 11:01:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37228 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404222AbfEXPBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 11:01:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id n27so5210480pgm.4;
        Fri, 24 May 2019 08:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qJHwzr2Xb9OgZp+GNKXElpzk8S4Bwefhiqqlqq7Ge9Q=;
        b=ME1ry+gKIK1PeITGct1uVTRK2mcRK1RzTn2KD7Z9M0OmDVCQHTnSHq59oNvKWeRyLz
         PM4bP6+0F/H7PTZtQ6NRL2g9iqzSzjZczuPgV+pQvGFVO75i81PxfWj8hSWYki52SOQf
         2d+ygBiKiwwZZb6SIeWznxRCkarblXGsRCZTGypu2abFllK9a3Qop1lF+pjaTx0UQVcZ
         k71AgLR+c0CiBGnaNBG2Qe2ry/z9+mj97MUJVg5fmhmf3NZo09wG2nsO/3gZy/4Xed68
         WjbWKw1PDUXzuSup9SI61Q+nt7JOYgKjHrFYb4J4M/gY7/wnvaJXnpN9Lp38ZDwHblyC
         vBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qJHwzr2Xb9OgZp+GNKXElpzk8S4Bwefhiqqlqq7Ge9Q=;
        b=loNBUAhDyOvjhX3SGizW90d0hTr+a7aG3F1w3atmXtCR6+MP93i30daHYGahdo/b7k
         GNWqhqwRNMbvN++ZFu981NBPL2iqHtA0+3k7GxAf2jGfi0rssluZ9JzCbYD1a1nR+SdF
         JpiM3eicfhp9sW1Zd2rzWeJ9m0dOOPcaOwVEjBlQSTYA+M59P1FJLf4ie9ErI89gyZpu
         Mmx86++9qzROxZx2H8MtFab2O+jM5rVTTU0AZXth8A58v7TXECxyqpBi7kdMyk/XUJho
         L6qp/AveYjugyb3l3s+NTJy2T57dZ+JQhIzgipVxrgqWci25y+nlJMrapjfIdQLWAc0h
         rChQ==
X-Gm-Message-State: APjAAAV2LCIoK7P+uvcS/z3eGPo5pBVM0KRcyWHWiuIJp4amkVVvHJ2N
        D9som8E+E7FrvXQ2brrwRLHvgliyLxchQw==
X-Google-Smtp-Source: APXvYqzJdBKU5ZfnafzyYJdg6yuA4mPvK4pbUFl4lPClYZTImtuomicgJXntZbXamno6+euXA5i1OA==
X-Received: by 2002:a17:90a:f488:: with SMTP id bx8mr10054192pjb.62.1558710065929;
        Fri, 24 May 2019 08:01:05 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id e10sm5504824pfm.137.2019.05.24.08.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 08:01:05 -0700 (PDT)
Date:   Fri, 24 May 2019 23:00:53 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tegra_wm9712: Fix a memory leaking bug in
 tegra_wm9712_driver_probe()
Message-ID: <20190524150053.GA9235@zhanggen-UX430UQ>
References: <20190524005014.GA2289@zhanggen-UX430UQ>
 <b2d43dfe-17e5-a975-435b-49f2aa2ad550@nvidia.com>
 <20190524143309.GA8631@zhanggen-UX430UQ>
 <e52f4140-a119-a584-40a2-6359d6e1784a@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e52f4140-a119-a584-40a2-6359d6e1784a@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 03:47:34PM +0100, Jon Hunter wrote:
> 
> On 24/05/2019 15:33, Gen Zhang wrote:
> > On Fri, May 24, 2019 at 09:33:13AM +0100, Jon Hunter wrote:
> >>
> >> On 24/05/2019 01:50, Gen Zhang wrote:
> >>> In tegra_wm9712_driver_probe(), 'machine->codec' is allocated by
> >>> platform_device_alloc(). When it is NULL, function returns ENOMEM.
> >>> However, 'machine' is allocated by devm_kzalloc() before this site.
> >>> Thus we should free 'machine' before function ends to prevent memory
> >>> leaking.
> >>
> >> Memory allocated by devm_xxx() is automatically freed on failure so this
> >> is not correct.
> > Thanks for your comments, Jon. But after I examined the code, I am still
> > confused about the usage of devm_kmalloc(). You can kindly refer to 
> > hisi_sas_debugfs_init() in drivers/scsi/hisi_sas/hisi_sas_main.c. And
> > devm_kfree() is used to free a memory allocated by devm_kmalloc(). And
> > I found other situations similar to this in other files.
> > 
> > So, I hope you can give me some guidance on this. Thanks!
> 
> Please refer to the devres documentation [0].
> 
> Cheers,
> Jon
> 
> [0] https://www.kernel.org/doc/Documentation/driver-model/devres.txt
> 
> -- 
> nvpublic
Thanks for your reply. I figured out that devm_kmalloc will free the 
memory no matter fail or not. But I still want to ask why other codes
as I above mentioned use devm_kfree() to free memory allocated by 
devm_kmalloc(). If the memory is automatically freed, is this 
devm_kfee() redundant codes that should be removed? Am I 
misunderstanding this again or it is something else?

Thanks
Gen
