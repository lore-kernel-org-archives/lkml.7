Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF330C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E08B2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="xSLCrrxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbfLJVcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:32:39 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:41953 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbfLJVce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:32:34 -0500
Received: by mail-ed1-f53.google.com with SMTP id c26so17331045eds.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 13:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4Ja+Cy4lz3d7/9D3E5SJdSwFwUmUfYYIZtw7SRnmxMQ=;
        b=xSLCrrxPejnE0kdt17030quLJkQSeBjnB1vQJo4e7EaofNY9vrZMLRjLWjTUAcCSCT
         yuxr7DHf+2HvLYOySwaOiOuJZYvB0oesOytWvM4DmGl/IhueidOi+nYm0/KXxlf2GwEa
         eXFXrese8dp5z5H0DwYhE+Ts7EObyeM8Pthks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4Ja+Cy4lz3d7/9D3E5SJdSwFwUmUfYYIZtw7SRnmxMQ=;
        b=DRW3KqHccQe0VCCoxNaE2HprD5CP75KI9hWRczg4RVj9EduH2F34+Euk2aUsb0gvc2
         gHo9Z81gVL7gSP3DHHDiyC7OED+L1V7Rgh1rvpA53HBhPtVzBU/dxH6OtWVhliuTyi+T
         5OXeJC7vPsf76ZYEhHUUU4CvAZzTwtwRpWD9jUeRs6LaG9vwaW9MsJb4zBaeZp4MXY+L
         vGuwwDgXYVL7j0ItHaj5Dm6itPeoobAbyEFlvYdIJ5Y0dBbEFWojwH+wk1AuudQ8h+w4
         e2TDy2IZmswLANkdzdNP3+z05WU6HRwMWIfNTlWB3e0pdz74G8R5Vy2ql3rJdMqZ4asG
         S4tQ==
X-Gm-Message-State: APjAAAUQb1N/7lCBBnosf6IhzPKiK1a7lsWSESkmIYYfFt39LyQXC1mZ
        f6PQG/kqVHYfWDHiJ7NUZlYTYA34cWxTouhJ8mRHT/778vGxMw==
X-Google-Smtp-Source: APXvYqy8VOTXuAbKw0j1c3O8zCSGmAQsSkjj1KkDXdHcwLguds5DtEdZJNT8Hy/+moiMk2YEf22e7OKRLAhqNqpl30A=
X-Received: by 2002:a17:906:2e47:: with SMTP id r7mr6151354eji.215.1576013552064;
 Tue, 10 Dec 2019 13:32:32 -0800 (PST)
MIME-Version: 1.0
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Tue, 10 Dec 2019 13:32:21 -0800
Message-ID: <CABWYdi2GG3qi6ucxtyk3=Bu1eXi0N9Dow42F4gzi9DUUc3XhLw@mail.gmail.com>
Subject: Lock contention around unix_gc_lock
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>, hare@suse.com,
        axboe@kernel.dk, allison@lohutok.net, tglx@linutronix.de,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We're seeing very high contention on unix_gc_lock when a bug in an
application makes it stop reading incoming messages with inflight unix
sockets. In our system we churn through a lot of unix sockets and we
have 96 logical CPUs in the system, so spinlock gets very hot.

I was able to halve overall system throughput with 1024 inflight unix
sockets, which is the default RLIMIT_NOFILE. This doesn't sound too
good for isolation, one user should not be able to affect the system
as much. One might even consider this as DoS vector.

There's a lot of time is spent in _raw_spin_unlock_irqrestore, which
is triggered by wait_for_unix_gc, which in turn is unconditionally
called from unix_stream_sendmsg:

ffffffff9f64f3ea _raw_spin_unlock_irqrestore+0xa
ffffffff9eea6ab0 prepare_to_wait_event+0x70
ffffffff9f5a4ac6 wait_for_unix_gc+0x76
ffffffff9f5a182c unix_stream_sendmsg+0x3c
ffffffff9f4bb7f9 sock_sendmsg+0x39

* https://elixir.bootlin.com/linux/v4.19.80/source/net/unix/af_unix.c#L1849

Even more time is spent in waiting on spinlock because of call to
unix_gc from unix_release_sock, where condition is having any inflight
sockets whatsoever:

ffffffff9eeb1758 queued_spin_lock_slowpath+0x158
ffffffff9f5a4718 unix_gc+0x38
ffffffff9f5a28f3 unix_release_sock+0x2b3
ffffffff9f5a2929 unix_release+0x19
ffffffff9f4b902d __sock_release+0x3d
ffffffff9f4b90a1 sock_close+0x11

* https://elixir.bootlin.com/linux/v4.19.80/source/net/unix/af_unix.c#L586

Should this condition take the number of inflight sockets into
account, just like unix_stream_sendmsg does via wait_for_unix_gc?

Static number of inflight sockets that trigger a GC from
wait_for_unix_gc may also be something that is scaled with system
size, rather than be a hardcoded value.

I know that our case is a pathological one, but it sounds like
scalability of garbage collection can be better, especially on systems
with large number of CPUs.
