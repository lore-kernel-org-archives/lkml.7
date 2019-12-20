Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B20C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E0F24680
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="merEjebA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfLTLFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 06:05:07 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33381 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLTLFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 06:05:07 -0500
Received: by mail-io1-f66.google.com with SMTP id z8so9000979ioh.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 03:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=gBcQ52Vc0toBPV7dKKLgxOaPG2pGefeVWpEGH1otM58=;
        b=merEjebAIqoPaUC/PNFBkpWO4eKmUGZ0ismOE/vXnE0l4fbeEDc8cJLXWdZUJkgcVz
         I4oVx9t9r987Zncz/jiwh6IYMXE/wrbw+WQrOXSrkZoGdjVaCzvUHulxSJIY3ez8c/6V
         ubwc7VcT0XpXezefnAUG4taZylsqNAtvHnw63oLsa/r6aDFpZtqBbyJy54j8wl1vVjGN
         xfcLhLUYcVmvmVeHgffNnrsry12cd3EkZyEPcFt4EWZfLg1Fc41TExJuZ6EyhA1MLVyf
         q3v9qgb1Ipx6ujF5eoFo2N4jpvaKQ6er8GBzCSZfz7WDXKTZwQNZmtiElKcxs3rtwRuX
         S/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=gBcQ52Vc0toBPV7dKKLgxOaPG2pGefeVWpEGH1otM58=;
        b=XxECy7bltKfKrIGFeMFzvYETYkgm9vkdmGp1TnIK2YuBgC7avwQ9xVqPkjLmHZ2T9l
         oO+GU1r4yhH/uqNQmm8gvuH9JMcLDBW7DJk9o+5JzeFbWuaXc5r1FYYwo2KI15bmcGEy
         YD2avF/68qOOujI5zOOTWeneHShn7BT//4rgAz41CKqDQiOtm9Luqm1092AJrW/qVaCr
         uGtZIDKZk0YKrsYpeIMFig+kk94IWYOz3zjWlkkFd6tHKDdDntG2eWDQ23qi1jnCTnSw
         X570zHYgVMFOGrKKEjmPMXUzJ4/rE4MXb5HGBwHLX+0LLqkVc8Z+z/KbVOQv08u+5/3y
         o6mA==
X-Gm-Message-State: APjAAAVY4vsok/MWbB+4gqvQ36ts3y2Uori1dgOSF9CSiEcrjyOIiw9l
        Blj61Ln+WG7zDvGBQVI/UmgvmA==
X-Google-Smtp-Source: APXvYqwl5mnguF41j8sTQFLsJ0w/8LUOCH1dsK93T2voO/9qXSqCWGgYwqdAm3/fS+DpxABS0Nds7w==
X-Received: by 2002:a6b:8f41:: with SMTP id r62mr9306222iod.140.1576839906696;
        Fri, 20 Dec 2019 03:05:06 -0800 (PST)
Received: from localhost (67-0-26-4.albq.qwest.net. [67.0.26.4])
        by smtp.gmail.com with ESMTPSA id l83sm4396947ild.34.2019.12.20.03.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 03:05:05 -0800 (PST)
Date:   Fri, 20 Dec 2019 03:05:04 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Olof Johansson <olof@lixom.net>
cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        hch@lst.de
Subject: Re: [PATCH] riscv: export flush_icache_all to modules
In-Reply-To: <20191217040704.91995-1-olof@lixom.net>
Message-ID: <alpine.DEB.2.21.9999.1912200302290.3767@viisi.sifive.com>
References: <20191217040704.91995-1-olof@lixom.net>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2019, Olof Johansson wrote:

> This is needed by LKDTM (crash dump test module), it calls
> flush_icache_range(), which on RISC-V turns into flush_icache_all(). On
> other architectures, the actual implementation is exported, so follow
> that precedence and export it here too.
> 
> Fixes build of CONFIG_LKDTM that fails with:
> ERROR: "flush_icache_all" [drivers/misc/lkdtm/lkdtm.ko] undefined!

In the past we've resisted doing this; see 

https://lore.kernel.org/linux-riscv/20190611134945.GA28532@lst.de/

under the principle that we don't want modules to be able to flush the I$ 
directly via this interface.  But maybe, like moving the L2 related code 
out of arch/riscv, we should just do it.


- Paul
