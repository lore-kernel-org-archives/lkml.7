Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B7EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777FF20644
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdtaZKex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405843AbfIFQsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 12:48:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35651 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfIFQsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:48:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id w6so5626900lfl.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 09:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rQxQmL5WKmqkiAdBzxBOpYt8ZpWix1U/0Cxla2OL6B4=;
        b=CdtaZKexOxpjujZe0ssUyItgzsYGIs6tyrl06lcsSvQcidtI4XlufBfc+y17ixEWs2
         Yf3Ue404z91Vne3BD8g20GCjLqm6XNtIJMYNxDPmIxyGW4tJf/U61cBxFg+3l5q+7+7a
         dTfbgw2bHQ7dBu1D3Yq3OuiT5ExlJKlKPVS1/3a24X4DEuKYvmvptByERu1RAPp8IJBy
         M1c7XIVOni77s5rz8mHJKWIzoPczSGVix48QxGy9yQoiRjwAhzOtDZZoze6uAjXMhJ+b
         RiQKu+JawMjXorYN0ABKAx/OngQAWtG75kWbK/bDUqt2IBiRA+kYEA5J7iOTHIqhfcjd
         VQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQxQmL5WKmqkiAdBzxBOpYt8ZpWix1U/0Cxla2OL6B4=;
        b=IxdUd7BDkwPubh56h9QAgV2Bgqsi2Fu8DnR/PFNkFLDIa8tg6LTOXwpG93MScaTmuH
         rR0q3R7YU9xzx3eQYXL0+LEA2nemnou9l/LTFYzEF7WI0Xp8x+2zd4GQCYyGt6org8hn
         liSA3idrw9rqJl7Ggait4NJACRld/ZSgc1xka/rrEeHyZy3+iGJKt+S4qr5++154DcoZ
         WxYBJ0cSohsACBh7IwgQtGOOkupjKptX7gy3A1Uo1/WKnfyJudXuQikSy97HL4ibzzuL
         Fw/P9OjlcJqDia3DeXHiJKt0TxBSg9SmXrHPJL0RuEeR1BU0dwZmTVxBzR6OF4CxIeh/
         bYFQ==
X-Gm-Message-State: APjAAAVXvRHe5lmSA+C08u//Jnsx3WGw6rF3RwkXzqjJUnaPAsXho8sN
        AgDZSYLdUxQRZGB+t+ps+mPGIVboHULD+bNpMVeIDQ==
X-Google-Smtp-Source: APXvYqy+0qCW9TDQY5RuFmuYzqhGsB6VBVTHryyiAu3OlG6RsXDTWL6fSCLhiT3nsp/vA2mHCVdipZr6cGVOuocrA4g=
X-Received: by 2002:ac2:4902:: with SMTP id n2mr7206138lfi.0.1567788485327;
 Fri, 06 Sep 2019 09:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-1-linux@rasmusvillemoes.dk> <20190830231527.22304-5-linux@rasmusvillemoes.dk>
 <CAKwvOdktYpMH8WnEQwNE2JJdKn4w0CHv3L=YHkqU2JzQ6Qwkew@mail.gmail.com>
 <a5085133-33da-6c13-6953-d18cbc6ad3f5@rasmusvillemoes.dk> <20190905134535.GP9749@gate.crashing.org>
 <CANiq72nXXBgwKcs36R+uau2o1YypfSFKAYWV2xmcRZgz8LRQww@mail.gmail.com>
 <20190906122349.GZ9749@gate.crashing.org> <CANiq72=3Vz-_6ctEzDQgTA44jmfSn_XZTS8wP1GHgm31Xm8ECw@mail.gmail.com>
 <20190906163028.GC9749@gate.crashing.org>
In-Reply-To: <20190906163028.GC9749@gate.crashing.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 6 Sep 2019 18:47:54 +0200
Message-ID: <CANiq72k9BjDBChLMjbUbAsB3+DiX_efc6A010TYgrbyEg=xx=w@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 6:30 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> (Which isn't the C++ standard yet, okay).

At this stage, it pretty much is. It is basically bug fixing at this point.

> No, that is not what it does.  A user defines such a macro, and that
> makes the library change behaviour.

That is what I have said:

  "I want to test if the user enabled the feature"

means the *library* tests if the user enabled the feature before
including the library. But the user does not want to test anything.

Cheers,
Miguel
