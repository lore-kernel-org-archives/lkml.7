Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E213DC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA774217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389911AbfDRS4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:56:41 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44386 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfDRS4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:56:41 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 44BD614877C17;
        Thu, 18 Apr 2019 11:56:40 -0700 (PDT)
Date:   Thu, 18 Apr 2019 11:56:39 -0700 (PDT)
Message-Id: <20190418.115639.4353812313618266.davem@davemloft.net>
To:     eric.dumazet@gmail.com
Cc:     aryabinin@virtuozzo.com, edumazet@google.com,
        mgorman@techsingularity.net, willemb@google.com, fw@strlen.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/4] net/skbuff: don't waste memory reserves
From:   David Miller <davem@davemloft.net>
In-Reply-To: <791f4f23-d931-4ac8-4e60-3ffe46c4ece2@gmail.com>
References: <20190418180524.23489-1-aryabinin@virtuozzo.com>
        <791f4f23-d931-4ac8-4e60-3ffe46c4ece2@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 18 Apr 2019 11:56:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 18 Apr 2019 11:55:16 -0700

> AFAIK, drivers allocate skbs way before a frame is actually received,
> (at RX ring buffer initialization or refill)
> 
> So sk_memalloc_socks() might be false at that time, but true later.

This is exactly what I was going to say too.
