Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9691C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865BE22429
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z5T8NRw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfKSTF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 14:05:59 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41489 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfKSTF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 14:05:58 -0500
Received: by mail-ot1-f65.google.com with SMTP id 94so18875437oty.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 11:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0NatauBtPtJXOsbjFvuk9RBByg3dOvLiEzcuEjEIyik=;
        b=Z5T8NRw+0YDFCLzG1USKVrnQoi6akbzWg0AEZin9GQL7FupBZLWGa2T73NmchR7aSA
         pPfLQeAunLtuqxrSAXlTBx+JySV2avVYIQCmFaA05Dey3NogSQBBI4yygA7BCbP5/bpL
         Yz4o8QOp7wohXXlR2Faby+FBLa53lWNSYyaS7OaOdRc+bogOVA/MpJLVJaQtjBISre/G
         VJzG2KEDfV/FObm/rejuXbOc09Rlb98N5iCCm8csk+Bdw3QjvHpR0amM+IzfupcCN6LJ
         eRQqBM94k3KBJvq0hvkBY9LUx/UhTHhZXWIj+4eY3J7AO4aeEvK7IloE+ok2+yYUST7C
         /CuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0NatauBtPtJXOsbjFvuk9RBByg3dOvLiEzcuEjEIyik=;
        b=mSrv48S++S6jd6Sw7E9tTbj8uHfu7GLcUhEnejKHB4A2KpZ/lnRSCSEj43Wu5TXOry
         +SOasxcok7e6d+2T1KaV1rR2cDE3iUefPAMOItDEg0kmSCsjSrQNrgG7PdZdneycYRQ4
         TFk0qxRfMC2nM5mGoyb1h5c032rDSRGtLwGlG7L8ZPPVijjbOsDAvcLLAgbCeufe43Nr
         9tOAS8DhaB6SKxWCSTCjwUIJtA3eIjwZzrlv8QY5oeZkH4pkVIw2Abxh8Q/EuDa/WiLt
         yIKwvs2D6JuPe0r/PAawg7yhe5fcjS4cOUjX7see8rBVUtP6b96dsVQYOhSBq3PtpbMb
         NUfg==
X-Gm-Message-State: APjAAAWDb58xvGzmL7VH4j0DIQiJfgQvyp59ruWCtUvXPr9LtbVbW7mj
        U/EQu3r4BjXDtvhYSAVe9oru1v0Zjev2P3fviA1GWQ==
X-Google-Smtp-Source: APXvYqyUZtQAxkb9wAVmkm9Ylw96P/rfxBE9DAOE0RfSEB3iGv1yRwmd6+Rz7VODo0gvsGqNKgLx2YPETkbUgURxTzg=
X-Received: by 2002:a9d:69cf:: with SMTP id v15mr4680730oto.251.1574190357041;
 Tue, 19 Nov 2019 11:05:57 -0800 (PST)
MIME-Version: 1.0
References: <20191119194658.39af50d0@canb.auug.org.au> <e75be639-110a-c615-3ec7-a107318b7746@infradead.org>
 <CANpmjNMpnY54kDdGwOPOD84UDf=Fzqtu62ifTds2vZn4t4YigQ@mail.gmail.com>
 <fb7e25d8-aba4-3dcf-7761-cb7ecb3ebb71@infradead.org> <20191119183407.GA68739@google.com>
 <1574190168.9585.4.camel@lca.pw>
In-Reply-To: <1574190168.9585.4.camel@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Tue, 19 Nov 2019 20:05:45 +0100
Message-ID: <CANpmjNMfCNqgsXQdDckOg0kuMgvnD8_jka8N0AT2K3hC=CUe0w@mail.gmail.com>
Subject: Re: linux-next: Tree for Nov 19 (kcsan)
To:     Qian Cai <cai@lca.pw>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019 at 20:02, Qian Cai <cai@lca.pw> wrote:
>
> On Tue, 2019-11-19 at 19:34 +0100, 'Marco Elver' via kasan-dev wrote:
> > On Tue, 19 Nov 2019, Randy Dunlap wrote:
> >
> > > On 11/19/19 8:12 AM, Marco Elver wrote:
> > > > On Tue, 19 Nov 2019 at 16:11, Randy Dunlap <rdunlap@infradead.org> =
wrote:
> > > > >
> > > > > On 11/19/19 12:46 AM, Stephen Rothwell wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > Changes since 20191118:
> > > > > >
> > > > >
> > > > > on x86_64:
> > > > >
> > > > > It seems that this function can already be known by the compiler =
as a
> > > > > builtin:
> > > > >
> > > > > ../kernel/kcsan/core.c:619:6: warning: conflicting types for buil=
t-in function =E2=80=98__tsan_func_exit=E2=80=99 [-Wbuiltin-declaration-mis=
match]
> > > > >  void __tsan_func_exit(void)
> > > > >       ^~~~~~~~~~~~~~~~
> > > > >
> > > > >
> > > > > $ gcc --version
> > > > > gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407]
> > > >
> > > > Interesting. Could you share the .config? So far I haven't been abl=
e
> > > > to reproduce.
> > >
> > > Sure, it's attached.
> >
> > Thanks, the config did the trick, even for gcc 9.0.0.
> >
> > The problem is CONFIG_UBSAN=3Dy. We haven't explicitly disallowed it li=
ke
> > with KASAN. In principle there should be nothing wrong with KCSAN+UBSAN=
.
> >
> > There are 3 options:
> > 1. Just disable UBSAN for KCSAN, and also disable KCSAN for UBSAN.
> > 2. Restrict the config to not allow combining KCSAN and UBSAN.
> > 3. Leave things as-is.
> >
> > Option 1 probably makes most sense, and I'll send a patch for that
> > unless there are major objections.
>
> Both option #1 and #2 sounds quite unfortunate, as UBSAN is quite valuabl=
e for
> debugging. Hence, it is desire to make both work at the same time.

Apologies, I think I was a bit unclear with #1. For #1, this just
means that UBSAN is being disabled for the KCSAN runtime and
vice-versa. All other parts of the kernel are still instrumented with
both.

See here: https://lore.kernel.org/linux-next/20191119185742.GB68739@google.=
com/

Thanks,
-- Marco
