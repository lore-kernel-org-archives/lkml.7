Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1F5CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7278F21D82
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572014763;
	bh=c0TJ1mKs2s0GUD/wp9Pell6cGrl9NXu0zGJCItAHu+0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EJuFUY11d+E4eojg2jPQpD1D7Ukst8gdMTzbqkFCvLrKHxzauLgaYSlHnH+8cqQcO
	 pugMg4LMk7CBC3GwK8H7i5Ngt5bAOv9k7QPZF9OaKzOcSlcqNPwu1kwMtlr7Wmxk9+
	 GywzfftrBTcShjLe6mqAapKcE21Jdpn3UliMT498=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395028AbfJYOqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:46:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390195AbfJYOqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:46:02 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B5DA21E6F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 14:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572014761;
        bh=c0TJ1mKs2s0GUD/wp9Pell6cGrl9NXu0zGJCItAHu+0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hkMaQ42BA+w+biTpZI2C7IZ7RMwTnWX4vcDPoqxZHjjbESTSKSYzawpMytL0ntVGa
         i9vII2WX5+UXdGA3Il7bt/ALNrsVari4gzY8bHMHwSelBbrDXh+vSMDZSBKaeJefT3
         4jurLclJrpH+k2u/5euOwanrgR9VvrrxOWSpfYxo=
Received: by mail-wm1-f41.google.com with SMTP id g7so2430915wmk.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 07:46:01 -0700 (PDT)
X-Gm-Message-State: APjAAAWdxx475QHNYU5YQP0YPIRddVUEGXXNewSPt16E/TXT86CWhE/g
        oGHqQPbMMLbF/PslQL6+Ey5d1PVW9D+iUbGH8PPcaQ==
X-Google-Smtp-Source: APXvYqySxeWX+EY+FBP3Gs6CKKYYkYGhBHt4AIRaXekHZ3n0SMLgmO7fY8ACrIziZjSJN87UsKzOKeQYLu0KvRLu1xI=
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr3616761wmk.173.1572014759511;
 Fri, 25 Oct 2019 07:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrVepdYd4uN8jrG8i6iaixWp+N3MdGv5WhjOdCr9sLRK1w@mail.gmail.com>
 <20191025064225.GA22917@1wt.eu>
In-Reply-To: <20191025064225.GA22917@1wt.eu>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 25 Oct 2019 07:45:47 -0700
X-Gmail-Original-Message-ID: <CALCETrXtKBtMx3gf2BysCeYEzDFN_wjiKCGh_onCdA=7TbBxZw@mail.gmail.com>
Message-ID: <CALCETrXtKBtMx3gf2BysCeYEzDFN_wjiKCGh_onCdA=7TbBxZw@mail.gmail.com>
Subject: Re: Please stop using iopl() in DPDK
To:     Willy Tarreau <w@1wt.eu>
Cc:     Andy Lutomirski <luto@kernel.org>, dev@dpdk.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 11:42 PM Willy Tarreau <w@1wt.eu> wrote:
>
> Hi Andy,
>
> On Thu, Oct 24, 2019 at 09:45:56PM -0700, Andy Lutomirski wrote:
> > Hi all-
> >
> > Supporting iopl() in the Linux kernel is becoming a maintainability
> > problem.  As far as I know, DPDK is the only major modern user of
> > iopl().
> >
> > After doing some research, DPDK uses direct io port access for only a
> > single purpose: accessing legacy virtio configuration structures.
> > These structures are mapped in IO space in BAR 0 on legacy virtio
> > devices.
> >
> > There are at least three ways you could avoid using iopl().  Here they
> > are in rough order of quality in my opinion:
> (...)
>
> I'm just wondering, why wouldn't we introduce a sys_ioport() syscall
> to perform I/Os in the kernel without having to play at all with iopl()/
> ioperm() ? That would alleviate the need for these large port maps.
> Applications that use outb/inb() usually don't need extreme speeds.
> Each time I had to use them, it was to access a watchdog, a sensor, a
> fan, control a front panel LED, or read/write to NVRAM. Some userland
> drivers possibly don't need much more, and very likely run with
> privileges turned on all the time, so replacing their inb()/outb() calls
> would mostly be a matter of redefining them using a macro to use the
> syscall instead.
>
> I'd see an API more or less like this :
>
>   int ioport(int op, u16 port, long val, long *ret);

Hmm.  I have some memory of a /dev/ioport or similar, but now I can't
find it.  It does seem quite reasonable.

But, for uses like DPDK, /sys/.../resource0 seems like a *far* better
API, since it actually uses the kernel's concept of which io range
corresponds to which device instead of hoping that the mappings don't
change out from under user code.  And it has the added benefit that
it's restricted to a single device.

--Andy
