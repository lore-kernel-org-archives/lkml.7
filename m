Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F07C31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E25F206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560304193;
	bh=y8ozjjQpLXjfNGkgmFvdxqQHvA4RWzLtbjfYQfJZjzg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=f3OY42E5KYjZ8s4GaGtkGM2HWbBAtqpjqX+gC66JM3xLI3eh9sGF14Z/7QuGcGgsk
	 7BnkvlNNbZe1JTDWgvNT6ElrbzxK7+uwoAuKcU9jnK2fovEZu33CcM26urLnr7KOtH
	 GpqPavHbK3JVM6l64yPuttESkO6g4PHfcMSalkso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407549AbfFLBtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 21:49:52 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:42979 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbfFLBtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 21:49:52 -0400
Received: by mail-lf1-f47.google.com with SMTP id y13so10732480lfh.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 18:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gbMfZABo41/f10Q7nJ+1rb6WtMx9eMLy3331KA8ZSqQ=;
        b=LR555UVASGUDAyRxWXlECzWrsKk48W+39pIgi3RyHpdk6L/TiCzuG+CjSD/QFngxnb
         XvfdnDsbPH7Gvn8YfJ2uSd4Lnwvl6ygKOBzaoI0eVuOQzPzQc9uqfj9SKz4ruqH9Bklc
         PHQUsMWjtgFk61b6MNW2smHNPOl1cVkhHMang=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gbMfZABo41/f10Q7nJ+1rb6WtMx9eMLy3331KA8ZSqQ=;
        b=rqs41VNx7DKNRCrqcZBJMAGdcjS0g9AWrKQLBmKt1SCmGrx6sv/bKZq+fytq/kgr3s
         9nvvFsPWceuiq4kOsdfO2Xd9VFILvGzKwYRefVspI/g5ZgzeQNUjbAIg9RKSTUYxlbPJ
         pOrXOyZIlaYU3sGiPbI6p318RRPaD3KO0vN0hhGCyIXW8ABuKOORcQJTVNxAPhjYEqrt
         RAVnMMdNkcNaEzr9EG0zLyWQN6cl58K/83zZyOfqV8w6ta9tgJu5A5nAa4kX5shK/NH0
         SEcPx9AQKeyIV277XPKro+4nnT1yqWBI95D6YBVVpkuYUL9Q7EeDvXs4CHi5abevi+5Z
         /dqA==
X-Gm-Message-State: APjAAAVNponOq2ejTkI5aw48QQNWW6nwE7N7FNKcxpmOyj3jIGIDLavo
        lrq/h0Kqk19Cf0owx5vTtuIoOhoyr8w=
X-Google-Smtp-Source: APXvYqxc43VfBVWrxmQd4uaHGm95XKUz9ey3fJelA90k/nD278IZuDfS0V1eOCHFAqnE0Dej5r0Ivg==
X-Received: by 2002:a19:6a07:: with SMTP id u7mr37429028lfu.74.1560304189721;
        Tue, 11 Jun 2019 18:49:49 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id z12sm2780473lfg.67.2019.06.11.18.49.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 18:49:48 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id a21so13574726ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 18:49:48 -0700 (PDT)
X-Received: by 2002:a2e:658e:: with SMTP id e14mr11773158ljf.147.1560304188412;
 Tue, 11 Jun 2019 18:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <87d0jj6fcw.fsf@xmission.com>
In-Reply-To: <87d0jj6fcw.fsf@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jun 2019 15:49:32 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgZceNP1SOrGZmSwernbx-d7+ZYyCTJW8WBsEsZaBEbhw@mail.gmail.com>
Message-ID: <CAHk-=wgZceNP1SOrGZmSwernbx-d7+ZYyCTJW8WBsEsZaBEbhw@mail.gmail.com>
Subject: Re: [GIT PULL] Minor ptrace fixes for v5.2-rc5
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:23 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Apologies for being a little slow about getting this to you, I am still
> figuring out how to develop with a little baby in the house.

Heh. It gets better as they age. In just a couple of decades, you'll
find they have it all figured out..

              Linus
