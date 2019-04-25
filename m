Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F64AC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F8E2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfDYOJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:09:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:50026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbfDYOJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:09:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8F142ABCE;
        Thu, 25 Apr 2019 14:09:00 +0000 (UTC)
Message-ID: <1556201335.11912.6.camel@suse.com>
Subject: Re: KASAN: use-after-free Read in dvb_usb_device_exit
From:   Oliver Neukum <oneukum@suse.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>, andreyknvl@google.com,
        syzkaller-bugs@googlegroups.com, mchehab@kernel.org,
        corbet@lwn.net,
        syzbot <syzbot+26ec41e9f788b3eba396@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org
Date:   Thu, 25 Apr 2019 16:08:55 +0200
In-Reply-To: <9cfe433e-426e-19d1-9cb8-5bc2ba17145b@xs4all.nl>
References: <000000000000789d3d058653d9bb@google.com>
         <1555326745.13626.10.camel@suse.com>
         <9cfe433e-426e-19d1-9cb8-5bc2ba17145b@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 2019-04-24 at 16:09 +0200, Hans Verkuil wrote:
> On 4/15/19 1:12 PM, Oliver Neukum wrote:
> > On Fr, 2019-04-12 at 04:46 -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following crash on:
> > > 
> > > HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
> > > git tree:       https://github.com/google/kasan/tree/usb-fuzzer
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1643974b200000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=26ec41e9f788b3eba396
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f5efa7200000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1395a0f3200000
> > > 
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+26ec41e9f788b3eba396@syzkaller.appspotmail.com
> > > 
> > > dvb-usb: schedule remote query interval to 150 msecs.
> > > dw2102: su3000_power_ctrl: 0, initialized 1
> > > dvb-usb: TeVii S421 PCI successfully initialized and connected.
> > > usb 1-1: USB disconnect, device number 2
> > 
> > Hi,
> > 
> > proposed fix. If nobody objects, I will submit it.
> > 
> > 	Regards
> > 		Oliver
> > 
> > From d6097d205ac61745334b79639d3b8b910ae66c71 Mon Sep 17 00:00:00 2001
> > From: Oliver Neukum <oneukum@suse.com>
> > Date: Mon, 15 Apr 2019 13:06:01 +0200
> > Subject: [PATCH] dvb: usb: fix use after free in dvb_usb_device_exit
> > 
> > dvb_usb_device_exit() frees and uses teh device name in that order
> > Fix by storing the name in a buffer before freeing it
> > 
> > Signed-off-by: Oliver Neukum <oneukum@suse.com>
> > Reported-by: syzbot+26ec41e9f788b3eba396@syzkaller.appspotmail.com
> > ---
> >  drivers/media/usb/dvb-usb/dvb-usb-init.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
> > index 99951e02a880..2e1670cc3903 100644
> > --- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
> > +++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
> > @@ -288,13 +288,18 @@ void dvb_usb_device_exit(struct usb_interface *intf)
> >  {
> >  	struct dvb_usb_device *d = usb_get_intfdata(intf);
> >  	const char *name = "generic DVB-USB module";
> > +	char identifier[40];
> >  
> >  	usb_set_intfdata(intf, NULL);
> >  	if (d != NULL && d->desc != NULL) {
> >  		name = d->desc->name;
> > +		memcpy(identifier, name, 39);
> > +		identifier[39] = NULL;
> >  		dvb_usb_exit(d);
> 
> Why not just move this to after the info()? You'll need to repeat the
> 'if' in that case, but that way there is no need to memcpy anything.

The info() would make the incorrect claim that something has been
freed. It looks to me like it exists to guarantee that you know that
nothing hung while freeing.

	Regards
		Oliver

