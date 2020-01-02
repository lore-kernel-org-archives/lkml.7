Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E17C2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF52420866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="d85ZQ8Qf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgABHz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 02:55:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39355 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbgABHz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 02:55:27 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so14582954plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 23:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=sJ16jnOhr3QUr3TB0LIZMFGSCmwDcNlgrayZJgkHF8s=;
        b=d85ZQ8Qf1C6rSGTtqE9vzmhUlpU1i86WxYukWtgBheyHtfWLatiqdZYlddml435kvq
         f6bRaQ6Db7aXkStAjQUSjLjNTZP9AMCgPhdM7kgG/rlOdScniDBL0b7vP4C8/go/z2l9
         Voa+O15p5SVnc2KGMc/4Ge4wMhwLaFQRfsnOO33tH9HQJknLD4sF+9XvYG1a+VV/mADz
         Mn8EXcfy+00EY7P3qgy1XKOjHbP8LNQGM/mgeFmbLm+MFxZ2s5MAE3YSmTtY0DI/l7DG
         TLh/h/KlVvOpv5eZzIGDS71RF/maL0jGI0hXlNZQDa4vM8J0T7Lvsn760hMj7XX5idJF
         eG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=sJ16jnOhr3QUr3TB0LIZMFGSCmwDcNlgrayZJgkHF8s=;
        b=ULHqQoA9B8mI0OxxGzryZ5oN0U27Xaulh/1tajykYQVU7Xe+N09y5YF17dw4SFrsI3
         z2zTxst20L5E7DEQVY5cKcr+pFituuqE8k+RfwpDOa8HMbmJJE4HGpGCjkYTnz5S8Tiq
         BQu1HZFSD6jgvO7Tkc+jj7MvT+93dHAU4aOapx1VZbyfM7SJ85mYmnLToTd+4Qt7V8sa
         lNv5ovnUaudkKOPPF8Y2DXs3RBBAjYH7rzn9ZYA2TI4NvuyYPcJZC+UOTvYFIfkwQ8ft
         PDE2reeqDAfJSFwQSQreA8C7RqX4N9TSQWaU165I8vtRx7xxBtvpk/9GfBFS+94qHEjr
         ZOjg==
X-Gm-Message-State: APjAAAWxDGphwV2r4/oK7Sih3vv58FL3iYLmFuY4OLzLpbqko/oKN4EH
        A4fAaHtLrlDUA2dL5aGX54AySc2+kvqtQw==
X-Google-Smtp-Source: APXvYqzyMlk0BDFzd1sE3mSiZRlp/TfMc4PWjjUFhTKju697Yrgu9yZtGW/UqbxmgK/QPWCyhvT0Vg==
X-Received: by 2002:a17:90a:8a98:: with SMTP id x24mr18878530pjn.113.1577951726559;
        Wed, 01 Jan 2020 23:55:26 -0800 (PST)
Received: from [10.145.97.154] ([203.129.124.82])
        by smtp.gmail.com with ESMTPSA id j14sm57009728pgs.57.2020.01.01.23.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jan 2020 23:55:25 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v7 1/4] x86/insn-eval: Add support for 64-bit kernel mode
Date:   Thu, 2 Jan 2020 16:55:22 +0900
Message-Id: <498AAA9C-4779-4557-BBF5-A05C55563204@amacapital.net>
References: <20200102074705.n6cnvxrcojhlxqr5@box.shutemov.name>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
In-Reply-To: <20200102074705.n6cnvxrcojhlxqr5@box.shutemov.name>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 2, 2020, at 4:47 PM, Kirill A. Shutemov <kirill@shutemov.name> wrot=
e:
>=20
> =EF=BB=BFOn Thu, Dec 19, 2019 at 12:11:47AM +0100, Jann Horn wrote:
>> To support evaluating 64-bit kernel mode instructions:
>>=20
>> Replace existing checks for user_64bit_mode() with a new helper that
>> checks whether code is being executed in either 64-bit kernel mode or
>> 64-bit user mode.
>>=20
>> Select the GS base depending on whether the instruction is being
>> evaluated in kernel mode.
>>=20
>> Signed-off-by: Jann Horn <jannh@google.com>
>=20
> In most cases you have struct insn around (or can easily pass it down to
> the place). Why not use insn->x86_64?
>=20
>=20

What populates that?

FWIW, this code is a bit buggy: it gets EFI mixed mode wrong. I=E2=80=99m no=
t entirely sure we care.=
