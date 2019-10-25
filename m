Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF3ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 04:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FD321D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 04:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571978771;
	bh=wiorhjSe1Jgcumgj5fluZs16cVEe1hZJXsHjFLCRfNw=;
	h=From:Date:Subject:To:List-ID:From;
	b=ep1tSqCF+6FJ881qZ4zWsy38qtyRjYz6v5g/3AOBV8BfCfoTQH+hCDB6yYKFh8+jT
	 fX9kB31PYPtwC2Iv5QcANd4vXxZqtWFDWbKYk2URih5m3u+YIoUiZWgAL7iFf990Sf
	 gL3iy8KXAW6GzWmjg+w0C6q1DAmSaiRiH4bHxVmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390024AbfJYEqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 00:46:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387990AbfJYEqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 00:46:10 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C9E121D71
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 04:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571978769;
        bh=wiorhjSe1Jgcumgj5fluZs16cVEe1hZJXsHjFLCRfNw=;
        h=From:Date:Subject:To:From;
        b=oEnXcmg1azk8QDn15o3bAkiEncszDSU5RsmnFzLqFni3RkGh2DwCR2RLRRq3CBBWC
         8PODXZeZvxdBdOdL/Hzc0UYPX9h1i7q5lKT0Wx/hUXkswqkiFmnfxnAyrqGkZaN8S0
         Kr5oPdgpCBStOwCCb5jrWGFtXAaAv1PRbhbj1a9s=
Received: by mail-wr1-f50.google.com with SMTP id o28so692297wro.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 21:46:09 -0700 (PDT)
X-Gm-Message-State: APjAAAX+PE8v7BR/+0AHY1ojTHYYkozoLGBRx/Mqww0CsMmSpbZZXFNO
        MwWPynhWWyNR/B2ABi7Bu40cpUxEDmW3C8PlSlsc4g==
X-Google-Smtp-Source: APXvYqyNOFp3Ms+uinOmOvqe7XDGXR8wMZpz/A8vGbtQnxZA8XQ8zPGalHKbQrZUar9wc/bhTGaD7FmpMXccmbOUWG8=
X-Received: by 2002:a5d:51c2:: with SMTP id n2mr865701wrv.149.1571978767560;
 Thu, 24 Oct 2019 21:46:07 -0700 (PDT)
MIME-Version: 1.0
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 24 Oct 2019 21:45:56 -0700
X-Gmail-Original-Message-ID: <CALCETrVepdYd4uN8jrG8i6iaixWp+N3MdGv5WhjOdCr9sLRK1w@mail.gmail.com>
Message-ID: <CALCETrVepdYd4uN8jrG8i6iaixWp+N3MdGv5WhjOdCr9sLRK1w@mail.gmail.com>
Subject: Please stop using iopl() in DPDK
To:     dev@dpdk.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all-

Supporting iopl() in the Linux kernel is becoming a maintainability
problem.  As far as I know, DPDK is the only major modern user of
iopl().

After doing some research, DPDK uses direct io port access for only a
single purpose: accessing legacy virtio configuration structures.
These structures are mapped in IO space in BAR 0 on legacy virtio
devices.

There are at least three ways you could avoid using iopl().  Here they
are in rough order of quality in my opinion:

1. Change pci_uio_ioport_read() and pci_uio_ioport_write() to use
read() and write() on resource0 in sysfs.

2. Use the alternative access mechanism in the virtio legacy spec:
there is a way to access all of these structures via configuration
space.

3. Use ioperm() instead of iopl().


We are considering changes to the kernel that will potentially harm
the performance of any program that uses iopl(3) -- in particular,
context switches will become more expensive, and the scheduler might
need to explicitly penalize such programs to ensure fairness.  Using
ioperm() already hurts performance, and the proposed changes to iopl()
will make it even worse.  Alternatively, the kernel could drop iopl()
support entirely.  I will certainly make a change to allow
distributions to remove iopl() support entirely from their kernels,
and I expect that distributions will do this.

Please fix DPDK.

Thanks,
Andy
