Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14070C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC3A2464F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UIhWvGtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbfLEOiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:38:20 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38729 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbfLEOiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:38:20 -0500
Received: by mail-qk1-f196.google.com with SMTP id k6so3508307qki.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 06:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=omWgUdt2lqUl+xhBEN5ihPOntS+M4FEdV/QH92UTrzU=;
        b=UIhWvGttTAkN5l5034Z8e5zeLaLNI3r2q89siMfEfzDHyVPGBlUyw9awSlnXLtOU8K
         7HogI8QP7c/UhmzG7czmyKNTXD/w62FImbIi0ya5oibqTtm/55lDwvAwd1hYw4gmxSr0
         s3HbWI3oRozCHqxoCdDk8nYYmFUUMuLFaMSQ9239tyNGy0PIy6CUGu2+xsaqV5N4WeDH
         wKuLF0RzYHred7Gwf0n0mlDXXwzDGENqN998v9vaSp87D5CvHB22tpUVFU7ra84PHoSR
         fdGpaf2KPH+QaxB3GJ0rzNKqwUuETRjTSrZDKgTUlD1L+08gLMwBY6CbI2aY+BydsZmM
         BYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=omWgUdt2lqUl+xhBEN5ihPOntS+M4FEdV/QH92UTrzU=;
        b=JwMYa7+7yTjvF6tDm+IMFImcM5tCFgQyVJVj6QmDVoCp4jhlPznFtP3JIlS1CndLOz
         4GoR+0pKkzrrVvzUx26oaVMrBToZoYiFcRuo0Ii1pqtJnI1iYba9ToOL71Ay+yZWwq02
         YmYt4/xoZn9iQKcmlFN9f7OkguXoLC2qjFbm7qPGIbk1J2ZMjClcH3UE+eaFDaK87WtS
         tJZB6FGtuqHbHX29Vb4/VUHTgBCiRnTJ7qTUeWKzOpNSsulvpf6b255KZ2JhD63uz0v6
         f1KAKiT4W8LF8WN2SHCXF1Ld2Hw5peCmN9ZQwnJsschWuUILm9mpTG9MmYBG57iw94h2
         9w8w==
X-Gm-Message-State: APjAAAUDHX1F/AF025K0zyTjH/syFplf/3NVB5QeIM9MikJhSIPUymla
        IG2wseeKpH4iyQaqf5ClsghXIw==
X-Google-Smtp-Source: APXvYqw3uCvzvHTDFgO1iY1S8KTw29SAdiF1UyUgWAbRL+Ur4SVE1kG+cTjFz5MmpWO2vcqfQWv95A==
X-Received: by 2002:a05:620a:98d:: with SMTP id x13mr7954868qkx.221.1575556699289;
        Thu, 05 Dec 2019 06:38:19 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t9sm1262482qkt.112.2019.12.05.06.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2019 06:38:18 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH v15 00/23] Generic page walk and ptdump
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <e1f4ec12f9b3f92e481a42698cc1a5645e0e7c0f.camel@vmware.com>
Date:   Thu, 5 Dec 2019 09:38:17 -0500
Cc:     "Steven.Price@arm.com" <Steven.Price@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "david@redhat.com" <david@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "James.Morse@arm.com" <James.Morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Mark.Rutland@arm.com" <Mark.Rutland@arm.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de" <arnd@arndb.de>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "will@kernel.org" <will@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A1E27467-83D7-4D36-A029-31649417248E@lca.pw>
References: <20191204163235.GA1597@arm.com>
 <A22DE6B7-23A1-41FA-AF82-9613778277C7@lca.pw>
 <e1f4ec12f9b3f92e481a42698cc1a5645e0e7c0f.camel@vmware.com>
To:     Thomas Hellstrom <thellstrom@vmware.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 5, 2019, at 9:32 AM, Thomas Hellstrom <thellstrom@vmware.com> =
wrote:
>=20
> On Thu, 2019-12-05 at 08:15 -0500, Qian Cai wrote:
>>> On Dec 4, 2019, at 11:32 AM, Steven Price <Steven.Price@arm.com>
>>> wrote:
>>>=20
>>> I've bisected this problem and it's a merge conflict with:
>>>=20
>>> ace88f1018b8 ("mm: pagewalk: Take the pagetable lock in
>>> walk_pte_range()")
>>=20
>> Sigh, how does that commit end up merging in the mainline without
>> going through Andrew=E2=80=99s tree and missed all the linux-next =
testing? It
>> was merged into the mainline Oct 4th?
>=20
> It was acked by Andrew to be merged through a drm tree, since it was
> part of a graphics driver functionality. It was preceded by a fairly
> lenghty discussion on linux-mm / linux-kernel.
>=20
> It was merged into drm-next on 19-11-28, I think that's when it
> normally is seen by linux-next. Merged into mainline 19-11-30. =
Andrew's
> tree got merged 19-12-05.

Ah, that was the problem. Merged into the mainline after only a day or =
two
showed up in the linux-next. There isn=E2=80=99t enough time for =
integration testing.

>=20
> linux-next signaled a merge conflict from one of the patches in this
> series (not this one) resolved manually with the akpm tree on =
19-12-02.
>=20
> Thomas
>=20
>=20
>=20
>=20
>=20
>=20

