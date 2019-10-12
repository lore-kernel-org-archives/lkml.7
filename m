Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A178AC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8812B20679
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 19:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfJLT0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 15:26:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52578 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbfJLT0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 15:26:16 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0AA9126E
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 19:26:15 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id j7so6265405wrx.14
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 12:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NER+WYNjIiTuYyELfX6XGxRMHyIeb8bjpkbmjz8T8Lw=;
        b=h9NgEd56x6Gp1WbMEzmxYygSRFT549Airh3Amus0vi8jTqRF0zOSCVqzPA2+kzm3fI
         YaTXd7dsPnjwzizPsS2cvmKEWyM+9QYD4OZ02mjgFNNY7bC8+EZKnZuPUYnEaKrGWs1F
         McXYjYfxNlKkLRFM/+/Qrxq3EYevY7O5bQ9ieJj5YWfonIk19DSM0apkZnhTgoQfjM8X
         BZKI5ktQgttrXMV7OU+AJstUavV4IFAUHr+Lm4jEPi5yBdGKYqshnrQqdjextH5r4PrQ
         04z/9eSDThNrclfDBZBbb4IB9BH1Hh0Dckw4n+KHp3bVtR4YcOz77BXtWcdakIVT49j4
         1Rvg==
X-Gm-Message-State: APjAAAXQkWnGfuxnN/dcRf5nBePkoEdkC0Ouv4Szg0pkPwLeCAEnKpgw
        //SLtUzagty8i1oxBzZuk1Ofw5XcbLw3KCVn/6+fXbfi/f6XFaI50AG9tuOTeipXLDO2P5Uq7aa
        FF7ytX/hvGBXIwrszCrdBHhxb
X-Received: by 2002:adf:e90d:: with SMTP id f13mr18704545wrm.104.1570908374717;
        Sat, 12 Oct 2019 12:26:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwzVc4L36wZsuw/yIheWC3DcZ/4dWluqHH2rLuU6KbnjXtc/R53950cBJ1bTedee2IPkXIj5Q==
X-Received: by 2002:adf:e90d:: with SMTP id f13mr18704533wrm.104.1570908374478;
        Sat, 12 Oct 2019 12:26:14 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id r6sm14770346wmh.38.2019.10.12.12.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 12:26:13 -0700 (PDT)
Date:   Sat, 12 Oct 2019 15:26:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC v1 0/2] vhost: ring format independence
Message-ID: <20191012152332-mutt-send-email-mst@kernel.org>
References: <20191011134358.16912-1-mst@redhat.com>
 <f650ac1a-6e2a-9215-6e4f-a1095f4a89cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f650ac1a-6e2a-9215-6e4f-a1095f4a89cd@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 04:15:42PM +0800, Jason Wang wrote:
> 
> On 2019/10/11 下午9:45, Michael S. Tsirkin wrote:
> > So the idea is as follows: we convert descriptors to an
> > independent format first, and process that converting to
> > iov later.
> > 
> > The point is that we have a tight loop that fetches
> > descriptors, which is good for cache utilization.
> > This will also allow all kind of batching tricks -
> > e.g. it seems possible to keep SMAP disabled while
> > we are fetching multiple descriptors.
> 
> 
> I wonder this may help for performance:

Could you try it out and report please?
Would be very much appreciated.

> - another indirection layer, increased footprint

Seems to be offset off by improved batching.
For sure will be even better if we can move stac/clac out,
or replace some get/put user with bigger copy to/from.

> - won't help or even degrade when there's no batch

I couldn't measure a difference. I'm guessing

> - an extra overhead in the case of in order where we should already had
> tight loop

it's not so tight with translation in there.
this exactly makes the loop tight.

> - need carefully deal with indirect and chain or make it only work for
> packet sit just in a single descriptor
> 
> Thanks

I don't understand this last comment.

> 
> > 
> > And perhaps more importantly, this is a very good fit for the packed
> > ring layout, where we get and put descriptors in order.
> > 
> > This patchset seems to already perform exactly the same as the original
> > code already based on a microbenchmark.  More testing would be very much
> > appreciated.
> > 
> > Biggest TODO before this first step is ready to go in is to
> > batch indirect descriptors as well.
> > 
> > Integrating into vhost-net is basically
> > s/vhost_get_vq_desc/vhost_get_vq_desc_batch/ -
> > or add a module parameter like I did in the test module.
> > 
> > 
> > 
> > Michael S. Tsirkin (2):
> >    vhost: option to fetch descriptors through an independent struct
> >    vhost: batching fetches
> > 
> >   drivers/vhost/test.c  |  19 ++-
> >   drivers/vhost/vhost.c | 333 +++++++++++++++++++++++++++++++++++++++++-
> >   drivers/vhost/vhost.h |  20 ++-
> >   3 files changed, 365 insertions(+), 7 deletions(-)
> > 
