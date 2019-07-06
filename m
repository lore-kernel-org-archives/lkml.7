Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798EEC0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1DB20838
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kvgDePG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfGFRdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 13:33:15 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38195 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfGFRdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 13:33:15 -0400
Received: by mail-io1-f66.google.com with SMTP id j6so25773904ioa.5
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 10:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aORoEfxHMte5Izs1lq4tjs5CsYwqAPQNnbHEGD7zrHk=;
        b=kvgDePG9Qhe5RimxRYGTdvtCHvnIA64aS0kZ+uGbl4/sheZZNvoQmc9BwVlHR6yyR7
         uObNmUaps0Ba4wtzAtPNdW3XbHk1/WS/pBwlRdnv2QmS2t318RmhkbEaT9/LU9r2tTHM
         5E14Qz/dVHMzvTDzLcx8JAUv+woHxk7001nRbjOpAtv5CZqKr/Zypac7Ih3jswZ8NVhY
         vUBbT0vi8fVLaB/SsOvi3SWu2Z3KLWqDPH2YKTbBcHcFtfh8wQUC1SN+ZFxOPoYIRMkZ
         it1Top97FKplk7mBWTty7+A9R4DJDQO481ASiwUSzuKZz/7MIgbf1ZOi3CdSrqtEhy6W
         rSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aORoEfxHMte5Izs1lq4tjs5CsYwqAPQNnbHEGD7zrHk=;
        b=nYqYG+0UOjhYyt7HiEAUp6XnktQmOpjBacEgNufF7VHcEmEO+crGeOiyZz+Qe/dzH0
         11g4ebFPhmBaHHWiAA/J0mnZCd/sx+MGLbVAdTkslcPPMOcBiYaDp4e9qsEZNg/hnHw9
         +oZSAlHur2oEGattP3UmiWw1YJdU2GJguRmhITMQ+YFtlzfurEKvCUGTzMPA0dLKu0Lo
         Sat7QuDnUD16idyrPSZA2jkB466znveymhYQIlqykEJfZzoodcly1/6YvHITBpc5WaIU
         +Gh7l9glB6y6DXhRfIFu9rxHw3aKIufGxyQx8/ku6URr5II1Cg32pGcriAEoxxbXW/PC
         3cnA==
X-Gm-Message-State: APjAAAWwsSFsbB9ZJdLP35dXYf3LfAC0G7xS98csENNnMDrYh//TVVCV
        LKRlYLCbSKx2v0HUPx6zTH+A2w==
X-Google-Smtp-Source: APXvYqwt2kjsDRTuEZSm8wEakw60cJMABjp+Orn0k1S4sY1HPmriYbz/5kYKdXsRrWEe4S1bw6x/rg==
X-Received: by 2002:a05:6638:691:: with SMTP id i17mr11651649jab.70.1562434394233;
        Sat, 06 Jul 2019 10:33:14 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:9f3b:444a:4649:ca05])
        by smtp.gmail.com with ESMTPSA id l14sm12481945iob.1.2019.07.06.10.33.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Jul 2019 10:33:13 -0700 (PDT)
Date:   Sat, 6 Jul 2019 11:33:09 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Junwei Zhang <Jerry.Zhang@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/ttm: properly unmap dma page upon failure
Message-ID: <20190706173309.GA111051@google.com>
References: <20190325202250.212801-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325202250.212801-1-yuzhao@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 02:22:50PM -0600, Yu Zhao wrote:
> dma_unmap_page() must be called with exactly the same dma address
> and size returned by dma_map_page(). Otherwise, the function may
> fail.
> 
> This is at least the case for debug_dma_unmap_page() and AMD iommu
> unmap_page callback.

Hi, can we please take this fix? Thanks.
