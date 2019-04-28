Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C52C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 17:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECE52054F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 17:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7uhXqUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfD1R7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 13:59:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42703 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfD1R7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 13:59:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id x15so3984900pln.9;
        Sun, 28 Apr 2019 10:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cigPqpv3EbqRHveB6bMukXbNAdYdoNI2R+pRgqg/pak=;
        b=V7uhXqUEI2VtmyWshqsswwdT4xcBODxImnK+G5AEQU2F8Xo5/AeJJ04NbdpSF3+ETf
         zFEAiQEg0eWaNharc3qkRz4syjtRsyC82yilvcvKzcGLpRm2FcoKG3j74KVtxj7yR1s0
         Xo9E8dhnwqeeiZswzro3T1juoqzIrzlD1K1JXEaP2vP5Cp6nD08BMJgaT8KJ2Q5sXu7c
         ncXVgqYHbKKjTA4qVgYqqSduDqk1kt2Mko9pmpDW8oy/J1KhvaoQP3jMAKStOlibpDFN
         KO0bJsWTQ4IhFslJ6G/0nx2nO0meAbt3cVoOCv/XIBdFRgJHvW+7z5qDaDoxkasBNpDw
         ZxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cigPqpv3EbqRHveB6bMukXbNAdYdoNI2R+pRgqg/pak=;
        b=ezr1JRg5cqiGCm70udyLo8LnoYcK5qRWKNcEXeBudPX2wbflw23DR15QHIdr0urVkg
         BoHGb3nE+8JkBAuyhbfOnEt0MApfrgebKCgeIjTSyWHwiZ//nfomGbqtx1gqsmAU9Oxr
         GMPurnG/qxG0rY+361/h0E243SvIFNhidKtMjvGqlKnlcfaRBhEazcbU/2+UhLfRRdfS
         JRqKxfFPYNYJNFqLS8PKbrwcF6ofc/FBh4yaRi9MGb7XihndjWvRlYgA7YX2RrwfsVpH
         60ZavyHJL9MneQQSu2oK8bAoLdeiL2TU+FxFwexRvKpjJk1yd4O83dw1qFGWRuMmKPxV
         GV2w==
X-Gm-Message-State: APjAAAWTlq+/ycd74QKbo/j6oOlfEMe0Bz4eOQ7FoyN+wZA7Ua5O2m5N
        5qBQ1/VTYkB/FIcv1nrDS0GNyGTRkFcvYGpGsQbsZ73H
X-Google-Smtp-Source: APXvYqxSnfcqMHGbUgq9eeNwxyyP0WpeR9+ljgpYdmRsTp8BAxBVA27MwZfOjadrgpKr6Tukjxq6NfXSGTqnMK6T7sM=
X-Received: by 2002:a17:902:9b8d:: with SMTP id y13mr3478970plp.70.1556474387663;
 Sun, 28 Apr 2019 10:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <71250616-36c1-0d96-8fac-4aaaae6a28d4@redhat.com>
 <20190428030539.17776-1-yuehaibing@huawei.com> <516ba6e4-359b-15d0-e169-d8cc1e989a4a@redhat.com>
 <2c823bbf-28c4-b43d-52d9-b0e0356f03ae@redhat.com> <6AADFAC011213A4C87B956458587ADB4021F7531@dggeml532-mbs.china.huawei.com>
 <b33ce1f9-3d65-2d05-648b-f5a6cfbd59ab@redhat.com>
In-Reply-To: <b33ce1f9-3d65-2d05-648b-f5a6cfbd59ab@redhat.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Sun, 28 Apr 2019 10:59:36 -0700
Message-ID: <CAM_iQpUfpruaFowbiTOY7aH4Ts-xcY4JACGLOT3CUjLqpg_zXw@mail.gmail.com>
Subject: Re: [PATCH] tun: Fix use-after-free in tun_net_xmit
To:     Jason Wang <jasowang@redhat.com>
Cc:     "weiyongjun (A)" <weiyongjun1@huawei.com>,
        yuehaibing <yuehaibing@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "brouer@redhat.com" <brouer@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "lirongqing@baidu.com" <lirongqing@baidu.com>,
        "nicolas.dichtel@6wind.com" <nicolas.dichtel@6wind.com>,
        "3chas3@gmail.com" <3chas3@gmail.com>,
        "wangli39@baidu.com" <wangli39@baidu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2019 at 12:51 AM Jason Wang <jasowang@redhat.com> wrote:
> > tun_net_xmit() doesn't have the chance to
> > access the change because it holding the rcu_read_lock().
>
>
> The problem is the following codes:
>
>
>          --tun->numqueues;
>
>          ...
>
>          synchronize_net();
>
> We need make sure the decrement of tun->numqueues be visible to readers
> after synchronize_net(). And in tun_net_xmit():

It doesn't matter at all. Readers are okay to read it even they still use the
stale tun->numqueues, as long as the tfile is not freed readers can read
whatever they want...

The decrement of tun->numqueues is just how we unpublish the old
tfile, it is still valid for readers to read it _after_ unpublish, we only need
to worry about free, not about unpublish. This is the whole spirit of RCU.

You need to rethink about my SOCK_RCU_FREE patch.

Thanks.
