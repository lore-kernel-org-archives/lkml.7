Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B137FC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E5A2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 15:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RPWbux+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389158AbfGYPTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 11:19:19 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:57000 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388736AbfGYPTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 11:19:19 -0400
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x6PFJ2Cm028409;
        Fri, 26 Jul 2019 00:19:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x6PFJ2Cm028409
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564067943;
        bh=ybYKBy2jy2mNaj9dapjCxjrjOczwrfBem/VG0oV9nbc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RPWbux+yjMepS0eHBsNLg6KHVJNe8nyxRgAyeUBrPLRd3lkQ70KNqeCAl4/SFU1rA
         KqBCIJnmWTt2dzLfUOdXeqg+NBM9I3lI8V+DKpydh+IeSPY5DNQ5WiA4bUBUSLIEkt
         CwCTwUmJ/5Nte6KSXD0BHkytFeq93XGtPvEC8kcmddSm6NmhCaqhVNgH28OM66ukCr
         lLHl4P5+M38HUeaBBTMOTcOcN9ExEtQDRXnM8pW4pA5bnQZzg00ryltINj4ovvWtKJ
         oVvWb/xneF1qbgFz9QMY5BMTL9S8MZrPnS+NV0+3zfI6zHcHYFLOddfge1s6iJs6oe
         p7abfWuOYSYfA==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id j8so19975307uan.6;
        Thu, 25 Jul 2019 08:19:02 -0700 (PDT)
X-Gm-Message-State: APjAAAWG2hHadUBZSQoluo44Dern+wLF9J+iIOtiPh5fXNhrhPOBRKch
        fia/qU5R4gKWuy7KXLSaniPkmUGLIChPUQFHcr0=
X-Google-Smtp-Source: APXvYqzREwsVdqY9MpRLTcsyv3GQ7mTlG0gkpVTsr5J+UESJVcs/+a1yYujSjrS2p7W2Tw/dNRFWb+R1W2ZTVW6lnTQ=
X-Received: by 2002:ab0:5ea6:: with SMTP id y38mr56716853uag.40.1564067941791;
 Thu, 25 Jul 2019 08:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190717061800.10018-1-yamada.masahiro@socionext.com>
 <20190717061800.10018-8-yamada.masahiro@socionext.com> <230d2ca1-19cd-b60e-1b1b-6d7413eea9e2@siemens.com>
In-Reply-To: <230d2ca1-19cd-b60e-1b1b-6d7413eea9e2@siemens.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 26 Jul 2019 00:18:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNARu--p-tiJA2RGM5_KSQPSeo6-pkp-4GRd2AwM_1dtD7Q@mail.gmail.com>
Message-ID: <CAK7LNARu--p-tiJA2RGM5_KSQPSeo6-pkp-4GRd2AwM_1dtD7Q@mail.gmail.com>
Subject: Re: [PATCH v3 07/12] kbuild: modpost: read modules.order instead of $(MODVERDIR)/*.mod
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Thu, Jul 25, 2019 at 5:39 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >
>
> This affects also external modules builds: I have patterns here that do
>
> [Makefile]
> subdir-y := some-module
>
> [some-module/Makefile]
> obj-m := some-module.o
>
> and since this patch, the final some-module.ko is no longer built. Am I missing
> something in the kbuild makefiles, or is this a regression?

Thanks for the report.
Interesting. I have never imagined that Makefiles were written like that.

I just wrote a fix-up, but I have not determined to apply it.
https://patchwork.kernel.org/patch/11059033/

It is easy to fixup your Makefile, though.

--
Best Regards
Masahiro Yamada
