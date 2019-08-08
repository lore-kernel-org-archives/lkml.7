Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6498BC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3664A2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="baL8kVkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404742AbfHHU1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:27:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37311 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404351AbfHHU1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:27:10 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so44047625plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 13:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WTcQccWDVPotg15phg3zTAF2oauPTn+igOIs1LWZuPo=;
        b=baL8kVkzYdf3Yw7iok/ISH9qw6Z5IgHF4JsMSBGfdZmgc/JdCO+HpcWQGGMZ/YHvH6
         SSVI1kBNX28mBZcYh+JlM/bQag427pRge8EruzV2ieAIq88fFgNsZ3WJqshOscuVs3Iz
         d3XBgLRYWP/OlBSFKX0cWHM3Fb5cJyhJJWQKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WTcQccWDVPotg15phg3zTAF2oauPTn+igOIs1LWZuPo=;
        b=t5Hef4IzkqHN/FIgbaGOqKleB1lL6RdHYVDJx+5keHLHdLLLwdjtP2n7WLbXulfvE7
         34vj8zk7CX9Garv3FV8bVr1r6JOUn4bVWKENnERxQeg7crjMv0zjMT2tflxtQw4rDDKn
         dLZ+HLaDacG5L73rd5mdRMwP2lRyANu6+LZEk5Y2QrVfldG5gV40thg8O/M2Vc90yoLe
         e5O6qkacDtEDQnY0PxHSPdecvNue1uHyE/cPpMegElqWjC0LWuL/2ONXIAX0YTd01uPl
         20NWhoUOqKvtGqUnDHMT936olM9uQ2H8UG7kLhuxYLuJ8Pa0ZsK9+zt8O5CMlIRHdqF2
         ttZQ==
X-Gm-Message-State: APjAAAVVw8gRPYQJ2tMWlW8eS7mvaCqvRFaHqxfyhtmIieJI1i7/Q6LH
        bTQJC7qP7bSo7haZ4mVDsi2a9Dr9sqg=
X-Google-Smtp-Source: APXvYqxwm9iB2DDzVLvhxV2ThVMadzVdxUASbdYGfIVkvlE3ECQjJubaoQGdIuoteqU4Z4An/jmJ/g==
X-Received: by 2002:a17:902:9a85:: with SMTP id w5mr15426653plp.221.1565296029267;
        Thu, 08 Aug 2019 13:27:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 14sm93977517pfy.40.2019.08.08.13.27.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 13:27:08 -0700 (PDT)
Date:   Thu, 8 Aug 2019 13:27:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+3de312463756f656b47d@syzkaller.appspotmail.com>,
        allison@lohutok.net, andreyknvl@google.com, cai@lca.pw,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        Jiri Kosina <jkosina@suse.cz>
Subject: Re: BUG: bad usercopy in hidraw_ioctl
Message-ID: <201908081319.E2123D5A@keescook>
References: <000000000000ce6527058f8bf0d0@google.com>
 <20190807195821.GD5482@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807195821.GD5482@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 12:58:21PM -0700, Matthew Wilcox wrote:
> On Wed, Aug 07, 2019 at 12:28:06PM -0700, syzbot wrote:
> > usercopy: Kernel memory exposure attempt detected from wrapped address
> > (offset 0, size 0)!
> > ------------[ cut here ]------------
> > kernel BUG at mm/usercopy.c:98!
> 
> This report is confusing because the arguments to usercopy_abort() are wrong.
> 
>         /* Reject if object wraps past end of memory. */
>         if (ptr + n < ptr)
>                 usercopy_abort("wrapped address", NULL, to_user, 0, ptr + n);

This test actually contains an off-by-one which was recently fixed:
https://lore.kernel.org/linux-mm/1564509253-23287-1-git-send-email-isaacm@codeaurora.org/

So, this is actually a false positive if "ptr + n" yields a 0
(e.g. 0xffffffff + 1 == 0).

> ptr + n is not 'size', it's what wrapped.  I don't know what 'offset'
> should be set to, but 'size' should be 'n'.  Presumably we don't want to
> report 'ptr' because it'll leak a kernel address ... reporting 'n' will

Right, I left offset 0 (this is normally the offset into a reported area
like a specific kmalloc region, but isn't meaningful here IMO). And I
left the size as "how far we wrapped". (Which is pretty telling: we
wrapped 0 bytes ... *cough*.)

> leak a range for a kernel address, but I think that's OK?  Admittedly an
> attacker can pass in various values for 'n', but it'll be quite noisy
> and leave a trace in the kernel logs for forensics to find afterwards.
> 
> > Call Trace:
> >  check_bogus_address mm/usercopy.c:151 [inline]
> >  __check_object_size mm/usercopy.c:260 [inline]
> >  __check_object_size.cold+0xb2/0xba mm/usercopy.c:250
> >  check_object_size include/linux/thread_info.h:119 [inline]
> >  check_copy_size include/linux/thread_info.h:150 [inline]
> >  copy_to_user include/linux/uaccess.h:151 [inline]
> >  hidraw_ioctl+0x38c/0xae0 drivers/hid/hidraw.c:392
> 
> The root problem would appear to be:
> 
>                                 else if (copy_to_user(user_arg + offsetof(
>                                         struct hidraw_report_descriptor,
>                                         value[0]),
>                                         dev->hid->rdesc,
>                                         min(dev->hid->rsize, len)))
> 
> That 'min' should surely be a 'max'?
> 
> Jiri, this looks like it was your code back in 2007.

I think this code is correct and the usercopy reporting fix already in
-mm solves the problem.

-- 
Kees Cook
