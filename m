Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E710FC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 00:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B576E21849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 00:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563409058;
	bh=eWv2yyNVWjqJgYvQSjpLnrBiMC4TFG7TEEo/AQcdcbI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PUxKg5xHHyHUuKx2Wn1yiFMIuBMFrugWLRwC8fC85yPV3LXWuTaN8tfbX6ezWA1PT
	 OP7rg2vJVXW+FOm2vLBG4eQnpNh9+Lj38iOhRLzNjqedXZcwiSeM2IHB757LUGoCu7
	 1SjkJle/CVoCqums79ghMclOOXg/7b4dKLROcnhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfGRARh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 20:17:37 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40811 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfGRARh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 20:17:37 -0400
Received: by mail-lf1-f65.google.com with SMTP id b17so17820299lff.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 17:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C0omOYCeBkj3DClmy7cN352yT9rYjsx3u2yS4CxQowY=;
        b=BvTuMTyXw/kDbnoeAOdMjWZXqMnUi8pjAXkhvdYVsYGuIIDkcsJie3V1m70FCbZdKm
         0rMYzTZbhZpCiT6SqOeMP1CeLmtdHF3hRJVHwmZetf7zBpR2DIPEOAQl9ThV4uq0HD3S
         RKrrQmecpZjF5xWKdw5hXLilgdnrSnHHhHExw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C0omOYCeBkj3DClmy7cN352yT9rYjsx3u2yS4CxQowY=;
        b=Rpykdm/gRYfMqnTeByTViLqcIc+eGZMgveUWWr9HUwHdUh1P3yxNUxsz4nTawl5YUd
         ibIuVxUyMmhqGkEPY9rwzYS7zX6KVmDZzfyN/QBIfCctTWOqONGVMS6gUu3bqBwsHOxc
         86qd7XyFDEaI8QkCVlaUPTdnrn1B7wp7RXyix3KRiI6/FI8l0BBTpNRcDmRGbzOq0D1Y
         lUxW8YG1quQqhZISs68LqOJJdp3oJ8c2vxLrCwR1vQSf4z6ifuOLEiygHu+YqwcJSELo
         PeqspCpUsXn8EBPCeEjllmBUV+HBmRlZNNbtBi7WrWp/odPGmsx2XIhhgGQD9mvfdRhT
         VKGw==
X-Gm-Message-State: APjAAAWRb2/HTnOYhmQkQK2BVenjv3qAvV00VJJmC+z/1zLWGCEltwTI
        FIS3y9mGgeYYYSyWD9hzuBMMAvXVcm0=
X-Google-Smtp-Source: APXvYqxq3kGuYb5YfyDcq00KxdJ7+SadylzC/5rj1moc2B7qBIwXUOCplYaYjBCF3xTlbGzaeebcVA==
X-Received: by 2002:ac2:484f:: with SMTP id 15mr19425303lfy.51.1563409054776;
        Wed, 17 Jul 2019 17:17:34 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id s21sm4818993ljm.28.2019.07.17.17.17.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 17:17:33 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id r15so820793lfm.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 17:17:33 -0700 (PDT)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr19380093lft.79.1563409053376;
 Wed, 17 Jul 2019 17:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190625143715.1689-1-hch@lst.de> <20190625143715.1689-10-hch@lst.de>
 <20190717215956.GA30369@altlinux.org> <CAHk-=whj_+tYSRcDsw7mDGrkmyU9tAk-a53XK271wYtDqYRzig@mail.gmail.com>
 <20190717233031.GB30369@altlinux.org>
In-Reply-To: <20190717233031.GB30369@altlinux.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Jul 2019 17:17:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjmt2i37nn9v+nGC0m8-DdLBMEs=NC=TV-u+9XAzA61g@mail.gmail.com>
Message-ID: <CAHk-=wgjmt2i37nn9v+nGC0m8-DdLBMEs=NC=TV-u+9XAzA61g@mail.gmail.com>
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anatoly Pugachev <matorola@gmail.com>,
        sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 4:30 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
>
> Sure, here it is:

Hmm. I'm not seeing anything obviously wrong in the generic gup conversion.

From the oops, I assume that the problem is that get_user_pages_fast()
returned an invalid page, causing the bad access later in
get_futex_key(). But that's odd too, considering that
get_user_pages_fast() had already accessed the page (both for looking
up the head, and for then doing things like SetPageReferenced(page)).

The only half-way subtle thing is the pte_access_permitted() movement,
but it looks like it matches what gup_pte_range() did in the original
sparc64 code. And the address masking is done the same way too, as far
as I can tell.

So clearly there's something wrong there, but I'm not seeing it. Maybe
I'm incorrectly looking at that pte case, and the problem happened
earlier.

Anyway, I suspect some sparc64 person needs to delve into it.

I know this got reviewed by sparc64 people (the final commit message
only has a single Reviewed-by, but I see an Ack by Davem in my maill
that seems to have gotten lost by the time the patch made it in), but
maybe actually nobody ever _tested_ it until it hit my tree?

                   Linus
