Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1811AC31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01AE20717
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="a+FlUpPM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387705AbfHFRok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 13:44:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35696 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfHFRoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 13:44:39 -0400
Received: by mail-qk1-f195.google.com with SMTP id r21so63634656qke.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2I3grgZ/J9vjahvSqFuu/xLlITG6j2k/vYLpAp6Amls=;
        b=a+FlUpPMj54ngc2/wzpnUtdmboVj9jOXSHKH/KtrlsaDDTF+4/b1FPDz2QFwEeg1rz
         toYHqJ4grC/Zrmy66au/tF6Xp/GKKcRCxOW4nEVINsOTZE+UABenhA41pYRrtsHlIMvp
         Nn3XoKBGu7pNa90wuuXeU6vI4KIN35sIQDY2+B49rW0uXGXipKd2iMbP0zvgC1X9Q5AA
         ElTW3gUtiOMCLtIVvCF4ky6LpJZ0pbBAQDWXAaM8GADHJRXL3Q/ScIQSuBrcNYhW/MZ4
         lFfb7gJrmnotB3O3ZucXNGj9Aoegb9k7du/Rw1dzmNZgaivujgybGTKauFX4u4s2pKkF
         9f0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2I3grgZ/J9vjahvSqFuu/xLlITG6j2k/vYLpAp6Amls=;
        b=DoVng9Y7hz0JJHE+Uv1PjmZ2dnH5C9DAXbr+hXeBb7D6OMKrUr4WXcwVl0pvLdHVsx
         cP6t5sHhVzxLBwE3iU/wXqQJ4/SZA+W5FZLR3RGCXRWzNVGKFOnrL66ujOu3ANbC7gxh
         aP6cRbPdYdIFa2SFXTcS3joXQMArgT/Xy+3WoB56jn5JXebAwPOkNLrdTz6xsn8SPTvi
         jMc5+StFgU731AlpP/QXBCy1HMMZbO/m5FJmmyiXd9vaJDTn3Cm64Smp751yqoiFmC59
         OJ6kZC/unc1gilDnMeTnlTpXPci4t8Ge9IvbDSl/ie3jEIU6yWHGyrS2zvYYjhit/N9a
         zGGg==
X-Gm-Message-State: APjAAAXR5V667CO/1J6t9bwYDC3x67sNW7mf/FK5L3ehVkxvxz1g1zR6
        H6naeECGFrNV4fU8Hm2E5ugp+A==
X-Google-Smtp-Source: APXvYqymlpp4BycD0qGnpnv+d7FFVmLpdZkWfIi+lh2JiL6V9IwlA24sYISFadK7zx21lftJy/jhgQ==
X-Received: by 2002:a37:4a8a:: with SMTP id x132mr4450025qka.42.1565113478452;
        Tue, 06 Aug 2019 10:44:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 2sm45957746qtz.73.2019.08.06.10.44.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 10:44:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hv3Vl-0008VN-Do; Tue, 06 Aug 2019 14:44:37 -0300
Date:   Tue, 6 Aug 2019 14:44:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] amdgpu: remove CONFIG_DRM_AMDGPU_USERPTR
Message-ID: <20190806174437.GK11627@ziepe.ca>
References: <20190806160554.14046-1-hch@lst.de>
 <20190806160554.14046-16-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806160554.14046-16-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 07:05:53PM +0300, Christoph Hellwig wrote:
> The option is just used to select HMM mirror support and has a very
> confusing help text.  Just pull in the HMM mirror code by default
> instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/Kconfig                 |  2 ++
>  drivers/gpu/drm/amd/amdgpu/Kconfig      | 10 ----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  6 ------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 12 ------------
>  4 files changed, 2 insertions(+), 28 deletions(-)

Felix, was this an effort to avoid the arch restriction on hmm or
something? Also can't see why this was like this.

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
