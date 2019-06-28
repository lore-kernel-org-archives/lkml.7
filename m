Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E5CC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4BA20665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 09:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T7nBZsHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfF1J0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 05:26:53 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40899 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfF1J0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 05:26:49 -0400
Received: by mail-lf1-f67.google.com with SMTP id a9so3518909lff.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 02:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wq4uV6TuyH2wgrXO6dLo0IFjBcNz+4TUFVVmynqQmqA=;
        b=T7nBZsHZw/8UcjeYFRks7+Eva2K/3e1j/QIWRpChWFd+dTtuHZWRuEcXs11S5mYn8e
         Dd7FOfioX2ifWa2RmYXPNgdL/eqFHZqZWmU6somvzxCLtxUcAo+QVbkfcI+B8nbkjXM8
         xJsHXeV9Bg5176S1omOvyVoveyhBcnzLKAKVPnDZBTXCHeq5w+3ohntbyyxJ5zanrsRT
         6YEOrzTKleaMpv0j2Uvgb4NMXyqBhJKmBD/6dZMVFhbYRB0BTstXeHUB06Pgg/g/jVNR
         8jJ834GpUUrM05TY2aJxTSDjuUP+QqFpQv8/cWR+BR3eKBln2zW+tU6DtO0jGCONJyuc
         Eg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wq4uV6TuyH2wgrXO6dLo0IFjBcNz+4TUFVVmynqQmqA=;
        b=C77owOpebyS81q/BCE2FqTygALqn8TeWXmVHa14+nJCzUSqvfv5KjqqmweEXq56o1V
         p6fN3rvJlaWSkbe2i/jPNfz19L+so/msmXgNzsI0hAUT7WR7OiFyX8whCKiG23jH8T8p
         Br4arSBBs6VrUfgzbbT3fKW5lzO+eg++E8eQT8rqbu76vXEQmJCr4/iolMPjeS4gYBCo
         6djnNhvF06VnoRBt8LZC0lZzlbOQDGH304VQTSKm6vxpFxRB8ntpEbBf4ORyDRrWPBzN
         og5BsQVzrWCZHjQvcajifmleXqp7g1B0aZQygjwqpGVaKR7Py7Je1/pUwBDPDHVtVMTK
         EP7Q==
X-Gm-Message-State: APjAAAW1lrtzCWvgJYeU5LnFqAnCwe0ONRwWvLc/6fH+8aOEqaPfz9TU
        eUn7kFHFkTlJSHisv7zIENQUsZJ75PAlz7JdDmX39w==
X-Google-Smtp-Source: APXvYqxZow6JTfEigRwpH8n/PtdL/0nTxAip4vmcDqLYc1cX/YUDxITdfUsmFNehMEuUFoW/17Gqvjs/oZenFRcn7MY=
X-Received: by 2002:ac2:48a5:: with SMTP id u5mr4624411lfg.62.1561714007021;
 Fri, 28 Jun 2019 02:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <201906261343.5F26328@keescook> <20190627080207.sdpwjoi4wnc664gp@mbp>
 <201906270856.8CF50064@keescook> <20190627162505.GD9894@arrakis.emea.arm.com>
In-Reply-To: <20190627162505.GD9894@arrakis.emea.arm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 28 Jun 2019 11:26:34 +0200
Message-ID: <CAG_fn=UhdoyWjFPxdFOJ7XFRHb62RErxFjOKnFeHtMJWTib7pg@mail.gmail.com>
Subject: Re: [PATCH] arm64: Move jump_label_init() before parse_early_param()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@lca.pw>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 6:25 PM Catalin Marinas <catalin.marinas@arm.com> w=
rote:
>
> On Thu, Jun 27, 2019 at 08:58:03AM -0700, Kees Cook wrote:
> > On Thu, Jun 27, 2019 at 09:02:08AM +0100, Catalin Marinas wrote:
> > > On Wed, Jun 26, 2019 at 01:51:15PM -0700, Kees Cook wrote:
> > > > This moves arm64 jump_label_init() from smp_prepare_boot_cpu() to
> > > > setup_arch(), as done already on x86, in preparation from early par=
am
> > > > usage in the init_on_alloc/free() series:
> > > > https://lkml.kernel.org/r/1561572949.5154.81.camel@lca.pw
> > >
> > > This looks fine to me. Is there any other series to be merged soon th=
at
> > > depends on this patch (the init_on_alloc/fail one)? If not, I can que=
ue
> > > it for 5.3.
> >
> > Yes, but that series will be in 5.3 also, so there's rush for 5.2. Do
> > you want Alexander (via akpm) to include it in his series instead of it=
 going
> > through the arm64 tree?
>
> It's pretty late for 5.2, especially since it hasn't had extensive
> testing (though I'm fairly sure it won't break). Anyway, it's better if
> it goes together with Alexander's series.
Am I understanding right this is already covered by Kees having sent
his patch to -mm tree and I don't need to explicitly include it into
my series?
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
