Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D5DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0EDD20644
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 17:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MJJjNVx5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391617AbfISRGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 13:06:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34286 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391432AbfISRGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 13:06:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id b128so2735826pfa.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 10:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vfr/ak8PqAW3a7/adXohYxQN4EYY6B1BFF1JySzS168=;
        b=MJJjNVx5uL2HXYrQioINGIINJXrL+8NHmytYrd5C3UwHDWLgWE03FZMknALR7lCzHd
         cVI4agqMVF5gouZA6bF+foFe75VuKkdq9/n5pWIwJT1aP6NFsI8QdhEMwDvCF7IqdoyD
         f65lX8lTnv1HdiTXGLoPHQVB/Dt42gsdD4+Tuog368YFq3r3NQmZJOMlxaBDKaSqolBu
         6UCN7IUxVCUcaxDr0IbU5L511/jB9zuv1IUt0jf1K+/0EfjXmG1wrM07Hdr9X0Mni97h
         Rf1WpExTtW89vWzvCGrdPiHc8R+9DunVEifQMKWNqY//gf9w1fsUfuUmLmFKmaPXuVsY
         N3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vfr/ak8PqAW3a7/adXohYxQN4EYY6B1BFF1JySzS168=;
        b=pni0kCQrh7qHijbK/K8raxYA5AwPcMCXV847NEZrkb/2bxG2dvkPxjpf9Cd5FtOuT7
         EkGhXkac26xjVx1bnYwu1wEr9Mqnd0kkt/j5pK66WQtXgQZDMHcnQttzqMUKIOryqd92
         QVJROsoYluz2Wv+BkuuYvyhV7Cnx0IqM+JyefjCNfpTxEHlwYawTis3tH4zaM5LzXYZ1
         39UpIW0c4PTlSQjouH4kKuNdiFb6wFi5EyrbyAHV8Zln6M+TOBP1ZsnmNa3H/Z/nC4Ld
         1m1e0EUdq97cq3S3R6OASMlG0fWJ+QcwQfoN2igeZlm2Q2oscQWPKmVVK0CD6r+Sdyzr
         qZDA==
X-Gm-Message-State: APjAAAVI0FZI3xCBNY0tEfy/sfhdshEvkm9ZbeVKUdmajT0QamWWKHN8
        Fe+fU7YZY36fN6qvb+Z0ts+EDIGnOl80vhIWRVKv6g==
X-Google-Smtp-Source: APXvYqwF+yEDDmq8bzyXKUa8CBKAnT1PB+m3Gugv1nZP8AoxwOhoLKvil38EsnOPFTFQHI/1545FCjvI+5Emi0e+4U0=
X-Received: by 2002:a63:d20f:: with SMTP id a15mr5142567pgg.130.1568912770407;
 Thu, 19 Sep 2019 10:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cd1def0592ab9697@google.com> <Pine.LNX.4.44L0.1909171423360.1590-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1909171423360.1590-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 19 Sep 2019 19:05:59 +0200
Message-ID: <CAAeHK+wh0bQKRXU_7fOC5XZKUUL1QW8DskCBJKQACwqZd=tZyw@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Write in ga_probe
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+403741a091bf41d4ae79@syzkaller.appspotmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 8:24 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, 16 Sep 2019, syzbot wrote:
>
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14045831600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
> > dashboard link: https://syzkaller.appspot.com/bug?extid=403741a091bf41d4ae79
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c1e62d600000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166a3a95600000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+403741a091bf41d4ae79@syzkaller.appspotmail.com
> >
> > usb 1-1: config 0 interface 0 altsetting 0 has 1 endpoint descriptor,
> > different from the interface descriptor's value: 9
> > usb 1-1: New USB device found, idVendor=0e8f, idProduct=0012, bcdDevice=
> > 0.00
> > usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> > usb 1-1: config 0 descriptor??
> > greenasia 0003:0E8F:0012.0001: unknown main item tag 0x0
> > greenasia 0003:0E8F:0012.0001: hidraw0: USB HID v0.00 Device [HID
> > 0e8f:0012] on usb-dummy_hcd.0-1/input0
> > ==================================================================
> > BUG: KASAN: slab-out-of-bounds in set_bit
> > include/asm-generic/bitops-instrumented.h:28 [inline]
> > BUG: KASAN: slab-out-of-bounds in gaff_init drivers/hid/hid-gaff.c:97
> > [inline]
> > BUG: KASAN: slab-out-of-bounds in ga_probe+0x1fd/0x6f0
> > drivers/hid/hid-gaff.c:146
> > Write of size 8 at addr ffff8881d9acafc0 by task kworker/1:1/78
> >
> > CPU: 1 PID: 78 Comm: kworker/1:1 Not tainted 5.3.0-rc7+ #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Workqueue: usb_hub_wq hub_event
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0xca/0x13e lib/dump_stack.c:113
> >   print_address_description+0x6a/0x32c mm/kasan/report.c:351
> >   __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
> >   kasan_report+0xe/0x12 mm/kasan/common.c:618
> >   check_memory_region_inline mm/kasan/generic.c:185 [inline]
> >   check_memory_region+0x128/0x190 mm/kasan/generic.c:192
> >   set_bit include/asm-generic/bitops-instrumented.h:28 [inline]
> >   gaff_init drivers/hid/hid-gaff.c:97 [inline]
> >   ga_probe+0x1fd/0x6f0 drivers/hid/hid-gaff.c:146
> >   hid_device_probe+0x2be/0x3f0 drivers/hid/hid-core.c:2209
> >   really_probe+0x281/0x6d0 drivers/base/dd.c:548
> >   driver_probe_device+0x101/0x1b0 drivers/base/dd.c:721
> >   __device_attach_driver+0x
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > syzbot can test patches for this bug, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
>
> The driver assumes that the device contains an input.

BTW, these two reports look fairly similar:

https://syzkaller.appspot.com/bug?extid=94e2b9e9c7d1dd332345
https://syzkaller.appspot.com/bug?extid=1e86e2ccce227cca899b

>
> Alan Stern
>
> https://github.com/google/kasan.git f0df5c1b
>
>  drivers/hid/hid-gaff.c |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> Index: usb-devel/drivers/hid/hid-gaff.c
> ===================================================================
> --- usb-devel.orig/drivers/hid/hid-gaff.c
> +++ usb-devel/drivers/hid/hid-gaff.c
> @@ -64,14 +64,20 @@ static int gaff_init(struct hid_device *
>  {
>         struct gaff_device *gaff;
>         struct hid_report *report;
> -       struct hid_input *hidinput = list_entry(hid->inputs.next,
> -                                               struct hid_input, list);
> +       struct hid_input *hidinput;
>         struct list_head *report_list =
>                         &hid->report_enum[HID_OUTPUT_REPORT].report_list;
>         struct list_head *report_ptr = report_list;
> -       struct input_dev *dev = hidinput->input;
> +       struct input_dev *dev;
>         int error;
>
> +       if (list_empty(&hid->inputs)) {
> +               hid_err(hid, "no inputs found\n");
> +               return -ENODEV;
> +       }
> +       hidinput = list_entry(hid->inputs.next, struct hid_input, list);
> +       dev = hidinput->input;
> +
>         if (list_empty(report_list)) {
>                 hid_err(hid, "no output reports found\n");
>                 return -ENODEV;
>
