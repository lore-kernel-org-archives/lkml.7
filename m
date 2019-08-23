Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9D4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 11:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FD52133F
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 11:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eW4Vjfs3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392340AbfHWLag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 07:30:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33702 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732963AbfHWLaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 07:30:35 -0400
Received: by mail-lj1-f193.google.com with SMTP id z17so8570109ljz.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 04:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2oV8aGDXYBwpeOJu/TypOz+stiC6mNN3ycHZh0Kn0k=;
        b=eW4Vjfs3G9Tl4+b2j5T/iW0ED0EL+cu1RMWikv/U/CgTyOolReXxhuMXyaKhMGBXH9
         KkjkDBa4hVRQniQ69vyo8TTeyumnnfMMz2RWpEh3ocPZbVWqeOfgGO8hcJLgH439I107
         BGQsFewbpEG5mQrSRAaI2k0wc+tgwTqt7rEt7qznzVrydthf2B3ScLfk3ZWtlbpB9pRL
         BK171HTvSJ0YJ9fUM6V7cLoMnnnGInx2UyNGIPRzwvtkIctbzy1CUqC0k07SH2fMDOFn
         2/MnFOVIaL4NTGSe/HEww5SucXvT6aqLIYLxuBvrrAOwDDFHpMBMCsJEJ4kmKb11krue
         6hnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2oV8aGDXYBwpeOJu/TypOz+stiC6mNN3ycHZh0Kn0k=;
        b=uLDXbLvIfSZroDyzf7YqrL0jQUiT7idRSJdJ27W+diraUkn6u3MmBUiflIVFI2Yqir
         zlPSk/u6NkzKTY3MCDwFQUQHrvtLzgddTK2xbiwMiJxW1l0hAkNRB2WTlVkqQpwNVV5J
         L7d8kzB/onOA7AuCZZW+yCrpTZc+gcUAc/Afoz0QHLP9bAOLtAJNlQF4S1TaE+hXzW4+
         1eqRcPQGjv0h46GbK7cnRBtCglCaY7xjvFHHpovyVQUCcSx0i0SvxXsE+tzuC270/nA/
         LRURh6SgByRLMEIkRSJ7XrXmn63GBmMROF4+RT9ILPoCKXvDoRQe4VvZMwlqiO0e2RHt
         X78w==
X-Gm-Message-State: APjAAAUmimsYl0t3KS8qoOh7iQqSS00M+JqduNT2+8XYtrMXFzNdJrG4
        Od99Iyvaqh1STGtkkhpI8wa6yJyghLvhK2F5ISAO7A==
X-Google-Smtp-Source: APXvYqzUv9Xg7GpAEDApY8oyIhZ29QEVEkbDkSwK6WO75eejvqh0J9DhqDObUV6G0QvS5flaO2CPV3gVKZ+4ivB1vjk=
X-Received: by 2002:a2e:80da:: with SMTP id r26mr2545097ljg.62.1566559833448;
 Fri, 23 Aug 2019 04:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190810002039.95876-1-dmitry.torokhov@gmail.com>
 <CACRpkdZo9so+5UoT3QpFmL_8NZT1d1i7Yab202RNn8gDfnPK7A@mail.gmail.com> <20190821174257.GC76194@dtor-ws>
In-Reply-To: <20190821174257.GC76194@dtor-ws>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Aug 2019 13:30:22 +0200
Message-ID: <CACRpkdaTK0pybDM6So-E=weE_+uz8TSr=38YNzNQdqjZvnnYXw@mail.gmail.com>
Subject: Re: [PATCH 00/11] Face lift for bu21013_ts driver
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linux Input <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 7:43 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> The issue is this:
>
> static void bu21013_disable_chip(void *_ts)
> {
>         struct bu21013_ts *ts = ts;
>
> which shuts up gcc about the fact that 'ts' is uninitialized, it should
> have said "ts = _ts". I guess it is a lesson for me to not call the voi
> d pointer argument almost the same name as the structure, as it is easy
> to miss in the review. The compiler would not care in either case, but a
> human might have noticed.
>
> Can you please try making this change (and the same in power off
> handler)?

Yes this works! :)

Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
