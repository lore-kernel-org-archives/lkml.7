Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD52C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4585F218D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XQ/RLMil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732905AbfGWNhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:37:41 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41236 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbfGWNhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:37:41 -0400
Received: by mail-qk1-f193.google.com with SMTP id v22so31098171qkj.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BV3g3NzuGp2I4JOWUlVwtiumFmjFWG11w8FIYIpu7kQ=;
        b=XQ/RLMilf7JYd4QxsVFlm1Ezv5tYekt7L1E3NSjRuh73+LefrAqfkxCSlHWTCzBxQr
         ZK4jpZm/tG1KVE/vGwqc4Bq6i0wbiw8El27ucO2yorJ99AJJa/d2Jc6JAwEBaeSSctja
         DXe+gTJpsmQQUcRwQl8LKq/5UDoUrOujvijKs4C6q3V5vMn0pY6mKDTIaVb/ekez0At1
         VV2zgzxkL0vdZ73159UZHpxZGLxCZYknqaM7qoN68xXRbGnWjcAUbcGkKklL8mLDW3lI
         TtwQm+3k/G8M3XuDPHWJuNZXrzKRMaDK67V+vkMi9eoxQ/3ic9FxLdc/lLw/cvYHosiA
         kAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BV3g3NzuGp2I4JOWUlVwtiumFmjFWG11w8FIYIpu7kQ=;
        b=U4Vi98T7sZqX25toah841i9AuIOoBZA+aZPzIqF03WQR+I2TtmwTM4+pg1B/lSOnE/
         aaj19UN3aL1Mr76XAbog9iglZoivgs+LeUegP01mU3Zy6vjWOi7tZtvIzs1ocbm952vj
         Gn8Wlf6h3GWI3a2a05ohYeFCg9JDp2dx7CDJ8Fgbf9CimK7NMsqno7sIJcHmikkEOXAg
         fqnU8Z8WYqbQifoFdgFqlw6PaoI3Ied3yGeaz4heAA5F+dEkqPmypq1MbD5CbbfLm1gR
         SDSkWWpcEAaVFhcSnzE9+Tm2ACe1OO19dfVlJfJH555x9xZNGQmNqOoycEe8TscAOEy+
         43Tg==
X-Gm-Message-State: APjAAAW7tuqjFkMZIofOwwatCG0vu3f6ozAASHXFcSdRBADGRTsK7kSe
        PQd3inECjhSDa+3D8VfMg9K34g==
X-Google-Smtp-Source: APXvYqxPn04Nx/qm9eIGQ3LU0Fs5EwZ5fHRzCtY6vm1ksvXraqBBP8PCqJz6BC47gMTXLs3RkMaivw==
X-Received: by 2002:ae9:dfc3:: with SMTP id t186mr47784983qkf.461.1563889060140;
        Tue, 23 Jul 2019 06:37:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id x2sm19297155qkc.92.2019.07.23.06.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jul 2019 06:37:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hpuz5-0005fS-2e; Tue, 23 Jul 2019 10:37:39 -0300
Date:   Tue, 23 Jul 2019 10:37:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, oulijun@huawei.com,
        xavier.huwei@huawei.com, dledford@redhat.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Fix build error for hip08
Message-ID: <20190723133739.GC15357@ziepe.ca>
References: <20190723024908.11876-1-yuehaibing@huawei.com>
 <20190723074339.GJ5125@mtr-leonro.mtl.com>
 <20190723123402.GA15357@ziepe.ca>
 <20190723133540.GM5125@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723133540.GM5125@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 04:35:40PM +0300, Leon Romanovsky wrote:
> On Tue, Jul 23, 2019 at 09:34:02AM -0300, Jason Gunthorpe wrote:
> > On Tue, Jul 23, 2019 at 10:43:39AM +0300, Leon Romanovsky wrote:
> > > On Tue, Jul 23, 2019 at 10:49:08AM +0800, YueHaibing wrote:
> > > > If INFINIBAND_HNS_HIP08 is selected and HNS3 is m,
> > > > but INFINIBAND_HNS is y, building fails:
> > > >
> > > > drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function `hns_roce_hw_v2_exit':
> > > > hns_roce_hw_v2.c:(.exit.text+0xd): undefined reference to `hnae3_unregister_client'
> > > > drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function `hns_roce_hw_v2_init':
> > > > hns_roce_hw_v2.c:(.init.text+0xd): undefined reference to `hnae3_register_client'
> > >
> > > It means that you have a problem with header files of your hns3.
> > >
> > > >
> > > > Reported-by: Hulk Robot <hulkci@huawei.com>
> > > > Fixes: dd74282df573 ("RDMA/hns: Initialize the PCI device for hip08 RoCE")
> > > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > > >  drivers/infiniband/hw/hns/Kconfig | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/infiniband/hw/hns/Kconfig b/drivers/infiniband/hw/hns/Kconfig
> > > > index b59da5d..4371c80 100644
> > > > +++ b/drivers/infiniband/hw/hns/Kconfig
> > > > @@ -23,7 +23,8 @@ config INFINIBAND_HNS_HIP06
> > > >
> > > >  config INFINIBAND_HNS_HIP08
> > > >  	bool "Hisilicon Hip08 Family RoCE support"
> > > > -	depends on INFINIBAND_HNS && PCI && HNS3
> > > > +	depends on INFINIBAND_HNS && (INFINIBAND_HNS = HNS3)
> > >
> > > This is wrong.
> >
> > It is tricky. It is asserting that the IB side is built as a module if
> > the ethernet side is a module..
> >
> > It is kind of a weird pattern as the module config is INFINIBAND_HNS
> > and these others are just bool opens what to include, but I think it
> > is OK..
> 
> select ???

select doesn't influence module or not any different from depeends

Jason
