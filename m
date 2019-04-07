Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FA1C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 01:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA672133F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 01:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDGBSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 21:18:36 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39612 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDGBSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 21:18:36 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5F82114BC08AC;
        Sat,  6 Apr 2019 18:18:35 -0700 (PDT)
Date:   Sat, 06 Apr 2019 18:18:34 -0700 (PDT)
Message-Id: <20190406.181834.995998216821289412.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     edumazet@google.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tcp: remove redundant check on tskb
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190404144603.27682-1-colin.king@canonical.com>
References: <20190404144603.27682-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 06 Apr 2019 18:18:35 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Thu,  4 Apr 2019 15:46:03 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> The non-null check on tskb is always false because it is in an else
> path of a check on tskb and hence tskb is null in this code block.
> This is check is therefore redundant and can be removed as well
> as the label coalesc.
> 
> if (tsbk) {
>         ...
> } else {
>         ...
>         if (unlikely(!skb)) {
>                 if (tskb)       /* can never be true, redundant code */
>                         goto coalesc;
>                 return;
>         }
> }
> 
> Addresses-Coverity: ("Logically dead code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to net-next.
