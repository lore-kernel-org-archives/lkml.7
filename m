Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586BAC48BE1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3370E2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561051328;
	bh=Sh+i3/+atKsLHq20f7BYR2YeUmM7aHDmKCg2/Gz2RQM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EpgvVgwzfF9AzFGZl3isV5NMqSelizq0vqpjTt9EuN0w73qKgakt2tudaLUc3+RiW
	 xnRFa0R4OGN8DrBLvpwbmiA6EKFg1+Y28LEDd0dghYo4TrRy34xtWEYNee3+fZ2f33
	 o/4LZY8+4XILVJcXfX/DlqT5T6myy9SIgVPZJ5Uk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbfFTRWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:22:06 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40037 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfFTRWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:22:06 -0400
Received: by mail-lf1-f67.google.com with SMTP id a9so3007752lff.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 10:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8s7nWa83ZrllVywYBO3+qENQEvSqioKh5iSEDp3yvQc=;
        b=g1mjJHSB+/44ZB7V3d991RQ8lmWdxyz7cRKmwtk9byrjcNUD9YP2uS+RZIIrKE7lKn
         tVpZNvyJkolb6AtIXbb56yLA6c56wf2OFIIZEIPMa1TRDMJb6FE75meYgwCBSBqSYdRC
         O8jEDgU+LfyGIAqseIIvIOnHddyiMVgjB9lIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8s7nWa83ZrllVywYBO3+qENQEvSqioKh5iSEDp3yvQc=;
        b=C+vjOvTPMwj5HWDlvrJDfiRZeFdw9XXC1jmqkywmN0XvNiuSFFPWaFXa2mVAt3b+3Y
         raKU1JopF0d91yTcqZWTlZxhD/CCTKj2x1M2j03ObSUy6p5935nF1l+pR/hegwDbZxMI
         KEGSR6jabNkDaEx4LNLF3ectS5ahHF+r3dhzLzpSCAxAp8Z09I3chVAbk6ISidtjXwDs
         tBBLEIziqF7NEdtNqlg/uLz8anoPcPUjTDUWIid4qDGnGA+6OcMSJhW08agD5DWAvt8C
         TEVnJ4k/N+jtZ3XLpoeP97KFDXH8zFtF7thBXtcLe8kc7AXUPINvN0ZbrCaGxm7mZmvD
         QHRA==
X-Gm-Message-State: APjAAAUl7wlD3T6Rzqc3s/hqDrEArE34T8owNBN5dgbeQzp0J0djj7Js
        6U/rykuLoNoLOQqpF7qgevZxFiTVp8c=
X-Google-Smtp-Source: APXvYqyX+4vQPX/HP+UQYV3HX4ivwOw7f7p1AbhLuX3+Q8+99VwKUCQPH1Fa99sla6t6M6nY3ZWpZQ==
X-Received: by 2002:a05:6512:24a:: with SMTP id b10mr63615946lfo.37.1561051323910;
        Thu, 20 Jun 2019 10:22:03 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id x79sm38713lff.74.2019.06.20.10.22.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 10:22:02 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id a9so3007613lff.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 10:22:02 -0700 (PDT)
X-Received: by 2002:ac2:5601:: with SMTP id v1mr51955604lfd.106.1561051322002;
 Thu, 20 Jun 2019 10:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190611144102.8848-1-hch@lst.de> <20190611144102.8848-17-hch@lst.de>
 <1560300464.nijubslu3h.astroid@bobo.none> <CAHk-=wjSo+TzkvYnAqrp=eFgzzc058DhSMTPr4-2quZTbGLfnw@mail.gmail.com>
 <1561032202.0qfct43s2c.astroid@bobo.none>
In-Reply-To: <1561032202.0qfct43s2c.astroid@bobo.none>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Jun 2019 10:21:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh46y3x5O0HkR=R4ETh6e5pDCrEsJ94CtC0fyQiYYAf6A@mail.gmail.com>
Message-ID: <CAHk-=wh46y3x5O0HkR=R4ETh6e5pDCrEsJ94CtC0fyQiYYAf6A@mail.gmail.com>
Subject: Re: [PATCH 16/16] mm: pass get_user_pages_fast iterator arguments in
 a structure
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        James Hogan <jhogan@kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Burton <paul.burton@mips.com>,
        Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 5:19 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> The processor aliasing problem happens because the struct will
> be initialised with stores using one base register (e.g., stack
> register), and then same memory is loaded using a different
> register (e.g., parameter register).

Hmm. Honestly, I've never seen anything like that in any kernel profiles.

Compared to the problems I _do_ see (which is usually the obvious
cache misses, and locking), it must either be in the noise or it's
some problem specific to whatever CPU you are doing performance work
on?

I've occasionally seen pipeline hiccups in profiles, but it's usually
been either some serious glass jaw of the core, or it's been something
really stupid we did (or occasionally that the compiler did: one in
particular I remember was how there was a time when gcc would narrow
stores when it could, so if you set a bit in a word, it would do it
with a byte store, and then when you read the whole word afterwards
you'd get a major pipeline stall and it happened to show up in some
really hot paths).

            Linus
