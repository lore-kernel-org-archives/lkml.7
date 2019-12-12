Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F47C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3BC206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576176523;
	bh=MTd9muN0RFcbU7r9IeK72YN2J5t+SjeoBTN78A1i2RI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rxCDQRB/u4Bb5iskhVpRzjlqBKqeVI9nsrJ5elUnkoyvCy9aihN39phTeCrYE7pp0
	 eLEdSmjYlthSuArGzm134Ne1J80xd9IVUUyPkajO09Zlov05NNnlpG4nJSZ/cl+E1I
	 IQVxIw1sH0/sbdrIGBpjkVxVLj1s0lHc1TI/8vTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfLLSsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:48:42 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37914 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730473AbfLLSsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:48:41 -0500
Received: by mail-lj1-f194.google.com with SMTP id k8so3445556ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 10:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yLX/s+7Ivhh0xF9dE8Ygc3zv1BE9WaHo0SxDQx/ndOw=;
        b=Hxo7zIOH626xCx5M7isNX9Kz2i6WfXy8dvU+dHqLV39CO//zL/XyJhwdy9zMUggXsF
         sKVjhBuXVQzllryD1mGY0+h/6F170yVG671fMzLLAz66yPU2LfkO41ADlv1O+3YGsXdW
         gJZ1lANbmyuJbIB7rg2DrjzC2Wjd1R0mzUPj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yLX/s+7Ivhh0xF9dE8Ygc3zv1BE9WaHo0SxDQx/ndOw=;
        b=Nod1kR4wP5CdQoIC5S4b7J7kEx5YA0sid57Q4MloxGCF4gOJ4V6QYe0pegytp5ZzL/
         Y+APOD2Uo/OZpgvWHx4fLEsyi6CMyrlcPFLHPUogiIkWTqSPKhZpeixgIwnX/ePhgB04
         ENsYJAROgUaFBLNwbUgXD2OKIN3aPvutPgC1oYpECrStQbKJgcvBei2QcFVqQn7QplHo
         3fEnin3lcb5BL1HP1HxTZHbAcGeOV+AEafeqzQx+CIldOvnCg+zM/jbQHtJbSDje/PyP
         0vFRurpXUVxIfqk0VVBqK/CE6slCphUO8+IloHt6ocj1kfuCGfUEVgjtZuNgQj/j2het
         Xs3Q==
X-Gm-Message-State: APjAAAVIb7APMKzlPgY3qdY4o8bjVgJ0HX4v0xknITWlV44h2946BoVW
        KRwsp/3qIlw2CXWsKf6AIpa+wkYMS7E=
X-Google-Smtp-Source: APXvYqzPk6YH+rKagLV8YHy5FQfHJkd3taeBJHCEroXGR2erpOm9SttWVHAThjx8Us5nqlFBEhcXgg==
X-Received: by 2002:a2e:808a:: with SMTP id i10mr6590531ljg.151.1576176519194;
        Thu, 12 Dec 2019 10:48:39 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id x29sm3763110lfg.45.2019.12.12.10.48.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 10:48:38 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id 203so11685lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 10:48:38 -0800 (PST)
X-Received: by 2002:ac2:50cc:: with SMTP id h12mr6524868lfm.29.1576176517766;
 Thu, 12 Dec 2019 10:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20191212140752.347520-1-linux@dominikbrodowski.net>
 <20191212140752.347520-3-linux@dominikbrodowski.net> <20191212183848.GJ4203@ZenIV.linux.org.uk>
In-Reply-To: <20191212183848.GJ4203@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Dec 2019 10:48:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGH8mBqShwmOy-g+QA4_+prs-5s4eX6wZa7yatCu3aNw@mail.gmail.com>
Message-ID: <CAHk-=wiGH8mBqShwmOy-g+QA4_+prs-5s4eX6wZa7yatCu3aNw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fs: remove ksys_dup()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 10:38 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Let's not expose the kernel guts to init/*.c more than absolutely unavoidable.

Well, in this case I think it's more than justified: it removes one of
the nasty "pass user pointers from kernel space" cases.

I'd like to get to the point where "init" doesn't need set_fs() at
all. We're not there now - do_execve() is going to be painful. So
maybe we'll never be. But this gets us one step closer, at least.

               Linus
