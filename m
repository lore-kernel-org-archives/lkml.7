Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49769C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 10:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3AB2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 10:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfF0KGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 06:06:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36094 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfF0KGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 06:06:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id u8so5043291wmm.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 03:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l1NwZTpnYPouG/Q6w8KVsqVGc7B8RfSH5Nd1fRhhCTg=;
        b=htvL8ker5JTfl4mGvxaiph7g5vGSFok6mJ+ysY3yaKyjX5MraQ2C2hYUCgGGkTMiXh
         aJHqnLYnS9RhwQ5bIJI/9hcHUolYPIPvHS0r6dKsJt4d3sPUABeu6kf1WAZE8Rkf0qhD
         fCvjF1kG0rnJTnOLa2lmBBxMP3Gq25C7OX4xn0bPfbcxBgB0UMvTkEPxIDm0bD3b8drk
         xH566Y4VNgwJhaUlId0p5bkEnxpfcPT4mgMqRr2JZgv/rpy1C9wENpTYGXQRcX1Zc1Nk
         8oP+ZaRSaGgFEVxobFiU3jV/H7BgKyeeoJGqI7OrJBCeWpoRN+wX4xaRriX+RRrUX0jZ
         qEvA==
X-Gm-Message-State: APjAAAWXqXCFRdb7yjKLht2wdX1mWGBHyNo4SyfAyM4XvmSxPZ9uy9Yg
        P5H0pfYCc8P/ploD2LoCK77e7Q==
X-Google-Smtp-Source: APXvYqzQ0sKIY6ZChWYC2WJ9R3q0SreK0ALQXZZlzrAyFs4jZYqRQY8Nns9g7u2vtKtU2ORhMeHCKQ==
X-Received: by 2002:a1c:4484:: with SMTP id r126mr2685540wma.27.1561629959060;
        Thu, 27 Jun 2019 03:05:59 -0700 (PDT)
Received: from steredhat.homenet.telecomitalia.it (host21-207-dynamic.52-79-r.retail.telecomitalia.it. [79.52.207.21])
        by smtp.gmail.com with ESMTPSA id l12sm3249628wrb.81.2019.06.27.03.05.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 03:05:57 -0700 (PDT)
Date:   Thu, 27 Jun 2019 12:05:55 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     netdev@vger.kernel.org, kvm@vger.kernel.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 0/4] vsock/virtio: several fixes in the .probe() and
 .remove()
Message-ID: <20190627100555.pmnecffewzsopxyw@steredhat.homenet.telecomitalia.it>
References: <20190528105623.27983-1-sgarzare@redhat.com>
 <20190610130945.GL14257@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610130945.GL14257@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 02:09:45PM +0100, Stefan Hajnoczi wrote:
> On Tue, May 28, 2019 at 12:56:19PM +0200, Stefano Garzarella wrote:
> > During the review of "[PATCH] vsock/virtio: Initialize core virtio vsock
> > before registering the driver", Stefan pointed out some possible issues
> > in the .probe() and .remove() callbacks of the virtio-vsock driver.
> > 
> > This series tries to solve these issues:
> > - Patch 1 postpones the 'the_virtio_vsock' assignment at the end of the
> >   .probe() to avoid that some sockets queue works when the initialization
> >   is not finished.
> > - Patches 2 and 3 stop workers before to call vdev->config->reset(vdev) to
> >   be sure that no one is accessing the device, and adds another flush at the
> >   end of the .remove() to avoid use after free.
> > - Patch 4 free also used buffers in the virtqueues during the .remove().
> > 
> > Stefano Garzarella (4):
> >   vsock/virtio: fix locking around 'the_virtio_vsock'
> >   vsock/virtio: stop workers during the .remove()
> >   vsock/virtio: fix flush of works during the .remove()
> >   vsock/virtio: free used buffers during the .remove()
> > 
> >  net/vmw_vsock/virtio_transport.c | 105 ++++++++++++++++++++++++++-----
> >  1 file changed, 90 insertions(+), 15 deletions(-)
> 
> Looking forward to v2.  I took a look at the discussion and I'll review
> v2 from scratch.  Just keep in mind that the mutex is used more for
> mutual exclusion of the init/exit code than to protect the_virtio_vsock,
> so we'll still need protection of init/exit code even with RCU.

Thanks for the advice! I'll send the v2 ASAP.

Thanks,
Stefano
