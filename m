Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680B8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEAE2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfCKPFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:05:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44771 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfCKPFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:05:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id d2so5370734qti.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 08:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8JhRdJRNHWZZlJcrBLvx7nz+wU7UBcbNikrqEH9nDOw=;
        b=WZFyACqZLaKRrTnE1CRq2kOZ0EHMsWR90ZSRE7L4FO8SU9HshWfmpqUj766xKGrSgq
         Zyxx2L55zZ0YlGurj2YXrc68c9GsieCxfWRjSX8ZCDitzDQbDO8vOVJL/8fpQ/XFNfNI
         4gTAyZ7l3zqrOf6B1b7e68oHvL7kY7iA59rF34dNFp38sJ/bPBR+pViohXl7Pxlztg9l
         GeytQv1MnJLvBMmSqX8OTvT3u9jnwKKRjf1Z+I/QgvRkyML9LcSxl9n/F2x1iINNEP5r
         ormTXovM9Rl4WGVQ5qGp0ZFiZnLhEEgGznC0XAWlFeN6XBcg5up+wtjn1U4J0ipo0jKG
         7qfQ==
X-Gm-Message-State: APjAAAVXsBgpXtTL2ZanGKWtpejm0NIkeV5kzHKFvOShAdo5mcGXEV9F
        dvppFIr0U1ckJZ/bzZUnlWndk5NsaJS0ubM5HtqudyGO
X-Google-Smtp-Source: APXvYqxM++T3t7Logq5vlOla6hgRaXf/s7vqSCeCrLuEPDUUv2+C9M8A4+t0CLlXEBJrQkC/Pv5pDMFbN+3mNQUyCvI=
X-Received: by 2002:a0c:c781:: with SMTP id k1mr3051925qvj.180.1552316746114;
 Mon, 11 Mar 2019 08:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190308123432.20520-1-saumah@gmail.com>
In-Reply-To: <20190308123432.20520-1-saumah@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Mar 2019 16:05:28 +0100
Message-ID: <CAK8P3a2yKZqB1CtYSSrhHQmRDdE-GpwdHMifgPB5Ledv-UJzWw@mail.gmail.com>
Subject: Re: [PATCH 2/4] Add SUNIX Multi-I/O card device driver
To:     Morris Ku <saumah@gmail.com>
Cc:     gregkh <gregkh@linuxfoundation.org>, morris_ku@sunix.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 1:34 PM Morris Ku <saumah@gmail.com> wrote:
>
> Driver for SUNIX Multi-I/O card.
> Based on driver/char/serial.c by Linus Torvalds, Theodore Ts'o.
>
> SUNIX serial card designed with SUNIX UART controller and
> compatible with 16C950 UART specification.
>
> Signed-off-by: Morris Ku <saumah@gmail.com>

Hi Morris,

Thanks for your submission!

Enrico has already replied with the most important comments. Here
are just some more high-level thoughts from me:

* We want the functionality to be present in subsystem specific
  standalone drivers, i.e. drivers/tty/serial/, drivers/parport/, drivers/gpio
  etc, as Enrico said

* It looks like you may need some glue logic to tie those together for
  the multi-I/O cards. This is a bit tricky but doable. Many other multi-I/O
  cards simply appear as a set of PCI functions that are connected to
  a single slot. This is the ideal case, as you can simply have one
  driver per function and they do not have to be linked together at all.
  If this is not possible, what you may need to do here is to have a
  small driver in drivers/mfd/ that handles the PCI function and creates
  platform_device instances that the individual drivers can bind to.
  Have a look at the various files in drivers/mfd that come with a
  'struct pci_driver' instance to see what I mean.

* In any way, new drivers must probing according to our driver
  module if possible. This means you should have a 'pci_driver'
  structure listing the possible vendor/device ID combinations,
  and register that with 'module_pci_driver'. If you use mfd_cell
  to register sub-drivers, use 'module_platform_driver' to register
  the driver for those.

* do not implement your own ioctl handlers. If you need a custom
  interface for something hardware specific, split that out into
  a separate patch, so the base support can be reviewed
  independently.

* If the functions (in particular serial and parport) have a similar
  register layout to existing drivers, try to reuse the existing code
  and extend it, rather than duplicating the implementation.

       Arnd
