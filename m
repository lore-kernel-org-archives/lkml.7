Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF92C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090AD20828
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.washington.edu header.i=@cs.washington.edu header.b="lOFXls3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfF1Rlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 13:41:31 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40045 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfF1Rla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:41:30 -0400
Received: by mail-io1-f65.google.com with SMTP id n5so14213215ioc.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uqJ6r1Mjakiqpd0ZD9iGpyAkpv+xSUcUqESly9SnS30=;
        b=lOFXls3FkwUg97CyPjvyXgrcjW6i3Y09TjD9O1sKjz+4VVLO0kGXwLk7Lh5Ks/8aAW
         JijWwpKYFieazAh57d6dT1oO3AO01TZnC7WoBmE1OSNdS8W3PrRrtsH2CbmHSwhjVWw+
         zeSbiFOvp9Kpu25n4n1vGhIUhGVzJdYcNha8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uqJ6r1Mjakiqpd0ZD9iGpyAkpv+xSUcUqESly9SnS30=;
        b=RtrlwvMN0CndXBEsmS816KtvhJMZSoRXOk0yF87TMNDV6ByVJcTjn77uqU4soez2ji
         kDFCQoBic3brQvhLl9U5HIh0+GFKktR/47mV799fo8vagWc5qVSsybg76id6c2W/aZVR
         SNiguKpxdUeYWwtcHtiXijgFb0RuSSUlJ8AI9o/i51I3AE+SyGKYLedVBcjtsemv81Oz
         lg91yz+IIBdop1cPA1Jw3ibQqIi+EsoPO2e8vjfLt20BZtNmxkRVeH87QGoAR+QH7Ia0
         YcQkLtfPtFcw2S15lP4jUDIxWpUQ4QB/TvenNH+Nr1AK/M9QQqmGqY4Rtf0GKZLwXE7U
         03oA==
X-Gm-Message-State: APjAAAX9s4pwwu9tMgpPrx781JaC15HCWCdczzkgqDyyqdJCNcBaHglH
        /H+Ck9UNRopmu3Nxj72aL1vND1UPYrTEm89nsh3uwA==
X-Google-Smtp-Source: APXvYqwcltk4JmdpNvtJF1qrqeEE0+mFopXztg8enMwMB7rkn3G9Vg90wC0+Jkas2dqkKaCJf2/GoPK0tBQW9eKSXf8=
X-Received: by 2002:a6b:f90f:: with SMTP id j15mr12016235iog.43.1561743689556;
 Fri, 28 Jun 2019 10:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190626231257.14495-1-lukenels@cs.washington.edu> <87y31nuspw.fsf@netronome.com>
In-Reply-To: <87y31nuspw.fsf@netronome.com>
From:   Luke Nelson <lukenels@cs.washington.edu>
Date:   Fri, 28 Jun 2019 10:41:18 -0700
Message-ID: <CADasFoAqjZVnMFGZNgQMhXsBC78vbb-u1PPv_aZx3fMXeHBXKg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] RV32G eBPF JIT
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        linux-riscv@lists.infradead.org, Netdev <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 5:18 AM Jiong Wang <jiong.wang@netronome.com> wrote:
>
> #define BPF_ZEXT_REG(DST)
>         ((struct bpf_insn) {
>                  .code  = BPF_ALU | BPF_MOV | BPF_X
>
> So it can't be BPF_ALU64. It is safe to remove this chunk of code.
>

Thanks! I'll fix this in the next revision.

- Luke
