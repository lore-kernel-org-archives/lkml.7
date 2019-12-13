Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52654C00454
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091282077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 21:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ryXfaXsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfLMVsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:48:32 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34248 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLMVsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 16:48:31 -0500
Received: by mail-pf1-f195.google.com with SMTP id l127so375312pfl.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 13:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=LQM0SeoeNiwh+vjuahrdocxZ7v2lN0s5qQ2LuFjv7EM=;
        b=ryXfaXsmkKOf8ne8NGU6qqsPIo4DsI5MiAc8WmgxRyinEO3jdT3FKStLuEpZ5OzpEb
         Lz1AzCXIVN7yPQqYjkz8/ped7q1726Fj5rNW7J+DxHeLDWLU4rDPSO3s7s97ylxzQhJj
         UP2N5vJHmbMf80MjoCx8wqcwnk7sopxpBC7mr0fh6ze6bwCj1l4r0UC1qJgD1TM7rhQR
         JY+d/j1Rp+hjc2PR4fXTZdLe65bm4nQp1Z55jJ+kq8nid+AFC+rOvqyipgE9XVHEhthr
         mSStFYSgX2sRI+zrt3zLcSAViR36cD7Bny43mCebRE60dACBpclRBy9ednnYjc5Sq9gW
         aTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=LQM0SeoeNiwh+vjuahrdocxZ7v2lN0s5qQ2LuFjv7EM=;
        b=W+Z5A27kClq3b4TJXo/6nsC2S7F91GzSVOAGywnO+PBXgIrkv+HwFGZNmKplRJDXOb
         VzLLqbCeaNV18igIhnnUusk+ir3+SJiTgurVrkiu5UbA6snjUfJmA31vIDhXZMWbAB5A
         AqoEPLAcGExGooCCEr3wCnhF7Q6bNOzSaJtu3M8/IJ8Gx1YCf7IYj3MgsQyNS5gSAQfU
         +Ev254Y2hPahQqdGXAEg2BMrFK6UI+k/722GpwXzg5ux3kqfxq1uWH3ABvQbn2yGc5xR
         h1AejXbk//kng6KgSzK0+bNaStKuQe69zC0YLRmsOyMTFEYvz/nTPRodAWfffPdZJbpf
         FUvA==
X-Gm-Message-State: APjAAAWUM/+leqRiW68e/pYEcDcTRbLBf6Ue5+7oWFUJGt4zhQxrDVkr
        OhO7zOT92ob0TQF7Wm27h2Wv/LhnCQM=
X-Google-Smtp-Source: APXvYqzZFKttwt9HJQrOXzkIWGWsstEYgjjMTYz5i0rFgJigdZXfeyEznbxMXtAW1WbIXOoR1pQH9w==
X-Received: by 2002:a63:646:: with SMTP id 67mr1912598pgg.150.1576273710413;
        Fri, 13 Dec 2019 13:48:30 -0800 (PST)
Received: from ?IPv6:2600:380:7711:c4b4:bda3:a46c:a74e:d77f? ([2600:380:7711:c4b4:bda3:a46c:a74e:d77f])
        by smtp.gmail.com with ESMTPSA id i127sm13864499pfe.54.2019.12.13.13.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 13:48:29 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Jens Axboe <axboe@kernel.dk>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/1] io_uring: don't wait when under-submitting
Date:   Fri, 13 Dec 2019 14:48:28 -0700
Message-Id: <B50496AA-BE78-45B7-A17D-9740FF42A8EF@kernel.dk>
References: <47a5641b-af81-0edf-1d71-4e3063ce8517@gmail.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <47a5641b-af81-0edf-1d71-4e3063ce8517@gmail.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Dec 13, 2019, at 2:32 PM, Pavel Begunkov <asml.silence@gmail.com> wrote=
:
>=20
> =EF=BB=BFOn 13/12/2019 21:32, Jens Axboe wrote:
>>> On 12/13/19 11:22 AM, Jens Axboe wrote:
>>> On 12/13/19 12:51 AM, Pavel Begunkov wrote:
>>>> There is no reliable way to submit and wait in a single syscall, as
>>>> io_submit_sqes() may under-consume sqes (in case of an early error).
>>>> Then it will wait for not-yet-submitted requests, deadlocking the user
>>>> in most cases.
>>>=20
>>> Why not just cap the wait_nr? If someone does to_submit =3D 8, wait_nr =3D=
 8,
>>> and we only submit 4, just wait for 4? Ala:
>>>=20
>=20
> Is it worth entangling the code? I don't expect anyone trying to recover,
> maybe except full reset/restart. So, failing ASAP seemed to me as the
> right thing to do. It may also mean nothing to the user if e.g.
> submit(1), submit(1), ..., submit_and_wait(1, n)
>=20
> Anyway, this shouldn't even happen in a not buggy code, so I'm fine with
> any version as long as it doesn't lock up. I'll resend if you still prefer=

> to cap it.

I like the cap version a lot better, and in fact we did used to have that bu=
t lost it early. I like it behaviorally a lot better, too.=20

Can you resend? Thanks!

