Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7331C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934B520868
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfEQI06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 04:26:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54097 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbfEQI06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 04:26:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id 198so6038985wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 01:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sEvENpqG7iRDJFzplTTWGKcKFWzhWauRstxh0Bhc8E4=;
        b=fyBND6S0FBdZuHKJYJWpcSL6YHlII/x4g7UdIWq24ZQgRH4HLihdgphY54QLC7gOmV
         A1ylSwM1KrHQlps68M085zqRCm2fUBVOKFnE4L9gyEfCPu1JtH0YCfUT18dApL3wec8a
         knh5+s0TOeT00GWCW+Ap3yv19qE6snWHG62MEcQlyLpM6q4Tk5BXgilUC7SLwAN7xfpX
         5IW2ioJiSRfpbvj/9iqq37Sbn1I6QH5sIdD15F+HbcP3ZIlHWjlyCu6oFccv3/q12K5d
         U2rhqhjmXjUqEWDdEBHHlCPsgzcKyG39g5e7PuB7UFWYyemXDJOZRxLmCyGzZ1EyBd44
         fn/A==
X-Gm-Message-State: APjAAAXct1wCABbzrTMGLzvqbiYxzAv/p0MqhYMi6rF1jzjp6rvT2DXw
        iVHzpFeJ9GNNJNgR3pVwg7dDUA==
X-Google-Smtp-Source: APXvYqzbrpzTZlidwr0VrrxreIABY704QNogR/kYguVAnOeyJIKbn/D8MSRkU5vYa/5xmd361QHBXQ==
X-Received: by 2002:a1c:c015:: with SMTP id q21mr1265915wmf.75.1558081616187;
        Fri, 17 May 2019 01:26:56 -0700 (PDT)
Received: from steredhat (host151-251-static.12-87-b.business.telecomitalia.it. [87.12.251.151])
        by smtp.gmail.com with ESMTPSA id a5sm6714144wrt.10.2019.05.17.01.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 01:26:55 -0700 (PDT)
Date:   Fri, 17 May 2019 10:26:53 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 2/8] vsock/virtio: free packets during the socket
 release
Message-ID: <20190517082653.aymkhkqkj5yminfg@steredhat>
References: <20190510125843.95587-1-sgarzare@redhat.com>
 <20190510125843.95587-3-sgarzare@redhat.com>
 <20190516153218.GC29808@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516153218.GC29808@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 04:32:18PM +0100, Stefan Hajnoczi wrote:
> On Fri, May 10, 2019 at 02:58:37PM +0200, Stefano Garzarella wrote:
> > When the socket is released, we should free all packets
> > queued in the per-socket list in order to avoid a memory
> > leak.
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  net/vmw_vsock/virtio_transport_common.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> 
> Ouch, this would be nice as a separate patch that can be merged right
> away (with s/virtio_vsock_buf/virtio_vsock_pkt/).

Okay, I'll fix this patch following the David's comment and I'll send
as a separate patch using the virtio_vsock_pkt.

Thanks,
Stefano
