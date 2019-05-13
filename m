Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A51EC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 03:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6303E20879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 03:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfEMDRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 23:17:02 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60130 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfEMDRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 23:17:02 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8EF5E14D85C45;
        Sun, 12 May 2019 20:17:01 -0700 (PDT)
Date:   Sun, 12 May 2019 20:17:01 -0700 (PDT)
Message-Id: <20190512.201701.1918995863082655897.davem@davemloft.net>
To:     jgg@mellanox.com
Cc:     torvalds@linux-foundation.org, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: Annoying gcc / rdma / networking warnings
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190513011131.GA7948@mellanox.com>
References: <CAHk-=whbuwm5FbkPSfftZ3oHMWw43ZNFXqvW1b6KFMEj5wBipA@mail.gmail.com>
        <20190513011131.GA7948@mellanox.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 12 May 2019 20:17:01 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>
Date: Mon, 13 May 2019 01:11:42 +0000

> I think the specific sockaddr types should only ever be used if we
> *know* the sa_family is that type. If the sa_family is not known then
> it should be sockaddr or sockaddr_storage. Otherwise things get very
> confusing.
> 
> When using sockaddr_storage code always has the cast to sockaddr
> anyhow, as it is not a union, so this jaunty cast is not out of place
> in sockets code.

From what I can see, each and every call side of these helpers like
rdma_gid2ip() et al. redefine this union type over and over and over
again in the local function.

That's the real problem.

It seems that if we just defined it explicitly in one place, like
include/rdma/ib_addr.h, then we could have tdma_gid2ip(), addr_resolve(),
and rdma_resolve_ip() take that type explcitily.

No?
