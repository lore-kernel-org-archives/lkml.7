Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D327C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35CA2089E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ilGaCnEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfHUMve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:51:34 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40332 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfHUMve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:51:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so1266785pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 05:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDg2RdtG7Cz+w7k0sv4SLvwMq1+rrsznp++aE2ju7Y4=;
        b=ilGaCnELheniQzM0KRdr8BOfUNf2z9cBxn9s8KDxNEm1bfHwxWBAPKo4Es8v4UoOk2
         shc0STCvm9amVmKCcPnndTpgG16kvQLxP1MrA7W8i9SXd6/wCEZWuL9+NLdXYyxj/LuH
         orgbpy0FlDzwPeBwlMsjMb5nzXKOK7ivcyVVT75bHD8iBY7D6oT8zx8lXR+MA8fKPIjM
         zigrnz/16PdWSRcXR+WtqE6lYVm6ZEUYD34NzKKtepYx1QrC09Dec2h8NGfyilDlB6/R
         Kfn2dhlmCq8rhYORjhTjjsJpBpZJslWYt34ov0eGm0kqrOMcwxyBzBjAEXtxY9fYsoR4
         xUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDg2RdtG7Cz+w7k0sv4SLvwMq1+rrsznp++aE2ju7Y4=;
        b=tcSPFglR888xdaVcTvSCsImYvWmNbZBu0hBEyTxNOwTmIeSk5TO7KrzZ2Q5R95CW0n
         l8uytofW1gGgMDRiAAcrAsHcIr43qJ3zWTCC86R/gKNaI/ZR69vn1hHGOXuhzPBO1VHS
         StAHDHPgCKSgQmVlG7nFp0E6MPfznxqw4XdGeJ4w2axlLPLCFTucu2PLXu2Shl1PN4Wx
         UEOimUXONEI/CJnqLztgIGuf3cc/2eyd+kFdq4C4/Op5ZAA/AdTWzLBJ2AhDlWZ+zFv3
         74g71W8Njt8ep9czMPezhom3ogke+5W/Fjt/DkYj8ZXsWh/RLhurHXJaHR51bAf4Po92
         RdNg==
X-Gm-Message-State: APjAAAX0HftN7BvWGq71uw/xZQGcRFWL59vx+1IYmk4TrTQ2RlYADHE2
        88bpRCIeidYFGh3JzjL9tzb9KzZyBeSRbb4a4Daq/A==
X-Google-Smtp-Source: APXvYqxnEfLShyut1kWSPXdZfm5zIR82ZtHiXYIaVl/djFPAtbt3jJFEbhHCc6x5wWWjm/z1xZH56xspe1yn68cWNOw=
X-Received: by 2002:a17:90a:c20f:: with SMTP id e15mr4939139pjt.123.1566391892418;
 Wed, 21 Aug 2019 05:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d195cc058feb2498@google.com> <Pine.LNX.4.44L0.1908121115390.1659-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1908121115390.1659-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 21 Aug 2019 14:51:20 +0200
Message-ID: <CAAeHK+wkV7zpAHURRzdY_TMRkCv=P5=yfJqLf9tAoYJA35779A@mail.gmail.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+a7a6b9c609b9457c62c6@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: multipart/mixed; boundary="000000000000542c740590a0084a"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000542c740590a0084a
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 13, 2019 at 10:13 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, 12 Aug 2019, syzbot wrote:
>
> > Hello,
> >
> > syzbot has tested the proposed patch but the reproducer still triggered
> > crash:
> > KASAN: invalid-free in hcd_buffer_free
>
> This bug report shows that Hillf's fix isn't exactly right.
>
> > usb 5-1: USB disconnect, device number 2
> > ==================================================================
> > BUG: KASAN: double-free or invalid-free in hcd_buffer_free+0x199/0x260
> > drivers/usb/core/buffer.c:165
> >
> > CPU: 0 PID: 1745 Comm: kworker/0:2 Not tainted 5.3.0-rc2+ #1
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 01/01/2011
> > Workqueue: usb_hub_wq hub_event
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0xca/0x13e lib/dump_stack.c:113
> >   print_address_description+0x6a/0x32c mm/kasan/report.c:351
> >   kasan_report_invalid_free+0x61/0xa0 mm/kasan/report.c:444
> >   __kasan_slab_free+0x162/0x180 mm/kasan/common.c:428
> >   slab_free_hook mm/slub.c:1423 [inline]
> >   slab_free_freelist_hook mm/slub.c:1470 [inline]
> >   slab_free mm/slub.c:3012 [inline]
> >   kfree+0xe4/0x2f0 mm/slub.c:3953
> >   hcd_buffer_free+0x199/0x260 drivers/usb/core/buffer.c:165
> >   usb_free_coherent+0x67/0x80 drivers/usb/core/usb.c:932
> >   hid_free_buffers.isra.0+0x94/0x290 drivers/hid/usbhid/hid-core.c:964
> >   usbhid_stop+0x308/0x450 drivers/hid/usbhid/hid-core.c:1224
> >   logi_dj_remove+0x107/0x210 drivers/hid/hid-logitech-dj.c:1797
>
> Here the double-free occurred when logi_dj_remove() called
> hd_hw_stop()...
>
> >   hid_device_remove+0xed/0x240 drivers/hid/hid-core.c:2242
> >   __device_release_driver drivers/base/dd.c:1118 [inline]
> >   device_release_driver_internal+0x206/0x4c0 drivers/base/dd.c:1151
> >   bus_remove_device+0x2dc/0x4a0 drivers/base/bus.c:556
> >   device_del+0x420/0xb10 drivers/base/core.c:2288
> >   hid_remove_device drivers/hid/hid-core.c:2413 [inline]
> >   hid_destroy_device+0xe1/0x150 drivers/hid/hid-core.c:2432
> >   usbhid_disconnect+0xad/0xd0 drivers/hid/usbhid/hid-core.c:1414
>
> which occurred inside usbhid_disconnect()'s call to
> hid_destroy_device().
>
> But just above the call to hid_destroy_device(), Hillf's patch adds a
> direct call to hid_hw_stop(), which is what did the original free.
>
> So it looks like the problem here is that some paths in the original
> unpatched code end up calling hid_hw_stop() by way of the hid_device's
> driver, and other paths do not.
>
> I haven't had time to track down this difference.  Maybe somebody
> on the mailing list already knows why it occurs.

