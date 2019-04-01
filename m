Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B6AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFF12192C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbfDARNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:13:09 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:32950 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730470AbfDARNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:13:06 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5E80B14B8AF60;
        Mon,  1 Apr 2019 10:13:06 -0700 (PDT)
Date:   Mon, 01 Apr 2019 10:12:34 -0700 (PDT)
Message-Id: <20190401.101234.1259757550586433319.davem@davemloft.net>
To:     edumazet@google.com
Cc:     dust.li@linux.alibaba.com, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, caspar@linux.alibaba.com
Subject: Re: [PATCH] tcp: fix a potential NULL pointer dereference in
 tcp_sk_exit
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CANn89iLAHD1Jkk4xeKUk89s7FPVaBdE5AHu3zNdBZNMn8w8mBw@mail.gmail.com>
References: <20190401080453.87465-1-dust.li@linux.alibaba.com>
        <CANn89iLAHD1Jkk4xeKUk89s7FPVaBdE5AHu3zNdBZNMn8w8mBw@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Apr 2019 10:13:06 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>
Date: Mon, 1 Apr 2019 02:23:39 -0700

> On Mon, Apr 1, 2019 at 1:05 AM dust.li <dust.li@linux.alibaba.com> wrote:
>>
>> From: Dust Li <dust.li@linux.alibaba.com>
>>
>>  When tcp_sk_init() failed in inet_ctl_sock_create(),
>>  'net->ipv4.tcp_congestion_control' will be left
>>  uninitialized, but tcp_sk_exit() hasn't check for
>>  that.
>>
>>  This patch add checking on 'net->ipv4.tcp_congestion_control'
>>  in tcp_sk_exit() to prevent NULL-ptr dereference.
>>
>> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
> 
> Fixes: 6670e1524477 ("tcp: Namespace-ify sysctl_tcp_default_congestion_control")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

This patch didn't make it to the list for whatever reason, but I applied it and
have it queued up for -stable.

Thanks.
