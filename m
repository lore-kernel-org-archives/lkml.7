Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B36C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E72720842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfCEQqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:46:36 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40549 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfCEQqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:46:35 -0500
Received: by mail-qk1-f195.google.com with SMTP id h28so5113666qkk.7;
        Tue, 05 Mar 2019 08:46:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2nFeIVZZ0YkP5tatfiz9qqm4VERh5YEjLKrII81znkU=;
        b=T/QVGHf8qfJ2k81W5LGOzEyE1kDaAjR5uY9ux3PMoh0e+FUPT7OPDKO5rq5EregHOQ
         /SQV0JXsLDv7M5rtFUaxIkXCt6lowVgM3bCRthhdQRQRT3ZgPnBCjjmYSd2766Vhctcf
         Din4RVGDo6uHKWuqCStNZ5bmP6+HYktnVu8oL+zNfcdg32/kpX2EPVFQz0b45Hzt12FS
         WR6hRsikgIk+/c0YYsROfGow3+NOFPdZNvcJhK1NJq4Aox8LruROs9P3on6v2nYrPFb+
         iGcPfbPooQRx6HTJUZu42SHPxTIzSp/hIlMKjMhuFmt5v5RbYNcKpcIptZXAPJgzY9EE
         FGeg==
X-Gm-Message-State: APjAAAUrYcE/MI4V6lLb6R1Ex+0dRbkTGMh5fIP+ZmrwaCZH/fJ3w+FW
        dLEDTRsLVH4/dMAW5zT3dhRlSwc9fZ733YHAQSrhoA==
X-Google-Smtp-Source: APXvYqwaZpVjfN0p5nB6VQv5gsLMHhyw6pUvBkmaXP8XJVn6zIrc25tulh33B1hnEOxRiqR9BFiKCVmmmiJJy7YjfZA=
X-Received: by 2002:ae9:dec2:: with SMTP id s185mr2296406qkf.107.1551804394373;
 Tue, 05 Mar 2019 08:46:34 -0800 (PST)
MIME-Version: 1.0
References: <20190304201930.1622839-1-arnd@arndb.de> <20190304201930.1622839-2-arnd@arndb.de>
 <a94c3c6a-481e-96a5-74e1-8c3299c74129@metux.net> <CAK8P3a0vdhCTNTF-K0mXjRWkPvv0qr3nf_52=8n6zTa7p3ELLw@mail.gmail.com>
 <54a7d035-155f-c47b-1db1-acb851b3aec6@metux.net>
In-Reply-To: <54a7d035-155f-c47b-1db1-acb851b3aec6@metux.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 Mar 2019 17:46:17 +0100
Message-ID: <CAK8P3a1-AYWtNEqwb4ZMpXKDwGB_ZGLj==uBakh0+L=5g=BQQw@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86: apuv2: fix input dependencies
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linus Walleij <linusw@kernel.org>,
        Enrico Weigelt <info@metux.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 2:50 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 05.03.19 09:23, Arnd Bergmann wrote:
>
> hmm, if circular deps happen, wouldn't that mean we've got some deeper
> problems in here ? IMHO, dependencies should always form a DAG (except
> for some really rare cases).
>
> Do you recall any actual problem w/ input vs gpio vs. drivers ?
> I'd like to have a closer look at it.

Not with gpio. Most of the circular dependencies I've seen tend to
revolve around drivers/gpu/drm, which uses more 'select' statements
than most other subsystems. Those dependencies often touch
backlight, acpi, fbdev and other things then.

       Arnd
