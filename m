Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841CEC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E1F206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rqH+Q70g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389181AbfIPPdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:33:04 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45864 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfIPPdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:33:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id r5so5412248wrm.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 08:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XnZzCgNl5Li64ZSQFv//FoKBxLdLaPCGLly2eacdiG4=;
        b=rqH+Q70gXbDpZRgp7MkKmtdfPNCj1S6kcZp4f2P7jcpIbex5mq95XA+aG6nDCAIHEI
         xKOmlWruDiIKVYGn7cLwTjgDMyW/qf+xfJwnC10FCHUZJ1MY/mhyssqvyWznJm7zzuBH
         yFpJORCI9Dx84FFHqQ7cA8YfYPRPTz/0JF0KWXp9Cwxc/wSbAPXiYyC2t+Kl63N7+kOt
         4JKV7fLJHJQmzbi00wTrSGJ+Rm+6wthLxgooAZn+qpAdIBP48yfiET5Uo6TIQUX+ZY7k
         RAi5opxkcPwdyeVU9aXkvZvqWnZf8uuD98BKmGD6QxESOKJMD+YwKi+AKEpGaHCWrcYL
         8WBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XnZzCgNl5Li64ZSQFv//FoKBxLdLaPCGLly2eacdiG4=;
        b=Lkb5JIYw3MFAt5F0vt9G6Gqyn03GXuyO3elb2b/9TpwtYjVM9MPrVedi3IzPaJvGwh
         x7jdk569OXX4Sp+B8BgTVdHW5ljl8cbfFGGeFFFa2JhBvwdH0575RTrqVqCo1g4vVZgO
         k1s8cgRwNpJtCeKNRVrc7KLQsKEeHlXpCgjJXrnAFegAYXwV81aDe0Q89ZvOerot+Xb8
         tY3Y940leeSX8KbcTFu70VZa3AV0lEYs0alPHBPSIW//2JtxOJtvqHRWgIOxbb98tWbU
         7FF12Qde2iuR8EwXGypAk6Sn0CQf7IzZ/q+npwX7qM9Z9mFWXI7wgpCOWTgWnhb6crIw
         x5xw==
X-Gm-Message-State: APjAAAXc2jigphYps8I/XXf6CinKcYpTxeEPxOwxazaIEkZJtrSofr7x
        gy12d0Fbd8I4FJhwEz0Xy8ilmQ==
X-Google-Smtp-Source: APXvYqwvOf40jqFvjzXJxMSjhDrzjIihGtQ9d3G915lKe0I5hiaurjjPRNbwGPTC39BKGkJkIqoqkQ==
X-Received: by 2002:a5d:4ac5:: with SMTP id y5mr300402wrs.179.1568647981775;
        Mon, 16 Sep 2019 08:33:01 -0700 (PDT)
Received: from [192.168.0.101] (146-241-102-115.dyn.eolo.it. [146.241.102.115])
        by smtp.gmail.com with ESMTPSA id f17sm30458272wru.29.2019.09.16.08.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 08:33:01 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 0/4] block, bfq: series of improvements and small fixes of
 the injection mechanism
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <9088f78edc97279e34f6a96277d088f9@natalenko.name>
Date:   Mon, 16 Sep 2019 17:32:57 +0200
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C486212B-1601-45A6-A66D-FA764195882F@linaro.org>
References: <20190822152037.15413-1-paolo.valente@linaro.org>
 <9088f78edc97279e34f6a96277d088f9@natalenko.name>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
can these be considered for 5.4 too?

Thanks,
Paolo

> Il giorno 9 set 2019, alle ore 08:03, Oleksandr Natalenko =
<oleksandr@natalenko.name> ha scritto:
>=20
> On 22.08.2019 17:20, Paolo Valente wrote:
>> Hi Jens,
>> this patch series makes the injection mechanism better at preserving
>> control on I/O.
>> Thanks,
>> Paolo
>> Paolo Valente (4):
>>  block, bfq: update inject limit only after injection occurred
>>  block, bfq: reduce upper bound for inject limit to =
max_rq_in_driver+1
>>  block, bfq: increase update frequency of inject limit
>>  block, bfq: push up injection only after setting service time
>> block/bfq-iosched.c | 35 ++++++++++++++++++++++++++---------
>> 1 file changed, 26 insertions(+), 9 deletions(-)
>> --
>> 2.20.1
>=20
> FWIW, Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name> (I run =
it for quite some time already).
>=20
> --=20
>  Oleksandr Natalenko (post-factum)

