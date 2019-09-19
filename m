Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E16C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 18:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388E321A4C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 18:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lOeg7N6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392045AbfISS3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 14:29:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39569 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392032AbfISS3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 14:29:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id i1so2852213pfa.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 11:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+egVsXTih8AcjpoFq8MrlR1R2OAn0r56wvvLUrVKT0=;
        b=lOeg7N6P6ratCco6cR2CzzUcEKxK7mbScFHDl0Wih4XkzRVA0DZCoOMNako11XW2Vd
         MxzWPyTkZ8Bi+/qkgoT0zULYBaDw2RH4BFLTGx4WqgjwROcUgj4OYk0jC+dEi0NThQlt
         sc8Mupj/1NU1kzHi44qDOc6ci1NFMZjTsChCeNYFIsjJ6trKnxmXsn3ToCiNs4bvkKQL
         uL+6/t8MWuUkknY7id7H6b4FN/ke1HthC1qwqsEIZ7MxZg+PbzgOtAoTXg8ceoQDNWbJ
         SosKfV3NcKbZxZlgSWNVd6qgUeXoAJHANe0+MmPQw6oWij2B9qreAWV+tuLAZewjv2dv
         02hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+egVsXTih8AcjpoFq8MrlR1R2OAn0r56wvvLUrVKT0=;
        b=BrxtePSoHwvAO+Rh0iiUKdEt9lZRWus0A4VkTjysOK9kkHoB+HyiOo2HW5yPOOin2N
         SBNjnXy2NqVjAB5Wq7BqvV5cvFNfoeA6vjBDzQfkQk2a2QDeNxlpiZCqHH+y16JWV69v
         NhrEdscw+A6I1r0Q2Ib00nsNq1EZ7CzcRdjNXavqONnoHGWs4U3ftAnInVgO51V3zEt0
         J8TRiTBeqDyloOEYGrJhxi0j2MdGxNaFGh9JClG2e+PP4RL0qV8H8/m72H6VNEiptjXq
         hbtxa1uYu8P+6nNGoPckK6zTRKaD556kMcPdE1ahlJKqmazCqBd4Mw3Cgh1jxxsU3XTR
         IGAg==
X-Gm-Message-State: APjAAAVzbEaMHx6Phh1i7PLV9a+JH/QrbhtXSNxW+Bdk2Tx/ZO9yImUw
        QevuouU6HRc17iVEwynMemONVolWVQc9xtupJahFYQ==
X-Google-Smtp-Source: APXvYqyw4DqS43DzKxjdvNSfsZpaFyQ29Bu0vG1o/hF4aRsRWpqEPFPS2O+6I98nB1YSgOflOq6EqdsPjem6w/kpufY=
X-Received: by 2002:a62:1cd2:: with SMTP id c201mr12126076pfc.51.1568917773162;
 Thu, 19 Sep 2019 11:29:33 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000025ae690592b00fbd@google.com> <alpine.DEB.2.21.1909161258150.118156@chino.kir.corp.google.com>
 <20190916205756.GR29434@bombadil.infradead.org>
In-Reply-To: <20190916205756.GR29434@bombadil.infradead.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 19 Sep 2019 20:29:22 +0200
Message-ID: <CAAeHK+zV6M8MOWUt8BUgmTO1Dr6+KMKR8yR65_O2HBVrwkg1MQ@mail.gmail.com>
Subject: Re: WARNING in __alloc_pages_nodemask
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Rientjes <rientjes@google.com>,
        syzbot <syzbot+e38fe539fedfc127987e@syzkaller.appspotmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        USB list <linux-usb@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vlastimil Babka <vbabka@suse.cz>, yang.shi@linux.alibaba.com,
        zhongjiang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 10:58 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Sep 16, 2019 at 01:00:11PM -0700, David Rientjes wrote:
> > On Mon, 16 Sep 2019, syzbot wrote:
> > > HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
> > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=14b15371600000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=e38fe539fedfc127987e
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1093bed1600000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1603cfc6600000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+e38fe539fedfc127987e@syzkaller.appspotmail.com
> > >
> > > WARNING: CPU: 0 PID: 1720 at mm/page_alloc.c:4696
> > > __alloc_pages_nodemask+0x36f/0x780 mm/page_alloc.c:4696
> > > Kernel panic - not syncing: panic_on_warn set ...
>
> > > alloc_pages_current+0xff/0x200 mm/mempolicy.c:2153
> > > alloc_pages include/linux/gfp.h:509 [inline]
> > > kmalloc_order+0x1a/0x60 mm/slab_common.c:1257
> > > kmalloc_order_trace+0x18/0x110 mm/slab_common.c:1269
> > > __usbhid_submit_report drivers/hid/usbhid/hid-core.c:588 [inline]
> > > usbhid_submit_report+0x5b5/0xde0 drivers/hid/usbhid/hid-core.c:638
> > > usbhid_request+0x3c/0x70 drivers/hid/usbhid/hid-core.c:1252
> > > hid_hw_request include/linux/hid.h:1053 [inline]
> > > hiddev_ioctl+0x526/0x1550 drivers/hid/usbhid/hiddev.c:735
> > Adding Jiri and Benjamin.  The hid report length is simply too large for
> > the page allocator to allocate: this is triggering because the resulting
> > allocation order is > MAX_ORDER-1.  Any way to make this allocate less
> > physically contiguous memory?
>
> The HID code should, presumably, reject reports which are larger than
> PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER.  Particularly since it's using
> GFP_ATOMIC.

This is an int underflow when doing report buffer size calculation, see here:

https://groups.google.com/d/msg/syzkaller-bugs/X0zVbh8aFEM/NsPcshjxBgAJ

#syz dup: KMSAN: kernel-usb-infoleak in hid_submit_ctrl

https://syzkaller.appspot.com/bug?extid=401d71a99cfca9fceb77
