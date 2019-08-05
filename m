Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C346FC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E06A21841
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfHEJLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:11:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42810 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEJLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:11:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so33698646wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 02:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Kd5EDYqpvFgk4WZntRRcgRB794tUUJ1gUXoaDcOppmQ=;
        b=aXpZWrQkM8xcX3sjiL1nx2CmQVtmM9BzhAUYVXVgNxjyo3N/4d1tUpOfy4ifhaOyEx
         cXYpKxteYwJovF+UhW8E1AOAPhVSAFRpjDc4rAHA+QpAHbpyAFrMaMP79CGkHmjtNkxw
         6izYAb7dfJGZ/TP0RR7b9YD+dwQZpj5ZDjNWw0Au5Y0MyDM/RF0CU1w8EEihEz6RzIAX
         bUJAV8uruqWE0Dwc2Ug5EkriRFz51Vx7Fp0NQFg420esW6mAtqt919LYau28R1ss01vY
         5EimrujYChCIGaldFtNf7DKWnD2taHmCxFiUjLEzVyRPPoWSv9tZ8iriZ4gkYmDkLE4K
         osuw==
X-Gm-Message-State: APjAAAXwfCpahuadwRe5r9F1lscV2yLmouA69I4vL3GF2bbRydiw8xVY
        RnLKfv6xDwlMXjeHItVyQuD+x3dc2zo=
X-Google-Smtp-Source: APXvYqy42iFTD64kbGgpTmrmrVKrbki4jJhCaZNAhS5Gv2HeG+hlpEJ0xXgqzQz3fh4h/CCbofs+qA==
X-Received: by 2002:a5d:4cca:: with SMTP id c10mr8992464wrt.233.1564996262955;
        Mon, 05 Aug 2019 02:11:02 -0700 (PDT)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id k9sm14580720wrd.46.2019.08.05.02.11.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 02:11:02 -0700 (PDT)
