Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202B1C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BB9207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442975AbfIYRg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 13:36:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57616 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440165AbfIYRg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 13:36:28 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 17717883D7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 17:36:28 +0000 (UTC)
Received: by mail-io1-f70.google.com with SMTP id a8so899996ios.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 10:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VFdORSkWirTdFE3lpW2I0cVLLFytt/ZPc6xlcyf3Oe8=;
        b=Z9WttoqAlVvJJ/e2HJLr3CjY3YSCCFq/aEKxv4qQW2DN2EpwkiMt5fQzQyvHIfZwNU
         z/XrFckLGsCBMexlnImT5fV3kgzGaqqA/Xly2FlNaVVXN8/DCpV02hgX6u2+0w5qVmWG
         XSJC9kY0C+EseSnh0Aq13IFiVzqgoOJRdCDgT6271s468r6CwrbGGOpH4SVIwtyNVhAq
         nvrmA7WjTv9LJUoYIgGglI6nuXHuL8DFGLcQ8Bt7UwYpO1wLWIs6amZROH5VQE/c299n
         BgAvchtCec8b2Sx/OarGQyY1oANFVC8TIGopC9YHSuOmPPShEnqRkYSFq6DJubMlp7Xl
         dlYg==
X-Gm-Message-State: APjAAAX2wxV6s1bp8vQvXx8XvRmIjFFeQAWzPXprBgamP8mwudCojtXN
        qYtEGyKNx0wQbAq3ub5m+FF2yUaa+CcMPdwsZzU4OzfTaCk3/W1wtBLW2nkhIiUAY5D3mzxQS05
        wDfzo4lvDyipRcBJ2XZqENy9RG1RmKzyGcEZ/nwzH
X-Received: by 2002:a5e:8c01:: with SMTP id n1mr554512ioj.13.1569432987453;
        Wed, 25 Sep 2019 10:36:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxkPS19VrCAqglb+m/aQRHvIdqWMXsUbAZkZudVFYeFArga+gkrST5kZCyMkQWooJQ6T6QcawuuDT7GyDfnIQA=
X-Received: by 2002:a5e:8c01:: with SMTP id n1mr554487ioj.13.1569432987234;
 Wed, 25 Sep 2019 10:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190919160521.13820-1-kasong@redhat.com> <CAKv+Gu95NGPF7m9_K-0MDmti7XN++cfyYWRj6WEXqpYzDM9Btg@mail.gmail.com>
In-Reply-To: <CAKv+Gu95NGPF7m9_K-0MDmti7XN++cfyYWRj6WEXqpYzDM9Btg@mail.gmail.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Thu, 26 Sep 2019 01:36:16 +0800
Message-ID: <CACPcB9c=DzGrqnm1WrEtr85v5f_F41NQ-di5NV-F2ukbbrpTTw@mail.gmail.com>
Subject: Re: [PATCH v2] x86, efi: never relocate kernel below lowest
 acceptable address
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Matthew Garrett <matthewgarrett@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 11:25 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Thu, 19 Sep 2019 at 18:06, Kairui Song <kasong@redhat.com> wrote:
> >
> > Currently, kernel fails to boot on some HyperV VMs when using EFI.
> > And it's a potential issue on all platforms.
> >
> > It's caused a broken kernel relocation on EFI systems, when below three
> > conditions are met:
> >
> > 1. Kernel image is not loaded to the default address (LOAD_PHYSICAL_ADDR)
> >    by the loader.
> > 2. There isn't enough room to contain the kernel, starting from the
> >    default load address (eg. something else occupied part the region).
> > 3. In the memmap provided by EFI firmware, there is a memory region
> >    starts below LOAD_PHYSICAL_ADDR, and suitable for containing the
> >    kernel.
> >
> > Efi stub will perform a kernel relocation when condition 1 is met. But
> > due to condition 2, efi stub can't relocate kernel to the preferred
> > address, so it fallback to query and alloc from EFI firmware for lowest
> > usable memory region.
> >
> > It's incorrect to use the lowest memory address. In later stage, kernel
> > will assume LOAD_PHYSICAL_ADDR as the minimal acceptable relocate address,
> > but efi stub will end up relocating kernel below it.
> >
> > Then before the kernel decompressing. Kernel will do another relocation
> > to address not lower than LOAD_PHYSICAL_ADDR, this time the relocate will
> > over write the blockage at the default load address, which efi stub tried
> > to avoid, and lead to unexpected behavior. Beside, the memory region it
> > writes to is not allocated from EFI firmware, which is also wrong.
> >
> > To fix it, just don't let efi stub relocate the kernel to any address
> > lower than lowest acceptable address.
> >
> > Signed-off-by: Kairui Song <kasong@redhat.com>
> >
>
> Hello Kairui,
>
> This patch looks correct to me, but it needs an ack from the x86
> maintainers, since the rules around LOAD_PHYSICAL_ADDR are specific to
> the x86 architecture.
>
>

Thanks for the review, Ard.

Can any x86 maintainer help provide some review?

-- 
Best Regards,
Kairui Song
