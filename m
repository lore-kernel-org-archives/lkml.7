Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D4FC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E472082A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gv1MQ9tG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDJV6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:58:03 -0400
Received: from mail-vk1-f178.google.com ([209.85.221.178]:36158 "EHLO
        mail-vk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDJV6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 17:58:03 -0400
Received: by mail-vk1-f178.google.com with SMTP id w140so925502vkd.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zQ6wwUQrK1NqHrZtbqa5TkZR4Gt0ENtEbKzfcyHpppE=;
        b=gv1MQ9tGqukjy1cxAUfCcBksLGw3OlCHJEx6K+6Mj+1qUsoKucc/YgqMNaG86eMB1D
         WTZemX8QDCe1WFlW0Juf+fhQeN08D7xVWNfo88NerKEYK9jpXnm7gPmG9WLWOA3Q0qGA
         0Zf/bWUhqXgosvN7oHj639aOLqJscqb1wUEVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQ6wwUQrK1NqHrZtbqa5TkZR4Gt0ENtEbKzfcyHpppE=;
        b=BSx0teldFTdEWB8nuL60GTa3T8J0SWm4wgXkVHeeO4O+FPw9Vtupqg8NrrguK2Ti7g
         Tyzeds7oEOLCbxCfLckhnIzkR+j3nMFo0Ib3y6dxXTDF/7xmvZyhyscxKBsqeqKn5ZUb
         H5I0uEdu/dke71MPH1Tnal8fGqcpkZ+yn7bdmVy5Dj/i+ZoGyX0LGuWmAI5a6hQkZal+
         jTj+aDTz5ycutluN8yrMuycSNeL4TNi6pIlvfH48EVId7GwBb3xuhjR2W6QMZ2y3XffE
         LJBzXaTQ7opEpKwn7mcJxFZNi7E0S08V5RVPg6qa0VxgfvjwLRaS/fpccgDalIzjEz9P
         JhkQ==
X-Gm-Message-State: APjAAAXk8NCgPLm9LlRCyE3DwY9fjcDJxbO3lbi40kw8k1Z3IVKiBRvC
        +GpPzM/UMn/lxLsv0P4MHTEtQ4VKLhI=
X-Google-Smtp-Source: APXvYqzwDvmV5N3syCkoeEBTAL0ogOVoXmRE7W2Qp5F7QVVM8r4hKWER0hmHK27xcpf1u7hTGQb8cg==
X-Received: by 2002:a1f:2b8e:: with SMTP id r136mr25307247vkr.48.1554933481186;
        Wed, 10 Apr 2019 14:58:01 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id d193sm5764984vkd.41.2019.04.10.14.57.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 14:57:59 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id j184so2275673vsd.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 14:57:59 -0700 (PDT)
X-Received: by 2002:a67:1345:: with SMTP id 66mr24870637vst.30.1554933478741;
 Wed, 10 Apr 2019 14:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdWhx0-kspDyLOgTp+9udiBpkMHULSGyMg9uPPV16=FWQg@mail.gmail.com>
 <20190319170911.GB202956@gmail.com> <20190320185719.GB180195@gmail.com>
 <CAGXu5jL-5C1ZGZ1JgaNFqK-z1Pp1N1X8gD3_ysKTCa=omD+_VQ@mail.gmail.com>
 <20190321175122.GA1587@sol.localdomain> <20190410031734.GB7140@sol.localdomain>
 <CAGXu5j+SZ2+Zkc=Vp5CXQUHhiR9f_OOnca684JTRW3T0yXdaNQ@mail.gmail.com> <20190410190729.GA120258@gmail.com>
In-Reply-To: <20190410190729.GA120258@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 14:57:46 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+Gfvj9G6s_UQTw6hE11gJb1edt3BXzpbDQdc_dpcHgag@mail.gmail.com>
Message-ID: <CAGXu5j+Gfvj9G6s_UQTw6hE11gJb1edt3BXzpbDQdc_dpcHgag@mail.gmail.com>
Subject: Re: crypto: Kernel memory overwrite attempt detected to spans
 multiple pages
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 12:07 PM Eric Biggers <ebiggers@kernel.org> wrote:
> That didn't answer my question.  My question is what is the purpose of this?  If
> there was actual buffer overflow when __GFP_COMP isn't specified that would make
> perfect sense, but AFAICS there isn't.  So why does hardened usercopy consider
> it broken when __GFP_COMP isn't specified?

The goal of CONFIG_HARDENED_USERCOPY_PAGESPAN was to detect copies
across page boundaries in memory allocated by the page allocator.
There appear to be enough cases of allocations that span pages but do
not mark them with __GFP_COMP, so this logic hasn't proven useful in
the real world (which is why no one should use the ..._PAGESPAN config
in production). I'd like to get the kernel to the point where hardened
usercopy can correctly do these checks (right now it's mainly only
useful at checking for overflows in slub and slab), but it'll take
time/focus for a while. No one has had time yet to track all of these
down and fix them. (I defer to Laura and Rik on the design of the
pagespan checks; they did the bulk of the work there.)

Does that help explain it, or am I still missing your question?

-- 
Kees Cook
