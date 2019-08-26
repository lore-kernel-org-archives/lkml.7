Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4907DC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 17:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D51520850
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 17:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gK38A443"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732577AbfHZREG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 13:04:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40885 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbfHZREG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 13:04:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id h3so10319559pls.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 10:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQr2+CCalKgDrA12cz6kTPFlEgpE4NTSJBHk84k9KlA=;
        b=gK38A443J07JEv1eh/lZRr+OP0alDEoLrPFRvrv0zx5PtWmDjpTo4wBqkXvanXqjRb
         womdthz/nhAEw63Hr7UOKqCsf5KERELbxa/Zr5s1O5Mzy8LBJsr8yN34FuO60Jm1IiuT
         UXgjQtyVt5Gwo0tmxjHxcSj1RAoSitwBdXQW+n+vaJbaaYkMDPtVzPJwmd0tSg3sXNDU
         lXcphOgTaWgiVrnkBPDWoXbkjGp9PS3O27W1GwLxqG5n+xVP2vtsFBG1IBPoNTpGRS7K
         eRy5w6Wx8de29tC7h1k4Md4ZVCe4WSHKOUNT+qXUDzCB4ozgZaUlDffa25kNVr4n4ayr
         MYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQr2+CCalKgDrA12cz6kTPFlEgpE4NTSJBHk84k9KlA=;
        b=ap4TgmjDeT6X6c34JXLD+gH81nFSaOS10ukm4iLnUqD9kz5eeoLIXMvCOHPZ/5ajxj
         tSPsTCAKBNyfmY0U/A1pqvimEfxtCfwGwlCAldyNC3iDMbUy98/91ga6Kl8pBLVXIeZA
         r3/NMTmztFBPhoqxW4gUH4ZXGsFxB78qIktHcvWc6Pwyq9NxAeDleDfCoSrOBc3iTYo1
         1FTO1FmmSEngBcuCJTXoTyYNkewLQH29S5JFEIMg6lvq7xJCydXLNmKfrjordSoEZVHg
         x/NthSjdnFWbKvOTTWWTBID1rW7fh/gX/8DJOC0N1nHUc1mG52KzSPG7GfTpO87M8uUY
         aPmA==
X-Gm-Message-State: APjAAAVrZ67p/F+o54Fazh8KaaORHHhymUV/+9Ib59KrOi6ioCYAi4A6
        t330aymOWKS1vEj1oeccGf3bJ3I/6RmfcSPLkZAIWA==
X-Google-Smtp-Source: APXvYqxjWDEwbkiE2ZsJXoDXKy8bI8tnus4ZqI8PGuQRfd0/qEvKV0AcHKVrO9J3tvHAbI2QR49LL7GHmT1tgXzHaKI=
X-Received: by 2002:a17:902:8484:: with SMTP id c4mr19844087plo.223.1566839045123;
 Mon, 26 Aug 2019 10:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190812215052.71840-1-ndesaulniers@google.com>
 <20190812215052.71840-12-ndesaulniers@google.com> <20190813082744.xmzmm4j675rqiz47@willie-the-truck>
 <CANiq72mAfJ23PyWzZAELgbKQDCX2nvY0z+dmOMe14qz=wa6eFg@mail.gmail.com>
 <20190813170829.c3lryb6va3eopxd7@willie-the-truck> <CAKwvOdk4hca8WzWzhcPEvxXnJVLbXGnhBdDZbeL_W_H91Ttjqw@mail.gmail.com>
 <CANiq72mGoGpx7EAVUPcGuhVkLit8sB3bR-k1XBDyeM8HBUaDZw@mail.gmail.com>
 <CANiq72nUyT-q3A9mTrYzPZ+J9Ya7Lns5MyTK7W7-7yXgFWc2xA@mail.gmail.com>
 <CANiq72nfn4zxAO63GEEoUjumC6Jwi5_jdcD_5Xzt1vZRgh52fg@mail.gmail.com>
 <20190824112542.7guulvdenm35ihs7@willie-the-truck> <CANiq72mcSniCzMzW6AX_5tG5W2edjEmZ=Rf=jo-Mw3H-9RVJqw@mail.gmail.com>
In-Reply-To: <CANiq72mcSniCzMzW6AX_5tG5W2edjEmZ=Rf=jo-Mw3H-9RVJqw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 26 Aug 2019 10:03:53 -0700
Message-ID: <CAKwvOdkhJQEwWNZSC08sg9vGjydTXrbqNqNrqfN6vbRZUsjGvA@mail.gmail.com>
Subject: Re: [PATCH 12/16] arm64: prefer __section from compiler_attributes.h
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Yonghong Song <yhs@fb.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 5:48 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Aug 24, 2019 at 1:25 PM Will Deacon <will@kernel.org> wrote:
> >
> > Which bit are you pinging about? This patch (12/16) has been in -next for a
> > while and is queued in the arm64 tree for 5.4. The Oops/boot issue is
> > addressed in patch 14 which probably needs to be sent as a separate patch
> > (with a commit message) if it's targetting 5.3 and, I assume, routed via
> > somebody like akpm.
>
> I was pinging about the bit I was quoting, i.e. whether the Oops in
> the cover letter was #14 indeed. Also, since Nick said he wanted to
> get this ASAP through compiler-attributes, I assumed he wanted it to
> be in 5.3, but I have not seen the independent patch.
>
> Since he seems busy, I will write a better commit message myself and
> send it to Linus next week.

Sorry, very hectic week here last week.  I'll try to get the import
bit split off, collect the acks/reviewed-by tags, and resend a v2 of
the series this week.
-- 
Thanks,
~Nick Desaulniers
