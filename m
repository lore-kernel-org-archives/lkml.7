Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA70C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0527120C01
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfELRQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:16:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43350 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfELRQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:16:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id r3so12202731qtp.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 10:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qMf0PlJDzZT0ii1CmsFhoJpwYJlUGaPBImKHduw9guM=;
        b=s7c6hTgb5i3KnpwWYbnqg6dd3f4xwTDNhtAb0OMudSOX1p0Dv5k4tv21xQ79rmFvF7
         sBB3Gq1C+ArWPbJVdMgTjKLQEFBIkY9lTp4kd+3Wnd36Yh6iz5NqJPrgJ17/NuRFYjM7
         0+kVB4Stqh+j6WqbgYQRVk4N00Hn7pemjStbRldcYIzAsKvWOKrE16bg2AuU2MpMMcZa
         l8r3Bdrq2pa2w0oUjPe5hQRGI0zRPn4Z9fvg5aQTDX6BdaBIGa1IjaW3pditIHpEOtyA
         6/jeUvFrZ6wZ5ddytKGRmPSAwJeCSJamasj5h7A8L21Qj2/38FGTMZBTuq5CYAOMwKce
         Qa6A==
X-Gm-Message-State: APjAAAUNoTN1fnnJJ7Cf0VXswQVfXNuUa6z7n5uikzS6yoCN2sHrisV6
        Sy65q3Xys/k0j26oedfrZqG1FQ==
X-Google-Smtp-Source: APXvYqxu4CfNnRIj63eVd29IxNZnET4PAxdUfo2ihSl72RnvRJaZAB5kKkF0ZPjXcEUdWEfCYjQHxA==
X-Received: by 2002:a0c:ee28:: with SMTP id l8mr18688827qvs.67.1557681389397;
        Sun, 12 May 2019 10:16:29 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net. [173.76.105.71])
        by smtp.gmail.com with ESMTPSA id j93sm5815209qte.42.2019.05.12.10.16.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 12 May 2019 10:16:28 -0700 (PDT)
Date:   Sun, 12 May 2019 13:16:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>
Subject: Re: linux-next: manual merge of the vhost tree with the iommu tree
Message-ID: <20190512131410-mutt-send-email-mst@kernel.org>
References: <20190227152506.4696a59f@canb.auug.org.au>
 <2370af99-9dc1-b694-9f1c-1951d1e70435@arm.com>
 <20190227085546-mutt-send-email-mst@kernel.org>
 <20190228100442.GB1594@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228100442.GB1594@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:04:42AM +0100, Joerg Roedel wrote:
> On Wed, Feb 27, 2019 at 08:58:36AM -0500, Michael S. Tsirkin wrote:
> > Even though it's not going into 5.1 I feel it's helpful to keep it in
> > the vhost tree until the next cycle, it helps make sure unrelated
> > changes don't break it.
> 
> It is not going to 5.1, so it shouldn't be in linux-next, no? And when
> it is going upstream, it should do so through the iommu tree. If you
> keep it separatly in the vhost tree for testing purposes, please make
> sure it is not included into your linux-next branch.
> 
> Regards,
> 
> 	Joerg

Joerg, what are we doing with these patches?
It was tested in next with no bad effects.
I sent an ack - do you want to pick it up?
Or have me include it in my pull?

Thanks!


-- 
MST
