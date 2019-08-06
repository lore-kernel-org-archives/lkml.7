Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A94C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95996217D9
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 18:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dmyRhMBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732096AbfHFSCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 14:02:50 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39426 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFSCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 14:02:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id w190so63604319qkc.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 11:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J340zbxKrZwPhKQPn9TeC4csGhsk958SAmRA1+an/JE=;
        b=dmyRhMBZI6zY0I2u7wdyHQjMKNx7X6q/44JyGKfb/VDswyFMmZFRkfFHuwa6xb9W77
         /60SemHut0sNFpXi8VWhLEujUvdmhIPrdRNkn3/J8WP+d2+9yM+59k7uYRD0oXqoGmkv
         AdAgySgMZPnuRZQMrufc/1lAUL2PUjg7rsZvJGuL8Mj2mTI3z0O2wFRQECzd2fD6TiTN
         BOs8Eu8913OI8Gc+ity2XD16jj+X32RK4PRj79qKdpLBOcODvMrV18XBvn3mOzh3Diqj
         awOnPn2b4LSHKJWlA/RvcCNCNU2eXDwXISITGSPgHG1GksuEOvVSXUJKrqxO2IQiTL/B
         Xh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J340zbxKrZwPhKQPn9TeC4csGhsk958SAmRA1+an/JE=;
        b=plHZ6/88ESEkGkP9lzp+04SJMtgP4k6atljd3GuvfYCnEgJwS0K17Pt58tuaQ3jenq
         /SsCOM4yZ47X0FZXdtR/Cmxdiceip0Oa2ZDV4yEC3L6oakGdtM/YBMbqmKoaasISk8gS
         3FyYr9n6RuuSu1GLV9OAk+NzqLmq7CG/5k5vAZuwWHbzZFCz64FyV7y6bBHPFllaAlX+
         5EmRQDknjLOCxsDZOxKLC5gCGR6dm1XFjA77LmS8vvxkSRzIeB5Phx+5hPV17RLqz1sw
         mccZbbqz/ZJ/lG0esPEETpJyJShhGNrq73x5EWgYLNxY4YcRUqEYLlL0+tJXTZOc7eJi
         zsxA==
X-Gm-Message-State: APjAAAWrpGo5kj0jEytum4e+OBIKfiaJxW/Ez+XDAqk5NKfnNL2n6VqY
        VPS56vDORNJWFHRdubhdCFpxgnFUB4w=
X-Google-Smtp-Source: APXvYqzeVullh9O51A7m3TZsWYHDgm0ndSlca+disOdIT8zFGqnFmyETv0vAgxjYTLrTqv0QWoZpMA==
X-Received: by 2002:a37:7704:: with SMTP id s4mr4481690qkc.310.1565114569197;
        Tue, 06 Aug 2019 11:02:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c18sm6024222qtj.25.2019.08.06.11.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 11:02:48 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hv3nM-0000IY-6M; Tue, 06 Aug 2019 15:02:48 -0300
Date:   Tue, 6 Aug 2019 15:02:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] nouveau: pass struct nouveau_svmm to
 nouveau_range_fault
Message-ID: <20190806180248.GO11627@ziepe.ca>
References: <20190806160554.14046-1-hch@lst.de>
 <20190806160554.14046-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806160554.14046-4-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 07:05:41PM +0300, Christoph Hellwig wrote:
> We'll need the nouveau_svmm structure to improve the function soon.
> For now this allows using the svmm->mm reference to unlock the
> mmap_sem, and thus the same dereference chain that the caller uses
> to lock and unlock it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/nouveau/nouveau_svm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
