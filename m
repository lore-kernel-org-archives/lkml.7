Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B40C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C699208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfFQPKu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:10:50 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42013 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQPKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:10:50 -0400
Received: by mail-qk1-f195.google.com with SMTP id b18so6350417qkc.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 08:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=54cAo5sToazz1E9yyx60Dd6u83R9yNhhfYqnU/wYvBY=;
        b=bm8Eg/BU04mbURgDWrIGzaNl8c87kD2wYPSZ7L1DSzJLj0hVgY8qispxpYXAtQMTJo
         U+IZJ5MFv+H7GYHCkUiJxwJw+wnMCacVu+yUw5687H3WWHRBDYaszrEt5Gx3DydcIuHz
         G3ctgbz+Wijhk5izke1A1WJwcVFcBjx+Ah22ouPg0tQSAOvxTr5/ZU4sPjvV1z9fSZiR
         SbOUqVXWaoVs2/cTLrG6K67f2y0GF7mW++H4ZYLc/GgryYIVSimZES0y85QsaqdVNdlC
         BxUsFaToydYoRavcDm55DAKbSdAwJD70iqp2KZfH2MRPQOIZOIu8BHv4S/s2F7a4g5vZ
         bx1g==
X-Gm-Message-State: APjAAAXGrqOttGfc94OH/d7MCP6jQOD25hO3OzvCkJNNc1vrXZ8kg1hb
        Dg7P7F3fcJ5D047C786v+Fdylx/zxQ/e8e4xytNtDNq0m0s=
X-Google-Smtp-Source: APXvYqycbp3OzbqjWTCHqwJrr+j4yGwSF9O1ZfciD8f4z6gSkVtEfsede0TOf2zxNdmTqlb0SwFt1Lpir7otOz6EHUY=
X-Received: by 2002:ae9:c106:: with SMTP id z6mr68991875qki.285.1560784249188;
 Mon, 17 Jun 2019 08:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190617104237.2082388-1-arnd@arndb.de> <20190617112652.GB30800@fuggles.cambridge.arm.com>
 <CAK8P3a2aJNiLTyfRDqazJa2sAc-Jf-QShSZ7+4-whHSxKbLUVQ@mail.gmail.com> <87a7eg9s0o.fsf@zen.linaroharston>
In-Reply-To: <87a7eg9s0o.fsf@zen.linaroharston>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Jun 2019 17:10:32 +0200
Message-ID: <CAK8P3a2evZN5aHFRtc4MQvyvgtuT+djD-gzgc5TBcMKjJ6bUYg@mail.gmail.com>
Subject: Re: [PATCH] arm64/sve: fix genksyms generation
To:     =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 4:59 PM Alex Bennée <alex.bennee@linaro.org> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Mon, Jun 17, 2019 at 1:26 PM Will Deacon <will.deacon@arm.com> wrote:
> >> On Mon, Jun 17, 2019 at 12:42:11PM +0200, Arnd Bergmann wrote:
> >> I suspect I need to figure out what genksyms is doing, but I'm nervous
> >> about exposing this as an array type without understanding whether or
> >> not that has consequences for its operation.
> >
> > The entire point is genksyms is to ensure that types of exported symbols
> > are compatible. To do this, it has a limited parser for C source code that
> > understands the basic types (char, int, long, _Bool, etc) and how to
> > aggregate them into structs and function arguments. This process has
> > always been fragile, and it clearly breaks when it fails to understand a
> > particular type.
>
> Shouldn't the solution for this be to fix genksyms to be less fragile
> and more understanding? The code base doesn't seem to be full of these
> sorts of ifdef workarounds.

It is one of the things I tried before I got to the version I send.
Unfortunately
the genksyms codebase is a big complex and I quickly got lost in it.

You're welcome to volunteer fixing it though. My main problem was that
I couldn't even find out which types exactly are supported, as __uint128_t
is not even in the gcc documentation. "unsigned __int128" is a documented
type, but is also not in genksyms.

        Arnd
