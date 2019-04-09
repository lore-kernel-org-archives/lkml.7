Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D017C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0047C20818
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfDIGpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:45:14 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37080 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDIGpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:45:14 -0400
Received: by mail-qk1-f193.google.com with SMTP id c1so9587740qkk.4;
        Mon, 08 Apr 2019 23:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H3AGjhJG/qECk6YIraAzXhJt9zQXwQlyVHfKeK5Cpu0=;
        b=FMvfqC5N/ZZgDEqG2FBeomBJHLYArVRwLSutF98J3t/1/w7f1ELaH2/OG2/4xjjDcf
         LH5Ku/O9+/M7IrLIVCmVwGGcfVPi9abNsCGraj/FYRGsxqZFw6qrwVzEi3fimDzAcgUj
         Lky2OFp56V31oDELkkMdpS+S8wVPr5pUdi3SIGxwTf9kXMiXqrL1RJXPG0Gm+JrKkrHg
         DeijuXf2tWmRb6gImE5g+3FfU43fZ5YVYfSm1KW82vGDEE3oElvwza6Pk4aRuWriuGTE
         O+447StXRtOdzFySVKyVpVkfQaOB/onkS4T/Od5wc2M8tNksZY43uzb+0pNmFS+POD+b
         zqXw==
X-Gm-Message-State: APjAAAX21FvNZh6snlWoEFO0W6VMGwayybAqgxdYOYUpqav8k4Vl33j1
        LjeN1M+/ZtkQsQgxTBCaNekUT1riRfKrukeZeco=
X-Google-Smtp-Source: APXvYqz0SMp8jZpMjMixY5TZKQkpM6LH8DSQuRiwLkSb/KWWTXgL6VFSjmn07Xc5j/tc0y+5xzbuvjDTiMC20ohJSYw=
X-Received: by 2002:a37:9e8a:: with SMTP id h132mr25649612qke.74.1554792313330;
 Mon, 08 Apr 2019 23:45:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190408212648.2407234-1-arnd@arndb.de> <20190408212648.2407234-4-arnd@arndb.de>
 <20190408221632.GB18333@archlinux-i9>
In-Reply-To: <20190408221632.GB18333@archlinux-i9>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 9 Apr 2019 08:44:56 +0200
Message-ID: <CAK8P3a1GugkfpM7az6JDs4hQh-7CFz4VjykGspVD=-VSFgAX0Q@mail.gmail.com>
Subject: Re: [PATCH 04/12] s390: qeth: address type mismatch warning
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 12:16 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Apr 08, 2019 at 11:26:17PM +0200, Arnd Bergmann wrote:
> > clang produces a harmless warning for each use for the qeth_adp_supported
> > macro:
> >
> > drivers/s390/net/qeth_l2_main.c:559:31: warning: implicit conversion from enumeration type 'enum qeth_ipa_setadp_cmd' to
> >       different enumeration type 'enum qeth_ipa_funcs' [-Wenum-conversion]
> >         if (qeth_adp_supported(card, IPA_SETADP_SET_PROMISC_MODE))
> >             ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/s390/net/qeth_core.h:179:41: note: expanded from macro 'qeth_adp_supported'
> >         qeth_is_ipa_supported(&c->options.adp, f)
> >         ~~~~~~~~~~~~~~~~~~~~~                  ^
> >
> > Add a version of this macro that uses the correct types, and
> > remove the unused qeth_adp_enabled() macro that has the same
> > problem.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I wonder if it is better to just change the func parameter to type long.
> I guess it's better to keep the type safety to make sure values aren't
> unintentionally mixed but the body of the functions is the same so does
> the type actually matter?

I think using the right enum type makes most sense here, as this seems
to be something that is easy to confuse.

      Arnd
