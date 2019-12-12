Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D88C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 897BF22527
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtVi64iN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfLLM4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:56:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43726 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729302AbfLLM4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:56:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576155393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BQ/OeprMEEQbDYMzEQzXy36w02TkBbbXNkwJyG1iOw4=;
        b=gtVi64iN0HoEcZbCzpcBqlAhmLgS+evhu+NHrOcBUrNLg3HBT4VF91CUB9zfuRebBTl/pW
        F7Rpc4zWUHQuNCKlKlRDBWSK7Epb98KuFwMWvR6EAmavxHuJZXqFOZGRRv4TYIhMg1JHVW
        pJ32uHIaiq9++Z+bC0LqoC3fXQfjg8g=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-pcC1Jcf9PnerXW_dvLiJDw-1; Thu, 12 Dec 2019 07:56:32 -0500
X-MC-Unique: pcC1Jcf9PnerXW_dvLiJDw-1
Received: by mail-qt1-f198.google.com with SMTP id l25so1328321qtu.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 04:56:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BQ/OeprMEEQbDYMzEQzXy36w02TkBbbXNkwJyG1iOw4=;
        b=pVaeHYGO4Yi/M89q4FVocfSjYm0pAyQmc3R7Prsj3RamTAl1hTMF4x4wQSL8Y9sOeR
         yImWXp/NBIc9n2/shXsHmHuKOl+uTmfFo3ZqvV+zS2pNgIDL6i/lSkK8kCOu3eGnXBnO
         c96OWu8iQxH+4dXdQE6R1+SiJTzNcZ4pqsJd93/9Q7zmVG0i1rBYni0avHzvhlZtCOXL
         JraaDDqZPCnkLSAsGke48EtbQJ8NveX+C5hSu9KeRzCeyYcvAKEhAGnCjM0XVtya3Ypp
         f88U/UZJLlCirlgj5aXfYqPtAkic3+/+7b411vZBb7k1B1RQUSyk8B+H89A9HavhP89D
         7F/w==
X-Gm-Message-State: APjAAAXccPye+njisdsTw57j9rQRuG2ZtR5HGfraVgSG4fek//76Y5BP
        85s+LfcVDoTRfg1MLCD5aDdmVEDvh/B0QC6U34dWmLqhFBTNo1IR+zJhyFxoYXFXT59Yu7W9TIr
        d1x3IR7Nc717UbW7X1V7dtYEI
X-Received: by 2002:ac8:1196:: with SMTP id d22mr7374521qtj.344.1576155392076;
        Thu, 12 Dec 2019 04:56:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqwGAOqNeoXt3nIrQGWq7m2hfYKhqzgGGgHCw70gSt6fz7ekSW8rLr9/hwp3tuH2X5BB5yIhKQ==
X-Received: by 2002:ac8:1196:: with SMTP id d22mr7374504qtj.344.1576155391867;
        Thu, 12 Dec 2019 04:56:31 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
        by smtp.gmail.com with ESMTPSA id d23sm2191968qte.32.2019.12.12.04.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 04:56:30 -0800 (PST)
Date:   Thu, 12 Dec 2019 07:56:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] vhost/vsock: accept only packets with the right dst_cid
Message-ID: <20191212075356-mutt-send-email-mst@kernel.org>
References: <20191206143912.153583-1-sgarzare@redhat.com>
 <20191211110235-mutt-send-email-mst@kernel.org>
 <20191212123624.ahyhrny7u6ntn3xt@steredhat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212123624.ahyhrny7u6ntn3xt@steredhat>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 01:36:24PM +0100, Stefano Garzarella wrote:
> On Wed, Dec 11, 2019 at 11:03:07AM -0500, Michael S. Tsirkin wrote:
> > On Fri, Dec 06, 2019 at 03:39:12PM +0100, Stefano Garzarella wrote:
> > > When we receive a new packet from the guest, we check if the
> > > src_cid is correct, but we forgot to check the dst_cid.
> > > 
> > > The host should accept only packets where dst_cid is
> > > equal to the host CID.
> > > 
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > 
> > Stefano can you clarify the impact pls?
> 
> Sure, I'm sorry I didn't do it earlier.
> 
> > E.g. is this needed on stable? Etc.
> 
> This is a better analysis (I hope) when there is a malformed guest
> that sends a packet with a wrong dst_cid:
> - before v5.4 we supported only one transport at runtime, so the sockets
>   in the host can only receive packets from guests. In this case, if
>   the dst_cid is wrong, maybe the only issue is that the getsockname()
>   returns an inconsistent address (the cid returned is the one received
>   from the guest)
> 
> - from v5.4 we support multi-transport, so the L1 VM (e.g. L0 assigned
>   cid 5 to this VM) can have both Guest2Host and Host2Guest transports.
>   In this case, we have these possible issues:
>   - L2 (or L1) guest can use cid 0, 1, and 2 to reach L1 (or L0),
>     instead we should allow only CID_HOST (2) to reach the level below.
>     Note: this happens also with not malformed guest that runs Linux v5.4
>   - if a malformed L2 guest sends a packet with the wrong dst_cid, for example
>     instead of CID_HOST, it uses the cid assigned by L0 to L1 (5 in this
>     example), this packets can wrongly queued to a socket on L1 bound to cid 5,
>     that only expects connections from L0.

Oh so a security issue?

> 
> Maybe we really need this only on stable v5.4, but the patch is very simple
> and should apply cleanly to all stable branches.
> 
> What do you think?
> 
> Thanks,
> Stefano

I'd say it's better to backport to all stable releases where it applies,
but yes it's only a security issue in 5.4.  Dave could you forward pls?

-- 
MST

