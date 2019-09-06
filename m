Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAC6C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8864E20578
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6Q9UjJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405961AbfIFRGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 13:06:36 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41709 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405919AbfIFRGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 13:06:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id j4so5637495lfh.8;
        Fri, 06 Sep 2019 10:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NvfoOyEj+ih5o8wpzVxnSkvdM4Np7xE84LtSUp5GXZY=;
        b=a6Q9UjJnl32Gh5jKV9aA1ESbWUq3TasZZByboadX5fxEGDdpUcSpQoyCrMHes6mySc
         3BIFissMrM21WksNtJtPzit0lLOoyBZ5dbrM1pFFZwhSHe1C35l3Q87JmPhJUYH4pAil
         EzLisbCm9JUYZPepSrNcMkvnW9bVeDi3a5EUIfGHdKVaNwnNFArWAZSYM4AMy9xliMCE
         o1cwETUsX8MAJqQXcJ0Arvf3wp2rXdzHeCbj7nlz/SNfaHwvlxsHBYaNIgjHEwcbYxto
         hIVrUPBjWpOQlmEJSnsL/YTcBsvJm0xSYD4/c8kwv3iWnUCirN2D3d2DPW1xA6Z1SZG9
         i94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NvfoOyEj+ih5o8wpzVxnSkvdM4Np7xE84LtSUp5GXZY=;
        b=dv2RJ12tEUFhhafx7L/2syEBAaXBQj4Sjqij1SdDLYMC/plJ4yGeeWig8Z81ZEYIty
         XgjEk3pOs4AFIK9SDJFH48rYU/80ezXQxum0c5L5RnvOwE4dQyR6BN0Fhcz6gvwPnwk5
         hb8vSGWrUdoIaJDFCn/QxkuLAQcH6ulX+hpCJAX0WybBahhQtYHkG/G4+MfUPwp0gcVw
         CsIgwiwgI8RWhQMgCq3RofzlV8PJ04/nnoiO3RajTGjJbHL96RwmeHUPY0OKv4onY2GM
         n0MSjyWYMZgKlhAMjhP3jyvdMpZ6fJr8TA+UF4tfXyUbodiceMEVP93hHxyjc3UN84am
         6GaA==
X-Gm-Message-State: APjAAAURgl22LfbaJ1Uc5zsOWDCdV+8wCMmwmOH0Jpk40yJkGxaD6bzT
        IYMIvwRwyQNJqSls7r3zpIyPWmw0gZBVbr51kxg=
X-Google-Smtp-Source: APXvYqyYdeEKWQWkzvHxoiCTooug/jA/xryoDQ94eaq/KpyAX9ozJaRkjngWwLnE70ojLdQ+3Es+pZ8vvMksOdoIy/s=
X-Received: by 2002:ac2:558a:: with SMTP id v10mr6747840lfg.162.1567789593473;
 Fri, 06 Sep 2019 10:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190905211528.97828-1-samitolvanen@google.com> <0f77cc31-4df5-a74f-5b64-a1e3fc439c6d@fb.com>
In-Reply-To: <0f77cc31-4df5-a74f-5b64-a1e3fc439c6d@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 6 Sep 2019 10:06:21 -0700
Message-ID: <CAADnVQJxrPDZtKAik4VEzvw=TwY6PoWytfp7HcQt5Jsaja7mxw@mail.gmail.com>
Subject: Re: [PATCH] kcm: use BPF_PROG_RUN
To:     Yonghong Song <yhs@fb.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Tom Herbert <tom@herbertland.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 3:03 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 9/5/19 2:15 PM, Sami Tolvanen wrote:
> > Instead of invoking struct bpf_prog::bpf_func directly, use the
> > BPF_PROG_RUN macro.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> Acked-by: Yonghong Song <yhs@fb.com>

Applied. Thanks
