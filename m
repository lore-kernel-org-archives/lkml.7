Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E407AC282E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F3A205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcYnCzeD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfDSU1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:27:22 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41926 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbfDSU1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:27:22 -0400
Received: by mail-pl1-f194.google.com with SMTP id d1so3043889plj.8;
        Fri, 19 Apr 2019 13:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZJa9DDteyNFYDeRtsgsDX/MNzkgWGaFxN9Xza+wbv0o=;
        b=NcYnCzeDxnv+ZFSOT9Da7hQdlgkG8b7xwWuxDRppRbVWqJFEmuKkHdd82OiiCLJOOY
         x3a7ONMf+Dq6EUy32yIgy7zd9f16SczxL1MCwJRXA2BP1GH7qENyuJEWk4ToWuFApaUK
         DI+Js7bpY4nvkXTTLg50S0/NclupX16Zb4F8e6hcCyiUQtZpops47H1y+pU9/H2nUph8
         chCbexEiZuxb90vH+N8oLQAjtvKqDvP9ts99yqHCn08HOypa5pt0sc8RxpKkLyzffBj9
         lwegzrgXY7KtUOLQycKXXUB6jaolIj0WCNywlxJsXcaabhJVNrXYm3Ci73bw7nwXz17+
         MCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZJa9DDteyNFYDeRtsgsDX/MNzkgWGaFxN9Xza+wbv0o=;
        b=UdX9MF5ysaby7YFdW15mPfD5NznKB4c8FTZrQUi5I5gRinUrdKMPRuLt/CgrHslVYs
         X0YtIaV9Ivh/p9zedo/gH+r1N7RtA4d0TLFdE597WmB9tfLbfJpbdxtSoxBM3aM8r8LE
         O1n6l97FxVmhr/+dhL5DjtfSSod2vOufTjV6DG2HV/I9/WHTtta+RxshGkilvevGsel1
         +LSDZT9Zoeouv+X1gJswm9MAIKj4WvnL50slonUL7quraXNwj9+hK0AY56n7JAyiuWse
         xnWRIycwG4qo9CZlkbDbxKeE0e8s8GXWLXRPwDG0y0tbWVdYalWlu1jfU/XlICsM3KNZ
         XWQA==
X-Gm-Message-State: APjAAAW8H/64rWbKKeINW3HuQ5IJ2jdkyl9YPOEkR/FRz56ct+z382tg
        5xCOMD/++6FNuEdUBdv4TdlMRZtTY8Y=
X-Google-Smtp-Source: APXvYqztdjD0Z6AzehC+nI2YgwZiAumg5bZPfqipPvy4BsRN8AV9QNaRX4Yf+OP3oml2HNChO83Wug==
X-Received: by 2002:a17:902:e508:: with SMTP id ck8mr2335018plb.96.1555660101314;
        Fri, 19 Apr 2019 00:48:21 -0700 (PDT)
Received: from localhost ([61.199.190.18])
        by smtp.gmail.com with ESMTPSA id e1sm5129503pfn.187.2019.04.19.00.48.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 00:48:20 -0700 (PDT)
Date:   Fri, 19 Apr 2019 07:48:11 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 3/4] input: keyboard: gpio_keys_polled: use gpio lookup
 table
Message-ID: <20190419074811.7rkq3p6t7s56g4fo@penguin>
References: <1555444645-15156-1-git-send-email-info@metux.net>
 <1555444645-15156-4-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555444645-15156-4-git-send-email-info@metux.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,

On Tue, Apr 16, 2019 at 09:57:24PM +0200, Enrico Weigelt, metux IT consult wrote:
> Support the recently introduced gpio lookup tables for
> attaching to gpio lines. So, harcoded gpio numbers aren't
> needed anymore.

I would prefer if gpiod API could parse static board data/gpio lookup
tables for child nodes, instead of adding this to gpio-keys. Now that
Heikki Krogerus work on software nodes has landed I need to resurrect
my patch to gpiolib.

Thanks.

-- 
Dmitry
