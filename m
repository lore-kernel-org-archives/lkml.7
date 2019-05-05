Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD694C04AAC
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 07:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB542082F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 07:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZV9lW0Qu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfEEHFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 03:05:20 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32784 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbfEEHFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 03:05:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id f23so8512102ljc.0;
        Sun, 05 May 2019 00:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v7iSncdIvsuvyTrphAXGuJAYFAkD+y6z0FJYn1j2iZU=;
        b=ZV9lW0QuO+Txr8J6/pYclsUtn6qhm6q+aw2Ada/zYRYutwLYhGR/0qVB/zXCtan7HC
         Hvl7O++4DUMm7PmhW7OkGep0tTWB7pfDELlO/gOeZUkDUUcA0X1HxIAo2x9dVSOEqg9b
         5OFwNj057kowEyNUUezQL+8vsfmJrIYjQRSCpKvaoh/cKjJxvaDeIiEthd3V8jwErDh2
         XeaP8eoplBxpzgkF8Wt7OQ78JRYWQR0A3c0jKdUYvdGkMTWjt2r+S67BH40MK9GBakOr
         HaCPCatBwXWKiIIH3n6dIdQvgnCYWC2Kd2PTpRkOuksp/rN8mcvcfYzVFA8/F6+U9nxy
         Ymvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v7iSncdIvsuvyTrphAXGuJAYFAkD+y6z0FJYn1j2iZU=;
        b=PGqHxx+VUVSz4Vywe5fuKnHznsTHoO533in4jwbNR0JEHtSi8NRhB+rm2aaqjOgHka
         yfY/0yOCIAbnHNYuLxplye91kjeR7j/NK0up4YN3TYh15kPaICOSHuGAzKtuDh4TxH9O
         Nvud4Z6nRhcElzsrXCtk6nj6jNc3udCdAyZt2DedXBp1AEcKwvrleaNdCWPADXjrhGnj
         lmM/cMzcjYA0Aqrvqk6hHCFBKUFQcSTYEMJjq+zLt8QYHd3hzruMcq2KVFhLsgNTN6no
         06RDcW3sU6ODEh+vGH3L8XalKTntOCYzzV3sxEAOaj8MiZItk4WISbK22IGQLGYdkqL2
         qrog==
X-Gm-Message-State: APjAAAX65m0y67V73cTZF3WijwrWpEpE+BLozI2jgaRBCeEvId9p9JS2
        JLnKc0/tw0U5tqNVTOOD2pN/iJeF2lzneH01ND0=
X-Google-Smtp-Source: APXvYqwzg0DtE4Y05nlp4ITu2sCe9+QtfxbhcVcWyBhvsHXtMsB9fvX522nv/54/3I0yk2DQkoo7EYf1RALeLvxv+AY=
X-Received: by 2002:a2e:9703:: with SMTP id r3mr705226lji.37.1557039917517;
 Sun, 05 May 2019 00:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAH3MdRVkUFfwKkgT-pi-RLBpcEf6n0bAwWZOu-=7+qctPTCpkw@mail.gmail.com>
 <1556812610-27957-1-git-send-email-vgupta@synopsys.com> <CAH3MdRWkiFSRA+PRo53_Syx9OBmyj2U_ebap-9iBR8L7xW9UVw@mail.gmail.com>
In-Reply-To: <CAH3MdRWkiFSRA+PRo53_Syx9OBmyj2U_ebap-9iBR8L7xW9UVw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 5 May 2019 00:05:06 -0700
Message-ID: <CAADnVQKOR7NJ=zDLndJpTnVjnkjr1UrtWG_2vwgJK3QcCAADcA@mail.gmail.com>
Subject: Re: [PATCH v2] tools/bpf: fix perf build error with uClibc (seen on ARC)
To:     Y Song <ys114321@gmail.com>
Cc:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 1:20 PM Y Song <ys114321@gmail.com> wrote:
>
> On Thu, May 2, 2019 at 8:57 AM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
> >
> > When build perf for ARC recently, there was a build failure due to lack
> > of __NR_bpf.
> >
> > | Auto-detecting system features:
> > |
> > | ...                     get_cpuid: [ OFF ]
> > | ...                           bpf: [ on  ]
> > |
> > | #  error __NR_bpf not defined. libbpf does not support your arch.
> >     ^~~~~
> > | bpf.c: In function 'sys_bpf':
> > | bpf.c:66:17: error: '__NR_bpf' undeclared (first use in this function)
> > |  return syscall(__NR_bpf, cmd, attr, size);
> > |                 ^~~~~~~~
> > |                 sys_bpf
> >
> > Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
>
> Acked-by: Yonghong Song <yhs@fb.com>

Applied. Thanks
