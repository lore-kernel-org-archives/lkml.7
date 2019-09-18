Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01763C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD767214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 11:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="agcxYxEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbfIRL02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 07:26:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46539 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfIRL01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 07:26:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so4213172pfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 04:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEKDbhzwNhpOBR6dELM5ZLkIekkSqfOIMrHIJk1k/V0=;
        b=agcxYxEbPyxWq2pBrk006+27U5Xoh85acDeVMUH5z9Zi2Yv5CfEnPXpUFAYRMCeKXY
         kb/TnliN0XwWkNMfvn54EUu0OVnJuqlPQpzsfLEnDEwnnpzrgJUe+yUBqUA5i10oYROg
         vD4qAyXqC0EOCpXZfllRkyx6f/LAYJJl4mSF3yM2nBQJNF9dDD0/i+FYSMIWHc7+uAiz
         0tJuoDxwPf5IWZ3sojDRmILrmqVY6mOOpq7JA1UiD31fR9gHccTokozsg3TehMZfQ5nN
         dpzzMTHhZ8nJi5TruO/tQahI04h4PssBJrZuN4bTgGTpb8Vvjn78u3+N337VdsmXmQib
         CWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEKDbhzwNhpOBR6dELM5ZLkIekkSqfOIMrHIJk1k/V0=;
        b=Ks8lvZ6jlDCjZjcJiSRXZSatyRUwoHNsAt1eaYTM4XHRPg+KneorhRMls5XXDA9UWp
         rVJzu9IUiZ2hOaE5oRAmFIjKmKE1fi1HkWdqc5iXmIC87D+Rygp9UUEmV1uXeU8OAa7y
         hrth1lCRVXgKvs1GC6ewEpWlELTyeQhToM0TEJqkFmEaEqpQu9BLJ3AKYO7Uh6F2JrLQ
         MISIhfPCTPJ7hUmb/XtxhWeU0BYRwARQcOTrMQ5rB+5pco/p+LdaT/i8XSQ/pxRbiBDD
         0RMrxj9nDL2E6nmMyyWNzf4s+/x9tGTJAr/Wv1DPSQfXteHrTEaEsmMeLmVm8Y0qP6z3
         nvFg==
X-Gm-Message-State: APjAAAXnmUsz41UWbeBLwhzAd9y0xyyMKZVRwnAkR3+5es6FHYQJD/ED
        pXQeUCT7mIV39nkms3hw/WNvEKObf58kTrY8pQR0ww==
X-Google-Smtp-Source: APXvYqwYAv+hSySRkpTsC5JgvSWSS21M81RsY0zta+P6vdFIbrT8Kb6VbysxQ7uG06t7MGvURGAjaippiHqiexnoL7I=
X-Received: by 2002:a63:c442:: with SMTP id m2mr3520643pgg.286.1568805986413;
 Wed, 18 Sep 2019 04:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cd1def0592ab9697@google.com> <Pine.LNX.4.44L0.1909171423360.1590-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1909171423360.1590-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 18 Sep 2019 13:26:15 +0200
Message-ID: <CAAeHK+xJgJoR9rODcRH74knaRKmEq+DDVarNNwDMT_Vtg+gV2Q@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Write in ga_probe
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+403741a091bf41d4ae79@syzkaller.appspotmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: multipart/mixed; boundary="0000000000008b82dd0592d21ba8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008b82dd0592d21ba8
Content-Type: text/plain; charset="UTF-8"

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
>
> Alan Stern
>
> https://github.com/google/kasan.git f0df5c1b

You've forgotten "syz test" here :)

#syz test: https://github.com/google/kasan.git f0df5c1b

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

--0000000000008b82dd0592d21ba8
Content-Type: text/x-patch; charset="US-ASCII"; name="hid-gaff.patch"
Content-Disposition: attachment; filename="hid-gaff.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k0p6kf7m0>
X-Attachment-Id: f_k0p6kf7m0

SW5kZXg6IHVzYi1kZXZlbC9kcml2ZXJzL2hpZC9oaWQtZ2FmZi5jCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIHVz
Yi1kZXZlbC5vcmlnL2RyaXZlcnMvaGlkL2hpZC1nYWZmLmMKKysrIHVzYi1kZXZlbC9kcml2ZXJz
L2hpZC9oaWQtZ2FmZi5jCkBAIC02NCwxNCArNjQsMjAgQEAgc3RhdGljIGludCBnYWZmX2luaXQo
c3RydWN0IGhpZF9kZXZpY2UgKgogewogCXN0cnVjdCBnYWZmX2RldmljZSAqZ2FmZjsKIAlzdHJ1
Y3QgaGlkX3JlcG9ydCAqcmVwb3J0OwotCXN0cnVjdCBoaWRfaW5wdXQgKmhpZGlucHV0ID0gbGlz
dF9lbnRyeShoaWQtPmlucHV0cy5uZXh0LAotCQkJCQkJc3RydWN0IGhpZF9pbnB1dCwgbGlzdCk7
CisJc3RydWN0IGhpZF9pbnB1dCAqaGlkaW5wdXQ7CiAJc3RydWN0IGxpc3RfaGVhZCAqcmVwb3J0
X2xpc3QgPQogCQkJJmhpZC0+cmVwb3J0X2VudW1bSElEX09VVFBVVF9SRVBPUlRdLnJlcG9ydF9s
aXN0OwogCXN0cnVjdCBsaXN0X2hlYWQgKnJlcG9ydF9wdHIgPSByZXBvcnRfbGlzdDsKLQlzdHJ1
Y3QgaW5wdXRfZGV2ICpkZXYgPSBoaWRpbnB1dC0+aW5wdXQ7CisJc3RydWN0IGlucHV0X2RldiAq
ZGV2OwogCWludCBlcnJvcjsKIAorCWlmIChsaXN0X2VtcHR5KCZoaWQtPmlucHV0cykpIHsKKwkJ
aGlkX2VycihoaWQsICJubyBpbnB1dHMgZm91bmRcbiIpOworCQlyZXR1cm4gLUVOT0RFVjsKKwl9
CisJaGlkaW5wdXQgPSBsaXN0X2VudHJ5KGhpZC0+aW5wdXRzLm5leHQsIHN0cnVjdCBoaWRfaW5w
dXQsIGxpc3QpOworCWRldiA9IGhpZGlucHV0LT5pbnB1dDsKKwogCWlmIChsaXN0X2VtcHR5KHJl
cG9ydF9saXN0KSkgewogCQloaWRfZXJyKGhpZCwgIm5vIG91dHB1dCByZXBvcnRzIGZvdW5kXG4i
KTsKIAkJcmV0dXJuIC1FTk9ERVY7Cg==
--0000000000008b82dd0592d21ba8--
