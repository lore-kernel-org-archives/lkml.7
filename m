Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEFFC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6292146F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IdUcNIkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfCHQwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:52:24 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:37781 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbfCHQwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:52:24 -0500
Received: by mail-wm1-f41.google.com with SMTP id x10so12887373wmg.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 08:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qCKygBQCUpNS5P/JDpkW2DXSP6Bm4cP0NVIOldUyTZ8=;
        b=IdUcNIkGDmbmsvflun+maEjCASyVnQ25dAQq47phcFwSed1kJYKnVeSz7mkkAiseRR
         jQkAJUbyXm7cFTNz4zNMIohjLiZZ98334a8oF6pW4xKmEHS6d7MzqbqisudOYzn7O5I1
         WVTrLJ5YiMRGWeGkFwqeU/wHGih3+MGasyicy1wGmyux/NSZa1FX+BYT2fj/165VYTHD
         EzHRn9QWKL+X0FyMifWxCxnrsEHqnCVLNGZngbleHWce9/WlhFmweBQTLEWVtC3wAvO4
         y5posIkPqTh5Lvy7ioJrZAkx3GocpxyNvIzgBbUOeaL6SWTzH/I3HtLx9GohO7xN4Ssb
         4lqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCKygBQCUpNS5P/JDpkW2DXSP6Bm4cP0NVIOldUyTZ8=;
        b=i7knE+RDjsMaR6MKgmCBiezp70s6/RayzFadrHYG5gl6qz/o+iZfjdUfgq/fXWRzFp
         mpZIvpoBwIDNEfmj2CR7n/cgs73A5SqIyYAzWqwHAABJag3ChNU2RN9jnA1tM3HUkW0h
         Qaawai9qSOvW1l+w+aoA4yIn8mhxcIfwQqVabDbpcs2gyMSFep25j+PFe7cLr5taKZEV
         D+gOBfRYnDcdUlptXgpu8D54nkZ9JtWCWJOcqeYfIyp1L0CGUewb9Ju5A7ysfUTvvDgF
         71cr2mUPvFIQ1zrD9/bjH84i5jDn5+5WaD4ibYkfS6aSR+99qeK1hWOOUQ92emTZUr6n
         S+Ig==
X-Gm-Message-State: APjAAAX/3G+lWZiqENgcUUONKrRtGjDGstqX9u4F09dZWFrbypywc6Nj
        KlOL+B5VFhkKno1TFya7wgJ0l/zA/LaS/Dxd+ZOU4w==
X-Google-Smtp-Source: APXvYqzttkrEVJjjqDyxa/zfOqclVkyYUolMG2iZXFVPTcinuPAf+JQ9kcgfKFSQwj0ZURE/j01V0MJCRnkixtiCfh4=
X-Received: by 2002:a1c:80c4:: with SMTP id b187mr9273234wmd.23.1552063942102;
 Fri, 08 Mar 2019 08:52:22 -0800 (PST)
MIME-Version: 1.0
References: <1551330806-12502-1-git-send-email-lirongqing@baidu.com> <20190308155543.si2nqqm6j2otq27r@salvia>
In-Reply-To: <20190308155543.si2nqqm6j2otq27r@salvia>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 8 Mar 2019 08:52:10 -0800
Message-ID: <CALAqxLVZUOM=KXRADi8kQ6XB+AgsdVfYVg_LfzxAcgmAP6hjgg@mail.gmail.com>
Subject: Re: [PATCH][v2] time: Introduce jiffies64_to_msecs()
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Li RongQing <lirongqing@baidu.com>,
        netfilter-devel@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 7:55 AM Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>
> On Thu, Feb 28, 2019 at 01:13:26PM +0800, Li RongQing wrote:
> > there is a similar helper in net/netfilter/nf_tables_api.c,
> > this maybe become a common request someday, so move it to
> > time.c
> >
> > Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
>
> Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
>
> This is touching kernel/time.c bits, which is far from my realm.
>
> What should I do with this? I can just place it in nf-next.git if I
> get an ACK to do so. Otherwise, please just take this if this looks
> good to you.

Acked-by: John Stultz <john.stultz@linaro.org>
