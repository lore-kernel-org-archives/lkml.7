Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C90BC31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643A120896
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560301784;
	bh=e00HORJvjnK2yyu02KJWkbanAcfnTs6RiFKHXT512gA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yTqlxEwX9dRbT6VDFiOpUlHUQDLOnJIx+7O2UbRACMPJ5ojVkR1n45KTlfTk7ZuB1
	 DlWJFgdz7z/M0Jj6dwqpCSLCS2d1+MfLBfjFd3prvHaJjuVpgJicD54PAbvcHTM9mt
	 R/c/iHWg0x5TqM9e+2O0mjxYrihaSNdl1u5HlFCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407988AbfFLBJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 21:09:43 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39209 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405839AbfFLBJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 21:09:43 -0400
Received: by mail-lj1-f193.google.com with SMTP id v18so13509312ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 18:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZXVeOYEeW/t6moRL6yl166/GZV1HqW8qo9aOqBVN+Q=;
        b=gAjfSlHuLsIpxvb8lF0RyxQXzEhYSHQJnAZ4as99A8GBRPKGt8LtILDEijhajNv2fV
         FXhIx40OUX4WPq1W1eQvis0UNqIoFt7tkihxVZ4QyREYOfVPuleZ/0Zq1i4TWCfQY/NA
         AhmvmJi02EHwj98eCflp9T4F3Jku2HpzQgXkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZXVeOYEeW/t6moRL6yl166/GZV1HqW8qo9aOqBVN+Q=;
        b=bnwLHPET2LkFI9l+VnQhUsFcXKZgG7lsm5UzTElNR2It9SzN6LwRYgQn8V2d+HcFg4
         eI0LJCjHE39SlE8sdLwNez3ltSNYHHQGhi0I2igtpew/oyER4ZhXI1qMVIzwDNzYi67s
         dxREYRgemD7UtqJaI0IeXFC9t1fEzR32vThrH+zAjQq5xieCkXdjMMwyiNYo0yhthY6R
         zQocoTTcMXgFN8wfSxoE7pwtox3QHmBpAgjMlbr3RtItT1Vkm2e2NCTb8VpNyRgchF3+
         fW6bZ9lipZGdASKWykLkleSOw02UZLi78HJXHXGO2LkF621FKSKgp7LbO7OE03LemLOr
         THkw==
X-Gm-Message-State: APjAAAWPcxzNcGRnIPLbd05c8y+Kn0tuCRTXXJHnXfr7LG3iKIgd4jpU
        V2qb4Lim3ux4I/HMfc+kuRSsWqXo/DM=
X-Google-Smtp-Source: APXvYqwJIh93gJ/HvldojxYZxHf+aQez0E57Q5bEzgi4Q3u9aFxRNPob6zGT3ZLP17364QDEI/NUjg==
X-Received: by 2002:a2e:980e:: with SMTP id a14mr31605066ljj.60.1560301781232;
        Tue, 11 Jun 2019 18:09:41 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id s12sm2840311lji.34.2019.06.11.18.09.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 18:09:41 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id a25so10720849lfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 18:09:40 -0700 (PDT)
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr26185312lfm.61.1560301780325;
 Tue, 11 Jun 2019 18:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190611144102.8848-1-hch@lst.de> <20190611144102.8848-17-hch@lst.de>
 <1560300464.nijubslu3h.astroid@bobo.none>
In-Reply-To: <1560300464.nijubslu3h.astroid@bobo.none>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jun 2019 15:09:24 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjSo+TzkvYnAqrp=eFgzzc058DhSMTPr4-2quZTbGLfnw@mail.gmail.com>
Message-ID: <CAHk-=wjSo+TzkvYnAqrp=eFgzzc058DhSMTPr4-2quZTbGLfnw@mail.gmail.com>
Subject: Re: [PATCH 16/16] mm: pass get_user_pages_fast iterator arguments in
 a structure
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Andrey Konovalov <andreyknvl@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 2:55 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> What does this do for performance? I've found this pattern can be
> bad for store aliasing detection.

I wouldn't expect it to be noticeable, and the lack of argument
reloading etc should make up for it. Plus inlining makes it a
non-issue when that happens.

But I guess we could also at least look at using "restrict", if that
ends up helping. Unlike the completely bogus type-based aliasing rules
(that we disable because I think the C people were on some bad bad
drugs when they came up with them), restricted pointers are a real
thing that makes sense.

That said, we haven't traditionally used it, and I don't know how much
it helps gcc. Maybe gcc ignores it entirely? S

               Linus
