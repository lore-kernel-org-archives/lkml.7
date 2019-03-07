Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A26C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32962064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfCGRm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:42:57 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52202 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfCGRm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:42:57 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6FB1B147B05E5;
        Thu,  7 Mar 2019 09:42:56 -0800 (PST)
Date:   Thu, 07 Mar 2019 09:42:55 -0800 (PST)
Message-Id: <20190307.094255.1632492378766651810.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     benve@cisco.com, _govind@gmx.com, pkaustub@cisco.com,
        ndesaulniers@google.com, natechancellor@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] enic: fix build warning without
 CONFIG_CPUMASK_OFFSTACK
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190307155230.2923527-1-arnd@arndb.de>
References: <20190307155230.2923527-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 07 Mar 2019 09:42:56 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu,  7 Mar 2019 16:52:24 +0100

> The enic driver relies on the CONFIG_CPUMASK_OFFSTACK feature to
> dynamically allocate a struct member, but this is normally intended for
> local variables.
> 
> Building with clang, I get a warning for a few locations that check the
> address of the cpumask_var_t:
> 
> drivers/net/ethernet/cisco/enic/enic_main.c:122:22: error: address of array 'enic->msix[i].affinity_mask' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]
> 
> As far as I can tell, the code is still correct, as the truth value of
> the pointer is what we need in this configuration. To get rid of
> the warning, use cpumask_available() instead of checking the
> pointer directly.
> 
> Fixes: 322cf7e3a4e8 ("enic: assign affinity hint to interrupts")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: use cpumask_available() instead of open-coding a copy

Applied.
