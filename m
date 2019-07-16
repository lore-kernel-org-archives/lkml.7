Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02596C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCDB2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563302813;
	bh=P3Y5hOSYIaM5Zg01TYBiSlbJCBbpx4jXHEgZq3VjnL8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hIoWmtgd9wnCnBgzTQC284pIyztyKMfLh0yp3uBFdEn5+AZfIRn+B+PHffxniuXBD
	 w37tbZK0Gk1Vq9DJJ5q1vutlMrstHM3EsfuxE1oa0Q9grpQlRSdU8lKYTSE56t8ovH
	 G87Js8J3ETUCtBcy4Io+HjZ2licwmX00K7jf7+74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388464AbfGPSqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:46:52 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:39923 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfGPSqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:46:52 -0400
Received: by mail-lf1-f43.google.com with SMTP id v85so14468728lfa.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 11:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kTeeu+hLZEXpN0rThQFCD/UlvDUpZb8x8Ce3yWy8rA4=;
        b=GpFstsa7GDVMT7gyYKGgVCrWu9c5T0HDYr3BEdPSAugTtGNGH2YJjd1T79QBTinR5R
         2Z1jGz+ok9EirB48ppGzGSR0QsLYpM3t4ldEtSu0bDBNnGnRdktkY4Mkeug6i5ktf/EZ
         fMwrd/iOg3IWRY+g0+vzD5O+rbWrfuFmIA0l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kTeeu+hLZEXpN0rThQFCD/UlvDUpZb8x8Ce3yWy8rA4=;
        b=rbK/9j6BFQnF4MYpFd3LXwqFeGj+34U8i9dWbOtUb8X9uBQhu3J3vMog8NyEDyixy1
         yugszU+ns8gtNSj4/I2p2pLYbyynuzZMCEm5ZD3ZOLLYXWP3UswMGT38ELYZhDZ+oceI
         jwShuAzJOxd52aOSE9qFcITobRgsp1oy7WmPb4hje2/HSVM/5Lpmr+73LiEzn8zsdkyt
         DUuIy9TqZd3raJbH3/92pliQ6Bz00u5tVD1x8g82V4IMh5ji6/y7iOUoceWqLQoMTlOW
         MLjJrg9ScoAl3I/ABmFKH0F2B6ysP3FdZ5pwVhC8cEy1/xgRPT72erhjMEcKpbO7KIzN
         9aag==
X-Gm-Message-State: APjAAAW6QQqDAudvoS1L1UvUp01C/7Bf5hQjAHlcYY5KUTA4oLWWqYVZ
        5CRPh0GnCBVF+njLnDQsTFBxG1QmHZQ=
X-Google-Smtp-Source: APXvYqw3G3V3hnfwPGVCFew6LjJPWXBUzSwPLIJHL4AskAtBl/XIezdW2uGXhjm86BtkGJSLdAimqg==
X-Received: by 2002:ac2:4466:: with SMTP id y6mr15637776lfl.0.1563302809764;
        Tue, 16 Jul 2019 11:46:49 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id d16sm3887491ljc.96.2019.07.16.11.46.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 11:46:49 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 16so20985438ljv.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 11:46:48 -0700 (PDT)
X-Received: by 2002:a2e:9192:: with SMTP id f18mr18206103ljg.52.1563302808576;
 Tue, 16 Jul 2019 11:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1907161434260.1767@nanos.tec.linutronix.de>
 <20190716144034.GA36330@gmail.com> <alpine.DEB.2.21.1907161757490.1767@nanos.tec.linutronix.de>
 <20190716181324.GA41555@gmail.com>
In-Reply-To: <20190716181324.GA41555@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 Jul 2019 11:46:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjw5JGdP=1ezB4ZCQV1kCMR4K=NhSoA6AAOD1wuV=sH=A@mail.gmail.com>
Message-ID: <CAHk-=wjw5JGdP=1ezB4ZCQV1kCMR4K=NhSoA6AAOD1wuV=sH=A@mail.gmail.com>
Subject: Re: kbuild: Fail if gold linker is detected
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 11:13 AM Ingo Molnar <mingo@kernel.org> wrote:
>
> Then please make this a bit more apparent, such as:
>
>  "The gold linker has known issues of failing the build in random
>   but also in more predictible ways."

Maybe even mention a couple of particular known failure cases.

Just in case somebody decides to start up active gold development
again, and actually look at cases it fails at...

               Linus
