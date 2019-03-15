Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBC3C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E61320854
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="hDqAlN2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfCONaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:30:21 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33035 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfCONaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:30:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id k14so4309051qtb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wN20U8IEsLh5RNTubrw2jQVkk1uGCIfHs0EfnmILUwo=;
        b=hDqAlN2FFNw9E/cm85y3zwTUHBE+3/qKltYvD7P1DItMctcU264QY2NrOWTUhfEUL0
         sxDxY5mXqC++3qobHhXG3vbtLla4ZU5fnny9kTF05Wsi9HBw3FV0ftQfIFH/0Y8+48XE
         QstsgiTaVZlElstNtwvFyopEAoDyT/6GLOYQSaRSSYHARXUv0IECrlVROudmTjllefDv
         5EHFMqm29s6KN9UTfcGxcQptZyNDEm/L8AhtnDSWcfqHsJdg9kdVoa0F+n9zHaSkb6Lc
         6hboOr6eftZoQazM2uCyTV3VOveJATUk5WoEuJior/Ej618+RZLeQO9ECtQrfm1AsIZm
         VS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wN20U8IEsLh5RNTubrw2jQVkk1uGCIfHs0EfnmILUwo=;
        b=Jd11oI1529nWhr3mHq73zoiHrZpo7meCizd3znXEp64bffEjSGjoO/B0MgbzzW9WtE
         PsHjdNDdpWfBb+n4SyxIMAmMaibnVqQd9wULl1SsyGVtYVfblR9NPIMg2f/26C/vnism
         TbGci/n/L4LaUaWndMTGHJa/N2YclCpb7OykBJf548EpyWq2STsz2HA1vlG+U6Jeqv3S
         ytJ4V3JvEAPwEyAdZYqv/ddmIANAkL4eZxsxgd7pxvy5jOQn0lrDZFTStB8g1FnC4P5B
         MTUsoIVcbcVlVciis0q1NU5ijfLez7QLW2Vj68IbYx/mHRer2x7pp9cU2pBZcHL9iVI1
         rj2Q==
X-Gm-Message-State: APjAAAWmZDxFc4Kl/KlPW5teYfhJo/d7RYQ7cReXCce614448yIqiekD
        lUJWmGFCyxfsqFukEgVIZMmlmR4rC1HKQTdd
X-Google-Smtp-Source: APXvYqxkABG5ytAGHiYJZdbE/6xgxKLdj0lquVjJ0GTNgf5CqZnChnTRdQH+xMT0fzAKltDVEahxrg==
X-Received: by 2002:ac8:2427:: with SMTP id c36mr2857627qtc.124.1552656620302;
        Fri, 15 Mar 2019 06:30:20 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y2sm1435840qty.63.2019.03.15.06.30.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 06:30:19 -0700 (PDT)
Date:   Fri, 15 Mar 2019 09:30:18 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jianchao Wang <jianchao.w.wang@oracle.com>, axboe@kernel.dk,
        jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        bvanassche@acm.org, sagi@grimberg.me, keith.busch@intel.com,
        jsmart2021@gmail.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8]: blk-mq: use static_rqs to iterate busy tags
Message-ID: <20190315133017.lnr5cvtapo5nxilu@MacBook-Pro-91.local>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <20190315092020.GA2405@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315092020.GA2405@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 10:20:20AM +0100, Christoph Hellwig wrote:
> On Fri, Mar 15, 2019 at 04:57:36PM +0800, Jianchao Wang wrote:
> > Hi Jens
> > 
> > As we know, there is a risk of accesing stale requests when iterate
> > in-flight requests with tags->rqs[] and this has been talked in following
> > thread,
> > [1] https://marc.info/?l=linux-scsi&m=154511693912752&w=2
> > [2] https://marc.info/?l=linux-block&m=154526189023236&w=2
> 
> I'd rather take one step back and figure out why we are iterating
> the busy requests.  There really shouldn't be any reason why a driver
> is even doings that (vs some error handling helpers in the core
> block code that can properly synchronize).

I use it in NBD to error out any pending requests for forced disconnects.  I'd
be happy to use some other blessed interface, I'm not married to this one.
Thanks,

Josef
