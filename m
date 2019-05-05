Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA6CC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 10:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0802E20C01
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 10:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfEEKnZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 06:43:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39251 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfEEKnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 06:43:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id q10so8702464ljc.6
        for <linux-kernel@vger.kernel.org>; Sun, 05 May 2019 03:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4GjLl7K6asTFLnlYxatdFlHWtyLi5pvTCEs/u8ILWik=;
        b=DLxdxxsXcWXW4T+fZ3uvtuHRPwb4DTcyg7qdzMspM0zTgfW5wqXQ4n9P5J831L0/kh
         lHyqlxcYswW6/KXbt+p6LooJzJNEn7wQmgi4ncG5c0XAf1amxEXRhA1UUTQeg1lEX2sd
         nMBe00mhA1hREkgdlPnvdtohJ29qTqgMG1MMGksss4AEOFtcJYTb4AUAAUvXYaacw9mO
         Asuy6LHQRgne2Amd1o1Tu+eVleloJCHjiyzHNAlSqp6vgBJrF6KDsEuCN5ZXKoW+5BPV
         he4a4a/RmczBFP5Dw676oqGUf1giBD7EkRTbCVVlVyiiA7PxSzQoZICudhKEEXHrZjWU
         6U9Q==
X-Gm-Message-State: APjAAAUHehKKfBqZIW30sIWu4a7kJTXXuYkD+jutgKEdPwhaKq0rDOz6
        QyrT0PGFg5HFXatjGMblmrx1Wg==
X-Google-Smtp-Source: APXvYqwEy7omAXcrY5BsTGyRKJslL4mnjw0B1lsP0tlQ3iQfUu4XMFEePdMId0TLiu6kV5iIrnsOWg==
X-Received: by 2002:a2e:3c12:: with SMTP id j18mr10596470lja.193.1557053002627;
        Sun, 05 May 2019 03:43:22 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.vpn.toke.dk. [2a00:7660:6da:10::2])
        by smtp.gmail.com with ESMTPSA id b25sm1445240lji.50.2019.05.05.03.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 May 2019 03:43:21 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AB2A318039B; Sun,  5 May 2019 12:43:20 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Kevin 'ldir' Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk>,
        Greg KH <greg@kroah.com>
Cc:     "xiyou.wangcong\@gmail.com" <xiyou.wangcong@gmail.com>,
        "davem\@davemloft.net" <davem@davemloft.net>,
        "jhs\@mojatatu.com" <jhs@mojatatu.com>,
        "jiri\@resnulli.us" <jiri@resnulli.us>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest\@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "shuah\@kernel.org" <shuah@kernel.org>
Subject: Re: [net-next v2] net: sched: Introduce act_ctinfo action
In-Reply-To: <B6426224-12CC-417B-9A38-6DDBE574A85C@darbyshire-bryant.me.uk>
References: <CAM_iQpXnXyfLZ2+gjDufbdMrZLgtf9uKbzbUf50Xm-2Go7maVw@mail.gmail.com> <20190505101523.48425-1-ldir@darbyshire-bryant.me.uk> <20190505102314.GA12761@kroah.com> <B6426224-12CC-417B-9A38-6DDBE574A85C@darbyshire-bryant.me.uk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 05 May 2019 12:43:20 +0200
Message-ID: <8736lt9o6v.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin 'ldir' Darbyshire-Bryant <ldir@darbyshire-bryant.me.uk> writes:

>> On 5 May 2019, at 11:23, Greg KH <greg@kroah.com> wrote:
>> 
>> On Sun, May 05, 2019 at 10:15:43AM +0000, Kevin 'ldir' Darbyshire-Bryant wrote:
>>> --- /dev/null
>>> +++ b/net/sched/act_ctinfo.c
>>> @@ -0,0 +1,407 @@
>>> +// SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
>> 
>
> Hey Greg, thanks for the review.
>
>> How can a .c file, buried in the kernel tree, have a Linux-syscall-note
>> exception to it?
>
> Because I’m a moron and nobody else spotted it.
>> 
>> Are you _sure_ that is ok?  That license should only be for files in the
>> uapi header directory.
>
> Expect a v3 shortly.  I shall wear your chastisement with honour :-)

While you're at it, you don't actually need the GPL text blob when using
the SPDX headers... :)

-Toke
