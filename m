Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF81C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A9120851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="crvCEGgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbfFMS1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:27:52 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33665 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbfFMS1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:27:52 -0400
Received: by mail-oi1-f194.google.com with SMTP id q186so101798oia.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 11:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MQQWIXbMnO77ZtHyX2kfFVvlpzWpGkMLz/R1+ir3QOA=;
        b=crvCEGgkqd+iu3jPAVCgc0rO9kwagRqhiuh9lqc2Ju8CbgOGid+cpJ19wpMCBIaSji
         U8Mz0dX1Um88VCqaKkUNTGuID9Bzc63KYSiIdoNpp/7dpBf8k6fFGIdSQ7ELDhxa2lhq
         O+Cm1rdZssbK5qGXuJrRKvIFe20o9RjF63pnvwmTOEXNE3m0kL4mYXXHPHnWB7iNGKvf
         IRmvCqhPr54CoqyHGAWbyFjtaCU9quXmW4KMHVoz5mhnnS/xbbV6lznIglpAz1QTbisQ
         VH8TIrLDYodoKV2w14PaLsUgipHZwL/KVe25acJc00UDmNqVKP+RWr4Mjo9Lxw4wybxj
         3jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MQQWIXbMnO77ZtHyX2kfFVvlpzWpGkMLz/R1+ir3QOA=;
        b=LGQv2toO1pOBJnuJ9tfSUsVECbJaYKHraCDH5T3bZugUzy011lwcQjUelcaleBekk9
         N5oSc+xAH+J9rmQXLOxppW4pIyn9o2F3hofWwcvSgkPycn+e4o00tqtcCls6klMCPkwy
         A5akJqPYRirSfAHiixko/VqKtJ9xyE/ffHf4TNdp3EweRVR6c7Xqf/u1STfSw3YBBMML
         1DlsIWI+DDhIs8LYIzv8VywaxyDUlfAvYcYz52Q910Cc7zQET1Mc9/3Kz8OYjjgGxJ9O
         7XQnpoDSONIgmfuXLl2oAV+yAvmiUNW0VvgmURm1Cp7mFJqTno5lzBO5+5Ke14o4Chc2
         K2SA==
X-Gm-Message-State: APjAAAWlxEMWT0/XFqcT0ryB3u92i+jHWTIv0BZaJZfEgHtiBo3XrFON
        StJAw8ppMijmjSEBe4+Jp1vbhrpoUBtJdiOzfcc4xQ==
X-Google-Smtp-Source: APXvYqwS3UGoJsEHP8JK1xPznND3LFKZmK0TBwbTuAL+csM43V1iR6xbM76Rxv8Te4jLIHldpTP2/DzDl/DDdZFYcCo=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr4031867oii.0.1560450471426;
 Thu, 13 Jun 2019 11:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de>
In-Reply-To: <20190613094326.24093-1-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 Jun 2019 11:27:39 -0700
Message-ID: <CAPcyv4jBdwYaiVwkhy6kP78OBAs+vJme1UTm47dX4Eq_5=JgSg@mail.gmail.com>
Subject: Re: dev_pagemap related cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 2:43 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Dan, J=C3=A9r=C3=B4me and Jason,
>
> below is a series that cleans up the dev_pagemap interface so that
> it is more easily usable, which removes the need to wrap it in hmm
> and thus allowing to kill a lot of code
>
> Diffstat:
>
>  22 files changed, 245 insertions(+), 802 deletions(-)

Hooray!

> Git tree:
>
>     git://git.infradead.org/users/hch/misc.git hmm-devmem-cleanup

I just realized this collides with the dev_pagemap release rework in
Andrew's tree (commit ids below are from next.git and are not stable)

4422ee8476f0 mm/devm_memremap_pages: fix final page put race
771f0714d0dc PCI/P2PDMA: track pgmap references per resource, not globally
af37085de906 lib/genalloc: introduce chunk owners
e0047ff8aa77 PCI/P2PDMA: fix the gen_pool_add_virt() failure path
0315d47d6ae9 mm/devm_memremap_pages: introduce devm_memunmap_pages
216475c7eaa8 drivers/base/devres: introduce devm_release_action()

CONFLICT (content): Merge conflict in tools/testing/nvdimm/test/iomap.c
CONFLICT (content): Merge conflict in mm/hmm.c
CONFLICT (content): Merge conflict in kernel/memremap.c
CONFLICT (content): Merge conflict in include/linux/memremap.h
CONFLICT (content): Merge conflict in drivers/pci/p2pdma.c
CONFLICT (content): Merge conflict in drivers/nvdimm/pmem.c
CONFLICT (content): Merge conflict in drivers/dax/device.c
CONFLICT (content): Merge conflict in drivers/dax/dax-private.h

Perhaps we should pull those out and resend them through hmm.git?

It also turns out the nvdimm unit tests crash with this signature on
that branch where base v5.2-rc3 passes:

    BUG: kernel NULL pointer dereference, address: 0000000000000008
    [..]
    CPU: 15 PID: 1414 Comm: lt-libndctl Tainted: G           OE
5.2.0-rc3+ #3399
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06=
/2015
    RIP: 0010:percpu_ref_kill_and_confirm+0x1e/0x180
    [..]
    Call Trace:
     release_nodes+0x234/0x280
     device_release_driver_internal+0xe8/0x1b0
     bus_remove_device+0xf2/0x160
     device_del+0x166/0x370
     unregister_dev_dax+0x23/0x50
     release_nodes+0x234/0x280
     device_release_driver_internal+0xe8/0x1b0
     unbind_store+0x94/0x120
     kernfs_fop_write+0xf0/0x1a0
     vfs_write+0xb7/0x1b0
     ksys_write+0x5c/0xd0
     do_syscall_64+0x60/0x240

The crash bisects to:

    d8cc8bbe108c device-dax: use the dev_pagemap internal refcount
