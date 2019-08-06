Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9095FC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7134A2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732897AbfHFOWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:22:39 -0400
Received: from mail-ot1-f69.google.com ([209.85.210.69]:52871 "EHLO
        mail-ot1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731559AbfHFOWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:22:38 -0400
Received: by mail-ot1-f69.google.com with SMTP id a17so49451896otd.19
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 07:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=PfWPxoJNv7jYEQYH1igsVvAbHYTVjvG9o6NhTa2SlsE=;
        b=kEazPW8bh6mQn7p4DLcV4cJVbtu8eUbC3bJ9lC0DFKAR28Ubv0/q8AYoPlYHm9qGGr
         pjfv8gOtamfgxE6GrLTniyheof2sg3KY7nqvd3d9ZtKNevynTgoWWvkm19JncndZxBza
         PytAjMUFahpqQhfXzyhrMu2NDuXynFSnI8AoyIRVem5gsk7z4t9BGzyq23t7JHfSlHsB
         uXeWxHgCI4RaNyy/uE0M0It8tSRZEXlQPyjMsLoMROxKXBRNk6fijE2uuFv1BWVKO1Jg
         hJUf41qeR7S7BnmC91bxvRNLs6naAi+/w/SMOPlIXzwuFm3jH5Pn54ZQywwi7P9rjN+k
         L6pw==
X-Gm-Message-State: APjAAAXhybaxMmdpQRz+XB1YDJIhpawsKXuzCKRdiCN4FTEnopZaVej4
        jZ5W7P97WyHUL4CpnO7JwNEfpm+lQT/qmAaY6HMMpjzeZKYA
X-Google-Smtp-Source: APXvYqxsCHFRyT9xAwNOWbJE3nfEvhiHgt8amI5q1JfTcRNp4+PadLxVRVVpFR4dMRLKG08vpGt4/s56z88823u3f5FhoUWYaN9j
MIME-Version: 1.0
X-Received: by 2002:a5d:8890:: with SMTP id d16mr3723626ioo.274.1565101357255;
 Tue, 06 Aug 2019 07:22:37 -0700 (PDT)
Date:   Tue, 06 Aug 2019 07:22:37 -0700
In-Reply-To: <1565101353.8136.27.camel@suse.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006fd649058f738e01@google.com>
Subject: Re: Re: possible deadlock in usb_deregister_dev
From:   syzbot <syzbot+a64a382964bf6c71a9c0@syzkaller.appspotmail.com>
To:     Oliver Neukum <oneukum@suse.de>
Cc:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        oneukum@suse.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Am Montag, den 05.08.2019, 04:58 -0700 schrieb syzbot:
>> Hello,

>> syzbot found the following crash on:

>> HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
>> git tree:       https://github.com/google/kasan.git usb-fuzzer
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13b5bc8a600000
>> kernel config:   
>> https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
>> dashboard link:  
>> https://syzkaller.appspot.com/bug?extid=a64a382964bf6c71a9c0
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

>> Unfortunately, I don't have any reproducer for this crash yet.

>> IMPORTANT: if you fix the bug, please add the following tag to the  
>> commit:
>> Reported-by: syzbot+a64a382964bf6c71a9c0@syzkaller.appspotmail.com

> #syz test: https://github.com/google/kasan.git e96407b4

This crash does not have a reproducer. I cannot test it.


>  From 973e82b3f583113e4d7fe5cd2f918a16022c4e38 Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oneukum@suse.com>
> Date: Tue, 6 Aug 2019 16:17:54 +0200
> Subject: [PATCH] usb: iowarrior: fix deadlock on disconnect

> We have to drop the mutex before we close() upon disconnect()
> as close() needs the lock. This is safe to do by dropping the
> mutex as intfdata is already set to NULL, so open() will fail.

> Fixes: 03f36e885fc26 ("USB: open disconnect race in iowarrior")
> Reported-by: syzbot+a64a382964bf6c71a9c0@syzkaller.appspotmail.com
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>   drivers/usb/misc/iowarrior.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

> diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
> index ba05dd80a020..f5bed9f29e56 100644
> --- a/drivers/usb/misc/iowarrior.c
> +++ b/drivers/usb/misc/iowarrior.c
> @@ -866,19 +866,20 @@ static void iowarrior_disconnect(struct  
> usb_interface *interface)
>   	dev = usb_get_intfdata(interface);
>   	mutex_lock(&iowarrior_open_disc_lock);
>   	usb_set_intfdata(interface, NULL);
> +	/* prevent device read, write and ioctl */
> +	dev->present = 0;

>   	minor = dev->minor;
> +	mutex_unlock(&iowarrior_open_disc_lock);
> +	/* give back our minor - this will call close() locks need to be  
> dropped at this point*/

> -	/* give back our minor */
>   	usb_deregister_dev(interface, &iowarrior_class);

>   	mutex_lock(&dev->mutex);

>   	/* prevent device read, write and ioctl */
> -	dev->present = 0;

>   	mutex_unlock(&dev->mutex);
> -	mutex_unlock(&iowarrior_open_disc_lock);

>   	if (dev->opened) {
>   		/* There is a process that holds a filedescriptor to the device ,
> --
> 2.16.4

