Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8538C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077C520658
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 16:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573663261;
	bh=u70FTkIfHr0s5GeiochXVYbVDgHJlfOaLAB1vLa2K5E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZFLkmG6ABqijc/NsFGnx3+AlFxtyWpaF2SufSQpLXz9ZDhAGrCj+MwBlD+gf6eb2r
	 I7X4l5cYvZIAnDUGyb5oCrdD84squU0cCVEnvfffEWyUGIFcUdwv1KlfBoN4SYi/06
	 0IjErZBiyPEnRjg/FhDwP7K1YZboVX7KHA4skoOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfKMQlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:41:01 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38335 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfKMQlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:41:01 -0500
Received: by mail-lf1-f65.google.com with SMTP id q28so2509909lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 08:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IXJjwxWVC55yLVrTrqMlfhMslA2YmSoPCmuWxQ9Z1yA=;
        b=hBBa3CeKyqP0PPhoeL6NBNaKCWmnnCm42FJMebd8vhB9frKHZbx/LVLxNigeYeeSyf
         Tr9US9KNUDjInwfvRwXHyNa4DeqDgvfhgO7Bbq+xFPMkcEXTZsq5M/y0tPhks9KaQJcN
         CurISmPdkfK1RyWNlXatFqKzg9omOPzuFCsrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IXJjwxWVC55yLVrTrqMlfhMslA2YmSoPCmuWxQ9Z1yA=;
        b=JE6pZMk/15nnLdHR58OnJIdaPB/s9nq/2wL9Nz8nFmkWRs+wQDw8UoPZ3ZmJfLgUEC
         YOnVQuQPQ/qL1M0EBBvxWJxVxDo204Zh61+Md2DlDIfXVL/lVGHjxatmSMRCxaHOGyYo
         HgKGuEHlX+hhHJ3fZSQhTNNmorC6I/K/yJgzbegg4n9gtk4gd8nk9mS1kFwwrP2k8Y/K
         XHIHPvDUXaL+KT9QJMVFgHOUDqMCIlA/gAjDoahn9qAs2bDXxgO4NTlqG+YioVMHTjvH
         GHEv+oNNezGHDOL9kga4HuHjhz7+MGPdkBONlWx3q96asbXNdW85+Gjz3g1Ty3YTxKtg
         dfUg==
X-Gm-Message-State: APjAAAUlc/qu2W2vEB4SkJD73jcWQjXTGhktNoolt2vMLSTtDNHCgbRc
        mS/G7ZNCre1aFu74pAFuD0jsA83KOVk=
X-Google-Smtp-Source: APXvYqx8BE829VJlEJjYa/HeGmKDUGYaAlu9EnJxncemVWAUxSZrZF0EXC7mybqGHVBydcxSR4qRlQ==
X-Received: by 2002:ac2:484a:: with SMTP id 10mr3266452lfy.80.1573663258517;
        Wed, 13 Nov 2019 08:40:58 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id p14sm1105423ljc.8.2019.11.13.08.40.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2019 08:40:57 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id j26so2498995lfh.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 08:40:57 -0800 (PST)
X-Received: by 2002:ac2:5bca:: with SMTP id u10mr3466591lfn.134.1573663257105;
 Wed, 13 Nov 2019 08:40:57 -0800 (PST)
MIME-Version: 1.0
References: <20191112130244.16630-1-vincent.whitchurch@axis.com>
 <20191112160855.GA22025@arrakis.emea.arm.com> <20191112180034.GB19889@willie-the-truck>
 <20191112182249.GB22025@arrakis.emea.arm.com> <CAHk-=wg4vi27mnMVgZ-rzcEdDAjTXrY1Jyz3+=5STcY0bw4-jQ@mail.gmail.com>
 <20191113102357.GA25875@willie-the-truck> <CAHk-=wjmyEdYW4vEaNDP4UMB+H7wWneOwLUR3FmPG-Fb6U8dZg@mail.gmail.com>
In-Reply-To: <CAHk-=wjmyEdYW4vEaNDP4UMB+H7wWneOwLUR3FmPG-Fb6U8dZg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Nov 2019 08:40:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj5YrnTWzS4s0AVaXgsqEKMPQ+5AqwV69+G6UJCQ2Z5-g@mail.gmail.com>
Message-ID: <CAHk-=wj5YrnTWzS4s0AVaXgsqEKMPQ+5AqwV69+G6UJCQ2Z5-g@mail.gmail.com>
Subject: Re: [PATCH v2] buffer: Fix I/O error due to ARM read-after-read hazard
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jens Axboe <axboe@kernel.dk>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Vincent Whitchurch <rabinv@axis.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 8:36 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> test_bit() is a very unfortunate interface, in that we actually use it
> in some situations where we _really_ would want to merge reads (not
> split them, but merge them). There are several cases where we do
> constant test-bits on the same word, and don't care about ordering.
> Things like thread flags etc.

Side note: test_bit() really isn't good for locking in the first
place. The fact that the buffer heads use it for that is very
non-optimal indeed.

Particularly for testing something like "is this buffer uptodate", it
should be a "smp_load_acquire()", not a test_bit(). And READ_ONCE()
doesn't really help.

So in many ways it would be much better to make the buffer head stuff
use proper ordered accesses. But I suspect nobody is going to ever
want to go through that pain for a legacy thing, so the papering it
over with READ_ONCE() and a ugly ARM hw erratum hack is probably the
best we'll do..

                Linus
