Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD24C742D1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CB4204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDMKme+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfGLRjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 13:39:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54760 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfGLRjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 13:39:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so9630970wme.4;
        Fri, 12 Jul 2019 10:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HVK6msgsGJnoGkWkZSEGcmqkYH7ZezIUmPb0VYKKhC8=;
        b=YDMKme+uIxGp66/wwY/EplhFxPQr/t4DYX0MgTS1iwGFTUYTuH9IPIIscAa4Y49DFn
         xs0xsYa9MiPtOazvV5Vm55mtSLN1n1uXfZHOm251IXGXvrFDVmjrrF703hHkppChUuCb
         ut47oyWLOt2h14yHSXbvy8TzgciLeMaX/Bnk/LbXupP4A1wNo9Gc77v3R8ezvmBGCyNA
         QRs2Ga7xhLQAMb0e5YdR51V5U1HoRMh8sI1cFbBCCrPq/lWBVZOWLNaqBaXme1cycf6j
         9hlY0J6oNMqbZGRrV647Did2RmJ6mfaWNK5eag+9rq5OkBQN6EHm/2fA0ZiOnmCv9o2X
         BjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HVK6msgsGJnoGkWkZSEGcmqkYH7ZezIUmPb0VYKKhC8=;
        b=cTQlAR0YPHmzO+uTjQ8xfZiv1YJRTgCd3m+gpLckYtjumh8g5SHrgmXXGbnGNXYh9I
         n2386aXAp2NdRBK5eQDeF4JVYsqA0N5secXqUnhy1yJCwLsx5m5H03i3G+Of8trdewu9
         l8kYHTWtgfYMaqXvG0pJQ7HeKVUxLZq+yFq/l19so64ZU3E48o1WuOAd1Oou8a+XNb2D
         e1LKNp7IdVrhUbKRp/LOLvbYPxYtYmsp4T8/8wvaw6oN+2aVBS5QCUdF7Uxweiwplu+f
         EGYJpLuq/mMR7t9FWItlR+QFbf2wyFz+8rOz8/p8W7HJghkYQc7Dy3oURAQhis5tpwOS
         H5DA==
X-Gm-Message-State: APjAAAXGAI5NZsIFZe7EpDjFqKxrjd/Kyyp33cqlJrDw7LfAhfmWVB2R
        2JwZgMgtg9IFnIiZGiyFciw=
X-Google-Smtp-Source: APXvYqyI3efZEXBVC3rLAHfRJtLgBtlDWsCsQ2i98qK4Rh68IgPXHBx/4Z1VX0O6Ypffde530ZrROw==
X-Received: by 2002:a1c:6a0e:: with SMTP id f14mr11253843wmc.154.1562953154626;
        Fri, 12 Jul 2019 10:39:14 -0700 (PDT)
Received: from archlinux-threadripper ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id c3sm9887021wrx.19.2019.07.12.10.39.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 10:39:13 -0700 (PDT)
Date:   Fri, 12 Jul 2019 10:39:12 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] dma: ste_dma40: fix unneeded variable warning
Message-ID: <20190712173912.GA127917@archlinux-threadripper>
References: <20190712091357.744515-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712091357.744515-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 11:13:30AM +0200, Arnd Bergmann wrote:
> clang-9 points out that there are two variables that depending on the
> configuration may only be used in an ARRAY_SIZE() expression but not
> referenced:
> 
> drivers/dma/ste_dma40.c:145:12: error: variable 'd40_backup_regs' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> static u32 d40_backup_regs[] = {
>            ^
> drivers/dma/ste_dma40.c:214:12: error: variable 'd40_backup_regs_chan' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
> static u32 d40_backup_regs_chan[] = {
> 
> Mark these __maybe_unused to shut up the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Might be worth mentioning that this warning will only appear when
CONFIG_PM is unset (they are both used in d40_save_restore_registers).

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