Subject: Re: memory leak in pty_common_install
To:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+bdebcbf44250d75bdd82@syzkaller.appspotmail.com>
Cc:     syzkaller-bugs@googlegroups.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
References: <20190804142339.8180-1-hdanton@sina.com>
From:   Jiri Slaby <jslaby@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jslaby@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ff830428-1110-92cd-0290-5557f0d502a4@suse.com>
Date:   Mon, 5 Aug 2019 11:11:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190804142339.8180-1-hdanton@sina.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 08. 19, 16:23, Hillf Danton wrote:
> 
> On Tue, 30 Jul 2019 08:08:05 -0700
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    6789f873 Merge tag 'pm-5.3-rc2' of git://git.kernel.org/pu..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=1696897c600000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=339b6a6b3640d115
>> dashboard link: https://syzkaller.appspot.com/bug?extid=bdebcbf44250d75bdd82
>> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=153d7544600000
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: syzbot+bdebcbf44250d75bdd82@syzkaller.appspotmail.com
>>
>> BUG: memory leak
>> unreferenced object 0xffff88810d84d400 (size 512):
>>    comm "syz-executor.5", pid 7522, jiffies 4294954305 (age 14.260s)
>>    hex dump (first 32 bytes):
>>      50 d4 84 0d 81 88 ff ff e0 ff ff ff 0f 00 00 00  P...............
>>      10 d4 84 0d 81 88 ff ff 10 d4 84 0d 81 88 ff ff  ................
>>    backtrace:
>>      [<000000003d61da44>] kmemleak_alloc_recursive  include/linux/kmemleak.h:43 [inline]
>>      [<000000003d61da44>] slab_post_alloc_hook mm/slab.h:522 [inline]
>>      [<000000003d61da44>] slab_alloc mm/slab.c:3319 [inline]
>>      [<000000003d61da44>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
>>      [<00000000a6239e0a>] kmalloc include/linux/slab.h:552 [inline]
>>      [<00000000a6239e0a>] pty_common_install+0x4e/0x2b0 drivers/tty/pty.c:391
>>      [<00000000bd8cb19d>] pty_unix98_install+0x20/0x30 drivers/tty/pty.c:740
>>      [<000000001b46b5e1>] tty_driver_install_tty drivers/tty/tty_io.c:1227  [inline]
>>      [<000000001b46b5e1>] tty_init_dev drivers/tty/tty_io.c:1340 [inline]
>>      [<000000001b46b5e1>] tty_init_dev+0x86/0x210 drivers/tty/tty_io.c:1317
>>      [<00000000845ae712>] ptmx_open drivers/tty/pty.c:845 [inline]
>>      [<00000000845ae712>] ptmx_open+0xba/0x1c0 drivers/tty/pty.c:811
>>      [<000000007e87d771>] chrdev_open+0xe3/0x290 fs/char_dev.c:414
>>      [<00000000bd556826>] do_dentry_open+0x199/0x4f0 fs/open.c:797
>>      [<000000001ba9145b>] vfs_open+0x35/0x40 fs/open.c:906
>>      [<00000000c0275eb4>] do_last fs/namei.c:3416 [inline]
>>      [<00000000c0275eb4>] path_openat+0x854/0x1cd0 fs/namei.c:3533
>>      [<00000000156ad8b1>] do_filp_open+0xaa/0x130 fs/namei.c:3563
>>      [<00000000074d96c0>] do_sys_open+0x253/0x330 fs/open.c:1089
>>      [<000000009f7fc64a>] __do_sys_openat fs/open.c:1116 [inline]
>>      [<000000009f7fc64a>] __se_sys_openat fs/open.c:1110 [inline]
>>      [<000000009f7fc64a>] __x64_sys_openat+0x24/0x30 fs/open.c:1110
>>      [<000000005ca4479f>] do_syscall_64+0x76/0x1a0  arch/x86/entry/common.c:296
>>      [<00000000e1f64b0f>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> BUG: memory leak
>> unreferenced object 0xffff88810e639800 (size 1024):
>>    comm "syz-executor.5", pid 7522, jiffies 4294954305 (age 14.260s)
>>    hex dump (first 32 bytes):
>>      01 54 00 00 01 00 00 00 00 00 00 00 00 00 00 00  .T..............
>>      00 83 fa 19 82 88 ff ff a0 7f 9b 83 ff ff ff ff  ................
>>    backtrace:
>>      [<000000003d61da44>] kmemleak_alloc_recursive  include/linux/kmemleak.h:43 [inline]
>>      [<000000003d61da44>] slab_post_alloc_hook mm/slab.h:522 [inline]
>>      [<000000003d61da44>] slab_alloc mm/slab.c:3319 [inline]
>>      [<000000003d61da44>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
>>      [<000000001cfffc30>] kmalloc include/linux/slab.h:552 [inline]
>>      [<000000001cfffc30>] kzalloc include/linux/slab.h:748 [inline]
>>      [<000000001cfffc30>] alloc_tty_struct+0x3f/0x290  drivers/tty/tty_io.c:2981
>>      [<000000001946a70c>] pty_common_install+0xac/0x2b0 drivers/tty/pty.c:399
>>      [<00000000bd8cb19d>] pty_unix98_install+0x20/0x30 drivers/tty/pty.c:740
>>      [<000000001b46b5e1>] tty_driver_install_tty drivers/tty/tty_io.c:1227  [inline]
>>      [<000000001b46b5e1>] tty_init_dev drivers/tty/tty_io.c:1340 [inline]
>>      [<000000001b46b5e1>] tty_init_dev+0x86/0x210 drivers/tty/tty_io.c:1317
>>      [<00000000845ae712>] ptmx_open drivers/tty/pty.c:845 [inline]
>>      [<00000000845ae712>] ptmx_open+0xba/0x1c0 drivers/tty/pty.c:811
>>      [<000000007e87d771>] chrdev_open+0xe3/0x290 fs/char_dev.c:414
>>      [<00000000bd556826>] do_dentry_open+0x199/0x4f0 fs/open.c:797
>>      [<000000001ba9145b>] vfs_open+0x35/0x40 fs/open.c:906
>>      [<00000000c0275eb4>] do_last fs/namei.c:3416 [inline]
>>      [<00000000c0275eb4>] path_openat+0x854/0x1cd0 fs/namei.c:3533
>>      [<00000000156ad8b1>] do_filp_open+0xaa/0x130 fs/namei.c:3563
>>      [<00000000074d96c0>] do_sys_open+0x253/0x330 fs/open.c:1089
>>      [<000000009f7fc64a>] __do_sys_openat fs/open.c:1116 [inline]
>>      [<000000009f7fc64a>] __se_sys_openat fs/open.c:1110 [inline]
>>      [<000000009f7fc64a>] __x64_sys_openat+0x24/0x30 fs/open.c:1110
>>      [<000000005ca4479f>] do_syscall_64+0x76/0x1a0  arch/x86/entry/common.c:296
>>      [<00000000e1f64b0f>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Reset tty for port if none cares the open result.

Could you elaborate on how tty_port_open affects ptys? I.e. how does
this report relates to the change below?

And why do you think it is necessary at all? tty_port_close should take
care of it.

> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -669,6 +669,8 @@ EXPORT_SYMBOL_GPL(tty_port_install);
>  int tty_port_open(struct tty_port *port, struct tty_struct *tty,
>  							struct file *filp)
>  {
> +	int retval = 0;
> +
>  	spin_lock_irq(&port->lock);
>  	++port->count;
>  	spin_unlock_irq(&port->lock);
> @@ -685,16 +687,18 @@ int tty_port_open(struct tty_port *port,
>  	if (!tty_port_initialized(port)) {
>  		clear_bit(TTY_IO_ERROR, &tty->flags);
>  		if (port->ops->activate) {
> -			int retval = port->ops->activate(port, tty);
> -			if (retval) {
> -				mutex_unlock(&port->mutex);
> -				return retval;
> -			}
> +			retval = port->ops->activate(port, tty);
> +			if (retval)
> +				goto out;
>  		}
>  		tty_port_set_initialized(port, 1);
>  	}
> +out:
>  	mutex_unlock(&port->mutex);
> -	return tty_port_block_til_ready(port, tty, filp);
> +	if (!retval)
> +		retval = tty_port_block_til_ready(port, tty, filp);
> +	if (retval)
> +		tty_port_tty_set(port, 0);
> +	return retval;
>  }
> -
>  EXPORT_SYMBOL(tty_port_open);
> --
> 
> 

thanks,
-- 
js
suse labs
