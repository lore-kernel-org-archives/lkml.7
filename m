Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A83C606C2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2B821479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562606263;
	bh=xeeugXLQ3ZmZP7Y+0mWbGuIAc/QDh9snlWVr85+FCYQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=H+vd3c0NTIODBa3MsBuNDOpmSzg6bVs2dEDQk4vCryu6llLgjXpbn1J9KHuh3o1e8
	 d8MrIhJWgjeyLft2W5yUQqYiGYO4/7oOMDFQbVfXFi32egvRV9YmjAlibv3KveJQrP
	 SWF/QkrsL6LO0tLHBqRNDDT0I6jO7eg5ilrniTGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387560AbfGHRRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:17:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38890 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbfGHRRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:17:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id h28so7130090lfj.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+bECgTdMtGyGERAEx4hhuq1ieQo20b4zcXHR1yCPWbo=;
        b=YkdbkwQAEgL5WEVqh56Ro2gTiY0AqYU6FJl4lhKzjngEUNfc75EOmqvN/9o5KeQpRO
         8lpUZyvo4iiOCecAiFUNPpFjrlvMY38JOxpiAtItCRRMhaMDC1zexo+UgbU4ZqyeGdqs
         Q3VdTY3FIaBIw/JtDQVJXC5HHLSZ075eXR2II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bECgTdMtGyGERAEx4hhuq1ieQo20b4zcXHR1yCPWbo=;
        b=dHyNiKPTMQbjQap+IuMBIgmoSgrhtC4ZZrYOxgQtm75SnhyuBb2Hr1NE5hI68KP6xs
         XpNGi02mWcCs7TAL4koqgrjaSb2fyKPVeB42/q7Klh9QWZUMwWvEc5xKw6WzF4+7izZl
         G/awf3AAFRv28mk9LmkQMKw/uVf8mBYAGhz+o402jPUT+p74Wm2PVsrsdojGlL2i1ZPI
         7dnhEiVf7gyAh2CH3b6xcYyHR6vQDHSNbQuzFsEI9pVHvYmgD5Ne7ICwcIgD2k+eC636
         srmHZkwZxU10jM4MlxJfIyvxXoozHHgwrNLb86cW76xS8yuNbOQxArTfP61DjnlEF+fl
         ZROA==
X-Gm-Message-State: APjAAAUxnHdkBrkpaoP8+c/YSatG+Xo1ppdxTkbHqTV+EZovM8ipIiVp
        HhMJegAlAbyU5X2two6wwMsIxs2OW2Q=
X-Google-Smtp-Source: APXvYqy2JQCd64K3Ye9dSBV4wV4goFxtwz10QGzlPRqvr+382vadfJ2KMxecN8uia9sf3+oJj/55LA==
X-Received: by 2002:a19:6e41:: with SMTP id q1mr9496421lfk.20.1562606259526;
        Mon, 08 Jul 2019 10:17:39 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id r84sm4148687lja.54.2019.07.08.10.17.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 10:17:38 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id t28so16700829lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:17:38 -0700 (PDT)
X-Received: by 2002:a2e:9a58:: with SMTP id k24mr10999260ljj.165.1562606258274;
 Mon, 08 Jul 2019 10:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <your-ad-here.call-01562573328-ext-8139@work.hours>
In-Reply-To: <your-ad-here.call-01562573328-ext-8139@work.hours>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 8 Jul 2019 10:17:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=win6P5gsZnE57WZOUNGP12gX2gGri3+7EhQ6uky2fZk_w@mail.gmail.com>
Message-ID: <CAHk-=win6P5gsZnE57WZOUNGP12gX2gGri3+7EhQ6uky2fZk_w@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for the 5.3 merge window
To:     Vasily Gorbik <gor@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 1:23 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> please pull s390 fixes and features for 5.3.
> This is my first pull request. My PGP key id is 716A93D7,
> key fingerprint: F397 316C 210A 9C03 1205  6691 467C 8ED2 716A 93D7

Thanks for the heads-up, everything looks fine and I see you have the
proper signatures on that key.

> Please also note the fixup required to avoid s390 build error after you
> pull Greg's driver-core changes for 5.3:
> http://lkml.kernel.org/r/e9889ea3-0286-df1c-864c-ba67a0286855@de.ibm.com

Ok, so I don't have Greg's pull request in my in-box yet, which means
that I may well forget about this by the time I do get it, and I won't
see the build failure because I don't do a s390 cross-build.

I'll _try_ to remember, but apologies in advance if this slips
through. I have the working memory of a slightly retarded chipmunk.

Greg - if you happen to remember and add a reminder to the pull
request when it gets done that would be good, but worst case the s390
people get to call me names.

                Linus
