Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91566C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634AE2464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 13:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="TP6Rm1zO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfLENPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 08:15:05 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39744 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfLENPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 08:15:05 -0500
Received: by mail-qt1-f193.google.com with SMTP id g1so3468957qtj.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 05:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ci+Il7R0z85hcBaZjDpG/Dx0n3gFLviKjHNEHX1Pepk=;
        b=TP6Rm1zOouE3WSPWD8apJn5tfIaeOGIdFpSt5bs/4GbVl6fN5nFf05kN/RyiB0tQgs
         7+pi9+O0IfLFLMN8JyhbC64Lt69jKs1Hnn5YJhGDkGdML0trHHHwrv1UbYP1IHKxqfnT
         1c+7haZO77OhJJlUBsroTbFcDMTVlmNYLaNrcTjZ8yFNbarKmA0vkrvweWmLQ3e2/3Rc
         j2a2sHFIkWwNYdvePdcsP03aplXXl5o0huznYeYuC8O0+k5xPRPE99hbTibY/s8WLnTW
         L//lt3nW/AocEgytxvAzk+kn1RBaE4xSlMrVH5iCVPlsoQElHKzU+CiVZKNYXHLQuTTw
         VOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ci+Il7R0z85hcBaZjDpG/Dx0n3gFLviKjHNEHX1Pepk=;
        b=TBwB4Ei7NqdkDnjNjhtg5lgqiSNQJBjzoMy+LldUo39v4BEbJhxqhVMteujN7WPJej
         ssogq/hIqMj6vb1p2uihkZj44jY9Kt0qXvWAt/DF2EUWSs1aYVldJAZFNuHEZzbGzjRe
         H3oVXGRoxM0H8XhnkwTr4ShcUE3NM/ayMHNi49M6d456+HLCDtSY4wR8jN1NeawEjP5+
         aI0DqrnDLxdQkGQ4ok11zc36WTh8hzTDX9mj9hzYK6Gog61rqBXgkv3q0Sc6kYuv2jtB
         0LuX5BBQoFAWwVsvb4frRXF3tLWJcqD31ZQKOm5fb7/BymMu0XG7TqTTgXPLBpyZyY6T
         w0pw==
X-Gm-Message-State: APjAAAVVFwsuvWi0DfCejlQ3Qtx8QxjhbIW7ISBPB9d5n+0ABnmYIelr
        ocmmEUd7zJuV0t8zRo6EsjnBsg==
X-Google-Smtp-Source: APXvYqxHW8DGT/kKJL7N6FSy/ayvCsum2cTR7vYA5fykS6fEhOCjJRkFygAl+kF2HccA8SqNMAi0nQ==
X-Received: by 2002:ac8:60cc:: with SMTP id i12mr7329084qtm.103.1575551703794;
        Thu, 05 Dec 2019 05:15:03 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d134sm4917395qkc.42.2019.12.05.05.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 05:15:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v15 00/23] Generic page walk and ptdump
Date:   Thu, 5 Dec 2019 08:15:02 -0500
Message-Id: <A22DE6B7-23A1-41FA-AF82-9613778277C7@lca.pw>
References: <20191204163235.GA1597@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?Q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <James.Morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>
In-Reply-To: <20191204163235.GA1597@arm.com>
To:     Steven Price <Steven.Price@arm.com>
X-Mailer: iPhone Mail (17B111)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 4, 2019, at 11:32 AM, Steven Price <Steven.Price@arm.com> wrote:
>=20
> I've bisected this problem and it's a merge conflict with:
>=20
> ace88f1018b8 ("mm: pagewalk: Take the pagetable lock in walk_pte_range()")=


Sigh, how does that commit end up merging in the mainline without going thro=
ugh Andrew=E2=80=99s tree and missed all the linux-next testing? It was merg=
ed into the mainline Oct 4th?

> Reverting that commit "fixes" the problem. That commit adds a call to
> pte_offset_map_lock(), however that isn't necessarily safe when
> considering an "unusual" mapping in the kernel. Combined with my patch
> set this leads to the BUG when walking the kernel's page tables.
>=20
> At this stage I think it's best if Andrew drops my series and I'll try
> to rework it on top -rc1 fixing up this conflict and the other x86
> 32-bit issue that has cropped up.
