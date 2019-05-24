Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DCCC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6612133D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 14:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDjjTITk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404005AbfEXOdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 10:33:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33957 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391500AbfEXOdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 10:33:31 -0400
Received: by mail-pl1-f195.google.com with SMTP id w7so4258568plz.1;
        Fri, 24 May 2019 07:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bkANiCU/QOHZhbNxPjGAJHjS7JejXUR7CHNVdlS4/ms=;
        b=QDjjTITkxQodeNlBDOvaMduMLdxc/XVqi1m23ey82bMaG6/I38qQn8QskKhffhvdI2
         zDl3+ofdsRdHQ85Ypnascg2McRI4/rjka2NHxgxWTvsVkwkA30RW/Qr5E0JVspgd91h8
         FcpaXsjy6/bsZf31X2j3zaXNQocT4e49DA4mYeOHt+CXU5uJgSqtQZwHdagEexnaJm0s
         5+y4+s9RIaDyn0/LoSUOdrqjgj3NKzEwJH0vLL7+rvoaKTD/7Tdx8cr+SVEX+bLpx2T/
         fJbi/LMjO2tVdoH7+ze4jinDC6atA6OFNjxLSudP+Y2pLxpQGagR0ZC9Zs9chjrAH+OU
         Vscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bkANiCU/QOHZhbNxPjGAJHjS7JejXUR7CHNVdlS4/ms=;
        b=X5SqNvOsCG1aa9ggjvmpeuSO71+dSdehiFsIuGSUn/177DlpA8DQWXEdhvtnDQVNb5
         2JPupS2JTtMoXddHt7ZL+MiXOaSh5r7gtYULrpsCsnanUsu8VXvBt+a5vIwLrr0bqhkm
         c8snTG0iwfI77Mcn1SVKYu5XSL14dvwoe7f4zWZ1m7IIrNwv7ci+CUMeOh92dhoxkAgZ
         Pe9awnFCDhLH4PPcjj+2j5B1PYby03BOoIxo90mNJ9zJqca7cIC3p894GESf6UTNlhmF
         NluoDW9ReadNp15lb5U5iyFTPlj5KBjnZ1Jwr31dEmGmCg59i08/3B83y81aEKs1Pav+
         eL2Q==
X-Gm-Message-State: APjAAAVNr/g16N8K402BtksOlnna9V37LrPM3SKxXY12KKcJY06ER0mR
        cAo4xQsWO13HVh1as1iAtVI=
X-Google-Smtp-Source: APXvYqwye2akahN+OdAFoz3/avW9PE6yMBVVQi/FuXlUVOKHcANsVWoerj1ea1bSWcNDJSABYTiHrA==
X-Received: by 2002:a17:902:6a4:: with SMTP id 33mr64032456plh.338.1558708411303;
        Fri, 24 May 2019 07:33:31 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id s134sm3476408pfc.110.2019.05.24.07.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 07:33:30 -0700 (PDT)
Date:   Fri, 24 May 2019 22:33:09 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tegra_wm9712: Fix a memory leaking bug in
 tegra_wm9712_driver_probe()
Message-ID: <20190524143309.GA8631@zhanggen-UX430UQ>
References: <20190524005014.GA2289@zhanggen-UX430UQ>
 <b2d43dfe-17e5-a975-435b-49f2aa2ad550@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2d43dfe-17e5-a975-435b-49f2aa2ad550@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 09:33:13AM +0100, Jon Hunter wrote:
> 
> On 24/05/2019 01:50, Gen Zhang wrote:
> > In tegra_wm9712_driver_probe(), 'machine->codec' is allocated by
> > platform_device_alloc(). When it is NULL, function returns ENOMEM.
> > However, 'machine' is allocated by devm_kzalloc() before this site.
> > Thus we should free 'machine' before function ends to prevent memory
> > leaking.
> 
> Memory allocated by devm_xxx() is automatically freed on failure so this
> is not correct.
Thanks for your comments, Jon. But after I examined the code, I am still
confused about the usage of devm_kmalloc(). You can kindly refer to 
hisi_sas_debugfs_init() in drivers/scsi/hisi_sas/hisi_sas_main.c. And
devm_kfree() is used to free a memory allocated by devm_kmalloc(). And
I found other situations similar to this in other files.

So, I hope you can give me some guidance on this. Thanks!
> 
> > Further, we should free 'machine->util_data', 'machine->codec' and
> > 'machine' before this function normally ends to prevent memory leaking.
> 
> This is also incorrect. Why would we free all resources after
> successfully initialising the driver?
I re-checked this part, and it is totally incorrect. It should be deleted.

Thanks
Gen
