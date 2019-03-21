Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD97C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A9C218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfCUU6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:58:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53214 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfCUU6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:58:15 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D1C7D133E9775;
        Thu, 21 Mar 2019 13:58:14 -0700 (PDT)
Date:   Thu, 21 Mar 2019 13:58:14 -0700 (PDT)
Message-Id: <20190321.135814.680505348166965154.davem@davemloft.net>
To:     herbert@gondor.apana.org.au
Cc:     joshhunt00@gmail.com, jelsasser@appneta.com, tgraf@suug.ch,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v3 PATCH] rhashtable: Still do rehash when we get EEXIST
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190321013952.3quw6bsqptyngzo5@gondor.apana.org.au>
References: <A247F887-832E-44AD-AC41-C22E124E44EE@appneta.com>
        <CAKA=qzY4Pzee9BVzRCciW32toeHSz7t0q9LuvQXKLG2fX9fBbg@mail.gmail.com>
        <20190321013952.3quw6bsqptyngzo5@gondor.apana.org.au>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Mar 2019 13:58:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 21 Mar 2019 09:39:52 +0800

> As it stands if a shrink is delayed because of an outstanding
> rehash, we will go into a rescheduling loop without ever doing
> the rehash.
> 
> This patch fixes this by still carrying out the rehash and then
> rescheduling so that we can shrink after the completion of the
> rehash should it still be necessary.
> 
> The return value of EEXIST captures this case and other cases
> (e.g., another thread expanded/rehashed the table at the same
> time) where we should still proceed with the rehash.
> 
> Fixes: da20420f83ea ("rhashtable: Add nested tables")
> Reported-by: Josh Elsasser <jelsasser@appneta.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Applied and queued up for -stable, thanks Herbert.
