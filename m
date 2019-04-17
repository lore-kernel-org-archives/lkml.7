Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC79AC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A912020821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n4nsODDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbfDQLQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:16:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37361 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731337AbfDQLQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:16:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so11868968pgc.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 04:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DAhaUckrpoxHtyYXB6W9rqZ88dFeqr0QxEv6Qcjpc7E=;
        b=n4nsODDNdeTbJBwTDUwqHsjg7tTq1wDovUzp/3Ps5JJOHsmgB8vvaD3CJGB8FXP5oS
         ekWMPIBa4yITCfzNikroyOxKK8HO1837Q/RfZpkgbDdOA1efgGEREisUJlFdZs3gnQtT
         5IJFZ/Zh/23n/wj1TqS/PjaDOpmHhR3HqF+I9SiLBWoFiK4xb9MgPzU8Mwt7IKQ/AyS0
         o8mDLtHbNPGBVBLjW5zbdpp+qfz0bP1qK6c5J/816zmc8R1jf98SRLWlvZkHlPi1sXPA
         9GlYTJvpLmkt2vv/2WSjQgyb3CjmbwqX2v2j4F+yqoDyW82UTBPwePjYupe+aXXFfTOV
         Mq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DAhaUckrpoxHtyYXB6W9rqZ88dFeqr0QxEv6Qcjpc7E=;
        b=XAZCc+t9i9u5E+nzn6f0LfaFYCkb2PHF1f9bqXtuCg/70HC80ghkthC9FaOCoFCQNT
         xjxXsJt59SCkHXGysnUyGVg0tow79AJ4WmLoNT6g4m0Leoo2hsai8nwkYERpMLpUDDHA
         YZij2ReWSk8HrqBRwDSqCjqkLiEkwOcf7VRD7NlXRf2w5ckBoLMAtPhwRSluDL7wiASf
         e4nP+CvsVBrVQZVb0/btLhT8jNLy0rupcERS8P7r/eCjq0BbLl7CzNgxGtgqrJNVAGBH
         IpHkd1URtqiXlSsVJsP2GjOYWVs+/4x34V0Jg77HbIGCw8U2qslkyZQDHmVbXho+cCmb
         4hPQ==
X-Gm-Message-State: APjAAAX+jofL/f4Tkki7i6upY9osRlledYu32c3qku8z6VtXuxrAUWug
        fTenOPUW7qNDh5dgwwp2alriVxySCnAMsTPajoiFxg==
X-Google-Smtp-Source: APXvYqxHVLwGqIgZv7++lctI75Hz2Q/rX2w9jOZ9PftD0dp1WgmNTvAVnzqB+4CoubtY/ipYVX2jNcH+2I5thet27Vo=
X-Received: by 2002:a63:cf0d:: with SMTP id j13mr82112417pgg.34.1555499799534;
 Wed, 17 Apr 2019 04:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007380f90586a82005@google.com> <Pine.LNX.4.44L0.1904161421530.1605-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1904161421530.1605-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 17 Apr 2019 13:16:27 +0200
Message-ID: <CAAeHK+zCwXpAb02vaPuanStYCp_x8g92HDEvm_LTN_F+Y_wOfQ@mail.gmail.com>
Subject: Re: INFO: task hung in usb_kill_urb
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+d919b0f29d7b5a4994b9@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 8:25 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, 16 Apr 2019, syzbot wrote:
>
> > Hello,
> >
> > syzbot has tested the proposed patch but the reproducer still triggered
> > crash:
> > INFO: task hung in usb_kill_urb
>
> Okay, I think I found the problem.  dummy-hcd doesn't check for
> unsupported speeds until it is too late.  Andrey, what values does your
> usb-fuzzer gadget driver set for its max_speed field?

It's passed from userspace without any validation :( I'll fix this!
Thanks for looking into it!

I wonder why other people saw this hang as well, they didn't use the
dummy hcd module for sure. I guess there are might be other reasons.

>
> Anyway, if I'm right then this patch should fix the bug.
>
> Alan Stern
>
> #syz test: https://github.com/google/kasan.git usb-fuzzer
>
> --- a/drivers/usb/gadget/udc/dummy_hcd.c
> +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> @@ -979,8 +979,18 @@ static int dummy_udc_start(struct usb_ga
>         struct dummy_hcd        *dum_hcd = gadget_to_dummy_hcd(g);
>         struct dummy            *dum = dum_hcd->dum;
>
> -       if (driver->max_speed == USB_SPEED_UNKNOWN)
> +       switch (driver->max_speed) {
> +       /* All the speeds we support */
> +       case USB_SPEED_LOW:
> +       case USB_SPEED_FULL:
> +       case USB_SPEED_HIGH:
> +       case USB_SPEED_SUPER:
> +               break;
> +       default:
> +               dev_err(dummy_dev(dum_hcd), "bogus driver max_speed %d\n",
> +                               driver->max_speed);
>                 return -EINVAL;
> +       }
>
>         /*
>          * SLAVE side init ... the layer above hardware, which
> @@ -1785,7 +1795,8 @@ static void dummy_timer(struct timer_lis
>                 total = 490000;
>                 break;
>         default:
> -               dev_err(dummy_dev(dum_hcd), "bogus device speed\n");
> +               dev_err(dummy_dev(dum_hcd), "bogus device speed %d\n",
> +                               dum->gadget.speed);
>                 return;
>         }
>
>
>