Trying Alan's fix from another thread here:

#syz test: https://github.com/google/kasan.git 7f7867ff

--000000000000542c740590a0084a
Content-Type: text/x-patch; charset="US-ASCII"; name="logitech.patch"
Content-Disposition: attachment; filename="logitech.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jzl9a2kb0>
X-Attachment-Id: f_jzl9a2kb0

SW5kZXg6IHVzYi1kZXZlbC9kcml2ZXJzL2hpZC9oaWQtbGcuYwo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSB1c2It
ZGV2ZWwub3JpZy9kcml2ZXJzL2hpZC9oaWQtbGcuYworKysgdXNiLWRldmVsL2RyaXZlcnMvaGlk
L2hpZC1sZy5jCkBAIC04MTgsNyArODE4LDcgQEAgc3RhdGljIGludCBsZ19wcm9iZShzdHJ1Y3Qg
aGlkX2RldmljZSAqaAogCiAJCWlmICghYnVmKSB7CiAJCQlyZXQgPSAtRU5PTUVNOwotCQkJZ290
byBlcnJfZnJlZTsKKwkJCWdvdG8gZXJyX3N0b3A7CiAJCX0KIAogCQlyZXQgPSBoaWRfaHdfcmF3
X3JlcXVlc3QoaGRldiwgYnVmWzBdLCBidWYsIHNpemVvZihjYnVmKSwKQEAgLTg1MCw5ICs4NTAs
MTIgQEAgc3RhdGljIGludCBsZ19wcm9iZShzdHJ1Y3QgaGlkX2RldmljZSAqaAogCQlyZXQgPSBs
ZzRmZl9pbml0KGhkZXYpOwogCiAJaWYgKHJldCkKLQkJZ290byBlcnJfZnJlZTsKKwkJZ290byBl
cnJfc3RvcDsKIAogCXJldHVybiAwOworCitlcnJfc3RvcDoKKwloaWRfaHdfc3RvcChoZGV2KTsK
IGVycl9mcmVlOgogCWtmcmVlKGRydl9kYXRhKTsKIAlyZXR1cm4gcmV0OwpAQCAtODYzLDggKzg2
Niw3IEBAIHN0YXRpYyB2b2lkIGxnX3JlbW92ZShzdHJ1Y3QgaGlkX2RldmljZQogCXN0cnVjdCBs
Z19kcnZfZGF0YSAqZHJ2X2RhdGEgPSBoaWRfZ2V0X2RydmRhdGEoaGRldik7CiAJaWYgKGRydl9k
YXRhLT5xdWlya3MgJiBMR19GRjQpCiAJCWxnNGZmX2RlaW5pdChoZGV2KTsKLQllbHNlCi0JCWhp
ZF9od19zdG9wKGhkZXYpOworCWhpZF9od19zdG9wKGhkZXYpOwogCWtmcmVlKGRydl9kYXRhKTsK
IH0KIApJbmRleDogdXNiLWRldmVsL2RyaXZlcnMvaGlkL2hpZC1sZzRmZi5jCj09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0K
LS0tIHVzYi1kZXZlbC5vcmlnL2RyaXZlcnMvaGlkL2hpZC1sZzRmZi5jCisrKyB1c2ItZGV2ZWwv
ZHJpdmVycy9oaWQvaGlkLWxnNGZmLmMKQEAgLTE0NzcsNyArMTQ3Nyw2IEBAIGludCBsZzRmZl9k
ZWluaXQoc3RydWN0IGhpZF9kZXZpY2UgKmhpZCkKIAkJfQogCX0KICNlbmRpZgotCWhpZF9od19z
dG9wKGhpZCk7CiAJZHJ2X2RhdGEtPmRldmljZV9wcm9wcyA9IE5VTEw7CiAKIAlrZnJlZShlbnRy
eSk7Cgo=
--000000000000542c740590a0084a--
