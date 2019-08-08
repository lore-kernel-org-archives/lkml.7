Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F12DC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF66E217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TsthMIhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390367AbfHHUmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:42:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36097 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733140AbfHHUmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:42:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so44652665pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 13:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nS7CPtzCVp0ONgQlGgkx7OXPZavZodPDNiD74pSN4ok=;
        b=TsthMIhqXtbXp4xH+Z2wSZTAZqhudiQe7esQYSq3NqIJCExnewze/88rqQMCne0v0d
         FN5dRFOqevBvVNOO8AUZEPv3dAUQomTJ83wd9Wr7Y+kJNgX0HKAZzjJBQBi18lQPhP3w
         ASwqJ7VwHaeLqfgYDU479i5gbC/Pz/daiarWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nS7CPtzCVp0ONgQlGgkx7OXPZavZodPDNiD74pSN4ok=;
        b=gumREfGRvbo29/KYurXSqgzsdu+cj1bxtM4eUs0KJoxtantQBcQeVyhpR2BtuH8mNk
         9lE0A0SEozaAqWn4pFkHdpfdlrUkqAJt4gUUOZmxedtxlNTJGlsHues/w6rwZ2w81Wqv
         vscbXibKoqz0RdRH+qe9F1ikY2XQmfJB9+Gc9inogLbBhpWrkRH3xewePi8FriLdKLPu
         gEvQYu6uytC6M1c5daHEabkyy+G+H2UrJ+Y/a8Q7ZDY2v0P6IkgccDO5cDT6Dx8ZjKZ1
         dS3/NsMzUv2vhdLX9VE4B51j+YbNBIvQvzdu5SwLQlNlG9n7uCxIreZLo4Sy8VGnfrh+
         OHag==
X-Gm-Message-State: APjAAAVG3PlFO8l1vDPeE31FnHEGQUNhFWfxlV0usTgJJrIOB7QhcN39
        AnyI269hKWRVCvwJrWd7y915Nw==
X-Google-Smtp-Source: APXvYqzXHxnpRFvH9kCf1Uy9J4cWLZwuOKZTZDqgdkWhjibPvjL0xvjuHKfltUtrW/23JO7iytrk3Q==
X-Received: by 2002:a63:60d1:: with SMTP id u200mr14395334pgb.439.1565296921533;
        Thu, 08 Aug 2019 13:42:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s22sm103042884pfh.107.2019.08.08.13.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 13:42:00 -0700 (PDT)
Date:   Thu, 8 Aug 2019 13:41:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        syzbot <syzbot+3de312463756f656b47d@syzkaller.appspotmail.com>,
        allison@lohutok.net, andreyknvl@google.com, cai@lca.pw,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        Jiri Kosina <jkosina@suse.cz>
Subject: Re: BUG: bad usercopy in hidraw_ioctl
Message-ID: <201908081330.98485D9@keescook>
References: <000000000000ce6527058f8bf0d0@google.com>
 <20190807195821.GD5482@bombadil.infradead.org>
 <20190808014925.GL1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808014925.GL1131@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 02:49:25AM +0100, Al Viro wrote:
> On Wed, Aug 07, 2019 at 12:58:21PM -0700, Matthew Wilcox wrote:
> > On Wed, Aug 07, 2019 at 12:28:06PM -0700, syzbot wrote:
> > > usercopy: Kernel memory exposure attempt detected from wrapped address
> > > (offset 0, size 0)!
> > > ------------[ cut here ]------------
> > > kernel BUG at mm/usercopy.c:98!
> > 
> > This report is confusing because the arguments to usercopy_abort() are wrong.
> > 
> >         /* Reject if object wraps past end of memory. */
> >         if (ptr + n < ptr)
> >                 usercopy_abort("wrapped address", NULL, to_user, 0, ptr + n);

(Just to reiterate for this branch of the thread: this is an off-by-one
false positive already fixed in -mm for -next. However, see below...)

> > 
> > ptr + n is not 'size', it's what wrapped.  I don't know what 'offset'
> > should be set to, but 'size' should be 'n'.  Presumably we don't want to
> > report 'ptr' because it'll leak a kernel address ... reporting 'n' will
> > leak a range for a kernel address, but I think that's OK?  Admittedly an
> > attacker can pass in various values for 'n', but it'll be quite noisy
> > and leave a trace in the kernel logs for forensics to find afterwards.
> > 
> > > Call Trace:
> > >  check_bogus_address mm/usercopy.c:151 [inline]
> > >  __check_object_size mm/usercopy.c:260 [inline]
> > >  __check_object_size.cold+0xb2/0xba mm/usercopy.c:250
> > >  check_object_size include/linux/thread_info.h:119 [inline]
> > >  check_copy_size include/linux/thread_info.h:150 [inline]
> > >  copy_to_user include/linux/uaccess.h:151 [inline]
> > >  hidraw_ioctl+0x38c/0xae0 drivers/hid/hidraw.c:392
> > 
> > The root problem would appear to be:
> > 
> >                                 else if (copy_to_user(user_arg + offsetof(
> >                                         struct hidraw_report_descriptor,
> >                                         value[0]),
> >                                         dev->hid->rdesc,
> >                                         min(dev->hid->rsize, len)))
> > 
> > That 'min' should surely be a 'max'?
> 
> Surely not.  ->rsize is the amount of data available to copy out; len
> is the size of buffer supplied by userland to copy into.

include/uapi/linux/hid.h:#define HID_MAX_DESCRIPTOR_SIZE 4096

drivers/hid/hidraw.c:
                        if (get_user(len, (int __user *)arg))
                                ret = -EFAULT;
                        else if (len > HID_MAX_DESCRIPTOR_SIZE - 1)
                                ret = -EINVAL;
                        else if (copy_to_user(user_arg + offsetof(
                                struct hidraw_report_descriptor,
                                value[0]),
                                dev->hid->rdesc,
                                min(dev->hid->rsize, len)))
                                ret = -EFAULT;

The copy size must be less than 4096, which means dev->hid->rdesc is
allocated at the highest page of memory. That whole space collides with
the ERR_PTR region which has two bad potential side-effects:

1) something that checks for ERR_PTRs combined with a high allocation
will think it failed and leak the allocation.

2) something that doesn't check ERR_PTRs might try to stomp on an actual
allocation in that area.

How/why is there memory allocated there, I thought it was intentionally
left unused specifically for ERR_PTR:

Documentation/x86/x86_64/mm.rst:

     Start addr    | Offset |     End addr     | Size  | VM area description
  ==========================================================================
  ...
  ffffffffffe00000 | -2  MB | ffffffffffffffff |  2 MB | ...unused hole


or is this still a real bug with an invalid dev->hid->rdesc which was
about to fault but usercopy got in the way first?

-- 
Kees Cook
