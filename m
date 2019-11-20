Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EDFC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFBC2244A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 11:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfKTLTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 06:19:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:45644 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727127AbfKTLTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:19:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2A556BA64;
        Wed, 20 Nov 2019 11:19:01 +0000 (UTC)
Message-ID: <1574248737.14298.33.camel@suse.com>
Subject: Re: BUG: bad host security descriptor; not enough data (4 vs 5 left)
From:   Oliver Neukum <oneukum@suse.com>
To:     Greg KH <greg@kroah.com>,
        syzbot <syzbot+d934a9036346e0215d8f@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Date:   Wed, 20 Nov 2019 12:18:57 +0100
In-Reply-To: <20191111160950.GA870254@kroah.com>
References: <000000000000d9a391059713dc1f@google.com>
         <20191111160950.GA870254@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 11.11.2019, 17:09 +0100 schrieb Greg KH:
> On Mon, Nov 11, 2019 at 07:34:08AM -0800, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following crash on:
> > 
> > HEAD commit:    3183c037 usb: gadget: add raw-gadget interface
> > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12525dc6e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=79de80330003b5f7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=d934a9036346e0215d8f
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ac7406e00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13eea39ae00000
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+d934a9036346e0215d8f@syzkaller.appspotmail.com
> > 
> > usb 1-1: config 0 interface 0 altsetting 0 has 3 endpoint descriptors,
> > different from the interface descriptor's value: 4
> > usb 1-1: New USB device found, idVendor=13dc, idProduct=5611,
> > bcdDevice=2f.15
> > usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> > usb 1-1: config 0 descriptor??
> > hwa-hc 1-1:0.0: Wire Adapter v106.52 newer than groked v1.0
> > hwa-hc 1-1:0.0: FIXME: USB_MAXCHILDREN too low for WUSB adapter (194 ports)
> > usb 1-1: BUG: bad host security descriptor; not enough data (4 vs 5 left)
> > usb 1-1: supported encryption types: �SЁ���|cЁ����cЁ���
> > usb 1-1: E: host doesn't support CCM-1 crypto
> > hwa-hc 1-1:0.0: Wireless USB HWA host controller
> > hwa-hc 1-1:0.0: new USB bus registered, assigned bus number 11
> 
> wusb code, hah.  It's about to be deleted from the kernel because no one
> uses it and there is no hardware out there.  I wouldn't spend a ton of
> time fuzzing it.
> 
> One more good reason to just delete it soon...

Unfortunately that is not an option for the stable trees. Before I try
something quick and dirty here, I have a question for the testing team.

What exactly crashed? There is nothing in the logs? Did you undergo
an absolute freeze of the machine? Or do you tested for the word "BUG"
in the logs?

	Regards
		Oliver

