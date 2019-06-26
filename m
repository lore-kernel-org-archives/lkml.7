Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E7CC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5C421738
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 23:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.washington.edu header.i=@cs.washington.edu header.b="ZaJnj72v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfFZXUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 19:20:50 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33643 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfFZXUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 19:20:50 -0400
Received: by mail-io1-f66.google.com with SMTP id u13so622797iop.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 16:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=brea/2Qx9pBcYGaH6DB1Fc3qM+qPNzkSABIn8ioCvPU=;
        b=ZaJnj72valkhOWXD57cAGw+gAAyEfQy/JR47wmIiwfnDtp1TQpOJwz7GpvJSXTUD0u
         ZA/U+rG82kpbeH8Uqa6aoazQ8fD/ngaK2CVgNrTaqAQFz3f57WqXINxufX5TlzRjxCQa
         xI8Ss8Ko+wdFKlJb0vWMvWfg8h0WPripGQ3EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=brea/2Qx9pBcYGaH6DB1Fc3qM+qPNzkSABIn8ioCvPU=;
        b=SmTtd+Aer3QRmy57a5+6qfdkaM63AQnh+MHBptMC93Rxo9pYSuO+Vncp0i/efa0ktW
         GwHiqQUq23S9FTMmGxieNE7D0F4XnFsdA6HyfrKyfCbx82nClJl3/VVb8DZzbf3UMumU
         vIgIxMOrTaUr4U9vTC87V/nVPrrh5XG4ONvwS5qJOb0m/VwYI1oyMbFzRyARRNJB37rP
         HPNVm5rsxJoivivP3qfnyeD4FcXCghj9KBGTnjOedih8IvNoSKiNRJQHDws4FNuV0jG/
         Y1BUmKnnXhkC8Lyn7oMO9QShEjJXRzr+cwto14dHA4924fbsi70+6e60qzitlFAVz+gQ
         g1XQ==
X-Gm-Message-State: APjAAAUuMSyCpT+LJvqSJi5XMgYHhgX1/94j+6lt5pr5vBi8pKMQ2xn7
        yTkT+DlZpkM5mS8S3td/Pu5ONut2aruJHqtE8EwRpQ==
X-Google-Smtp-Source: APXvYqx4WUGRRdnDMn1qRC9QzduXjQrWAsPLCwLSndDqxI0ewueoPskdlrvCJKhtJLOzQy0pNf8LolgeC9PNFB3+1so=
X-Received: by 2002:a6b:f90f:: with SMTP id j15mr894411iog.43.1561591247732;
 Wed, 26 Jun 2019 16:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190621225938.27030-1-lukenels@cs.washington.edu> <CAJ+HfNgHOt4gMSq_gufwxb=cKekCfLrk-uGJuGeDiOeQV1-wwQ@mail.gmail.com>
In-Reply-To: <CAJ+HfNgHOt4gMSq_gufwxb=cKekCfLrk-uGJuGeDiOeQV1-wwQ@mail.gmail.com>
From:   Luke Nelson <lukenels@cs.washington.edu>
Date:   Wed, 26 Jun 2019 16:20:37 -0700
Message-ID: <CADasFoC6ga_DuHL+RxLPzBhMHr+Jj5OgGkjuUgX0o6Rx5vsvdw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] RV32G eBPF JIT
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 3:11 AM Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.co=
m> wrote:
> >   - Far branches
> >       These are not supported in RV64G either.
>
> This would be really nice to have, now that the size of BPF programs
> are getting larger.

I've sent out an updated version of the patch here, with support for
far branches: https://patchwork.ozlabs.org/patch/1123052

Thanks!
