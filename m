Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4441C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B97241C7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="YHpaHeen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfE2VFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 17:05:16 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:33592 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfE2VFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:05:16 -0400
Received: by mail-lj1-f179.google.com with SMTP id w1so3964502ljw.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 14:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=W9tjnUx4VNSKH9uRUiVgoOzrlN+0bCdbE4xMKDl4byY=;
        b=YHpaHeen9oOqwE8n+QEO9DJ9gMuBJbrXcrYjEPz/rWBQxOf+xD216e6HgUSuoPzXJh
         Ru4iX6MrHOUCY2I/Qg31rtslU3FsGrPB5xunkdg0uOx82uzvaH39MJisYPyGJo74v8vt
         rPNi229OQYDmaBetkOtIK1ROewNfDJ1gSiCtahoDXLlHDEQ7F43Qp9uWfgNRVuCpFuNF
         /uvg/Orz2MJbNkzbdEA6OQ7x3hXrIMi9Y2qK6BDPSs4TCpZ4ODGL+QvrKrpdqiAtF+d2
         xQQosAmop4cIJjuFX3PrK03FRatnQ0Qu3z9xir3OvP1gfuKDACsycC9eenvH/Gpe8kgN
         oItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=W9tjnUx4VNSKH9uRUiVgoOzrlN+0bCdbE4xMKDl4byY=;
        b=IgWUX1NPhFlt83G1X+/Cj7iT7MafulxczaQ6IWYcwUkwruf6iM4Dep3dzuYBFKqzt7
         +08dV4pGKs63CsvY3LBh6lBFyANgAjD3qjQg+27LZzBOfZr+CRNLCPlNtnl6goVXjHlP
         V2yjhlIwAeihufZe/+PtwdDxGoddMLzgx3NHXj2UUYrYmT3Mk33Dcw0KQC8GGAqzzHVZ
         Uh2iBMQuhhco8s2ca/Xf4deg09riqZRlx+JyBUzpX1Yks5jAi7IM7VnSzNbccLd6EGC7
         wp9C3uBKwForEaCbB6DsIgeHbHVFq8rhEM5xU8LEFJebg9en/GEHI/t6EuZygbhc2aPD
         Dk5g==
X-Gm-Message-State: APjAAAUQQzxhdbEWpzeNAyLvfc6IsOl/3IdCaFAhsWXzE/mCxqiYazfg
        Vu78msQnlPqYamt+UeJ8n0jw2Q==
X-Google-Smtp-Source: APXvYqwR3Nuq4X2E76sDNIhmSH2nLHEtjytO+gAjxiFimgrzY8/ZceCJZb5whpEZRo8/a+fpOLb9/A==
X-Received: by 2002:a2e:1412:: with SMTP id u18mr35023523ljd.197.1559163913754;
        Wed, 29 May 2019 14:05:13 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id u11sm120354lfb.60.2019.05.29.14.05.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 14:05:12 -0700 (PDT)
From:   "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund@ragnatech.se>
X-Google-Original-From: Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Date:   Wed, 29 May 2019 23:05:11 +0200
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: Re: linux-next: Fixes tag needs some work in the v4l-dvb tree
Message-ID: <20190529210511.GM1651@bigcity.dyn.berto.se>
References: <20190529080454.6d62a7fd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190529080454.6d62a7fd@canb.auug.org.au>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, Mauro,

On 2019-05-29 08:04:54 +1000, Stephen Rothwell wrote:
> Hi Mauro,
> 
> In commit
> 
>   0c310868826e ("media: rcar-csi2: Fix coccinelle warning for PTR_ERR_OR_ZERO()")
> 
> Fixes tag
> 
>   Fixes: 3ae854cafd76 ("rcar-csi2: Use standby mode instead of resetting")
> 
> has these problem(s):
> 
>   - Target SHA1 does not exist
> 
> Did you mean
> 
> Fixes: d245a940d97b ("media: rcar-csi2: Use standby mode instead of resetting")

Yes I meant d245a940d97b commit, for some reason I was on the wrong 
branch when looking up the sha1 for the fixes tag and used one from a 
local development branch.

This is my mess, sorry about that. What can I do to help fix it?

-- 
Regards,
Niklas Söderlund
