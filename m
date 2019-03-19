Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C589C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB6A2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfCSU0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:26:40 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53160 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfCSU0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:26:40 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0EAB014680288;
        Tue, 19 Mar 2019 13:26:37 -0700 (PDT)
Date:   Tue, 19 Mar 2019 13:26:34 -0700 (PDT)
Message-Id: <20190319.132634.921233603880385266.davem@davemloft.net>
To:     arnd@arndb.de
Cc:     jiri@mellanox.com, idosch@mellanox.com,
        yamada.masahiro@socionext.com, vadimp@mellanox.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlxsw: core: mlxsw: core: avoid -Wint-in-bool-context
 warning
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190318163536.2171073-1-arnd@arndb.de>
References: <20190318163536.2171073-1-arnd@arndb.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Mar 2019 13:26:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 18 Mar 2019 17:35:11 +0100

> A recently added function in mlxsw triggers a harmless compiler warning:
> 
> In file included from drivers/net/ethernet/mellanox/mlxsw/core.h:17,
>                  from drivers/net/ethernet/mellanox/mlxsw/core_env.c:7:
> drivers/net/ethernet/mellanox/mlxsw/core_env.c: In function 'mlxsw_env_module_temp_thresholds_get':
> drivers/net/ethernet/mellanox/mlxsw/reg.h:8015:45: error: '*' in boolean context, suggest '&&' instead [-Werror=int-in-bool-context]
>  #define MLXSW_REG_MTMP_TEMP_TO_MC(val) (val * 125)
>                                         ~~~~~^~~~~~
> drivers/net/ethernet/mellanox/mlxsw/core_env.c:116:8: note: in expansion of macro 'MLXSW_REG_MTMP_TEMP_TO_MC'
>    if (!MLXSW_REG_MTMP_TEMP_TO_MC(module_temp)) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The warning is normally disabled, but it would be nice to enable
> it to find real bugs, and there are no other known instances at
> the moment.
> 
> Replace the negation with a zero-comparison, which also matches
> the comment above it.
> 
> Fixes: d93c19a1d95c ("mlxsw: core: Add API for QSFP module temperature thresholds reading")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks Arnd.
