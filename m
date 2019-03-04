Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB708C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA1220823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfCDVPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:15:04 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39412 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfCDVPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 16:15:02 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 859BA10713A96;
        Mon,  4 Mar 2019 13:15:00 -0800 (PST)
Date:   Mon, 04 Mar 2019 13:14:59 -0800 (PST)
Message-Id: <20190304.131459.349979845655858570.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        Yanjun.Zhu@windriver.com, xiangxia.m.yue@gmail.com,
        nicolas.dichtel@6wind.com, dsahern@gmail.com, christian@brauner.io,
        lucien.xin@gmail.com, xiyou.wangcong@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ignore sysctl_devconf_inherit_init_net without
 SYSCTL
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190304203822.2094613-1-arnd@arndb.de>
References: <20190304203822.2094613-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 04 Mar 2019 13:15:01 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon,  4 Mar 2019 21:38:03 +0100

> When CONFIG_SYSCTL is turned off, we get a link failure for
> the newly introduced tuning knob.
> 
> net/ipv6/addrconf.o: In function `addrconf_init_net':
> addrconf.c:(.text+0x31dc): undefined reference to `sysctl_devconf_inherit_init_net'
> 
> Add an IS_ENABLED() check to fall back to the default behavior
> (sysctl_devconf_inherit_init_net=0) here.
> 
> Fixes: 856c395cfa63 ("net: introduce a knob to control whether to inherit devconf config")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks Arnd.
