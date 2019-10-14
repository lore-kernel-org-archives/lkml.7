Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC7CC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E57120854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 17:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="snBxDpYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbfJNRiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 13:38:06 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34454 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730039AbfJNRiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 13:38:05 -0400
Received: by mail-oi1-f195.google.com with SMTP id 83so14447308oii.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 10:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QSCO5aB2fA+02qEUEaBs4WEazb7/tnATGJJwnHFP2CY=;
        b=snBxDpYBkjPomhnffO2N88geBv6vgoB9wKs2Yu2t62CUJb0JWltYMS6AaF4WKv/NlB
         bLY6NAVQMq1lkCZPK3JKlFYPciGoE2cW/Qx8fbOFeI8HOrJtlgl3g4GSJLAGrRQ0zliB
         y7XfpND078dDkIKkQmM05NgKIQYQTHUonOhrDjy70Rwn1wGzOb4gn5gdhxpD/DrIDAOX
         UAyTRjasN9llYMhvUu+3xjF3E5Vkl3HkJ9lVC44s0rfPNVNPt1fqHyC5T3flTuk2nIKC
         wEo3r9449VLdpTdbOp9NpQ+N4KSwh0KVpmpiQB+VxUT7ncoubTL7ejieKOnBbdEQem50
         1zBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QSCO5aB2fA+02qEUEaBs4WEazb7/tnATGJJwnHFP2CY=;
        b=tjGCtfAHlIT501hD9euHqZ5WGMqF5fq1l5lW5JbI4pG2/Jmg1YRx5arGKXQEJulY9f
         QpUg9OTCcqkcGPm85CVe0RcHL209NCj1rLsnzjnHlikJ5I7LVXw9duxPcgXOr7v1gSnQ
         sp34UoqUs07dqjVlmAYr7VlhmtWDoDvgO14MlSxZg37m/62P3ociS6cXHIIcHTpXZMzm
         C99PxKhobwkGpO0gSJD/FVfcWIrpZ8S/4ayrFqjkWsicb9Hgzs7oe9sHShMyxEvqb5QP
         0kUAlSYQu1ybZ9L+UmiTSiIi+LuLa4vuAurh48nECC/GjblAEJ2323lwS4nrJ6iCkpqv
         8tag==
X-Gm-Message-State: APjAAAUwoh6GS6jbB1cRuhkt9MV0knwbm+XXE4iwXiUEKa6iDQc3fDNV
        xzxMSRB05PZslCW/tCMUWI0+V06sRZlUMxOFoLYIaQ==
X-Google-Smtp-Source: APXvYqztx76pi31dpiCrP7KHa3pI9SHJTfDuzi9ExMRTPyT4Eeto/zDYD3BIljiOAlRPGJD1fyGVBZ5ggSkrm3My2vg=
X-Received: by 2002:aca:f403:: with SMTP id s3mr25678430oih.23.1571074681984;
 Mon, 14 Oct 2019 10:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190715191804.112933-1-hridya@google.com> <CAG48ez0dSd4q06YXOnkzmM8BkfQGTtYE6j60_YRdC5fmrTm8jw@mail.gmail.com>
 <CAG48ez2ez1bb=3o3h1KSahPU6QcdXhbh=Z2aX4Mte24H4901_g@mail.gmail.com>
In-Reply-To: <CAG48ez2ez1bb=3o3h1KSahPU6QcdXhbh=Z2aX4Mte24H4901_g@mail.gmail.com>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Mon, 14 Oct 2019 10:37:25 -0700
Message-ID: <CA+wgaPNPSOzEf-p8wsorqGe=eEbhFLkW6gYfYP1MaCqhQBvrnw@mail.gmail.com>
Subject: Re: [PATCH] binder: prevent transactions to context manager from its
 own process.
To:     Jann Horn <jannh@google.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        syzbot+8b3c354d33c4ac78bfad@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 3:11 PM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Oct 11, 2019 at 11:59 PM Jann Horn <jannh@google.com> wrote:
> > (I think you could also let A receive a handle
> > to itself and then transact with itself, but I haven't tested that.)
>
> Ignore this sentence, that's obviously wrong because same-binder_proc
> nodes will always show up as a binder, not a handle.

Thank you for the email and steps to reproduce the issue Jann. I need
some time to take a look at the same and I will get back to you once I
understand it and hopefully have a fix. We do want to disallow
same-process transactions. Here is a little bit more of context for
the patch: https://lkml.org/lkml/2018/3/28/173
