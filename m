Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A279BC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A31D21848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405459AbfHVW5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 18:57:44 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:50114 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405430AbfHVW5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 18:57:43 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A12AB153952E3;
        Thu, 22 Aug 2019 15:57:42 -0700 (PDT)
Date:   Thu, 22 Aug 2019 15:57:42 -0700 (PDT)
Message-Id: <20190822.155742.2103304070969355809.davem@davemloft.net>
To:     liudongxu3@huawei.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: Add the same IP detection for duplicate address.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190821032000.10540-1-liudongxu3@huawei.com>
References: <20190821032000.10540-1-liudongxu3@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 22 Aug 2019 15:57:42 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongxu Liu <liudongxu3@huawei.com>
Date: Wed, 21 Aug 2019 11:20:00 +0800

> The network sends an ARP REQUEST packet to determine
> whether there is a host with the same IP.
> Windows and some other hosts may send the source IP
> address instead of 0.
> When IN_DEV_ORCONF(in_dev, DROP_GRATUITOUS_ARP) is enable,
> the REQUEST will be dropped.
> When IN_DEV_ORCONF(in_dev, DROP_GRATUITOUS_ARP) is disable,
> The case should be added to the IP conflict handling process.
> 
> Signed-off-by: Dongxu Liu <liudongxu3@huawei.com>

Even documents like RFC 5227 talk about there being a zero source
protocol address here (read the last two paragraphis of section
1.2. "relationship to 826"):

====================
An ARP Probe with an all-zero 'sender IP address' may ostensibly be
merely asking an innocent question ("Is anyone using this
address?"), but an intelligent implementation that knows how IPv4
Address Conflict Detection works should be able to recognize this
question as the precursor to claiming the address.
====================

I do not understand why we have to add a special case for an
implementation that has decided, after so many decades of our existing
behavior, to put something of than zero in the source protocol
address.

I'm not applying this, I do not see a legitimate justification for
this change at all.

Sorry.
