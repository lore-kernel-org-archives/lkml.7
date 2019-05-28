Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED19C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96B720989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBhnDbZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfE1SVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:21:51 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:45942 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbfE1SVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:21:51 -0400
Received: by mail-pg1-f171.google.com with SMTP id w34so6805440pga.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 11:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=09HIvg2inPi7bphvMoCycYNA4y8pfUWBWd3bGRh5UYc=;
        b=pBhnDbZW7weiEpqsw3Y5qTBVUgv0FmvS8/e3P0d9kRzSdRDnCw1cL4tUs6jSR/m5bo
         YPoVDz2oc2661lI+8eH4/DYUpVk6lGERmX1QHHBJTRYuxXhiZG5FBNfITO7j3O8TV4lz
         Ou1Dn36fLQ9HT9dalRdpfuN3mJfL/xD6zhu8E3K5M8++z0e9Mip5lDZPq/M3LmtmTc7T
         rIxcpOnadY4J0jjI5R+uiYvfwaFj4WnjRSvD/kE0hzJLGmp9eUxXsoL98goNAf9BJvGj
         MKJ41/QNvh6+lHQrNPjNuUBl+grVbneZigUeJKsRywEaQSI4UTlPnN9NhUoYjfjUJeE0
         ubJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=09HIvg2inPi7bphvMoCycYNA4y8pfUWBWd3bGRh5UYc=;
        b=Hy+f7VTynggO2liPTSP8bdR2zkS9Q53LZC47nc+On5vMmDESa4nPN2r3UNaNSX8Dub
         RfJrRdgVbgmv36LmtIRC56Qg7NaLUUqwlHZ7hJaK+dS3S0KTT3UQrg/QaWJBiAc2/I9z
         5wU8DiWDAnPNGh4PhzJeEmAbvEpWnMmLTHuymW9CmOtF7P7pVu8QEmge4BUqf06GLvbs
         EMAD1U/OxScURerKG/jZuicIYg0kkVJqBLMHNGDJdv2JylSXa+T6TUMKsq3PiMM4uKG7
         RNDjv81jkyf47A2pS8V17VzXCjsjnNeW1DWaJdwkzp+x7MRyXL+HwJY/UwFBpepoo3Dw
         wEhQ==
X-Gm-Message-State: APjAAAXRYRUoz48PbO/O1I67+YfFnOY35AGHSrOU4A+YnPZuACacrhfW
        66o9osgYlex4WH1L3jcDa9LDCi+HBaJGKg/Y3WsJXQ==
X-Google-Smtp-Source: APXvYqx5WeSrkC1uwhUc1CyCTbgJzbBNRbGo8bvv0jV4m0zaXpB81LG3x4pn0T7Ck30UKYCidZJnkBIxB7HXm7Q/byQ=
X-Received: by 2002:a63:1d05:: with SMTP id d5mr23972796pgd.157.1559067710633;
 Tue, 28 May 2019 11:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190517221039.8975-1-xiyou.wangcong@gmail.com> <20190520065906.GC8068@krava>
In-Reply-To: <20190520065906.GC8068@krava>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 28 May 2019 11:21:38 -0700
Message-ID: <CAM_iQpXoD3YzkUzyLSF9qKLpbGxXVeOdFccLbv-mCTVfshx-2w@mail.gmail.com>
Subject: Re: [Patch] perf stat: always separate stalled cycles per insn
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2019 at 11:59 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, May 17, 2019 at 03:10:39PM -0700, Cong Wang wrote:
> > The "stalled cycles per insn" is appended to "instructions" when
> > the CPU has this hardware counter directly. We should always make it
> > a separate line, which also aligns to the output when we hit the
> > "if (total && avg)" branch.
> >
> > Before:
> > $ sudo perf stat --all-cpus --field-separator , --log-fd 1 -einstructions,cycles -- sleep 1
> > 4565048704,,instructions,64114578096,100.00,1.34,insn per cycle,,
> > 3396325133,,cycles,64146628546,100.00,,
> >
> > After:
> > $ sudo ./tools/perf/perf stat --all-cpus --field-separator , --log-fd 1 -einstructions,cycles -- sleep 1
> > 6721924,,instructions,24026790339,100.00,0.22,insn per cycle
> > ,,,,,0.00,stalled cycles per insn
> > 30939953,,cycles,24025512526,100.00,,
> >
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks for reviewing it. Is there anyone takes this patch?
