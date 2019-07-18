Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7112CC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 22:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45AB221849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 22:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iSlmu3Xj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391392AbfGRWJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 18:09:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45765 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbfGRWJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 18:09:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so14557255plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 15:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cJB2IxtNuxhv2Lxf0ZUw5k1i+zFNjuXUoBzzFYiAiUI=;
        b=iSlmu3XjeX7IDdfGFhQ/E0HlxVhwZD8tpwT0Lm46g9LBlYjiZ4tz0B6zXRD1Ttozne
         8aOkaZExNeXM631WTOjJr3tWVXPLxz9sUk6B94pxCH7Xv5nbht/AYMn6X0eZ963AqQBU
         tuK7lf3cbliGizEiu5ytaG5b/RXr+bsL6E5Dle/eSHoe6zRYYN3pzH7EPobKkyWy0L4M
         bNuyc6koByu1AmbhT0IvsTLIkfY58d0vTWSxuRIpu2VIocQUBeZ4C2xs29DYOU5BBKDw
         uD949MwV5QXn6bP1BvD6Vk+05moYO84ema77h4j20vFvDxlhJJCsO3Os1VxyXz+Vbxxe
         IdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJB2IxtNuxhv2Lxf0ZUw5k1i+zFNjuXUoBzzFYiAiUI=;
        b=AvS9SBc9cyP7XlS/2DCW+5O58YR+w4phS8XNfaozqb5vejt/fhb1EwJTp0d+oO6oCP
         3kpAqqijBl3erFtv5cNTXt61jOzuDahskIF2txOZmjnt5+/mk2suxIL2CQjLAzVWVn7C
         +R99ertKjL8Qp8Qty1BCPsWfPnyIGW7LKeABCmfuCYnkTRlm87byfx6h4gQXjxY1Y2gO
         pngpD9V19Vwc9BPoJDS1wN73cOdK4EMtYw7PktVmO+M0HiaR9SonBc8vNmlOBL8lusSv
         YJbPo2Rp+FAOIVX8RT/EcvIMnI2vwOMvj6YVzTLdOmTAIy8wVJ3z/G+TA08DBhIG3bP0
         LMAQ==
X-Gm-Message-State: APjAAAUuPupxWxCqoDlwtkZeeIUvom20PQhcku8++EfCiLuEo+5C9SXm
        4sI1Ney+xcuiVPSzz+Yr5Z6g6SDyaRrBkeewbLYFUA==
X-Google-Smtp-Source: APXvYqyLN6rNn0D3sq6zwlZXHimecH1MQwyf3IBu+wM0HsHZQXKCwhV8W3q8i3fb7njRdU8V46G9SdJgSzdzsrmox70=
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr52157329plq.223.1563487776450;
 Thu, 18 Jul 2019 15:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190718141503.3258299-1-arnd@arndb.de> <0ee5952b-5a76-c8a5-a30a-ee3c46a54814@virtuozzo.com>
 <20190718162310.GG5761@sirena.org.uk>
In-Reply-To: <20190718162310.GG5761@sirena.org.uk>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Jul 2019 15:09:25 -0700
Message-ID: <CAKwvOd=XFVP78OjwQT0HzHyHF+ALA+V0ZLvuOB-8xKrrjSncUA@mail.gmail.com>
Subject: Re: [PATCH] kasan: push back KASAN_STACK detection to clang-10
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, Vasily Gorbik <gor@linux.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 9:23 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jul 18, 2019 at 07:18:28PM +0300, Andrey Ryabinin wrote:
> > On 7/18/19 5:14 PM, Arnd Bergmann wrote:
>
> > > asan-stack mode still uses dangerously large kernel stacks of
> > > tens of kilobytes in some drivers, and it does not seem that anyone
> > > is working on the clang bug.
>
> > > -   default !(CLANG_VERSION < 90000)
> > > +   default !(CLANG_VERSION < 100000)
>
> > Wouldn't be better to make this thing for any clang version? And only when the bug is
> > finally fixed, specify the clang version which can enable this safely.
>
> Especially if nobody is currently working on it.

I agree.
-- 
Thanks,
~Nick Desaulniers
