Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892DCC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E492148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbfDHPRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:17:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51370 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfDHPRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:17:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so14821864wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 08:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w6z7MBI8+5GoJnaZnj0gEJa1yCqr80vB4dEYmuxnu7Q=;
        b=OxlVIKOM2MUV9yD/8+W6y4VePrwiIWiL95dW3NA18To8SwhaoAgqBCQy7H9JZSRwIi
         lxTANgDFp6uo1DCMGHV5arMglp9napFt5tjuCZrg9JqRtLiArN1+opkA37IqRrYMM2DV
         Z9pFcLqkF5ZWff032Rj8SlkSQngGGE3Y9sE79Dlke4Y7I4t5FBAykCeT5g/G5iFKoO/m
         24J9/zcgBwLwwSXfPnhVtDA1BYVwUoFGHeRI1Mjup6z5SWeKeQm7Wt62LncDS62IN8jp
         /ovQjYz3/0vQRcNcROdA3+zxULxULpcVFk16Ad/qafH1VtnAQU/6drMSMxLLVQBO41Bu
         JM5g==
X-Gm-Message-State: APjAAAXtQ1TO0/2R/P+Jycr4+OSLn97TL6gUElg6/OHCJfR6AzevKtaq
        FOYRnnhfsKsCjg5m2oB/roCdSrvMx+Y=
X-Google-Smtp-Source: APXvYqwltm8QBf/OmuBj4P6eatTDa6YrSxIwOSgoMgA7Ad/sLTugH590ZkpwmFcQ0sZ69EWlsXWUgQ==
X-Received: by 2002:a1c:2109:: with SMTP id h9mr19008264wmh.68.1554736658631;
        Mon, 08 Apr 2019 08:17:38 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it. [87.12.203.35])
        by smtp.gmail.com with ESMTPSA id f1sm8880617wml.28.2019.04.08.08.17.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 08:17:37 -0700 (PDT)
Date:   Mon, 8 Apr 2019 17:17:35 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefan Hajnoczi <stefanha@gmail.com>, netdev@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH RFC 3/4] vsock/virtio: change the maximum packet size
 allowed
Message-ID: <20190408151735.itsfswajk5ww3ejv@steredhat>
References: <20190404105838.101559-1-sgarzare@redhat.com>
 <20190404105838.101559-4-sgarzare@redhat.com>
 <20190405082447.GD25152@stefanha-x1.localdomain>
 <20190405100747.dbwi3sjaudp3d2wa@steredhat>
 <20190408093723.GP15001@stefanha-x1.localdomain>
 <20190408145531.yreyawkn5vjqj7sl@steredhat>
 <20190408105619-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408105619-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 10:57:44AM -0400, Michael S. Tsirkin wrote:
> On Mon, Apr 08, 2019 at 04:55:31PM +0200, Stefano Garzarella wrote:
> > > Anyway, any change to this behavior requires compatibility so new guest
> > > drivers work with old vhost_vsock.ko.  Therefore we should probably just
> > > leave the limit for now.
> > 
> > I understood your point of view and I completely agree with you.
> > But, until we don't have a way to expose features/versions between guest
> > and host,
> 
> Why not use the standard virtio feature negotiation mechanism for this?
> 

Yes, I have this in my mind :), but I want to understand better if we can
use virtio-net also for this mechanism.
For now, I don't think limiting the packets to 64 KiB is a big issue.

What do you think if I postpone this when I have more clear if we can
use virtio-net or not? (in order to avoid duplicated work)

Thanks,
Stefano
