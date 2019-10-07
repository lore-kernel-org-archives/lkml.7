Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AB3C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1140D206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570475696;
	bh=3NYteDlz2pQpKOythLE4uTVl1bYOYA3EbETiuZjI/OQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PrTivKpn1u1DxBqXTnm6eKrtP5nA5/yT4fjYu/LHibGQAPOsGnSsd3fZDz/MRtd2K
	 HA6itvle+fbeT7Y/NiUdxR4edhbRLexPc8dzD/tuS99i6dm8QrskmU+q46KgesgMgz
	 CxkQW1drgW0phEk/PUGhngsoLEmYMsaAeYsEk61E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfJGTOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:14:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37265 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfJGTOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:14:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id l21so14922211lje.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 12:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXTod068XsJ0/J/Qqj0/97Cyow7ru7du5wJrbrpf8I4=;
        b=VMe+eQLfh8WbO//QhhRZRR3AJUuhQ6YMQsuPufHVw3/oSqP7GkJb1KHifxQO5jSf17
         ZipMojysOuxRhaEDkhQaiJ3YNnCkQPYd57Y4JgtvTOvrZ4br1mebA4NG3Zg2WVG6nmaA
         c1kGI+h8Yt5V6m9E+KQeP/R/IvXp5VKHWEZ6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXTod068XsJ0/J/Qqj0/97Cyow7ru7du5wJrbrpf8I4=;
        b=jTLHy9V77WXfvoHD9EnUaJG1SmSP0RlX5HkVDpHFSwoYJCs36nhklBbwJyi15IYIk6
         Usu9dswAYOZl3qAsjRW8vVAfrx6jYSjtAJANztOVd/ZPR83y8Rv1zelgWUF5NwXCU5Bw
         RW2Sb/2BnSIbVlb6NZc+xpLqOjnI54Pmregzwtmky40DhuGwzBr7W4qO1TZmC5pGu5Qa
         p6B/6mL7qnkL0y6jFXegMaqrn1pluUOY7FZYMfN2DECnJ0+Pui36SCQBiIZpAyQQz7yk
         DnKMp6pdss1DIUuDIgsVIFDbg4spQN3MSEbKaGHrdd7x+F70sABNP33Swjm0OGKlL5LH
         amag==
X-Gm-Message-State: APjAAAUSTbFkAm09h+FnGZAyDdVOi7d8DMGgTPHoo5+DSrDOkrldw0cD
        bBr2STjP3klHkngJXVWNOEIofoDfW7k=
X-Google-Smtp-Source: APXvYqwz455T7HTogVNj5APElJzy2IOrcFp4E8G9REOfcd7bdF//aFfCxO8kABtbwCWmMGxkjMHJBQ==
X-Received: by 2002:a2e:2bda:: with SMTP id r87mr19488897ljr.3.1570475690935;
        Mon, 07 Oct 2019 12:14:50 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id c6sm2882942lfh.65.2019.10.07.12.14.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 12:14:50 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id u3so10050800lfl.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 12:14:49 -0700 (PDT)
X-Received: by 2002:a19:2489:: with SMTP id k131mr17252511lfk.52.1570475689589;
 Mon, 07 Oct 2019 12:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006b7bfb059452e314@google.com> <20191007190747.GA16653@gmail.com>
In-Reply-To: <20191007190747.GA16653@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Oct 2019 12:14:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtA4bWH=8xY8TAejDR4XyHDux0xH7_y-0jzft0XkvMfw@mail.gmail.com>
Message-ID: <CAHk-=whtA4bWH=8xY8TAejDR4XyHDux0xH7_y-0jzft0XkvMfw@mail.gmail.com>
Subject: Re: WARNING in filldir64
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+3031f712c7ad5dd4d926@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 12:07 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Seems this indicates a corrupt filesystem rather than a kernel bug, so using
> WARN_ON is not appropriate.  It should either use pr_warn_once(), or be silent.

I was going to silence it for the actual 5.4 release, but I wanted to
see if anybody actually triggers it.

I didn't really _expect_ it to be triggered, to be honest, so it's
interesting that it did. What is syzbot doing?

If this is syzbot doing filesystem image randomization, then it falls
under "ok, expected, ignore it, we'll silence it for 5.4"

But if it's syzbot doing something else, then it would be interesting
to hear what it's up to.

                Linus
