Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2CBC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04A12240A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LWkZy3XB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfKSSte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 13:49:34 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43561 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfKSSte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 13:49:34 -0500
Received: by mail-qt1-f196.google.com with SMTP id j5so24370137qtn.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 10:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BJFjHdyYM1vthkxjAoIbMlTbG4D7GBxFdcFj8PnQrWU=;
        b=LWkZy3XBK+6fGHfABcaDNWAQdmYW0o01piJuPCdyzNiafR4t07GJfwj6NHL05dXF9U
         FXWYX2PH725IYUJa0tVNtMVie9x7mgqL09kVIr11c/0byg0MZMW2XJohLeQeoTvKBn44
         aVMBPUgeTHsVuZj8qk1CSdiDe5b65iQ8CKrFIhoIVjFU1tbijp4dztUugaNxljdz0KpG
         ufVho8Y+VpFtgBdLC3pC1LhcKaOCHvGCtctlP/fxfHCrGsz1N/0XspeaUTxCk3mdQRAa
         BDCehThqrGIZ7uWAhtTcoOU4+wWrmyEv7R6XYFPuJtz5/EaPhYCMatC/0VvDlWFKLBZt
         1K+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BJFjHdyYM1vthkxjAoIbMlTbG4D7GBxFdcFj8PnQrWU=;
        b=dQocFQiC/s+W9n6+8k5P8a+k0nwpPsvnH2C3oBPeAILAWtyyFpu+9FDUhu0T/ur0AG
         GcJY6WFPoXvDV4QiAzj/N69U0N/UrpZkG5Ov/hYs0flt23MQHfQeL4RJrDYImkd1Sjdn
         baO8DUI+Wi3z/4JyokAfWRPWeqSFSrLThX3sXNfuhHIjZ2AHAjaTl2ebtoXX3R0E3+mY
         nYXiPCO+241qGTAxWVo/yMwYnvoUz7/DLn1TmNTjqHfNe2Yq1cOMNRGS0xcsRy6vhT0R
         VP2B5UoMCEv6lnEPFJkuUqF2Jl66Wn0fGFlP5t9fv8PiXNy37OiOtDR9Jng5XQhps+Ys
         e+jw==
X-Gm-Message-State: APjAAAXMx/u0NB2QC4JLjDhbGfEAxxvT9o3i2x9fFIDfRO2yVtJp6eCT
        pVzP80Kt6K5EVI+mo0kWaZlgWMQkZAM=
X-Google-Smtp-Source: APXvYqzh35+Ds32uBQz9Hp5oJ/hmQ+f4/zOs04uAR5OrQyFAqc0W+LMwbdKO3lqExiqyacnIDVWJuQ==
X-Received: by 2002:ac8:458c:: with SMTP id l12mr34922827qtn.300.1574189371993;
        Tue, 19 Nov 2019 10:49:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id b185sm10622433qkg.45.2019.11.19.10.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 10:49:31 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iX8Z9-0002Oe-53; Tue, 19 Nov 2019 14:49:31 -0400
Date:   Tue, 19 Nov 2019 14:49:31 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hmm: remove hmm_range_dma_map and hmm_range_dma_unmap
Message-ID: <20191119184931.GJ4991@ziepe.ca>
References: <20191113134528.21187-1-hch@lst.de>
 <20191113184943.GA4319@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113184943.GA4319@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 01:49:43PM -0500, Jerome Glisse wrote:
> On Wed, Nov 13, 2019 at 02:45:28PM +0100, Christoph Hellwig wrote:
> > These two functions have never been used since they were added.
> 
> The mlx5 convertion (which has been posted few times now) uses them
> dunno what Jason plans is on that front.

IMHO if ODP is going to be the only user then we should just keep the
existing ODP code.

Lets drop them until someone can come up with a series to migrate
several drivers.. It is small so it would not be hard to bring them
back if needed.

So applied to hmm.git

Thanks,
Jason
