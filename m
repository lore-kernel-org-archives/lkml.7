Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205F6C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 20:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033C5206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 20:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbfJLUhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 16:37:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38026 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729718AbfJLUhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 16:37:02 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 46C8E4E919
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 20:37:01 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id o128so5198225wmo.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 13:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nsuG9DynP4h5A9hJiRAHv7ZghRiHq0bUTGCGrIQlgl4=;
        b=O/TkJ3kW3aiGudc3m3E8emg0zak9RheZ6Hwkq0SDKRbbPc8un9jpmDYcyzeaXNy3tK
         VSabiYpsDGDH9SLbt5ehJp/g0LtMegSOqAL3X5zYplixpct90sAOxzKjm/0h9JjEFM8L
         Hfl94aO66WcyL0IiTbQ70miUgsYmKTbggLJ3wUmkeOv+uoGzBsw3NHWxkg3repCBwzSw
         AQ9EPxHvYtedRHHWbOfAXzLS7G7GsyosexcJvQUuqgRETNEYiWalLW9ulHNsWdqYN4im
         QFBLHki7duM+U+uEAClDHhpL63cLqtkPfPo/p4fS2Y14qLSTsXlqcAzTuKj49fbxUdGf
         a1Ww==
X-Gm-Message-State: APjAAAUFLJGI8E1egiQhVJcZKrrsC0bEOrfvudi7N6hbxRoVMsqGxqng
        RopReTJwKGRLFkbetUxnH74IdPq/e1u717qGZKnGEFPfNR7Rfy1wA5OPWG6gU0OPUGO8ez9ZKMf
        XQCVN1lizWHYgZ/Ur0eYpBc0F
X-Received: by 2002:a5d:6709:: with SMTP id o9mr18541562wru.116.1570912620054;
        Sat, 12 Oct 2019 13:37:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy8AwCsOKbqErxze+dj/LkUtWRGrZpyJTxNw8vodxFVLNH1FPTXAO2PjutYGomFF101n5ZJLw==
X-Received: by 2002:a5d:6709:: with SMTP id o9mr18541555wru.116.1570912619857;
        Sat, 12 Oct 2019 13:36:59 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id d78sm17957635wmd.47.2019.10.12.13.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 13:36:59 -0700 (PDT)
Date:   Sat, 12 Oct 2019 16:36:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH RFC v1 0/2] vhost: ring format independence
Message-ID: <20191012163635-mutt-send-email-mst@kernel.org>
References: <20191011134358.16912-1-mst@redhat.com>
 <b24b3c9e-3a5d-fa5e-8218-ea7def0e5a39@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b24b3c9e-3a5d-fa5e-8218-ea7def0e5a39@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 03:31:50PM +0800, Jason Wang wrote:
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
> 
> 
> It would be better to convert vhost_net then I can do some benchmark on
> that.
> 
> Thanks

Sure, I post a small patch that does this.

> 
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
