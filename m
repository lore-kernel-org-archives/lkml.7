Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F827CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AA8222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571409676;
	bh=2mbmhzgegCQlyYXrF5P5gLydyrxlewiD8+y0Ccn/JzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J/4OX2AATncbXUz93Vdc0FRlZVo/Ih8yNjoTLSaRF1FnIq3FbQcwIws86j05eTa5X
	 fxJ1B4CW0dPN73UfVp0RkH3FOd90VkVkZbS9P3Ukb1rTCI21PmP1JFaUq1mMbN0h5A
	 /XHs8nRaMoTlK7vmD4jyYMfPOo5eq4hWWOQxi2s8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634198AbfJROlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:41:14 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40633 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393897AbfJROlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:41:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id 7so6484992ljw.7;
        Fri, 18 Oct 2019 07:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ysRS4s8CxY/X140fibWCkqyMnE6CoZKaKn2AR9b3AvM=;
        b=q+yGq87oO6W0uq/4nYX3ExYbn+5Qm051RN0ZcUspbNZZBDKj7X6aMg0tsr8WUyAor4
         WQVrud/2IuD0q0Xw/SWHTNKEtEaS0ICACbsqoa/Fd5ElsL0hwYNqSqVt5PJ5WBaR2+7T
         po05GfLFodwytAaVsK4hFAjv0SVQBa3BLGT3a2oN/ohtBf4XPr4fCYD3yOwQ/ktwuaQ6
         oOeTqwSGLYJjDSd6OfHb4dhSPG0usDtKuNZX/7KhbfQOYqFiGP7K7E/4lAUsxJHnXIcu
         9pA8O3Ha12oFvEhJoIfcYCbq6vEHsruHagUOAL2XDGWw/pwEdMs7XaHmvFl1FoJzlT+I
         QKGg==
X-Gm-Message-State: APjAAAXQPQsRPfP6MliIhQC5Y4OqquPFGcQQ0KeuLISf9ST+xOoNMSkE
        0kLw84ykCHd7uVgleSPfluE=
X-Google-Smtp-Source: APXvYqxPNnGLE3QDYPozwfB7fnL0DuUsf074dWCOMMuY5c7yaTj4cr1EQAmQ3SHJnOee2VwHSkZWcQ==
X-Received: by 2002:a2e:8593:: with SMTP id b19mr6473865lji.34.1571409671391;
        Fri, 18 Oct 2019 07:41:11 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id o13sm2488267lji.31.2019.10.18.07.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 07:41:10 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iLTRS-0006RH-Nq; Fri, 18 Oct 2019 16:41:22 +0200
Date:   Fri, 18 Oct 2019 16:41:22 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     syzbot <syzbot+ba00d6a2a24df57a94ca@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: slab-out-of-bounds Read in ld_usb_read
Message-ID: <20191018144122.GH21827@localhost>
References: <0000000000003c013f058fea8493@google.com>
 <CAAeHK+xr9DoBHvF9B8+hN=4iEa-oVDogDtCcb04cxp+Mj3g-dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+xr9DoBHvF9B8+hN=4iEa-oVDogDtCcb04cxp+Mj3g-dg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 02:22:52PM +0200, Andrey Konovalov wrote:
> On Mon, Aug 12, 2019 at 2:18 PM syzbot
> <syzbot+ba00d6a2a24df57a94ca@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=162aac02600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ba00d6a2a24df57a94ca
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1123edc2600000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16079d2c600000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+ba00d6a2a24df57a94ca@syzkaller.appspotmail.com
> >
> > ldusb 1-1:0.28: Read buffer overflow, -131386046930688 bytes dropped
> > ==================================================================
> > BUG: KASAN: slab-out-of-bounds in _copy_to_user+0x124/0x150
> > lib/usercopy.c:27
> > Read of size 2147479552 at addr ffff8881cd580008 by task
> > syz-executor268/1890
> >
> > CPU: 0 PID: 1890 Comm: syz-executor268 Not tainted 5.3.0-rc2+ #25
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0xca/0x13e lib/dump_stack.c:113
> >   print_address_description+0x6a/0x32c mm/kasan/report.c:351
> >   __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
> >   kasan_report+0xe/0x12 mm/kasan/common.c:612
> >   check_memory_region_inline mm/kasan/generic.c:185 [inline]
> >   check_memory_region+0x128/0x190 mm/kasan/generic.c:192
> >   _copy_to_user+0x124/0x150 lib/usercopy.c:27
> >   copy_to_user include/linux/uaccess.h:152 [inline]
> >   ld_usb_read+0x31a/0x780 drivers/usb/misc/ldusb.c:495
> 
> #syz dup: KASAN: use-after-free Read in ld_usb_release

#syz dup: KASAN: slab-out-of-bounds Read in ld_usb_read (3)
