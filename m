Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D05C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72062082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OEGEvVoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfC1QsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:48:13 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:42636 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfC1QsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:48:13 -0400
Received: by mail-vk1-f193.google.com with SMTP id 195so223190vkx.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WSfQ5OmEiKGqOCo/4yLiYapctHnWzr5rZnujV5KL38A=;
        b=OEGEvVoX61AVG3rM40VKvHD3TYzBBLfWdY1+6HqXLePG8nOr4liT0RDO16iUgMxwyA
         G+BesGmIebsIjBPWPrIKxwnT2FvHHtHWUkn5MSpI2Juy4g/cL/lFhnZinqL3IuBTj2e8
         p7z4jPqepn7oNMkoUzwfXzog4gV1+kUR8F+Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WSfQ5OmEiKGqOCo/4yLiYapctHnWzr5rZnujV5KL38A=;
        b=LUJ1SgryuR12gAhvtixpYCAnWKyc2YDm7YSTy6LRVEqyzbfITgx1W+Pu/ClVis6SiE
         jBKAgObXC3oAo6GCtl8LozxhHvP/CerUXyuw8vJcNwYyH6Yiw8U8LC+D+91KGur7e66+
         eXjHWXEZUhh21JR6/CRn5Tm8ztlldnnrz2ZZ8+h1polzVvTQ9bLqNRQy0ezAwtvWI4YY
         nMD3HsygqF4i31k7+xp09fdCK9SQZ6TBRRviagbMizeSPL7sWtFpwZfec1DTHpbbYdMw
         VVEa6VQxZpKGH9P/B+P5PoRKADEcfhi7AzaaCi8QGkIVBDY+fudJodl56jUxmSitv/vm
         VXZA==
X-Gm-Message-State: APjAAAW0vOZXgC/nkz95VzvCbuwEGXgNdbVyVVoeCIHwcsgLwrDNXynI
        C2NhSAD7I/nEDemwzSoct92vAfyYYkU=
X-Google-Smtp-Source: APXvYqy2djjuS0h5/WLJoAROVN2gG8DGFxuqcgZXRsYJKFrG2dWdN+D5atxaIJIvUj7gASVn/NNiSg==
X-Received: by 2002:a1f:9991:: with SMTP id b139mr21941933vke.73.1553791691791;
        Thu, 28 Mar 2019 09:48:11 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id m23sm20779002vsl.24.2019.03.28.09.48.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:48:09 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id e131so4647357vkf.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:48:08 -0700 (PDT)
X-Received: by 2002:a1f:3458:: with SMTP id b85mr15309047vka.4.1553791688459;
 Thu, 28 Mar 2019 09:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190318094128.1488-1-elena.reshetova@intel.com>
 <CALCETrUxhzHyUQCAjPQcPNWwAw5UTxUX4ZaeGxpbf9VSCDdcPg@mail.gmail.com>
 <CAGXu5jLQaa2FYMOpQPLdRPmUPNY8jq7whM6Wa_YGjfH7oHwx4Q@mail.gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C19A55@IRSMSX102.ger.corp.intel.com>
 <CALCETrXnfk5zYWmpdLvYbcJ7hhFM13+LPq14MF7s99iqtS4-jg@mail.gmail.com>
 <CAGXu5j+r-NH5+QY=siE+6RTkUKoRF0Rso6KHM4NOMsCvpcjW5g@mail.gmail.com> <3F1480E2-3D58-4A79-8609-2A9F7991804F@amacapital.net>
In-Reply-To: <3F1480E2-3D58-4A79-8609-2A9F7991804F@amacapital.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 28 Mar 2019 09:47:56 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLBP-95aEF2refYimAJ=ea42C_3Ywb+1dZAaVR1rbmP9Q@mail.gmail.com>
Message-ID: <CAGXu5jLBP-95aEF2refYimAJ=ea42C_3Ywb+1dZAaVR1rbmP9Q@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/entry/64: randomize kernel stack offset upon syscall
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 9:29 AM Andy Lutomirski <luto@amacapital.net> wrote=
:
> Doesn=E2=80=99t this just leak some of the canary to user code through si=
de channels?

Erf, yes, good point. Let's just use prandom and be done with it.

--=20
Kees Cook
