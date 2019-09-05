Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8C2C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF71E20825
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BM+ek/d3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbfIEQN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:13:27 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38323 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfIEQN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:13:26 -0400
Received: by mail-lj1-f195.google.com with SMTP id y23so2782778ljn.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j8yKc9SHJAoYLzBrn3BT3OVSk2JhvmmAFDyBdCdHQDQ=;
        b=BM+ek/d3V9T6GKREugYTLjnPwoLY87hw+TftOCbo0oTZp5p0Qpt3Uze1Oz0p6viGqj
         94KLegS8mri/SGOpqrLeNW7YOyCOB4kP90Un6kzSr8WBpOdH925KmCgl7t/5pd38ji+4
         v37BX55Lpk3GaWdgORhcSzxWYqTZBLTFbpqpeRs2dgIPKMruBEp6k+WI+8dBDqVGI5MH
         VsOUzyBIttSKNaWSooyeI8tvfISBqHx/McEurKNuBCpBgqn40bHKGUFk/dGYPU0RyPqs
         DfXW/IPuSPN6cyHjDYgE3RxzBIeTs91yLBXcE/f1bzWwu8SHEIJH2g3tEPMoTI5qNBfQ
         lFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j8yKc9SHJAoYLzBrn3BT3OVSk2JhvmmAFDyBdCdHQDQ=;
        b=X9IE9L08EFriRfLylIt/Z4Sq9zXUOTzhh3in5c2e4Piay20JmynwEgBUuyUMdpt5Jt
         VIiTlSB2iXompSCneanFONFP8jJH8jaV4W9XOY7kEhVJNbNuWYoupQhr2KkLcgRMmRsd
         GMMX/AZs/AHZpcSISKddaiECGECGbeVlin6p0B+RqpiDQgp9BSubTYVSt6i8TffK44IH
         N9QjnS7DHdyJVNTSAyR4y60SkoQUC/U48j0Nc7kXtsy2qU/d2WXpj3wgplbMLaQSk8p6
         G5KSOCkGPRtZBxwwjnQsbaGnnw+yi9Xu8aDelyMbX0c27V+BsqXewDiSFQ2E42Iw1y5P
         3Odg==
X-Gm-Message-State: APjAAAXzjrgL1mE6qNOOEAnzAQIinyuPr1/m+uAMJerTe5kS/Nez0W8a
        VHgnacxsaIxuK0y1aB05+eV4LIHXSiJ814g4Ke8=
X-Google-Smtp-Source: APXvYqzCTJkFJfiZRgqh5jU9AOsfmAvYm1fHOp9MWUc9KkIpke8TwJqseKNrFfCUzEiq7/yLXkENRlHrZUvUktncius=
X-Received: by 2002:a2e:9555:: with SMTP id t21mr2605931ljh.93.1567700004732;
 Thu, 05 Sep 2019 09:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190829083233.24162-1-linux@rasmusvillemoes.dk>
 <20190830231527.22304-1-linux@rasmusvillemoes.dk> <20190830231527.22304-5-linux@rasmusvillemoes.dk>
 <CAKwvOdktYpMH8WnEQwNE2JJdKn4w0CHv3L=YHkqU2JzQ6Qwkew@mail.gmail.com>
 <a5085133-33da-6c13-6953-d18cbc6ad3f5@rasmusvillemoes.dk> <20190905134535.GP9749@gate.crashing.org>
 <CANiq72nXXBgwKcs36R+uau2o1YypfSFKAYWV2xmcRZgz8LRQww@mail.gmail.com>
In-Reply-To: <CANiq72nXXBgwKcs36R+uau2o1YypfSFKAYWV2xmcRZgz8LRQww@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 5 Sep 2019 18:13:13 +0200
Message-ID: <CANiq72ne3TWt7ydmt9eZsawMfAs-qgPoM92-c1EJ=zfFTdcBQw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] compiler-gcc.h: add asm_inline definition
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 5:52 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Yes and no. GNU libc defines feature test macros like you say, but
> C++'s feature macros are like Rasmus/Nick are saying. I think libc's
> definition is weird, I would call those "feature selection macros"
> instead, because the user is selecting between some features (whether
> to enable or not, for instance), rather than testing for the features.

By the way, this is not to criticize libc, I imagine they employed that
nomenclature since that is what some standards used, but still, the
naming is not great from the users' perspective vs. the header
writer's perspective, IMO.

Cheers,
Miguel
