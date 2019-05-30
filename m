Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F43C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 05:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1B032605F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 05:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck0fdUx3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfE3FUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 01:20:15 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39699 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfE3FUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 01:20:14 -0400
Received: by mail-vs1-f68.google.com with SMTP id m1so3590588vsr.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 22:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oa2XmYFYaHQCqkjGn+uHZ6oMylXcAxewRNyQ+T2pvSA=;
        b=ck0fdUx3qlekQ6XD3iyUQ6GxahV8SsA1xj2y/dpxn1bg81IYZ6ANB3rcRNTrZUmExc
         ypDf+MYG5fygkDbeII077c/s/UWa5S2IfP0b1Kbj3V/EJUM/ZCVqp76o6f9Lzf5PcuRx
         AghFTKbCId16wOFLWE/aM9zt5ptOhAAM7MrdGEhBD5XbAVPY8TEGjsOWJnlEVV0Jxhy9
         9lK2+rU0p7MquCsirQ9DUTbUiVF8FdYhlPYvJKOWdWrtoxdixrYA4UM5wcKzrCAn4PWP
         Fvt+KZaGAhx+9YKHV3BPs9aMuyyoVMoLyxXO9Fjkqpg5KYYhVjv1LzoLXqXzFj2tZHIH
         vfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oa2XmYFYaHQCqkjGn+uHZ6oMylXcAxewRNyQ+T2pvSA=;
        b=Q6Wdp/71GWM9zskk1OmNfVYl6ACKQd6TCFBknBjJxlnEdnaZmCxDBHHCO3hde9ZRR/
         WXefxQ7dYgHIB8OGjeru8hoWMC2S4XWeTSeD9agDarmDtdcNHqioKWZIeZmCPvEWYGMv
         OMaWz5nEaVSeFzEayxNqADOjh7ecDtNRlwTFNp9NHRyikxMtyqqvsqayO7tcqBHECh2F
         OEDuAyD7ugAmw1jn3LdOUbafHyMQRLgVKH0UYlxqcpjHXtGddgD4ppr+GTWTkbOxIDBW
         lLS0uPKuMt2kPrxmkQ0HeELJqSUO56cRnn0H7Ykr0j5tRgWthY+/4pu/jA9bg3lx1LV3
         8o8A==
X-Gm-Message-State: APjAAAVLovi1PStZ8jRR2zcdnxr3/3cmo0hDOgzy0aAEcg7lPDCx/k0h
        R1/fsj1d4ZzNE/77e+HSI7vylEAv0qCp0grD2QI=
X-Google-Smtp-Source: APXvYqzVoxCIcgDU/3WlEJIDK2NaAgiIm8ROgOtrojeJ+OR5OZLgQtxlKNiC0CU7W9CEYTJndJ1xDTtH30r8CdlnVow=
X-Received: by 2002:a67:2c0f:: with SMTP id s15mr951689vss.48.1559193613809;
 Wed, 29 May 2019 22:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <1559133448-31779-1-git-send-email-dianzhangchen0@gmail.com>
 <20190529162532.GG18589@dhcp22.suse.cz> <CAFbcbMDJB0uNjTa9xwT9npmTdqMJ1Hez3CyeOCjjrLF2W0Wprw@mail.gmail.com>
 <20190529174931.GH18589@dhcp22.suse.cz>
In-Reply-To: <20190529174931.GH18589@dhcp22.suse.cz>
From:   Dianzhang Chen <dianzhangchen0@gmail.com>
Date:   Thu, 30 May 2019 13:20:01 +0800
Message-ID: <CAFbcbMA6XjZqrgHmG70Vm_a34Rn4tKqoMgQkRBXES2r3+ymYwg@mail.gmail.com>
Subject: Re: [PATCH] mm/slab_common.c: fix possible spectre-v1 in kmalloc_slab()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that a CPU mis-predicts the conditional branch, and
speculatively loads size_index[size_index_elem(size)], even if size >192.
Although this value will subsequently be discarded,
but it can not drop all the effects of speculative execution,
such as the presence or absence of data in caches. Such effects may
form side-channels which can be
observed to extract secret information.


As for "why this particular path a needs special treatment while other
size branches are ok",
i think the other size branches need to treatment as well at first place,
but in code `index = fls(size - 1)` the function `fls` will make the
index at specific range,
so it can not use `kmalloc_caches[kmalloc_type(flags)][index]` to load
arbitury data.
But, still it may load some date that it shouldn't, if necessary, i
think can add array_index_nospec as well.



On Thu, May 30, 2019 at 1:49 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 30-05-19 00:39:53, Dianzhang Chen wrote:
> > It's come from `192+1`.
> >
> >
> > The more code fragment is:
> >
> >
> > if (size <= 192) {
> >
> >     if (!size)
> >
> >         return ZERO_SIZE_PTR;
> >
> >     size = array_index_nospec(size, 193);
> >
> >     index = size_index[size_index_elem(size)];
> >
> > }
>
> OK I see, I could have looked into the code, my bad. But I am still not
> sure what is the potential exploit scenario and why this particular path
> a needs special treatment while other size branches are ok. Could you be
> more specific please?
> --
> Michal Hocko
> SUSE Labs
