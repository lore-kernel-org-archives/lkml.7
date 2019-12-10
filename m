Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E365CC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF32620836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfLJTsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:48:05 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:38131 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfLJTsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:48:02 -0500
Received: by mail-io1-f72.google.com with SMTP id l25so5417747ioh.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 11:48:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=EpJ1D8lGNCCnF6AyqKcMgQqopgAaZAfpppfEN6g4mew=;
        b=mQF/6pbujqRM8uctzov1m6WT1FDIQTUu+c/GT7dJ5EydaZIEtsdgYFWBhb9K6e4ALO
         CkChgZae/pxfyUGPeeVcu2+4dB7dVFtMKH/UTV0Zhxrb9xwAfiBYZ/N0Tcoz1s6+IsX3
         HXFl12VjoiqCFLni5tHDLjbNsqr8M8yUKsumEkDF/7TsnrY8S+RWu1nHpX0w0V3Oarcm
         mGf0cUcltz4ePEC3ne+H7XPUbz69IzwoWBVvNeKjBVGwfLRp96gWTLIeL9c17Du58y/h
         DrPfTamuweefr0dTQRIQ0Aab80Uh9t1sVUo0n7DlL5yzfsKjRK9faqlPeoiTCvXav077
         pV0g==
X-Gm-Message-State: APjAAAUdvtbnfKVhVbuRJ5ddoU++SvvSwtR/7BClnTSQ3j8ZL8Cz/4P+
        m7Ia7PoVg/Wu+yJgOJehi5oajroaEw7s6oLx5sJLFxoqK2D6
X-Google-Smtp-Source: APXvYqxKD48ONsQ6nd5juqNdffFaYjK5nU3Y6JRWaFArNPVl+DXJ+YsIUSBXX56eZo+5lxcnBCxl8zBrHunWIDie2WOBj/1rR/k5
MIME-Version: 1.0
X-Received: by 2002:a02:cd3b:: with SMTP id h27mr16048577jaq.18.1576007281775;
 Tue, 10 Dec 2019 11:48:01 -0800 (PST)
Date:   Tue, 10 Dec 2019 11:48:01 -0800
In-Reply-To: <Pine.LNX.4.44L0.1912101440100.1647-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031a0af05995eca0b@google.com>
Subject: Re: Re: KASAN: use-after-free Read in usbvision_v4l2_open
From:   syzbot <syzbot+c7b0ec009a216143df30@syzkaller.appspotmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     andreyknvl@google.com, hverkuil@xs4all.nl, jrdr.linux@gmail.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org, rfontana@redhat.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 9 Dec 2019, syzbot wrote:

>> Hello,

>> syzbot found the following crash on:

>> HEAD commit:    1f22d15c usb: gadget: add raw-gadget interface
>> git tree:       https://github.com/google/kasan.git usb-fuzzer
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1296f42ae00000
>> kernel config:   
>> https://syzkaller.appspot.com/x/.config?x=8ccee2968018adcb
>> dashboard link:  
>> https://syzkaller.appspot.com/bug?extid=c7b0ec009a216143df30
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

>> Unfortunately, I don't have any reproducer for this crash yet.

>> IMPORTANT: if you fix the bug, please add the following tag to the  
>> commit:
>> Reported-by: syzbot+c7b0ec009a216143df30@syzkaller.appspotmail.com

>> ==================================================================
>> BUG: KASAN: use-after-free in __mutex_lock_common
>> kernel/locking/mutex.c:1043 [inline]
>> BUG: KASAN: use-after-free in __mutex_lock+0x124d/0x1360
>> kernel/locking/mutex.c:1106
>> Read of size 8 at addr ffff8881cad4d8b8 by task v4l_id/4526

>> CPU: 0 PID: 4526 Comm: v4l_id Not tainted 5.4.0-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 01/01/2011
>> Call Trace:
>>    __dump_stack lib/dump_stack.c:77 [inline]
>>    dump_stack+0xef/0x16e lib/dump_stack.c:118
>>    print_address_description.constprop.0+0x36/0x50 mm/kasan/report.c:374
>>    __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:506
>>    kasan_report+0xe/0x20 mm/kasan/common.c:638
>>    __mutex_lock_common kernel/locking/mutex.c:1043 [inline]
>>    __mutex_lock+0x124d/0x1360 kernel/locking/mutex.c:1106
>>    usbvision_v4l2_open+0x77/0x340
>> drivers/media/usb/usbvision/usbvision-video.c:314
>>    v4l2_open+0x20f/0x3d0 drivers/media/v4l2-core/v4l2-dev.c:423
>>    chrdev_open+0x219/0x5c0 fs/char_dev.c:414
>>    do_dentry_open+0x494/0x1120 fs/open.c:797
>>    do_last fs/namei.c:3412 [inline]
>>    path_openat+0x142b/0x4030 fs/namei.c:3529
>>    do_filp_open+0x1a1/0x280 fs/namei.c:3559
>>    do_sys_open+0x3c0/0x580 fs/open.c:1097
>>    do_syscall_64+0xb7/0x5b0 arch/x86/entry/common.c:294
>>    entry_SYSCALL_64_after_hwframe+0x49/0xbe

> This looks like a race in v4l2_open(): The function drops the
> videodev_lock mutex before calling the video driver's open routine, and
> the device can be unregistered during the short time between.

> This patch tries to make the race much more likely to happen, for
> testing and verification.

> Andrey, will syzbot run the same test with this patch, even though it
> says it doesn't have a reproducer?

> Alan Stern

> #syz test: https://github.com/google/kasan.git 1f22d15c

This crash does not have a reproducer. I cannot test it.


> Index: usb-devel/drivers/media/usb/usbvision/usbvision-video.c
> ===================================================================
> --- usb-devel.orig/drivers/media/usb/usbvision/usbvision-video.c
> +++ usb-devel/drivers/media/usb/usbvision/usbvision-video.c
> @@ -1585,6 +1585,7 @@ static void usbvision_disconnect(struct
>   		wake_up_interruptible(&usbvision->wait_frame);
>   		wake_up_interruptible(&usbvision->wait_stream);
>   	} else {
> +		msleep(100);
>   		usbvision_release(usbvision);
>   	}

> Index: usb-devel/drivers/media/v4l2-core/v4l2-dev.c
> ===================================================================
> --- usb-devel.orig/drivers/media/v4l2-core/v4l2-dev.c
> +++ usb-devel/drivers/media/v4l2-core/v4l2-dev.c
> @@ -419,9 +419,10 @@ static int v4l2_open(struct inode *inode
>   	video_get(vdev);
>   	mutex_unlock(&videodev_lock);
>   	if (vdev->fops->open) {
> -		if (video_is_registered(vdev))
> +		if (video_is_registered(vdev)) {
> +			msleep(200);
>   			ret = vdev->fops->open(filp);
> -		else
> +		} else
>   			ret = -ENODEV;
>   	}


