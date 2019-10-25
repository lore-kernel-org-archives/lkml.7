Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02529CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09212070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393264AbfJYHWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:22:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392610AbfJYHWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:22:39 -0400
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6EBB15AFDE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 07:22:38 +0000 (UTC)
Received: by mail-ua1-f69.google.com with SMTP id h15so375622uan.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 00:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yGx12ZWXQdTQ4DA+CRwxn3Wgl8jiBGsaV9L7QOn8O5g=;
        b=mZxRX0Lb3Z+lk/op4JTLQDgE9P9Vsbip+6yCwAJNpGHiC7NvfTgqNWkgN9v8nreH9+
         XURS7r+6xMj3eLnZxpdvT9iqdaMmlQ15vJertv7wzrKLOzjGYpgB+tReICPoimVnyEiN
         pdfa1eCuIK+Ity8c/WYNvM/N02bUHa9dFnAixXDGGEoIBl6VPJQsAxG/R4XFoEPkbkWc
         pEmc6f+z/GwSfwfrpsNb8ffPY9jS0d3EFiCDShMq4P+8GwN1u74130RDT0i8LgrdjyP+
         ir2EsVcSCJY/DMg+VkKUYuc7636BZCtsqPM/XNeHeTwj1wqEeD1gezK7vDlKbEsi7Jmv
         /ZCA==
X-Gm-Message-State: APjAAAUDxn6OGG0AhvbRX9+U7MBZ+Da5JhdXV+HkIugZIOPax07aZDfO
        XfEl773TCDFWzYtl0kFVnRJYzbdpepeqzW1iVnFFos1lg1QfxlqfprWwDD8FDLW+29+TwHaWUNr
        eY78qCSqGl35oKNUADdJBxb9BX/NIDDM1Wl6snwlt
X-Received: by 2002:a67:e88b:: with SMTP id x11mr1105265vsn.180.1571988157514;
        Fri, 25 Oct 2019 00:22:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyjBybREs5A0r9G8gktZgx1qhMgOORE/7AJ6wX1rGtnapuOznF9GpGMK5EoSbv0WQ1Dt/wwosoSVba22N3EeVU=
X-Received: by 2002:a67:e88b:: with SMTP id x11mr1105250vsn.180.1571988157178;
 Fri, 25 Oct 2019 00:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrVepdYd4uN8jrG8i6iaixWp+N3MdGv5WhjOdCr9sLRK1w@mail.gmail.com>
In-Reply-To: <CALCETrVepdYd4uN8jrG8i6iaixWp+N3MdGv5WhjOdCr9sLRK1w@mail.gmail.com>
From:   David Marchand <david.marchand@redhat.com>
Date:   Fri, 25 Oct 2019 09:22:26 +0200
Message-ID: <CAJFAV8y1qey9r9oSEzahLsMGDjNrRjE-ZhL_W_=cbUkRvORMMA@mail.gmail.com>
Subject: Re: [dpdk-dev] Please stop using iopl() in DPDK
To:     Andy Lutomirski <luto@kernel.org>
Cc:     dev <dev@dpdk.org>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        Tiwei Bie <tiwei.bie@intel.com>,
        Thomas Monjalon <thomas@monjalon.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

On Fri, Oct 25, 2019 at 6:46 AM Andy Lutomirski <luto@kernel.org> wrote:
> Supporting iopl() in the Linux kernel is becoming a maintainability
> problem.  As far as I know, DPDK is the only major modern user of
> iopl().

Thanks for reaching out.
Copying our virtio maintainers (Maxime and Tiwei), since they are the
first impacted by such a change.


> After doing some research, DPDK uses direct io port access for only a
> single purpose: accessing legacy virtio configuration structures.
> These structures are mapped in IO space in BAR 0 on legacy virtio
> devices.
>
> There are at least three ways you could avoid using iopl().  Here they
> are in rough order of quality in my opinion:
>
> 1. Change pci_uio_ioport_read() and pci_uio_ioport_write() to use
> read() and write() on resource0 in sysfs.
>
> 2. Use the alternative access mechanism in the virtio legacy spec:
> there is a way to access all of these structures via configuration
> space.
>
> 3. Use ioperm() instead of iopl().

And you come with potential solutions, thanks :-)
We need to look at them and evaluate what is best from our point of view.
See how it impacts our ABI too (we decided on a freeze until 20.11).


> We are considering changes to the kernel that will potentially harm
> the performance of any program that uses iopl(3) -- in particular,
> context switches will become more expensive, and the scheduler might
> need to explicitly penalize such programs to ensure fairness.  Using
> ioperm() already hurts performance, and the proposed changes to iopl()
> will make it even worse.  Alternatively, the kernel could drop iopl()
> support entirely.  I will certainly make a change to allow
> distributions to remove iopl() support entirely from their kernels,
> and I expect that distributions will do this.
>
> Please fix DPDK.

Unfortunately, we are currently closing our rc1 for the 19.11 release.
Not sure who is available, but I suppose we can work on this subject
in the 20.02 release timeframe.


Thanks.

-- 
David Marchand
