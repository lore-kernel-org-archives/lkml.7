Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42C0C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02AE2063F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfCFSrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:47:17 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39108 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfCFSrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:47:16 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 351321400EF14;
        Wed,  6 Mar 2019 10:47:16 -0800 (PST)
Date:   Wed, 06 Mar 2019 10:47:15 -0800 (PST)
Message-Id: <20190306.104715.777357136943937872.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     netdev@vger.kernel.org, yuehaibing@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] appletalk: Fix compile regression
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190306105249.2165038-1-arnd@arndb.de>
References: <20190306105249.2165038-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 06 Mar 2019 10:47:16 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed,  6 Mar 2019 11:52:36 +0100

> A bugfix just broke compilation of appletalk when CONFIG_SYSCTL
> is disabled:
> 
> In file included from net/appletalk/ddp.c:65:
> net/appletalk/ddp.c: In function 'atalk_init':
> include/linux/atalk.h:164:34: error: expected expression before 'do'
>  #define atalk_register_sysctl()  do { } while(0)
>                                   ^~
> net/appletalk/ddp.c:1934:7: note: in expansion of macro 'atalk_register_sysctl'
>   rc = atalk_register_sysctl();
> 
> This is easier to avoid by using conventional inline functions
> as stubs rather than macros. The header already has inline
> functions for other purposes, so I'm changing over all the
> macros for consistency.
> 
> Fixes: 6377f787aeb9 ("appletalk: Fix use-after-free in atalk_proc_exit")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
