Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFA1CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D66208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 15:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572362635;
	bh=Xjm58CjAmwj5IgwsPRLLJpZevG4ix9bqjOAO1BGI9nE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O5MQmvEzikmAUF60goz10VN5z6ATh8FroEN3CXqAwuoRNlOwn863lgGJkTGnIg5r9
	 0VxtwNPAEKL6WT+Y4IKQDG4FsWrDVhZboX0DsWNaqbNsyVRESHEYd7h3uKPlPEZ0OH
	 e7hFH4v95XoWAvyy7iNqHxKbfYhk2WmYcro7yXdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389928AbfJ2PXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 11:23:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37270 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbfJ2PXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 11:23:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id v2so1472634lji.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 08:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvcHp9MFdLfR8bNZqbPTsMw7QcOtDR/7+z/zPwHYvaQ=;
        b=bPEliTXJlKPIfokM04PB6S4SACA7puiFXlkFLxkxasWmULHE1IBGCUpacvoamu8m29
         yb9kZlYAsZzuU5B4+R82A32GS8PX/eGBMJQkuVZRuTSVqqgvY/1EDnB/TDR6YQrfG/gs
         uiI9Bb9zgYupw33RQI8PaZ2a5EIzNUmk2diiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvcHp9MFdLfR8bNZqbPTsMw7QcOtDR/7+z/zPwHYvaQ=;
        b=HGV3tg1ZYMwzK+WUZK/yl8270AYiOjHPXEP0WO20+1sblAWaSFHhRNz7apo7eV2SXQ
         DJAjmAJ+iqVmAkaScJRatwz9Uj9mH99hcuI1mtdRBo+GvD3CYwreKaSuCjyBaP2ORNdh
         GEc13jm1sHSOftEItAyEUvO202eH3gHXntPEDZGUjsZeSujm1BH6zyy0lMItxqq4CT4K
         f3jFSqmX0kqiZUka4m/SkXYhgK6krmz6+05BGLcZuD6JJWZSDbtsD03CFVh1Qm4K/LWt
         +/vQtG18wl/M1YzdpgfffPPIRVOGJ/njRACHiiWCC54pFAV0vY207ie5UMFuUm2jWywH
         /1Tw==
X-Gm-Message-State: APjAAAV1HYNZS7/0yoWt7Q81/QVNM65GDtdQu5l+3OfRIJR/p1HOExqO
        1bAiar/zYn4jFTUYa9OmGujK/511IwNgHA==
X-Google-Smtp-Source: APXvYqyEmM/NIrwy5URxWOpYj7CWFwJPaF7+6UQgP6zjldXPj6rpejo3pN654WrrfdxfQK8dTVyCBw==
X-Received: by 2002:a2e:3514:: with SMTP id z20mr3040558ljz.84.1572362631689;
        Tue, 29 Oct 2019 08:23:51 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id n7sm853507ljc.45.2019.10.29.08.23.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2019 08:23:50 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id v2so1472451lji.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 08:23:49 -0700 (PDT)
X-Received: by 2002:a05:651c:331:: with SMTP id b17mr3106750ljp.133.1572362629407;
 Tue, 29 Oct 2019 08:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191029092423.17825-1-haokexin@gmail.com> <CAHk-=wjU9ASiPYFqmGJtOqG-0KtuNtu-aNPPY4M1AbcPdrfz7A@mail.gmail.com>
 <20191029140921.GF23786@pek-khao-d2.corp.ad.wrs.com>
In-Reply-To: <20191029140921.GF23786@pek-khao-d2.corp.ad.wrs.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Oct 2019 16:23:33 +0100
X-Gmail-Original-Message-ID: <CAHk-=wja287VnDKdftnQUYYe=YqX5Lz-iweA-RkcG3EGS2sD6w@mail.gmail.com>
Message-ID: <CAHk-=wja287VnDKdftnQUYYe=YqX5Lz-iweA-RkcG3EGS2sD6w@mail.gmail.com>
Subject: Re: [PATCH] dump_stack: Avoid the livelock of the dump_lock
To:     Kevin Hao <haokexin@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 3:09 PM Kevin Hao <haokexin@gmail.com> wrote:
>
> Do you mean something like this?

Yeah, except I'd make it be something like

                local_irq_restore(flags);
-               cpu_relax();
+               do { cpu_relax(); } while (atomic_read(&dump_lock) != -1);
                goto retry;

instead, ie doing the cpu_relax() inside that loop.

Obviously untested.

          Linus
