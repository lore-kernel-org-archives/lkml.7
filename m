Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF62FC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A048F20717
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 17:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kGCc9AZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbfHFRox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 13:44:53 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42123 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfHFRow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 13:44:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id h18so85441570qtm.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 10:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bZtzSRQjhSrRQjuTGnm0cayQZPAGjzejTXG905wfdw0=;
        b=kGCc9AZ3EnQ1hENpi10zxnp8FPxEY+gZ4u/zkReV8Gk0g4EsnIsOyP2vX5idcMBB+N
         VqjEaaMot6kbdFxVmOlEm3tUIYXwEQT/y/7s11UZ+8vUXizamKWn9OUzoZVObkKRPWF5
         PC2DJb3kBYP003JMyG9RuoIAMt1yp2NAIcUhv0kLoc/5yOiIHRVEpLR3JQfH/W8OKUNe
         XjpQ60F11rN9ibmfNaecBWtkVeRv7sFxnhwEglCFAfG9t9UMxDtUa5fCeFlLC9UqkNOe
         29/8m0lfjCMFnxcTMwNskT+B5FKI1Hwf/xwSEWFHQlKgvBiwTtYdYbvXxZ38LEH2twL7
         VMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bZtzSRQjhSrRQjuTGnm0cayQZPAGjzejTXG905wfdw0=;
        b=uKkRBCJLfpGJPizIAh8aKTeDzyJ64W7v7RLrXaHfT5Izr/0EwTC0JbWhpXkAxn7BlU
         qMWgG2x0ObiIKRlwxP5k7MZaCt0zF15eTcEB1jlOE9jJpQO3VkztYXKdSEJA+p16vlzG
         CzNEqiwrJnkqCrwsALu5SXM8wPFcd3asmV+zL1FyDmlRBlTg463ZE9R4aix+MSvW7N2n
         iy/oSBl62JSpuKsSWas9oeqLFHGJ3yEayI8Dmk0ZjJ5G6KTk7vspEv+kUA/OAiVCge5B
         hgweR+pFpdihcGxxwEZd01A+r60w63C3D8jWNHAcP04eoFwi8dnLbYUGQ+nufuAiVzSa
         4m9w==
X-Gm-Message-State: APjAAAWsWExKvsWJe8TGHt2/3403DEhl5ej90IH5s3kp8vGo7/tYIllO
        PIs7RySXgvV1E3kWPOo5n+8coK1U4x4=
X-Google-Smtp-Source: APXvYqyZhLDncBVUJEIu2HEUQvEmb0gPiZCNGeOuB4xFtTfpcIsHYizrdBS0HYUKqNFQSDBwyqBK0g==
X-Received: by 2002:ac8:43d8:: with SMTP id w24mr4245586qtn.25.1565113492016;
        Tue, 06 Aug 2019 10:44:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id i22sm46601023qti.30.2019.08.06.10.44.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 10:44:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hv3Vz-0008Vn-5w; Tue, 06 Aug 2019 14:44:51 -0300
Date:   Tue, 6 Aug 2019 14:44:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/15] mm: make HMM_MIRROR an implicit option
Message-ID: <20190806174451.GL11627@ziepe.ca>
References: <20190806160554.14046-1-hch@lst.de>
 <20190806160554.14046-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806160554.14046-15-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 07:05:52PM +0300, Christoph Hellwig wrote:
> Make HMM_MIRROR an option that is selected by drivers wanting to use it
> instead of a user visible option as it is just a low-level
> implementation detail.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/Kconfig |  4 +++-
>  drivers/gpu/drm/nouveau/Kconfig    |  4 +++-
>  mm/Kconfig                         | 14 ++++++--------
>  3 files changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
