Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C56C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112A9229ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/UPHHu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfGXTZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:25:46 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43303 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388043AbfGXTZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:25:37 -0400
Received: by mail-lf1-f65.google.com with SMTP id c19so32727182lfm.10;
        Wed, 24 Jul 2019 12:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=62j7+wSkhUHI/uSOEbsFJlruhr6Za1QWHbaqDgoEVtQ=;
        b=D/UPHHu/fRcxCNNCrIdrC/33dxO3nj5swxlbIsELJLpjb2uo7H37kp4yGQ5uAHGGtj
         wLpgAFUMrHa1mZmTO4lu9Bh8EKH50d3EFZ7EjCX3SPIZRUaENr4lQFPThmYTI4fjVwDQ
         iUE6dcIf/SXrAt9dwzL2DSdMsaVQp4eGs87+rxz1XpaW/abr+DOHGmb+eqv6kzEl8b8O
         TZwRvz7aAnrDiwX6CHPs0ZhUq4/TzvEKUgH7dqL4Z+JGLo80HvGUBKVl3kJ0ANKU90jr
         dCL7t8ONpYxKjBd9RuQ9pEFnfomu0WBuKrBZIfDyXXLV/X5254HidEocWQ2+IbuO1ZA6
         eYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=62j7+wSkhUHI/uSOEbsFJlruhr6Za1QWHbaqDgoEVtQ=;
        b=A7kIPOXssOwQoHaO06HPM+jk9HywL73bV1z1nHwS11czdNjX0kfQwwhSSvFGhrD2l1
         2PgDs08d4Jc9XKWDnACaekbGlchVlR5TwYjgYQK/RJc2VY4ujc6UCVqMUfrFx7w9vS31
         ufpZmafIvp7baUgZIRj3UK2ZqLQYXsc3p8MqSUQObgP5ka6n0E83bE8bH8R0f1nmG0f2
         l9psNMpWK9qKzvBxWiodaaa5xixhskykOe646Cg4WK1G3gxPALlr7xco5gZ2TL8S11Zg
         nJtCiSAZiLK0uG/MdKj2Uw7Cbyn/QY/Bqt/FUjzNDKAVbj7IXdPOL7+GoY5XBApkOZfb
         COHQ==
X-Gm-Message-State: APjAAAXHRY1NXkRc6jskE3L9+GUYhJDA9d6HD4YsVJy7aTTIMe5QqJkY
        33BGJiypb45e8cpmjK7nMPc=
X-Google-Smtp-Source: APXvYqw7B3oyjIfw1cKuffGMQUDFrbiFo4davqC0Fk4UMrvpLwisAi0F3pd6A8VSflQTS2vwH4V40Q==
X-Received: by 2002:a19:6e41:: with SMTP id q1mr28989439lfk.20.1563996334490;
        Wed, 24 Jul 2019 12:25:34 -0700 (PDT)
Received: from localhost ([188.170.223.67])
        by smtp.gmail.com with ESMTPSA id k27sm8003487lfm.90.2019.07.24.12.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 12:25:33 -0700 (PDT)
Date:   Wed, 24 Jul 2019 22:25:28 +0300
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: elantech - mark expected switch fall-through
Message-ID: <20190724192528.GA6859@penguin>
References: <20190724175202.GA9583@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724175202.GA9583@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Wed, Jul 24, 2019 at 12:52:02PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/input/mouse/elantech.c: In function 'elantech_use_host_notify':
> drivers/input/mouse/elantech.c:1843:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (dmi_get_bios_year() >= 2018)
>       ^
> drivers/input/mouse/elantech.c:1845:2: note: here
>   default:
>   ^~~~~~~

Thank you for the patch but I already pushed out similar patch.

Thanks.

-- 
Dmitry
