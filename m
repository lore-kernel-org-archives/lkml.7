Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAB1C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052A6206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NUMqYmFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfFTRf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:35:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33129 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFTRf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:35:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so2077298pfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y//CKAUCmu4Z+CNgNicaVzKkv82IaCbCxrJa7F0wZn4=;
        b=NUMqYmFwkS8LkBdwNC20JWMzkawUchAYdEs+GIDQku+8JYDBs4GvrjFoeC5g9ptLB5
         6iDEHv//HyfEmC5eWmq/MRx0SWCEZ5mvOkbHQvhTphicSrniBya/z8l+GY/YvzCKxgYy
         4uSTgSW5ItQ0Slt9KpB8W7gwtPv0WmGfiEtOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y//CKAUCmu4Z+CNgNicaVzKkv82IaCbCxrJa7F0wZn4=;
        b=Depxvq95u3/O5BV6VZKuMIz1pBiIq5osRsZrWi0jkWqEnyWlClwWlM1+4YVgmpGNsD
         zxKmbn2QtQSl5H33BJMvww063ZJwSrDIUh2URBrU5SzkSO1shUKjOp+i0WqYQJrQTesD
         c1O6hZLEWkuc/K0EEmS+VV2c8RHEwkcjcS+5+XA/NeYh28tbES1hsu02uqD16QKhe0Li
         YWJuQJXjS1cTn3Rt0Bwro+Y9Jye/MmzEUwcnMs2CtOPbiLF03ywzIWfKZ4BfueVxRTls
         OFmyb+VF1iFTDborlVEFWwaKrpHvL/ZaNwAuzghmtPivlNY/cg3baA6ZxRtvuXTPay/M
         Ghpw==
X-Gm-Message-State: APjAAAX3pqSp/ckpfRde1z7boj7uLoOYHiTJKcpkQRwzUVA7/+1M3h2j
        /mBi/VP1KPOyzSAR64jAnsepxT6yEEo=
X-Google-Smtp-Source: APXvYqxiL8EXgij8EVUiiz93r2xVAl4pTaySQemAPFQP6yna6EQozFcR2qsIBQ9qPplMpsgaKHVBCg==
X-Received: by 2002:aa7:8083:: with SMTP id v3mr54261815pff.69.1561052158492;
        Thu, 20 Jun 2019 10:35:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 128sm89983pfd.66.2019.06.20.10.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 10:35:57 -0700 (PDT)
Date:   Thu, 20 Jun 2019 10:35:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] structleak: disable BYREF_ALL in combination with
 KASAN_STACK
Message-ID: <201906201034.9E44D8A2A8@keescook>
References: <20190618094731.3677294-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618094731.3677294-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 11:47:13AM +0200, Arnd Bergmann wrote:
> The combination of KASAN_STACK and GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
> leads to much larger kernel stack usage, as seen from the warnings
> about functions that now exceed the 2048 byte limit:

Is the preference that this go into v5.2 (there's not much time left),
or should this be v5.3? (You didn't mark it as Cc: stable?)

> one. I picked the dependency in GCC_PLUGIN_STRUCTLEAK_BYREF_ALL, as
> this option is designed to make uninitialized stack usage less harmful
> when enabled on its own, but it also prevents KASAN from detecting those
> cases in which it was in fact needed.

Right -- there's not much sense in both being enabled. I'd agree with
this rationale.

-- 
Kees Cook
