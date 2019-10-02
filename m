Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24644C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0731D218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 18:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbfJBSXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 14:23:16 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:47061 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbfJBSXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 14:23:12 -0400
Received: by mail-qt1-f194.google.com with SMTP id u22so27589917qtq.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 11:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mqmK4L98wN3cBmKGQwNpWC2fuKTRzV+ZdHOEG5KEhk0=;
        b=SttYAm5yUt4jvtf6tBY9+5GMOWxYb0vS3NXtr0mDsPlMJozOlqSR2o7zbiPvtAjLit
         17b3mF7YTot6/3R+KdOvXaF328v7Etpei1UJCE3jaxvjgJyk+lUmr4stoa5FQwbRZbyQ
         brfC6RIV8EIISbS9Flrd/tgvDbP4hnskTpPs4oUSRUFsNrIpYEXAj58eNdwszCehowgx
         YIKCH8++KcauvUysB8UTUlKvbtHR0toOh9c3HAHp43lIJwYztWMo4VaT4hkaxD1UAasy
         51pMsFnBncqsF2Igk4D3TxK2kkQIFRn7hOuFbw29Oz6xwBtiOAHPZQDAhik07qynln/a
         miHA==
X-Gm-Message-State: APjAAAVbwh8p6w9/+MTXy8kctR+ztcG+/JOc8qHuL0t7kvCPyltSJwrS
        aSPXv28A7bYosIc16dwP4CErdjl6ZjgK+cn6ayo=
X-Google-Smtp-Source: APXvYqwtf0T7R4X5gVmUCqaweE/Ksy294eakOxlv11RGepED8dxALjvWlAS7VUykd1YO5Bk9lQdlM1Dt6VJ/hQyC1rE=
X-Received: by 2002:ac8:1a2e:: with SMTP id v43mr5533802qtj.204.1570040590888;
 Wed, 02 Oct 2019 11:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <1569945867-82243-1-git-send-email-john.garry@huawei.com>
 <1569945867-82243-4-git-send-email-john.garry@huawei.com> <CAK8P3a1rAKF2k0iuPirF+_La_VEmEbQ+D0XAfdcy=6K-Q1fu9g@mail.gmail.com>
 <4f96d830-a38d-5ecd-4f46-faf0306251f1@huawei.com>
In-Reply-To: <4f96d830-a38d-5ecd-4f46-faf0306251f1@huawei.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 2 Oct 2019 20:22:54 +0200
Message-ID: <CAK8P3a2LZnDfT_yNaDo4CgheC-1dZvK3DMrC8RY6qt4F6rEGvg@mail.gmail.com>
Subject: Re: [PATCH 3/3] bus: hisi_lpc: Expand build test coverage
To:     John Garry <john.garry@huawei.com>
Cc:     Wei Xu <xuwei5@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 6:25 PM John Garry <john.garry@huawei.com> wrote:
> On 02/10/2019 16:43, Arnd Bergmann wrote:
> > On Tue, Oct 1, 2019 at 6:07 PM John Garry <john.garry@huawei.com> wrote:
> >>
> >> Currently the driver will only ever be built for ARM64 because it selects
> >> CONFIG_INDIRECT_PIO, which itself depends on ARM64.
> >>
> >> Expand build test coverage for the driver to other architectures by only
> >> selecting CONFIG_INDIRECT_PIO for ARM64, when we really want it.
> >>
> >> Signed-off-by: John Garry <john.garry@huawei.com>
> >
>
> Hi Arnd,
>
> > Good idea, but doesn't this cause a link failure against
> > logic_pio_register_range() when INDIRECT_PIO is disabled?
>
> No, it shouldn't do. Function
> lib/logic_pio.c::logic_pio_register_range() is built always, outside any
> INDIRECT_PIO checking.

Ok, I see.

> A some stage, for completeness we should probably change
> logic_pio_register_range() and friends to be under PCI_IOBASE. But then
> we would need stubs for !PCI_IOBASE, due to this above change and also
> references from the device tree code. I'd have to consider this a bit
> more. Let me know what you think.

It's probably not to do this with the usual 'static inline' stubs in the
header files. There is no rush here, but it would be nice to not build
this code when it is not needed.

I wonder if this one-line change would take care of the !CONFIG_OF
case already (it probably doesn't):

--- a/lib/Makefile
+++ b/lib/Makefile
@@ -107,7 +107,7 @@ obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
 obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
 obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o

-obj-y += logic_pio.o
+lib-y += logic_pio.o

 obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o

On a related note: At some point we may want to add an indirect
method for readl()/writel(), to deal with some of the weirder 32-bit
ARM platforms. We'll have to see how well this can fit into the
infrastructure we already have for indirect PIO.

     Arnd
