Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A9CC3F68F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B6021734
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 00:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="wGrwcyxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgADAtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 19:49:16 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33529 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbgADAtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 19:49:16 -0500
Received: by mail-pf1-f194.google.com with SMTP id z16so24226875pfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 16:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:mime-version:subject:from:in-reply-to:cc
         :date:message-id:references:to;
        bh=lfkMEtu2NrgRYzUtOkmU5nzh06SPXMP9QI5lxJ6vvU8=;
        b=wGrwcyxwzsa97nzzLZ7cMEJGg8JyFQk97N9ZrAaDadqtJFSLmA+3CVwLnYPqkxxKx1
         ewoWLANJqstiDbL8JEsT6zSOCxJ8VE7R7JweDXNJnFyU1V2EAVsh+HWF3kRlK7sFfxKX
         0OFY5D2n2zZPuv1R9Jza7ZcCvCDn6xBxKXvoqehyAXWfhigpmuglcBbnosWeXT7OVPPb
         3kmnngrMdS1XL4iy725VTlO44VKXGgqI6lotCqIhZq17jDuXG8IxOxMEjYEyfJ45g5E6
         t8b14ipDQSUgk2mUvjAt/TxgpkmHib7jx1QglFIgWvAB4TK+IVeYIhGh5ginJSAOcnPq
         QnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:mime-version:subject
         :from:in-reply-to:cc:date:message-id:references:to;
        bh=lfkMEtu2NrgRYzUtOkmU5nzh06SPXMP9QI5lxJ6vvU8=;
        b=G/HemDaFXEsEqr1Wia32C1imVvKm8DlZ9GE8ihH9Y49bFPqL7rU+EQTucPrfFqJ87Y
         PZdYcmKzrVIw2ZRMQ51TNHzmGEne94Gz5konbxxjvfZj+OXRcVWV4nh3fYhFDjJkrgJV
         iniFNidfA6sfQQY2UnciaD5PqJAbgMCQy1FIEHb5YZs0O+vXqR2xOmVKgI8hUdm5tLwp
         2PJyhvVEYAisqu3E52oGyfXNZSDjCLECkhE/d7BzA4vYM3oUIpJO1JMzbxykgTAtXz0t
         M8V0+40xqsBvRdD9tvq4vfSPkutLlWsqQHoQNHS+aDBiMmUY6xDhD6FnkwUVN8DrZLSg
         fyIA==
X-Gm-Message-State: APjAAAWUToKX84BifanjzN28SIIlPcGibezhQYNeRxYw4pI/XAv9C+tp
        aBLRhS9TtU3MOcmmubEkSCGYzw==
X-Google-Smtp-Source: APXvYqz6slvSHXMFhQAhVt0qNXjSRLs05jEmWebgeE6ecATTBIc2NexbQX/k8usJIbeOzoPyzC6wWg==
X-Received: by 2002:aa7:8dd0:: with SMTP id j16mr79260313pfr.186.1578098955813;
        Fri, 03 Jan 2020 16:49:15 -0800 (PST)
Received: from [25.171.60.22] ([172.58.27.167])
        by smtp.gmail.com with ESMTPSA id f43sm16380951pje.23.2020.01.03.16.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2020 16:49:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH bpf-next] bpf: Make trampolines W^X
From:   Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <20200103234725.22846-1-kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        linux-security-module@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Thomas Garnier <thgarnie@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Michael Halcrow <mhalcrow@google.com>
Date:   Sat, 4 Jan 2020 09:49:10 +0900
Message-Id: <F25C9071-A7A7-4221-BC49-A769E1677EE1@amacapital.net>
References: <20200103234725.22846-1-kpsingh@chromium.org>
To:     KP Singh <kpsingh@chromium.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 4, 2020, at 8:47 AM, KP Singh <kpsingh@chromium.org> wrote:
>=20
> =EF=BB=BFFrom: KP Singh <kpsingh@google.com>
>=20
> The image for the BPF trampolines is allocated with
> bpf_jit_alloc_exe_page which marks this allocated page executable. This
> means that the allocated memory is W and X at the same time making it
> susceptible to WX based attacks.
>=20
> Since the allocated memory is shared between two trampolines (the
> current and the next), 2 pages must be allocated to adhere to W^X and
> the following sequence is obeyed where trampolines are modified:

Can we please do better rather than piling garbage on top of garbage?

>=20
> - Mark memory as non executable (set_memory_nx). While module_alloc for
> x86 allocates the memory as PAGE_KERNEL and not PAGE_KERNEL_EXEC, not
> all implementations of module_alloc do so

How about fixing this instead?

> - Mark the memory as read/write (set_memory_rw)

Probably harmless, but see above about fixing it.

> - Modify the trampoline

Seems reasonable. It=E2=80=99s worth noting that this whole approach is subo=
ptimal: the =E2=80=9Cmodule=E2=80=9D allocator should really be returning a l=
ist of pages to be written (not at the final address!) with the actual execu=
table mapping to be materialized later, but that=E2=80=99s a bigger project t=
hat you=E2=80=99re welcome to ignore for now.  (Concretely, it should produc=
e a vmap address with backing pages but with the vmap alias either entirely u=
nmapped or read-only. A subsequent healer would, all at once, make the direc=
t map pages RO or not-present and make the vmap alias RX.)

> - Mark the memory as read-only (set_memory_ro)
> - Mark the memory as executable (set_memory_x)

No, thanks. There=E2=80=99s very little excuse for doing two IPI flushes whe=
n one would suffice.

As far as I know, all architectures can do this with a single flush without r=
aces  x86 certainly can. The module freeing code gets this sequence right. P=
lease reuse its mechanism or, if needed, export the relevant interfaces.
