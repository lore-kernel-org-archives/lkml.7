Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D205C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7E225F32
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfE3SNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 14:13:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36849 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfE3SNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 14:13:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id u12so8141839qth.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 11:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=swUKp54FsABaRx/HQxckmg32aK739BKT6ewItuokNDk=;
        b=mCnm3c9V+AUiXWu72CRiDG1lDftKWC0WYItdzS+nEAZ/TTkdtF9aaczm5EVhyDFBUz
         QVQ3UtueqzGuyPvF99YP9tEfiG9SSBt94wDCI85CSmsyoLUW6ecJc+CmzpXl43xcH+8L
         65FUXzWZFFsfB30dF0m7JYOsqi8PVL+DJNiuxjdbcNqx+SsHJ3GKRYW/mFXFWwZy4PC0
         HWnG3wfAAHH13wx2jZNw6mRcAEKq6TEF0ACehlWLbic8FJzyuY1VFgv7wnbGYK1Yj4Jm
         IEVNA0s4Fme90AUirhQWO0TKerIAhTx7c+KvygP0esafrZA1LHY8CrAkG/DICBfmKUzd
         AslA==
X-Gm-Message-State: APjAAAVWQrDZoKDyTVWBa2Pb9pUXkjyrDJL8GfZI/K183PBef99ZUMF9
        LbrhyL0p49k9NPMTCIj+vJJr6A==
X-Google-Smtp-Source: APXvYqyndgU/JBNxGTz081BydLXYPXGN+1/yzyTBopwAP5jF6DEPVUhyIlMc188XrJEeCGJfnA2k0g==
X-Received: by 2002:aed:2494:: with SMTP id t20mr4813376qtc.135.1559240011968;
        Thu, 30 May 2019 11:13:31 -0700 (PDT)
Received: from redhat.com (pool-100-0-197-103.bstnma.fios.verizon.net. [100.0.197.103])
        by smtp.gmail.com with ESMTPSA id k9sm1894099qki.20.2019.05.30.11.13.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 30 May 2019 11:13:31 -0700 (PDT)
Date:   Thu, 30 May 2019 14:13:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        James.Bottomley@hansenpartnership.com, hch@infradead.org,
        jglisse@redhat.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
        christophe.de.dinechin@gmail.com, jrdr.linux@gmail.com
Subject: Re: [PATCH net-next 0/6] vhost: accelerate metadata access
Message-ID: <20190530141243-mutt-send-email-mst@kernel.org>
References: <20190524081218.2502-1-jasowang@redhat.com>
 <20190530.110730.2064393163616673523.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530.110730.2064393163616673523.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 11:07:30AM -0700, David Miller wrote:
> From: Jason Wang <jasowang@redhat.com>
> Date: Fri, 24 May 2019 04:12:12 -0400
> 
> > This series tries to access virtqueue metadata through kernel virtual
> > address instead of copy_user() friends since they had too much
> > overheads like checks, spec barriers or even hardware feature
> > toggling like SMAP. This is done through setup kernel address through
> > direct mapping and co-opreate VM management with MMU notifiers.
> > 
> > Test shows about 23% improvement on TX PPS. TCP_STREAM doesn't see
> > obvious improvement.
> 
> I'm still waiting for some review from mst.
> 
> If I don't see any review soon I will just wipe these changes from
> patchwork as it serves no purpose to just let them rot there.
> 
> Thank you.

I thought we agreed I'm merging this through my tree, not net-next.
So you can safely wipe it.

Thanks!

-- 
MST
