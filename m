Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0202AC282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C586820821
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 16:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="KyyYJ4rz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfDTQ4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 12:56:22 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37023 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfDTQ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 12:56:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id f53so6645731ede.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 09:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y7jvqePrB1R8RcQSpXk/WHrFOQWIqpXtojXeqSYofx8=;
        b=KyyYJ4rzKUMCy/3XSYeWyMDH+nta39krwYu+3f+Hx1K9QPRRrKYCdKrQ+E0NCvO6rO
         rAi+v2jd7evE0ZQMiGxjRsOZttiw0ZbirQaocZjhRbr6VcXx4o+QwK5orJNSYfZkdGxR
         L7Bwp90laz5z3nWfswVp2FFMmOt1qFzHt0ODD/TO4KA1RuUKzVsKG/mh2NJY60nYualI
         37e4xCHkuTPsnfIRsgNichCrk3TYoTcHyUOgKFgaRG8STOBzQn2a8oJnvgQszP0F8ACl
         LEDkQXxJqBoBHkGKDErHLYsc4WoX3PGi+SbRK3idmSqadptOT1TzpCJU3F1PVRaj2Y8H
         MPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y7jvqePrB1R8RcQSpXk/WHrFOQWIqpXtojXeqSYofx8=;
        b=hlOsolbKOGCJ2B/RK/3DloZJS+Y4/c7rPm2/vD9SDgNrQgDmlpQDy/Ip019wzWkN1Z
         fUdIEDMIoA2vZGS1a3tt4uCj/EmetpTsKZUBji9zjGIMSE0f1UtpnQgSCS1GADAcwmL0
         foq2TPIQVPNOOrIbmp8SFt7RT17FHzIXk7bgJ+m4sUnfiZmRgrlDy4VRLO4kH7t/9kjU
         a+UhreYllwfLtBmizwJ9JLJgfAPCTopEn60s2RCxetGLAH4h6ldL1yvZLdLVA0MCxbAN
         Q9u3T46V0lHdY+EE91uFP73S5Z7fKsqo3TwgYYS9+9XMGTHxaVma6I0b3+/WduhckJs/
         5E+w==
X-Gm-Message-State: APjAAAWa0O2qQ1bf0qyB9cFn78jeOeOIi5jjuMtwHb9WHCuwkAHuc9PM
        Lb+7st2oBiID+1pEsCSHHch5SMz/tnbqDV2/rzkicA==
X-Google-Smtp-Source: APXvYqz+01cR3hHp5UbAXs/R5xp7syVX65tIoYJPYblGitJV0pOtK59VuzQYfKdPXF05WneN21sp+JUQWokjtBb2zB4=
X-Received: by 2002:a17:906:b291:: with SMTP id q17mr5107900ejz.56.1555779380463;
 Sat, 20 Apr 2019 09:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190420153148.21548-1-pasha.tatashin@soleen.com> <CAPcyv4h73gUwntDYx012qcyMYCmzZDU3HOvKcW5DRkO-GoTc+w@mail.gmail.com>
In-Reply-To: <CAPcyv4h73gUwntDYx012qcyMYCmzZDU3HOvKcW5DRkO-GoTc+w@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Sat, 20 Apr 2019 12:56:09 -0400
Message-ID: <CA+CK2bBpyiUKeiT5tPtT9Dt73DmKX9pOFLU2iZy=Xpubt1AhAA@mail.gmail.com>
Subject: Re: [v1 0/2] "Hotremove" persistent memory
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Takashi Iwai <tiwai@suse.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Makes sense, but I have some questions about the details.
>
> >
> > Copy the state, and hotadd the persistent memory so machine still has all
> > 8G for runtime. Before reboot, hotremove device-dax 2G, copy the memory
> > that is needed to be preserved to pmem0 device, and reboot.
> >
> > The series of operations look like this:
> >
> >         1. After boot restore /dev/pmem0 to boot

s/boot/to a ramdisk from which is is picked by apps/

> >         2. Convert raw pmem0 to devdax
> >         ndctl create-namespace --mode devdax --map mem -e namespace0.0 -f
> >         3. Hotadd to System RAM
> >         echo dax0.0 > /sys/bus/dax/drivers/device_dax/unbind
> >         echo dax0.0 > /sys/bus/dax/drivers/kmem/new_id
> >         4. Before reboot hotremove device-dax memory from System RAM
> >         echo dax0.0 > /sys/bus/dax/drivers/kmem/unbind
> >         5. Create raw pmem0 device
> >         ndctl create-namespace --mode raw  -e namespace0.0 -f
> >         6. Copy the state to this device
>
> What is the source of this copy? The state that was in the hot-added
> memory? Isn't it "already there" since you effectively renamed dax0.0
> to pmem0?

Before hotremove, applications create a file in a ramdisk that is 2G
in size. After that applications, exist. We copy this file from
ramdisk to /dev/pmem0  (RAM to RAM copy) to be able to quickly restore
after reboot. After reboot, applications take that file from ramdisk,
and ramdisk is freed.

>
> >         7. Do kexec reboot, or reboot through firmware, is firmware does not
> >         zero memory in pmem region.
s/is/if/
>
> Wouldn't the dax0.0 contents be preserved regardless? How does the
> guest recover the pre-initialized state / how does the kernel know to
> give out the same pages to the application as the previous boot?

On these machines we do not have real persistent memory, only regular
volatile RAM. So, kernel has to either be booted via memap arguments
that specify persistent range, or via special pmem device node in DTB.
