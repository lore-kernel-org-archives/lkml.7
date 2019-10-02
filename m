Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E90C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B6721A4C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 22:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JgvO7Xtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfJBW14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 18:27:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35503 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfJBW14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 18:27:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id y21so493489wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 15:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WVuyM2HI99wS0wrEjVTuybtyAoge/UdhgX0Riu1yBrw=;
        b=JgvO7XtwX8H4Z+QL5zkjv5W3cuYCeQaxxkpdk1bbkCf2LfkQavQHb5IuxUAV1/Q2Wr
         B5alBqCxh4pcNxn/B5njq2rMSzmtHXR8NbTXEtqkFvPR2iIgWgqCI/205qFN6pKpTW5X
         EgodLXLs3wJY1ViIUMLRBILoVqAv42zDI6sxpZkqr/lnh/+MrloQSy1c3sRcNX8RsT99
         JcEpYTYslnCN6MtOhpfPTspDva41JJqGHqlxAtLHCMvrmPEdlyX7gWlz59vuBcV6UBov
         y8AsdkbjfirxsdH2i8BLOoJlvm903gpDuhtSRhwGSXJ9EJ7Vy9MZB6Zg2AAxY4B5pEOz
         NNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WVuyM2HI99wS0wrEjVTuybtyAoge/UdhgX0Riu1yBrw=;
        b=Iz0/I2J4N8PfY4rPDT2YlGYPosbk9ZpZ57yZbpbr744RE9JfVbwFmkMzIlbi27JEnd
         b0VxXKZS8LcDSmloQum5eZNsri4WBz25Ml8+KNmcf9peEgc+mUO6AJiDqcqITarxIemo
         VLaT04wE2RYtV+N5XN+KHgEYfQmL46h4/4q1k+FMOvgMzT8BNdoLAyiY8hfQ9JwyHLyl
         kuhKk/j2GYGWJ3OTd557CCeFtaY3YjtEAmkQrG14OWPAax8MJx4KOEhYCBY5Xo029QnP
         8v58ofFMCcTv7m8cT4EAygZTQNYvQzSL7WfJvxZoQgrtU1UJiGv00jZ6jgh1Wsxz6HM1
         UCyQ==
X-Gm-Message-State: APjAAAVX7ZgePEGON1qF5xYKwzxJrKBxCbWisnhqujxbw/RC29X9LMac
        aGcnbu6+sA+oABDnQZ0yVR+op40mTdviNor+/Flcvg==
X-Google-Smtp-Source: APXvYqz/9fvt/NJ1VDIHFIXKAcThmwE0MvQ+M3a7SKRoqkqjvrIyn571bbWQVFHXE+01yobIs7fyFhY5VgysNS/Y4vY=
X-Received: by 2002:a7b:cd99:: with SMTP id y25mr4528872wmj.152.1570055273633;
 Wed, 02 Oct 2019 15:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191002182255.21808-3-john.stultz@linaro.org> <201910030658.lcYVTiTL%lkp@intel.com>
In-Reply-To: <201910030658.lcYVTiTL%lkp@intel.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 2 Oct 2019 15:27:41 -0700
Message-ID: <CALAqxLX7JgUvixQQMn=6thfhOg_Bw1fN02KQPkO9144yRwPwMw@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] dma-buf: heaps: Add heap helpers
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 3:10 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi John,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [cannot apply to v5.4-rc1 next-20191002]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/John-Stultz/DMA-BUF-Heaps-destaging-ION/20191003-042849
> config: mips-allmodconfig (attached as .config)
> compiler: mips-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=mips
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/dma-buf/heaps/heap-helpers.c: In function 'dma_heap_map_kernel':
> >> drivers/dma-buf/heaps/heap-helpers.c:43:10: error: implicit declaration of function 'vmap'; did you mean 'bmap'? [-Werror=implicit-function-declaration]
>      vaddr = vmap(buffer->pages, buffer->pagecount, VM_MAP, PAGE_KERNEL);
>              ^~~~
>              bmap
> >> drivers/dma-buf/heaps/heap-helpers.c:43:49: error: 'VM_MAP' undeclared (first use in this function); did you mean 'VM_MPX'?
>      vaddr = vmap(buffer->pages, buffer->pagecount, VM_MAP, PAGE_KERNEL);
>                                                     ^~~~~~
>                                                     VM_MPX


Ah, looks like I'm missing:
+#include <linux/vmalloc.h>

Which somehow gets pulled in through the headers on other arches.

I'll fix that up. Thanks so much!
-john
