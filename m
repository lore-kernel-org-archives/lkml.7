Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B90C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CD22082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="frxcaUEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfDDQD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:03:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36150 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfDDQD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:03:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id r24so2596267ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 09:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HqHuBNqXJz8dExEJM+QbA88JQIeFhoAKhDD+verad6s=;
        b=frxcaUEYxz2yMLaObMiy3j775o8HVkMqRyT3iSOyvvXWNK9vin1qaAMA54D1E7Oq7w
         vQuiCITf2BcL4cSkDjuYejJGgrHCv1FduiZELTdk28D3LNORwiDNTFRDqIXLMUFAI1Hm
         pvlMUvHVkCkdooez0WvjRZy6LszhpuBNkuM9y6fT8vwENNM9kqTdBBZ5H2sc0LxI8zrd
         gESHlfcjkZwLOPW2YprQrle1g2Hi7r299ziXtPuqaiIuMXNkE+L4AcqmVPgEVUQ5/SQe
         PrP2fI/baxOdZauQQwfyFpiseG1o3IEq+4Go1eRw5Cy3xAZZgRTDunIoe19DF4k4AyCc
         PPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HqHuBNqXJz8dExEJM+QbA88JQIeFhoAKhDD+verad6s=;
        b=Zi4iW8ZV4usDOnY75sljcbXTq9Iq/uo5TdAgnXhq2PYpEMMCRQsRXp9+BSmjmhmWy7
         tMYDyxBlgGrGQp9X0sytCu5RqD0PiE4szV51lrq/tNJ9ttf6V1Hbs4dMCfuCcD0JKL3t
         nOZ2xtLPJrax+EJYZ4z/HPWdZdHIs6jvxuI4FLECBS/Myv5mgnPYGcuS1foSlSBvb2FI
         i+imhCdx68o4dXabKnm+E6ysj90xa5sGK9jRQ9iWxVcAlvtIn9JFkTbAfTU0bo+trryO
         z9cpCwir72NFfZSQGhb+5aOa3MO2Cyj+AtS3imQVvWMXdnhc7p+cfwtv34tsUbTN4M5Q
         fJRA==
X-Gm-Message-State: APjAAAU1GExmzUqidvjOc9yAZj6d/MmKeAWk5sOYFuKAZj4pyNS8UvcD
        QRqzZpC0fcj90DweW3U0VrIlqLrLCXKEGKTo2OmmVA==
X-Google-Smtp-Source: APXvYqxpetcYW617va6pk1+hZtHOmdiiKxoqP1ajrT+cGlvFEdaL/z59mpxLc6GYwHX62OVi23z2IWDbw9X6W44S5zg=
X-Received: by 2002:a2e:9d12:: with SMTP id t18mr3845515lji.163.1554393834981;
 Thu, 04 Apr 2019 09:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <1553135724-38331-1-git-send-email-zhuchangchun@cvte.com>
 <20190321084420.GG3622@lahna.fi.intel.com> <20190321092330.GK9224@smile.fi.intel.com>
 <140c6ec0-7c11-6aa9-8434-f14d77be9a8c@metux.net> <CACRpkdZ1xPJ=NS=o=-PYqCO4d-VVZM1=f=xBZa5Dwx78LFPYtA@mail.gmail.com>
 <cb643914-2c3f-0c63-13e4-8171fa9a37e7@metux.net>
In-Reply-To: <cb643914-2c3f-0c63-13e4-8171fa9a37e7@metux.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Apr 2019 23:03:42 +0700
Message-ID: <CACRpkdYNN1Zyhw5+4=R68SQNMe_ZVWPD49afF3xEN-v39aikKw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: intel: Implements gpio free function
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        zhuchangchun <zhuchangchun@cvte.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hendychu@aliyun.com,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 5:51 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
> On 03.04.19 06:13, Linus Walleij wrote:
>
> > But the chardev on the other hand will protect you from all this.
> > If the program crashes, the lines will be free:ed.
> > If two scripts try to access the same GPIO, they will be denied.

> Right, when you want this concurrency protection and cleanup stiff
> the chardev is the better choice. But I've already had several cases
> where the simplicity of the sysfs interface is a big win - all you need
> few trivial fs operations.

It is admittedly a tradeoff. But if we want something that is hacky
and dangerous it should be moved over to debugfs not sitting
around in sysfs. In debugfs we give users enough rope all the
time.

> Another interesting usecase is permission handling:
>
> a) some ioctls need special privileges (oh, how I hate all these "if
>    (!capable(CAP_SYS_ADMIN)) ..." lines in the drivers), but you wanna
>    give some unprivileged user access to them
> b) you wanna give an unprivileged user access to specific gpio's,
>    but not to all at once.
>
> With pure filesystem based approach, you can easly define permissions
> for each filesystem object.

This was a comment when we designed the chardev as well, but
noone really could give a good usecase for this. Often GPIOs they
want to protect should not have been made available to userspace
or anyone else in the first place and we now have ways inside
the kernel to take GPIOs aside (valid_mask) we can also use
hogs (at least in the device tree) to set up GPIOs so that they are
held perpetually by the kernel (until reboot) so that userspace
cannot try to use them.

I can't see that any more access control granularity than the
whole gpiochip chardev is really used, not anymore than
you want to have access control on every indidual pixel on
a framebuffer or each individual block on a block device.

Things like requesting and flipping several GPIOs at once
could become explosively complex to implement with
individual access permissions on each GPIO line, and this
is on the other hand a very real and important use case.

Yours,
Linus Walleij
