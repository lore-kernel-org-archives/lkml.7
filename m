Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532D2C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19087206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 21:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbfG3Vmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 17:42:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55724 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfG3Vmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 17:42:36 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A68DC14E7A6C2;
        Tue, 30 Jul 2019 14:42:35 -0700 (PDT)
Date:   Tue, 30 Jul 2019 14:42:35 -0700 (PDT)
Message-Id: <20190730.144235.188879655867188705.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, g.nault@alphalink.fr,
        mostrows@earthlink.net, xeb@mail.ru, jchapman@katalix.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH v5 09/29] compat_ioctl: pppoe: fix PPPOEIOCSFWD handling
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190730192552.4014288-10-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
        <20190730192552.4014288-10-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 30 Jul 2019 14:42:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 30 Jul 2019 21:25:20 +0200

> Support for handling the PPPOEIOCSFWD ioctl in compat mode was added in
> linux-2.5.69 along with hundreds of other commands, but was always broken
> sincen only the structure is compatible, but the command number is not,
> due to the size being sizeof(size_t), or at first sizeof(sizeof((struct
> sockaddr_pppox)), which is different on 64-bit architectures.
> 
> Guillaume Nault adds:
> 
>   And the implementation was broken until 2016 (see 29e73269aa4d ("pppoe:
>   fix reference counting in PPPoE proxy")), and nobody ever noticed. I
>   should probably have removed this ioctl entirely instead of fixing it.
>   Clearly, it has never been used.
> 
> Fix it by adding a compat_ioctl handler for all pppoe variants that
> translates the command number and then calls the regular ioctl function.
> 
> All other ioctl commands handled by pppoe are compatible between 32-bit
> and 64-bit, and require compat_ptr() conversion.
> 
> This should apply to all stable kernels.
> 
> Acked-by: Guillaume Nault <g.nault@alphalink.fr>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied and queued up for -stable, thanks everyone.
