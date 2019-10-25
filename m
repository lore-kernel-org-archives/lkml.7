Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF2ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B612070B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 16:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="g0+LbZNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632751AbfJYQNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:13:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45214 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503806AbfJYQNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 12:13:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id c7so695446pfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 09:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DbUUYSktrWx+Mr7+/XFosbA8omgMeae0KrcIpIaZY+4=;
        b=g0+LbZNvC0/oQnA0E65voBPgI5E6LKImNIIY7vUgQIElbTP/N/BrP2eccHFrkwmFmY
         s/iRUc4IV33YfRn/jX8Dy5Rq/NFKpFf4+d+q8dsh1+mEWOqN1FDBuMLWAS/i7aiQDsTm
         rjZgYLDqNmvlES6m6SYlAsPse7N2DqlyyNu11QSUp8oEHIxqBkd52aZQWm93ynBV3QBI
         VCthI6AJ3X/avwK3KIFyPQAxihrQ2sHp2eIyAT+Q3Xy0iCAz40Kk5xkOkrJWkVcFD2wn
         MvWrFjUXMSAKazqGJ9Szf/+biteH0kYub08b0Xot8NmyY7SnoyQ4Z6XqA8WCb+zcBNyS
         Pmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DbUUYSktrWx+Mr7+/XFosbA8omgMeae0KrcIpIaZY+4=;
        b=dtrkBmHQGbEcuN65dp0pFY74ao3mL8UE9WeuBkkGCM+n5zvc7rDmCP368xy5+d5/Qd
         Imzxb18vLgB8/nIP5ptzFcYZYbJiTNJGk74aorKXBb2/T8BtNzR9MyYSN9/xJ7ZZyOcu
         8R/SDQpbU2J/NFiEaj+tDm+t2jUDV+qESeEiBMkrvrqXY/7vDG7yHCfzOiOkUBpdBdTD
         NORZvK3oux5D3uA2jrbiUrod9RFvkSRUkTaTO22MLWhpA+e786xfxYXzXkimmnWTkGQR
         m9wELWvSPT80AiC8IrOgAF8a3htp10i7vCUh+ey6urA2p53VCOoSwPPIX/Zr4tCi4BJu
         JTRg==
X-Gm-Message-State: APjAAAVTGvDgc0h8tQguG31VkFCVEUS7Qbhga1LAttyzhGTswaaJI4Db
        +cSeK5L0AxW/zraQj0SUzt0CUg==
X-Google-Smtp-Source: APXvYqz718L4D//TNkiHsd9UJJI/rWp8OgsETUNxs43YHSJTame92Lk+FqeWsvk+iMUqY5sAjjX7wQ==
X-Received: by 2002:a63:4c1c:: with SMTP id z28mr5276599pga.167.1572019994202;
        Fri, 25 Oct 2019 09:13:14 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id h14sm3024927pfo.15.2019.10.25.09.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 09:13:13 -0700 (PDT)
Date:   Fri, 25 Oct 2019 09:13:10 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     dev@dpdk.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [dpdk-dev] Please stop using iopl() in DPDK
Message-ID: <20191025091310.05770edc@hermes.lan>
In-Reply-To: <CALCETrVepdYd4uN8jrG8i6iaixWp+N3MdGv5WhjOdCr9sLRK1w@mail.gmail.com>
References: <CALCETrVepdYd4uN8jrG8i6iaixWp+N3MdGv5WhjOdCr9sLRK1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019 21:45:56 -0700
Andy Lutomirski <luto@kernel.org> wrote:

> Hi all-
> 
> Supporting iopl() in the Linux kernel is becoming a maintainability
> problem.  As far as I know, DPDK is the only major modern user of
> iopl().
> 
> After doing some research, DPDK uses direct io port access for only a
> single purpose: accessing legacy virtio configuration structures.
> These structures are mapped in IO space in BAR 0 on legacy virtio
> devices.

Yes. Legacy virtio seems to have been designed without consideration
of how to use it in userspace. Xen, Vmware and Hyper-V all use memory
as a doorbell mechanism which is easier to use from userspace.


> There are at least three ways you could avoid using iopl().  Here they
> are in rough order of quality in my opinion:
> 
> 1. Change pci_uio_ioport_read() and pci_uio_ioport_write() to use
> read() and write() on resource0 in sysfs.

The cost of entering the kernel for a doorbell mechanism is too
expensive and would kill performance. 


> 2. Use the alternative access mechanism in the virtio legacy spec:
> there is a way to access all of these structures via configuration
> space.

There is no way to use memory doorbell on older versions of virtio.
Users want to run DPDK on old stuff like RHEL6 and even older
kernel forks. There are even use cases where virtio is used for
a non-Linux host; such as GCP.


> 3. Use ioperm() instead of iopl().

Ioperm has the wrong thread semantics. All DPDK applications have
multiple threads and the initialization logic needs to work even
if the thread is started later; threads can also be started by
the user application.

Iopl applies to whole process so this is not an issue.

> 
> 
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

Please fix virtio.
