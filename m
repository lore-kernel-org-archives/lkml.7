Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91ED8C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9B020663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551922712;
	bh=d0W2Q99jfhV4USVthK09+aYzGwuETzCPnC8fxYYpfnM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KVumf96Rso0VbnoLcrQHH9kjSw3uJJjgZRb9rUeAYzhNwo/kF/fE/Xd/Q447iM9Aa
	 rm+u4hlcBvW/DLIs4IH8VZWxszC+S+7OxEy9rIyff0dKm+W0vFyjZ278hyOZQkgwVO
	 5735mpcAIG4pLDP3MQ54cTXa8lwL8ES2S7RhNkRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfCGBib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:38:31 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38843 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGBia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:38:30 -0500
Received: by mail-lj1-f194.google.com with SMTP id 199so12720797ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 17:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/h54bn5MUqgO8FxqLvtxQ5ssyd4D+ngpXlcxoit0L4=;
        b=QIlqE2OmvvilcYZJhkOscLXVK3QSOpv4YwowoAMEUvrv9dE+ucGLDbOoWzrBw6Bx0U
         IjFWLlk5FlJtQmWhfxbYFePRQY/V8qm4UdJ9io4+PDRZ18DIgqmb8qnmd7eXlI6WA8rL
         OxmgCN9S4rA8BW/SmJqXJtSkXuRatASti6BEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/h54bn5MUqgO8FxqLvtxQ5ssyd4D+ngpXlcxoit0L4=;
        b=X70VIypnVRSYmlJGsC0RLCiLmDKeLvAHkOdt8d/QeKDw1QZFKOJGnnU+sTU1lF9uRF
         rW1k3QBcxKcBXqJfX6EoFJn/jYVjMtHvUo2RSMBBBcoQFiTLAika9CkjHOPRCskUKjhI
         K3IHu0YhAvXOT1nr0pu+yhn824rFHoPxq6rTUacqRoWNJJsalj6prchFrznEDAl8EJn5
         4xXlyvKI87//TsaSmvCjc26fMMPRCPjW2pREkyqoCycAFxYjTxNkx4fVHC2VzvCz9MHz
         tbggB1Lrx1Tui7a6rEcxJeIOQmDiHCNHjVRU3mg59zhdH/CTBfpEcosTna9T6GH9uMC7
         N1yg==
X-Gm-Message-State: APjAAAX97yJl/BONSrht3RDMvYKqSeP3/9dKRhSwH9d3phVmBTa19v3S
        qgYGnUqAimHGvNC7bE8xjP7r/dwdpnA=
X-Google-Smtp-Source: APXvYqwW+uptKWg6JMyD5s0rPVtF8zfxw+eDnm6kf32aSmti6K+HhqA+niWB0qkogAp/E+ThMXb6Eg==
X-Received: by 2002:a2e:9355:: with SMTP id m21mr4107664ljh.172.1551922708283;
        Wed, 06 Mar 2019 17:38:28 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id j23sm578634lfb.17.2019.03.06.17.38.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 17:38:28 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id a8so10417080lfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 17:38:27 -0800 (PST)
X-Received: by 2002:ac2:5386:: with SMTP id g6mr5438808lfh.88.1551922237689;
 Wed, 06 Mar 2019 17:30:37 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wghRmdYKRAwakeHmjcpbLt9fJAHyU2x8s_NZONhz6RTOw@mail.gmail.com>
 <20190307000316.31133-1-viro@ZenIV.linux.org.uk> <CAHk-=wjzJSnQaj5b02aAjFdVMrKOp8UpyfQcoquRjem=X+SgTA@mail.gmail.com>
 <20190307004159.GY2217@ZenIV.linux.org.uk> <20190307004828.GZ2217@ZenIV.linux.org.uk>
 <20190307012036.GA2217@ZenIV.linux.org.uk>
In-Reply-To: <20190307012036.GA2217@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Mar 2019 17:30:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=whn7iJsbr=_ab3Ghvd1pzxvio3sktrBuMr6aG=gFLFtEg@mail.gmail.com>
Message-ID: <CAHk-=whn7iJsbr=_ab3Ghvd1pzxvio3sktrBuMr6aG=gFLFtEg@mail.gmail.com>
Subject: Re: [PATCH 1/8] aio: make sure file is pinned
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jason Baron <jbaron@akamai.com>, kgraul@linux.ibm.com,
        ktkhai@virtuozzo.com, kyeongdon kim <kyeongdon.kim@lge.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        zhengbin <zhengbin13@huawei.com>, bcrl@kvack.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-aio@kvack.org, houtao1@huawei.com, yi.zhang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 5:20 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I'll try to massage that series on top of your patch; I still hate the
> post-vfs_poll() logics in aio_poll() ;-/  Give me about half an hour
> and I'll have something to post.

No inherent hurry, I sent the ping just to make sure it hadn't gotten lost.

And yeah, I think the post-vfs_poll() logic cannot possibly be
necessary. My gut feel is that *if* we have the refcounting right,
then we should be able to just let the wakeup come in at any later
point, and ordering shouldn't matter all that much, and we shouldn't
even need any locking.

I'd like to think that it can be done with something like "just 'or'
in the mask atomically" (so that we don't care about ordering between
the synchronous vfs_poll() and the async poll wakeup), together with
"when refcount goes to zero, finish the thing off and complete it" (so
that we don't care who finishes first).

No "woken" logic, no "who fired first" logic, no BS. Just make the
operations work regardless of ordering.

And maybe it can't be done. But the current model seems just so hacky
that it can't be the right model.

               Linus
