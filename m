Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC33C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 04:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264422087B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 04:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfHLEWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 00:22:25 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38482 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHLEWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 00:22:24 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3F51714522F17;
        Sun, 11 Aug 2019 21:22:23 -0700 (PDT)
Date:   Sun, 11 Aug 2019 21:22:22 -0700 (PDT)
Message-Id: <20190811.212222.1922285162572379435.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][net-next] rxrpc: fix uninitialized return value in
 variable err
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190809170259.29859-1-colin.king@canonical.com>
References: <20190809170259.29859-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 11 Aug 2019 21:22:23 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Fri,  9 Aug 2019 18:02:59 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> An earlier commit removed the setting of err to -ENOMEM so currently
> the skb_shinfo(skb)->nr_frags > 16 check returns with an uninitialized
> bogus return code.  Fix this by setting err to -ENOMEM to restore
> the original behaviour.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: b214b2d8f277 ("rxrpc: Don't use skb_cow_data() in rxkad")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

David, I assume you will pick this up.
