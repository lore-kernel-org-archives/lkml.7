Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA401C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E8421707
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfD3ONk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 10:13:40 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:35354 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726294AbfD3ONj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:13:39 -0400
Received: (qmail 1597 invoked by uid 2102); 30 Apr 2019 10:13:38 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Apr 2019 10:13:38 -0400
Date:   Tue, 30 Apr 2019 10:13:38 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Eric Biggers <ebiggers@kernel.org>
cc:     syzbot <syzbot+a9fefd18c7b240f19c54@syzkaller.appspotmail.com>,
        <andreyknvl@google.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <rafael@kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hex_string
In-Reply-To: <20190429210917.GA251866@gmail.com>
Message-ID: <Pine.LNX.4.44L0.1904301007320.1465-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Apr 2019, Eric Biggers wrote:

> On Mon, Apr 29, 2019 at 04:07:04PM -0400, Alan Stern wrote:

> > Accessing beyond the end of the descriptor.
> > 
> > #syz test: https://github.com/google/kasan.git usb-fuzzer
> > 
> > --- a/drivers/video/fbdev/udlfb.c
> > +++ b/drivers/video/fbdev/udlfb.c
> > @@ -1511,6 +1511,7 @@ static int dlfb_parse_vendor_descriptor(
> >  	char *buf;
> >  	char *desc_end;
> >  	int total_len;
> > +	int width;
> >  
> >  	buf = kzalloc(MAX_VENDOR_DESCRIPTOR_SIZE, GFP_KERNEL);
> >  	if (!buf)
> > @@ -1529,9 +1530,10 @@ static int dlfb_parse_vendor_descriptor(
> >  	}
> >  
> >  	if (total_len > 5) {
> > +		width = min(total_len, 11);
> >  		dev_info(&intf->dev,
> > -			 "vendor descriptor length: %d data: %11ph\n",
> > -			 total_len, desc);
> > +			 "vendor descriptor length: %d data: %*ph\n",
> > +			 total_len, width, desc);
> >  
> >  		if ((desc[0] != total_len) || /* descriptor length */
> >  		    (desc[1] != 0x5f) ||   /* vendor descriptor type */
> > 
> > 
> 
> Why not write just:
> 
>                 dev_info(&intf->dev,
>                          "vendor descriptor length: %d data: %*ph\n",
>                          total_len, min(total_len, 11), desc);

I did consider doing that.  In the end I decided adding an extra
temporary variable made the code a little more readable.  (For some 
reason, extra recursion -- a function call embedded in a function 
argument -- seems to demand more mental effort than an extra 
temporary.  Maybe my brain is just getting old...)

> Also, aren't there more out-of-bounds reads in the code just after?  It only
> checks for at least 1 byte available, but then it reads up to 7 bytes:
> 
> 		while (desc < desc_end) {
> 			u8 length;
> 			u16 key;
> 
> 			key = *desc++;
> 			key |= (u16)*desc++ << 8;
> 			length = *desc++;
> 
> 			switch (key) {
> 			case 0x0200: { /* max_area */
> 				u32 max_area = *desc++;
> 				max_area |= (u32)*desc++ << 8;
> 				max_area |= (u32)*desc++ << 16;
> 				max_area |= (u32)*desc++ << 24;
> 				dev_warn(&intf->dev,
> 					 "DL chip limited to %d pixel modes\n",
> 					 max_area);
> 				dlfb->sku_pixel_limit = max_area;
> 				break;
> 			}
> 			default:
> 				break;
> 			}
> 			desc += length;
> 		}

Quite right.  Please feel free to submit a patch fixing all these 
problems.

> Also I couldn't help but notice it's also using 'char' rather than 'u8',
> so bytes >= 0x80 are read incorrectly as they're sign extended...

As I recall, the C standard doesn't specify whether char is signed or
unsigned; it can vary with the implementation.  However you are
certainly correct that to ensure there is no sign extension, the code
should use unsigned char or u8.

Alan Stern

