Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875CDC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 12:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6398E218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 12:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405962AbfIGMxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 08:53:34 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40556 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405937AbfIGMxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 08:53:34 -0400
Received: by mail-qk1-f196.google.com with SMTP id y144so366116qkb.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 05:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSJwfnMis9QrVqeedJqyZyK7Kr0nVk7TIwsUX6R+/Sc=;
        b=eWsj2Bw9EikjUgWsQBHy5ag54lTSU1jAB8e5KgqdsXoi9Jfz8/CydzxpLmsui7UoJn
         MfneqU3e55wu/yyBsjW+IMzlWugER0Qjm1hUewZQqZuSoJZgOQv+/pmaJao5EoST0b7y
         5AYJijThcAVz15dW+Lsc4VzzwrBfajeTHhelyX414eckkGTlFb9QzQxqKZ423SPYx5b6
         0Q5ug7KRb0VIbGP72PCBqewzz5/ULKdAsN9ydIzmO0aPuh/yfxFqXuVCWdNZYOGQtQjZ
         ed+IW7MHtMeR7jJSaJQIvZqh/Jn1yunaHPYzBpYmZ5QQ+M2AC00GGOOWKG58CeNRXBsc
         Q5Xg==
X-Gm-Message-State: APjAAAWGk9sFh6edu1iVqW+3jhZqvcAILH90myIRks5WEMzbZuuJrJnX
        3vyeD/AgaXW/yISZVgniktyEPeR0rEBKeEOOaAk=
X-Google-Smtp-Source: APXvYqx1WAz8NTJWR3u5PT+9/TEYFS9I/oprVLZ0lG7uw4e83SfDBJh1IoDvbQo/VbdQmw+xtGQxRWuIerQRBlObqdY=
X-Received: by 2002:a37:4fcf:: with SMTP id d198mr13773083qkb.394.1567860813556;
 Sat, 07 Sep 2019 05:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190907020631.29359-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190907020631.29359-1-yamada.masahiro@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 7 Sep 2019 14:53:16 +0200
Message-ID: <CAK8P3a2GRZJQThJAdavv_EKp27dtUtysKtpYpkKSSupTJ4qemg@mail.gmail.com>
Subject: Re: [PATCH] samples: watch_queue: add HEADERS_INSTALL dependency
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     David Howells <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 7, 2019 at 4:07 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> samples/watch_queue/Makefile specifies the header search path
> -I$(objtree)/usr/include, which is probaby needed to include
> <linux/watch_queue.h> etc.
>
> To make it work properly, add "depends on HEADERS_INSTALL" so that
> headers are installed into $(objtree)/usr/include before building
> this sample.
>
> Fixes: 7141642ed120 ("Add sample notification program")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Tested-by: Arnd Bergmann <arnd@arndb.de>

> Arnd reported a build error:
> https://lkml.org/lkml/2019/9/6/665
>
> Missing "depends on HEADERS_INSTALL" is the only reason
> I have in my mind.
>
> If it still fails to build, I do not know why.

It works, thanks for the fix!

       Arnd
