Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD8EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 03:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190542075B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 03:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564372457;
	bh=2tQuQHTnu/mJjklJUZsHAQI0kaAk3Bi3c79GlFJnet8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Gg3ulyLtoEGnqt7M6TLM8FBN3BInkFaKulxsN3ma/zfYsxeeUTFicNmU5uc1rETh4
	 KpOD1qU+6BEkbnUKP7Onk3jhl5Kn7+BWDWbmmEr8VuBTih9HNhdGPz1VoKP1vOD2Nt
	 KgjtYnZE2HSauMfS+CuKdIAOYdWhKSQ+C5CrFzTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfG2DyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 23:54:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbfG2DyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 23:54:12 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6826B21655
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 03:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564372451;
        bh=2tQuQHTnu/mJjklJUZsHAQI0kaAk3Bi3c79GlFJnet8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LjpAREuKb+1hbftFyPqNYMkp3woKKhr2b/xHD86G8/XOG2/HqU20ZDei2Za6qUDjv
         NhliTYYQuvTUzRx4lCxBkS5glhuezc4dly9I6qeEzB/jVlMy2YtxpcECvflyiAxD85
         gIKr07F+OCIx3PUpjCdjeuBZ/ArPjmebpT5OSlyU=
Received: by mail-wr1-f41.google.com with SMTP id f9so60112048wre.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 20:54:11 -0700 (PDT)
X-Gm-Message-State: APjAAAVQWFCN3AUhhPp/DZCeLej0xx+52vIO3SDcmYO1NkeITZWNhzaK
        kFZCM+O3ckWYtDVmSGQJPhWfZ+WxjXPYXMAlgCQgmQ==
X-Google-Smtp-Source: APXvYqx9kG3JhSn4ejzWbB2Y6ZZXlzbRvrHqILc4LGopmKRBvxtYUVZM7ewWknjCh0gGn94azjkdPJGXhhbOHIAqf6Q=
X-Received: by 2002:adf:f28a:: with SMTP id k10mr39238424wro.343.1564372449880;
 Sun, 28 Jul 2019 20:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190729015933.18049-1-dja@axtens.net>
In-Reply-To: <20190729015933.18049-1-dja@axtens.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 28 Jul 2019 20:53:58 -0700
X-Gmail-Original-Message-ID: <CALCETrX_+_zT8iKp9QMpaN0+NPS9_rmhZvPgG=ejN-5KkBbfdQ@mail.gmail.com>
Message-ID: <CALCETrX_+_zT8iKp9QMpaN0+NPS9_rmhZvPgG=ejN-5KkBbfdQ@mail.gmail.com>
Subject: Re: [PATCH] x86: panic when a kernel stack overflow is detected
To:     Daniel Axtens <dja@axtens.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     kasan-dev <kasan-dev@googlegroups.com>, X86 ML <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2019 at 6:59 PM Daniel Axtens <dja@axtens.net> wrote:
>
> Currently, when a kernel stack overflow is detected via VMAP_STACK,
> the task is killed with die().
>
> This isn't safe, because we don't know how that process has affected
> kernel state. In particular, we don't know what locks have been taken.
> For example, we can hit a case with lkdtm where a thread takes a
> stack overflow in printk() after taking the logbuf_lock. In that case,
> we deadlock when the kernel next does a printk.
>
> Do not attempt to kill the process when a kernel stack overflow is
> detected. The system state is unknown, the only safe thing to do is
> panic(). (panic() also prints without taking locks so a useful debug
> splat is printed even when logbuf_lock is held.)

The thing I don't like about this is that it reduces the chance that
we successfully log anything to disk.

PeterZ, do you have any useful input here?  I wonder if we could do
something like printk_oh_crap() that is just printk() except that it
panics if it fails to return after a few seconds.

--Andy
