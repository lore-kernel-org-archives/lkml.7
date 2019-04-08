Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70250C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3917821473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O1nKyhbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfDHPFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:05:39 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40516 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfDHPFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:05:39 -0400
Received: by mail-vs1-f68.google.com with SMTP id f22so7797161vso.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 08:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZiduu5sc9tcqdSWfryyiqTG8OwyOaOXxZnxCgv42Xc=;
        b=O1nKyhbq7EeYe3i8YJQ+qYMh6MvxDG34lCLSma+lXXO/4TI8TR66JJUigjVagFtxQp
         KW2+WRJX5FcQcZ+YuKer4WRLW3Mk04V6nWJ8ooHoixHThGtezfX/fXUpVjX2UFM+RRO4
         /nrv84VvNQC9ljqYAXIDyGESqQbzjcpUUNGvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZiduu5sc9tcqdSWfryyiqTG8OwyOaOXxZnxCgv42Xc=;
        b=cv1SiVBRBSbzFhjSw4ZlmMiL+TLaLnQQtLm1IIzwKyQtOFci2KfCUIonx+vcmE6Y+5
         pYh14R5PejKeECkiaHHkYlKWCgr61Du1+Ag6xk9kAjWffqduRq65pSsJ9uTzu+jZK10B
         tIg+8QQJRpKq2KYzYopYog6CBVg9hd8rr23AaRUtMJacP3qt8X60TraLkdbktsUZLP3f
         h+kTu2ZKXFmyOYaY91US2GSibPS0NhpEV83o6DS7OfSrAm+CHTqaM8KTwBlzq2/ib+5R
         ZmjvcrRsfvhA7yHRpLrSaXXWRZDNlkm/7/48H28wIfy7RncoeTqYsGO/jZ/ZU9xakddK
         nAyQ==
X-Gm-Message-State: APjAAAVJWNqL6z40vQyCTDxHTfVjlgFIxiONsEQaRF/fpfomaiZWd5MR
        pal2qOlNF37aGH8nCJMwFMdUqKwyBhQ=
X-Google-Smtp-Source: APXvYqxAZI2ZEQ170yLOq5lkal4U4lk/6VCndrH6CEAUmOsxtZPTPjX75cA83t6Zo7+12XgXja70Ew==
X-Received: by 2002:a67:e2cc:: with SMTP id i12mr16490993vsm.17.1554735938164;
        Mon, 08 Apr 2019 08:05:38 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id z127sm10534302vsc.5.2019.04.08.08.05.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:05:37 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id a190so827230vsd.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 08:05:37 -0700 (PDT)
X-Received: by 2002:a67:7e12:: with SMTP id z18mr17726475vsc.82.1554735560480;
 Mon, 08 Apr 2019 07:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190405015859.32755-1-tobin@kernel.org> <3d1bc44f-313b-5a58-3492-b706d9510d34@kernel.org>
In-Reply-To: <3d1bc44f-313b-5a58-3492-b706d9510d34@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 8 Apr 2019 07:59:08 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL+BhKGrsYU1Gfe=htLiYGiXt+-TqJOb+7RR_oA7HzyPw@mail.gmail.com>
Message-ID: <CAGXu5jL+BhKGrsYU1Gfe=htLiYGiXt+-TqJOb+7RR_oA7HzyPw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] lib/string: Add strscpy_pad() function
To:     shuah <shuah@kernel.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 7:09 AM shuah <shuah@kernel.org> wrote:
> The patch is series in now in linux-kselftest next for 5.2

Yay, awesome! :) Thanks!

-- 
Kees Cook
