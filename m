Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32C9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8353F20872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="y+4AuosQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfCRUFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:05:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44514 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfCRUFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:05:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id w2so18483235wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 13:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=63ZZZwu9uLaplGIIKqCDHTdurLG+7JXN6NksHNfhzj0=;
        b=y+4AuosQMkAJM4iIRv5ocREDpxI1H8nYo9b26D5l9TyFECr3vyXxZI9f4jVJUPBJrL
         PP2RpWIOTiceyg4lx+4fWHW5ZC6TrUopM4m9KSa9oOR+Js02dHwux0ZIEimA1GjPtKRC
         R9TW1n2K+/ipvxO7J8kAwZPgViA6W4xO2r66+xxZxWDxuSTQ+ewAd7hO4UTdM8m5fGJz
         YOGs5mdXV5figGi28MWJnd5lyZz5/tQG2XKho4tEZIwMMYooSy/O9qkvj6Mu5gxwELLX
         1k8QfcFRT1a2N8mDZVZuejaSj4RCcL2nRqmPfj4pIsHwj48nvJSEMXS7k9qFW51tMvsu
         PRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=63ZZZwu9uLaplGIIKqCDHTdurLG+7JXN6NksHNfhzj0=;
        b=GIp4Rvabz5EtfknOAubx9+RKJr1WKl3ZfZMzlXpWHA0OxIP/XYJD5v3d7s83qwOnax
         aqfuyBsa4fMyS005ilBIPrfZ0QDa0Gn0VSfImUgQr9Ms/0YDCnjtLHEf9WJXCX/miBqz
         q0/cO+vZNKM57V4V3NLgNDmaeQQdqtZvuj6x+nyrThkzVPoH5aIrGAkYGdaoBG1vsVZA
         j6B13Rhb/MK6V7mIOKyp7xtloq2h69pJByLrnnCdsUE4R2Z3IanXsTtHVfy3VbrKmVkS
         O236aDLU0JrK8WujQH75bRkr4nK/jmZe6GlQBG2L8IbvIPn+SZwtFLXJyKOlom7rit7X
         8Ijw==
X-Gm-Message-State: APjAAAW+C526O8nZOyMzhi1jTKlk6/+rvzYc4CDgGN3rK7t1UJ4R4tMH
        Xx1nMZcVj1TUSgObTryX8CKJ7Q==
X-Google-Smtp-Source: APXvYqzjvCtAkxKoXuP2rsyyqcpjOlICedUyeiEWnhx2gNWGZBp4yrv7ieqB+2+EY6o7pnCzvoM79Q==
X-Received: by 2002:a05:6000:104b:: with SMTP id c11mr14475430wrx.9.1552939519917;
        Mon, 18 Mar 2019 13:05:19 -0700 (PDT)
Received: from localhost (ip-94-113-125-71.net.upcbroadband.cz. [94.113.125.71])
        by smtp.gmail.com with ESMTPSA id b4sm414735wmj.3.2019.03.18.13.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 13:05:19 -0700 (PDT)
Date:   Mon, 18 Mar 2019 21:05:19 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vadim Pasternak <vadimp@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlxsw: core: mlxsw: core: avoid -Wint-in-bool-context
 warning
Message-ID: <20190318200519.GN2270@nanopsycho>
References: <20190318163536.2171073-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318163536.2171073-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Mar 18, 2019 at 05:35:11PM CET, arnd@arndb.de wrote:
>A recently added function in mlxsw triggers a harmless compiler warning:
>
>In file included from drivers/net/ethernet/mellanox/mlxsw/core.h:17,
>                 from drivers/net/ethernet/mellanox/mlxsw/core_env.c:7:
>drivers/net/ethernet/mellanox/mlxsw/core_env.c: In function 'mlxsw_env_module_temp_thresholds_get':
>drivers/net/ethernet/mellanox/mlxsw/reg.h:8015:45: error: '*' in boolean context, suggest '&&' instead [-Werror=int-in-bool-context]
> #define MLXSW_REG_MTMP_TEMP_TO_MC(val) (val * 125)
>                                        ~~~~~^~~~~~
>drivers/net/ethernet/mellanox/mlxsw/core_env.c:116:8: note: in expansion of macro 'MLXSW_REG_MTMP_TEMP_TO_MC'
>   if (!MLXSW_REG_MTMP_TEMP_TO_MC(module_temp)) {
>        ^~~~~~~~~~~~~~~~~~~~~~~~~
>
>The warning is normally disabled, but it would be nice to enable
>it to find real bugs, and there are no other known instances at
>the moment.
>
>Replace the negation with a zero-comparison, which also matches
>the comment above it.
>
>Fixes: d93c19a1d95c ("mlxsw: core: Add API for QSFP module temperature thresholds reading")
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Jiri Pirko <jiri@mellanox.com>
