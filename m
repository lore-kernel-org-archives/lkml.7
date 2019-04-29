Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23824C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE11D215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556572162;
	bh=pOpnxOmLj6jZaokHGolQKkRzuK516xtMuJlZUb+qn9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j+88cRnwZrWhhZu43/YQhGu6IJQYQeV4rPg+/6DrVCZmpEDwK2T+WOir4zLBbgINX
	 mN/8/YYTwBWLg5Woxfgiczx6pCJWx6w6Y6/jeddQYc1bIRwepiFn0jGAZeLaZj7QTF
	 iWdawclw4Mbc0X1jMN28iOd+DP+6D8XQwB8AQGqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfD2VJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 17:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728071AbfD2VJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 17:09:21 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89AA1215EA;
        Mon, 29 Apr 2019 21:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556572159;
        bh=pOpnxOmLj6jZaokHGolQKkRzuK516xtMuJlZUb+qn9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lsNbacl40arME70zOmem6T6XwPFBdqV0B0MeYH1Nlsh9pu7KfXu3gFGtXjZHd7A3V
         g1V7xbqNfJKhuJ+8k1P244SBeEHog4ju3+PeSKfG2Sf4mzfezSR7XxWT8PMbEU3wsQ
         99IAciulao8DPkzp8w8BJmHZWEUfjn5OdOrU2qQY=
Date:   Mon, 29 Apr 2019 14:09:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+a9fefd18c7b240f19c54@syzkaller.appspotmail.com>,
        andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: slab-out-of-bounds Read in hex_string
Message-ID: <20190429210917.GA251866@gmail.com>
References: <000000000000f69c3b0587aa1bc5@google.com>
 <Pine.LNX.4.44L0.1904291604510.1632-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1904291604510.1632-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 04:07:04PM -0400, Alan Stern wrote:
> On Mon, 29 Apr 2019, syzbot wrote:
> 
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    43151d6c usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan/tree/usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=139ac37f200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=4183eeef650d1234
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a9fefd18c7b240f19c54
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f3b338a00000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+a9fefd18c7b240f19c54@syzkaller.appspotmail.com
> > 
> > ==================================================================
> > BUG: KASAN: slab-out-of-bounds in hex_string+0x418/0x4b0 lib/vsprintf.c:975
> > Read of size 1 at addr ffff88821a41bd38 by task kworker/0:1/12
> > 
> > CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.1.0-rc3-319004-g43151d6 #6
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> > Google 01/01/2011
> > Workqueue: usb_hub_wq hub_event
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0xe8/0x16e lib/dump_stack.c:113
> >   print_address_description+0x6c/0x236 mm/kasan/report.c:187
> >   kasan_report.cold+0x1a/0x3c mm/kasan/report.c:317
> >   hex_string+0x418/0x4b0 lib/vsprintf.c:975
> >   pointer+0x460/0x910 lib/vsprintf.c:1985
> >   vsnprintf+0x5a0/0x16b0 lib/vsprintf.c:2400
> >   pointer+0x60b/0x910 lib/vsprintf.c:2038
> >   vsnprintf+0x5a0/0x16b0 lib/vsprintf.c:2400
> >   vscnprintf+0x29/0x80 lib/vsprintf.c:2499
> >   vprintk_store+0x45/0x4b0 kernel/printk/printk.c:1900
> >   vprintk_emit+0x210/0x5a0 kernel/printk/printk.c:1957
> >   dev_vprintk_emit+0x50e/0x553 drivers/base/core.c:3185
> >   dev_printk_emit+0xbf/0xf6 drivers/base/core.c:3196
> >   __dev_printk+0x1ed/0x215 drivers/base/core.c:3208
> >   _dev_info+0xdc/0x10e drivers/base/core.c:3254
> >   dlfb_parse_vendor_descriptor drivers/video/fbdev/udlfb.c:1532 [inline]
> 
> Accessing beyond the end of the descriptor.
> 
> #syz test: https://github.com/google/kasan.git usb-fuzzer
> 
> --- a/drivers/video/fbdev/udlfb.c
> +++ b/drivers/video/fbdev/udlfb.c
> @@ -1511,6 +1511,7 @@ static int dlfb_parse_vendor_descriptor(
>  	char *buf;
>  	char *desc_end;
>  	int total_len;
> +	int width;
>  
>  	buf = kzalloc(MAX_VENDOR_DESCRIPTOR_SIZE, GFP_KERNEL);
>  	if (!buf)
> @@ -1529,9 +1530,10 @@ static int dlfb_parse_vendor_descriptor(
>  	}
>  
>  	if (total_len > 5) {
> +		width = min(total_len, 11);
>  		dev_info(&intf->dev,
> -			 "vendor descriptor length: %d data: %11ph\n",
> -			 total_len, desc);
> +			 "vendor descriptor length: %d data: %*ph\n",
> +			 total_len, width, desc);
>  
>  		if ((desc[0] != total_len) || /* descriptor length */
>  		    (desc[1] != 0x5f) ||   /* vendor descriptor type */
> 
> 

Why not write just:

                dev_info(&intf->dev,
                         "vendor descriptor length: %d data: %*ph\n",
                         total_len, min(total_len, 11), desc);

Also, aren't there more out-of-bounds reads in the code just after?  It only
checks for at least 1 byte available, but then it reads up to 7 bytes:

		while (desc < desc_end) {
			u8 length;
			u16 key;

			key = *desc++;
			key |= (u16)*desc++ << 8;
			length = *desc++;

			switch (key) {
			case 0x0200: { /* max_area */
				u32 max_area = *desc++;
				max_area |= (u32)*desc++ << 8;
				max_area |= (u32)*desc++ << 16;
				max_area |= (u32)*desc++ << 24;
				dev_warn(&intf->dev,
					 "DL chip limited to %d pixel modes\n",
					 max_area);
				dlfb->sku_pixel_limit = max_area;
				break;
			}
			default:
				break;
			}
			desc += length;
		}


Also I couldn't help but notice it's also using 'char' rather than 'u8',
so bytes >= 0x80 are read incorrectly as they're sign extended...

- Eric
