Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1B0C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A253222C3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 23:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="LoYd6qXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgABXnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 18:43:11 -0500
Received: from mail.toke.dk ([45.145.95.4]:47027 "EHLO mail.toke.dk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgABXnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 18:43:07 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jan 2020 18:43:06 EST
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1578008042; bh=n+/Z2y8RBVuqOI4GbqxFKUrx0mw1L0vQ5v5oMAmp7p4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LoYd6qXDE5xAkgF2bwCD0T2jgTeox5j6DXM1M6YwSyyiIgC4s339InEiSQ+Ii9jEw
         E/03m4wW582/wfubbb5xghNEIY440TWkImjxPtKQrS6bPV43ssXEJz79HyoCtFA0WK
         jlfLzgl6Z20tN8ZdeNSgcyZ1/x6xf7f3uIaaVXk3NEZusaBYY0md3LnksEl/c9zV70
         i/XJP7w99sQRz/7o9Yh13kZtpl3ESq50+BRdyRlwZ71fN7M7Lk0O8hfCnNSWVjXgxm
         47uMNKSNCrYZujafjMO1cDRwfakGV3N9FBOiYwzlyQDfk4vxrFT8wJb2goOueaRRPk
         /3EEhSnY9xDCg==
To:     Wen Yang <wenyang@linux.alibaba.com>
Cc:     Wen Yang <wenyang@linux.alibaba.com>,
        Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        cake@lists.bufferbloat.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sch_cake: avoid possible divide by zero in cake_enqueue()
In-Reply-To: <20200102092143.8971-1-wenyang@linux.alibaba.com>
References: <20200102092143.8971-1-wenyang@linux.alibaba.com>
Date:   Fri, 03 Jan 2020 00:34:01 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ftgxl9g6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wen Yang <wenyang@linux.alibaba.com> writes:

> The variables 'window_interval' is u64 and do_div()
> truncates it to 32 bits, which means it can test
> non-zero and be truncated to zero for division.
> The unit of window_interval is nanoseconds,
> so its lower 32-bit is relatively easy to exceed.
> Fix this issue by using div64_u64() instead.
>
> Fixes: 7298de9cd725 ("sch_cake: Add ingress mode")
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: Kevin Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: cake@lists.bufferbloat.net
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
