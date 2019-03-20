Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F846C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E151F21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 22:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD7iHnLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfCTWj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 18:39:27 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44096 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfCTWj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 18:39:26 -0400
Received: by mail-oi1-f193.google.com with SMTP id i21so3182132oib.11;
        Wed, 20 Mar 2019 15:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EOc90PsaIu+tjx7ma+hK4XgRMjFPUysHJKVLlrLZMtQ=;
        b=kD7iHnLveB9wajrfIrXvOYeJQjvWJ/9mzM/ueBEFzm1mbNxVx1twFpGllc+RlY2eg0
         DWL2O/Ncx8VTsXzAC+qnJDwxKpgb2Gbc590Df8j4UAy2Pz92kIz83cwr4RRLjs+QIciK
         6AkEWmMp/e/IZLnkjPXSNJSqxqHG+u4Xz8qxmcV5pVsJ7Tzb6d0d3vvNciMJEhDCqJ0Z
         ij9tEaqxUAGhqeVHYiXYxPYuR5rFM1ad1UQIHYOKbtjLAoMUfdWLN0qPMc0+8I9b1Dns
         0eFt/S1Fls5N0ULbstYAoPH7HeshIxU2sw1IHKacA2HwrC2G0pI9Uv1MZ5FAm1jeLk5/
         5yHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOc90PsaIu+tjx7ma+hK4XgRMjFPUysHJKVLlrLZMtQ=;
        b=gjHfHY6jURfKmEQqltaNIQzl/72TUjc0T6AjCgiw98hx1kAtHS80gWZ2rQ4G06oyR2
         8fAUVvVVhQ3VA1EC726DtVBSe5HKfBl8HdMGFoGcVeMyrxU23qnHghZT/+j3QFlonJj6
         1ubRiA8DUKtxh2f7a6sY5GPckrUVVNlloOZxUIGU54RNmDXiN2z8TzspH1cgswOgJYt8
         6oZ4LuTTP7hi2hhJdoGtpvd4rRDoIYCDvKCmZUktJLe0p9ikk+ilxpB7VH96DyTk/z+u
         K6R5OoylP5LgVTO/hU1+xr3YQzmxWzkHi+MoWPDtNENKxkvL3vd/lEC3g5jvv/nR3ukR
         jHhA==
X-Gm-Message-State: APjAAAUKGyPODFw6oEvQfqgkBhmFY6o/tHKdxathj4hmnAjBcs1a4esI
        sifBB5xYJsC0qQDOIjjBrzWGZrFk163/Ra8vbGygvw==
X-Google-Smtp-Source: APXvYqy+XXlmo3RXMcgh9cLUZEkE3JfF0aSiDaf5+yV9OR4Et2QCDKnghv/5H3HlwXhPiKA3JqDEnM0ILMALRMiyqq8=
X-Received: by 2002:aca:4085:: with SMTP id n127mr243969oia.93.1553121565987;
 Wed, 20 Mar 2019 15:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190123211758.104275-1-jelsasser@appneta.com>
 <20190124030841.n4jtsqka5zji3e62@gondor.apana.org.au> <D5A6C2E7-2AB1-46D0-8876-2D6AAAA3937F@appneta.com>
 <A247F887-832E-44AD-AC41-C22E124E44EE@appneta.com>
In-Reply-To: <A247F887-832E-44AD-AC41-C22E124E44EE@appneta.com>
From:   Josh Hunt <joshhunt00@gmail.com>
Date:   Wed, 20 Mar 2019 15:39:15 -0700
Message-ID: <CAKA=qzZ96KQKFG+aXSws8S8fGGumUg9ReRNfOPVcK=fy9eornw@mail.gmail.com>
Subject: Re: [v2 PATCH] rhashtable: Still do rehash when we get EEXIST
To:     Josh Elsasser <jelsasser@appneta.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Graf <tgraf@suug.ch>, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 2:03 PM Josh Elsasser <jelsasser@appneta.com> wrote:
>
> On Jan 23, 2019, at 7:40 PM, Josh Elsasser <jelsasser@appneta.com> wrote:
> > On Jan 23, 2019, at 7:08 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> >
> >> Thanks for catching this!
> >>
> >> Although I think we should fix this in a different way.  The problem
> >> here is that the shrink cannot proceed because there was a previous
> >> rehash that is still incomplete.  We should wait for its completion
> >> and then reattempt a shrinnk should it still be necessary.
> >
> > I can't test this right now because our VM server's down
>
> Got one of the poor little reproducer VM's back up and running and loaded
> up this patch. Works like a charm. For the v2 PATCH, can add my:
>
> Tested-by: Josh Elsasser <jelsasser@appneta.com>

Trying again... gmail sent HTML mail first time.

Herbert

We're seeing this pretty regularly on 4.14 LTS kernels. I didn't see
your change in any of the regular trees. Are there plans to submit
this? If so, can it get queued up for 4.14 stable too?

Thanks!
-- 
Josh
