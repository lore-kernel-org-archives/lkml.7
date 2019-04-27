Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE71C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 23:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EAD20881
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 23:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNhoSXJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfD0Xb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 19:31:58 -0400
Received: from mail-it1-f178.google.com ([209.85.166.178]:54857 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfD0Xb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 19:31:58 -0400
Received: by mail-it1-f178.google.com with SMTP id a190so11374994ite.4;
        Sat, 27 Apr 2019 16:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ExXFeWZqr6q0Nj5H2kUVmtpTrOrKnLFcUsIpUqz/LX8=;
        b=FNhoSXJMubOcR10ZmwciYeQWptA4XxLc+6MUludTMoa5KX/JJZovPo840JBocGjpLX
         XdmXO7Q+zz+mMNG+89F39yhkfXNUqyCmfowhbLCeTPJrArycBUrYqJxMJFatSHcUr54Q
         gJEovtIubhJQXYui9TnL8O2/ER6UW1aqkhtZ5eLYdDNyZllQHXirOJun6EIyuD3uE7SY
         FNHDNIIyDRyyFjQfS0HN/ypKUP+23flUy/izl6/ufSMf7UqA3pA62A0uj6HG5zKbM1oW
         T6019ZyOUDDbU1FH2dgjAqS0tk+GyUqEwuv4cIizuVERMXoN69D8HammS1MRbIr8My9W
         f5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ExXFeWZqr6q0Nj5H2kUVmtpTrOrKnLFcUsIpUqz/LX8=;
        b=f8UBis0mHG4u8rae2rje9jc9Tl0HzjdIPPxTHMep2sI6O0ihoVV8qNpZYQyYoksDdw
         2SoNJ7U5dvePYyXIb0VNKoYzhrIxKM6I+PwlJE6uEL2BQh0XFdnCCCupnfb/+nHPum1B
         AmE+ZysFIrFOI0NjIncsktbozc93utXj7wZQKQKVQdMiHzjpTGJZ7m/4gXrJuCMRPPh3
         GLjTw3D64h2/CVhCFZbc18iuIIwsRmDfsva/graoIKQY9BX16ukIcSqAqiTScNQ8omqX
         0dWJe22bLIV8VQBIf7jNemCepO06P1ynHvvM2RqH/SdHr6nVXYUk5M1l/9u1aFHbRDfm
         Drvg==
X-Gm-Message-State: APjAAAVuyaMYwIaNtWi0NriIKDR77sHksAgLiZcjaGF/G0F01FC0XLkp
        WkSwOgIanD7eVClqKdBKfBQbXQkOQ36QSOI2k/w=
X-Google-Smtp-Source: APXvYqwmtZQQ9IkCf8f9naqRr1nT4SpdgpyKNqMH0vasq9b7okFPH/v7JvYjTDOXjw8wzbPC+mvSAhb3a3tgDZGkJO4=
X-Received: by 2002:a24:7456:: with SMTP id o83mr14196603itc.61.1556407917147;
 Sat, 27 Apr 2019 16:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <CA+8F9hicnF=kvjXPZFQy=Pa2HJUS3JS+G9VswFHNQQynPMHGVQ@mail.gmail.com>
 <20190424193903.swlfmfuo6cqnpkwa@dcvr> <20190427093319.sgicqik2oqkez3wk@dcvr>
In-Reply-To: <20190427093319.sgicqik2oqkez3wk@dcvr>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 27 Apr 2019 16:31:44 -0700
Message-ID: <CABeXuvrY9QdvF1gTfiMt-eVp7VtobwG9xzjQFkErq+3wpW_P3Q@mail.gmail.com>
Subject: Re: Strange issues with epoll since 5.0
To:     Eric Wong <e@80x24.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Davidlohr Bueso <dave@stgolabs.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jason Baron <jbaron@akamai.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Omar Kilani <omar.kilani@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to replicate the failure on qemu.
I do not see the failure with N=32.

Does it work for N < 32?
Does any other signal work?
Are there any other architectures that fail?

Could you help me figure out how to run just the one test that is failing?

-Deepa
