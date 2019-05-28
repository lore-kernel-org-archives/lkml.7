Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A807C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB2420717
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pd06yysC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfE1TDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 15:03:55 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44197 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfE1TDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 15:03:54 -0400
Received: by mail-lf1-f68.google.com with SMTP id r15so5989823lfm.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xNIfN8iP61jt3zQccTc9JxOkZ8J4CEm1u7qbNWzRMOM=;
        b=Pd06yysCLBSycRTXjmvKdW4Y+phHo573v+/6jzUP+xP3ps/hunOO1mtGrJzymmotMx
         7zR1oU8ZhbJj6VR78NkwLbJCmbgDlR7RA9b9wJIKnVnlN5jzcYV8+ATU/fkJ7tc8ab7w
         /+hb4CRqYA40DegwtV/SFf/6I8uHmFQixBD+OW25ggCJjCc/O1z+7TaZwvyE+BSibKBd
         v93/MxXRvgdq3Jkw7MhzduiRY55JyN6o3S0bwW10eo6Jd0abP542DYqBvpjnY3ssA5md
         rH5mrArbilaSYpjmru+39iJLPZupA8VX4KmPS+PI8UW6HiWd17rLGY9+/NKCIy47WG2d
         lNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xNIfN8iP61jt3zQccTc9JxOkZ8J4CEm1u7qbNWzRMOM=;
        b=bp6VZrzSCyXI7od1JUfG2kviK/HB8v92qB/jZp3GGDqkGRzHAPQVPbGOOLcVBjveAx
         zdcVftqwtP8O259J7z7DLap5omXmAhQ0+RStQ5UHagI1M7FeGXzYqqUxB1+sQiHKP4uO
         mMTneQEERehP7mxxasmWR4VQHTuFsIeUjz5gAtyVxy6N/CfxJ2xLEIpIQoiNaCrImLpN
         g/5oiDaI/jC16ChwM6ikJoZutwsa6DEY20Zwtm5Olwvg6vqgTA5yrgoyBfksWmAe5jL8
         MRMa7xGkumoQZl4JS+OJiL8oOIOlgaHPoij+0TMtycgQ9EMhbUoA+qJeNtyFwUfJyoJ4
         S+DQ==
X-Gm-Message-State: APjAAAUxGXa2Z2NmQ9xZ4e4oW4XpOMEEdDLB8CR1gICLHHgSNO+3XdEi
        ZrQKGCNH1Cu0Yo3vd/lqR4fjgfHTIeVi6Oyqdn0=
X-Google-Smtp-Source: APXvYqxOnR1QAtlj4QPyaxK/bP27aOlkgoiK+XMInOl7nujBMV3IZ3Lpodwe6l5EmMlVNYQnEc9yesNbk20aP1l6zrU=
X-Received: by 2002:ac2:598d:: with SMTP id w13mr2369750lfn.165.1559070232676;
 Tue, 28 May 2019 12:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <1558366258-3808-1-git-send-email-jrdr.linux@gmail.com>
 <20190521085547.58e1650c@erd987> <CAFqt6zZA32QA-6VtaKcrEtq=qkoGLHpirSvXb5wt7-wd_-74hQ@mail.gmail.com>
 <CANiq72nd5i4ADU1GbEt1Dkhp-5YkC9ip-h4a0G64oN+b95wAXA@mail.gmail.com>
 <CANiq72=zCD7AAE-OBzDYm5GXenoF48SdzwO1LunWSfexqBuH7A@mail.gmail.com> <CAFqt6zaUhPJYozmq-m_BjJTh5EUmsQoE4yZ+Ovv6F-ymns+JGA@mail.gmail.com>
In-Reply-To: <CAFqt6zaUhPJYozmq-m_BjJTh5EUmsQoE4yZ+Ovv6F-ymns+JGA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 28 May 2019 21:03:41 +0200
Message-ID: <CANiq72miwcM8Jt1pFeCKs=rstbSB70wyPGPSiC7Mgf3f=Z44Lg@mail.gmail.com>
Subject: Re: [PATCH 2/2] auxdisplay/ht16k33.c: Convert to use vm_map_pages_zero()
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 8:07 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> > > Taking a quick look now, by the way, why does vm_map_pages_zero() (and
> > > __vm_map_pages() etc.) get a pointer to an array instead of a pointer
> > > to the first element?
>
> For this particular driver, one page is getting mapped into vma. But
> there are other
> places where a entire page array ( with more than one pages) mapped into
> vma. That's the reason to pass pointer to an array and do rest of the operations
> inside __vm_map_pages().

Ah, "pointer to array of source kernel pages" made me think the actual
`struct page`s were the ones consecutive in memory, not the pointers.
Maybe "array of page pointers" is more clear.

> > Also, in __vm_map_pages(), semantically w.r.t. to the comment,
> > shouldn't the first check test for equality too? (i.e. for vm_pgoff ==
> > num)? (even if such case fails in the second test anyway).
>
> Sorry, didn't get it. Do you mean there should be a separate check for
> *vm_pgoff == num* ?

No, that the first check should be widened. I will send a patch.

Cheers,
Miguel
