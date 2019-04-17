Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9DDC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0AA217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 22:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387512AbfDQWD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 18:03:26 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45320 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQWD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 18:03:26 -0400
Received: by mail-qt1-f195.google.com with SMTP id v20so50154qtv.12;
        Wed, 17 Apr 2019 15:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jWBI7z25tmPalgRnA1mUPI0omTSWsVtl9pzxEugUanI=;
        b=Br9SPSzRNpRN6aWn7cjbCNrfVaQgQYZw15In789pDb4Nf9uvJuVHeopcHPsdH675n9
         SUqgzD7SEolO4rpY/abQ5R9LBnFRSq9LQIXqHgGbkNxFzsryca8cEjiC7VpBEYRBlZ/+
         x37KXojn/+6WLIc/qApWXZIvxbG1WxhUkrfBUH6pD7BXZ8PiMmJYbVl34sPATR1Z+yxq
         P48E8pCiqH1LcV8vKXJXrdavF36qKJo8gFBbHEWyqUVR74sx60nzmFMTqEj8Cs8XCXWH
         b8LKV7m5b6CoIJ1+o/+5Sn8q2P4YPM1DrqtsNTv+zJ5xnQNlWmmmc5lFsRyqPoW2fS72
         1mPw==
X-Gm-Message-State: APjAAAUDEM/fBcC+KOTULowDGk50w2pf2Jh/OdjUGNlpmL6L1Pfit0fq
        dn5dkz7PXFts2InOQ4a++H+dlxKLldWgjT4/8/k=
X-Google-Smtp-Source: APXvYqxeY/RBIJPHkl3A7sKa+/Nn/h/ovikhvpWCFzKLwfs36UqBc5tJ9PSNsAP6M2TpW5osDDDQpsE9hhCIMch87aI=
X-Received: by 2002:ac8:1637:: with SMTP id p52mr70875184qtj.212.1555538604880;
 Wed, 17 Apr 2019 15:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190416202013.4034148-1-arnd@arndb.de> <20190416202013.4034148-3-arnd@arndb.de>
 <20190417211303.GU2217@ZenIV.linux.org.uk>
In-Reply-To: <20190417211303.GU2217@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 18 Apr 2019 00:03:07 +0200
Message-ID: <CAK8P3a1tiRew6uqegUXsKbNQG7=sPVFMY3yXf0M7OjJdkxM=_g@mail.gmail.com>
Subject: Re: [PATCH v3 02/26] compat_ioctl: move simple ppp command handling
 into driver
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Ostrowski <mostrows@earthlink.net>,
        Dmitry Kozlov <xeb@mail.ru>,
        James Chapman <jchapman@katalix.com>,
        linux-ppp@vger.kernel.org, Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 11:13 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Apr 16, 2019 at 10:19:40PM +0200, Arnd Bergmann wrote:
> > diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
> > index c708400fff4a..04252c3492ee 100644
> > --- a/drivers/net/ppp/ppp_generic.c
> > +++ b/drivers/net/ppp/ppp_generic.c
> > @@ -899,6 +899,7 @@ static const struct file_operations ppp_device_fops = {
> >       .write          = ppp_write,
> >       .poll           = ppp_poll,
> >       .unlocked_ioctl = ppp_ioctl,
> > +     .compat_ioctl   = ppp_ioctl,
>
> Oh?  What happens on e.g. s390 with something like PPPIOCNEWUNIT?
> Current kernel:
>         * no ->compat_ioctl()
>         * ->unlock_ioctl() is present
>         * found by compat_ioctl_check_table()
>         * pass (unsigned long)compat_ptr(arg) to do_vfs_ioctl()
>         * pass that to ppp_ioctl()
>         * pass that to ppp_unattached_ioctl()
>         * fetch int from (int __user *)compat_ptr(arg)
>
> With your patch:
>         * call ppp_ioctl()
>         * pass arg to ppp_unattached_ioctl()
>         * fetch int from (int __user *)arg
>
> AFAICS, that's broken...

Correct. I had added this patch to the series from an older set of
patches (predating
the compat_ptr_ioctl() series) , and did not check for this issue again. When
I originally created the patch, I assumed that even on s390 it would be no
problem.

> Looking at that ppp_ioctl(),
> pointer to arch-independent type or ignored:
>         PPPIOCNEWUNIT PPPIOCATTACH PPPIOCATTCHAN PPPIOCSMRU PPPIOCSFLAGS
>         PPPIOCGFLAGS PPPIOCGUNIT PPPIOCSDEBUG PPPIOCSMAXCID PPPIOCCONNECT
>         PPPIOCGDEBUG PPPIOCSMAXCID PPPIOCSMRRU
>         PPPIOCDETACH PPPIOCDISCONN
>         PPPIOCGASYNCMAP PPPIOCSASYNCMAP PPPIOCGRASYNCMAP PPPIOCSRASYNCMAP
>         PPPIOCGXASYNCMAP PPPIOCSXASYNCMAP
>         PPPIOCGNPMODE PPPIOCSNPMODE
> pointer to struct ppp_option_data (with further pointer-chasing in it):
>         PPPIOCSCOMPRESS
> pointer to struct ppp_idle:
>         PPPIOCGIDLE
> pointer to struct sock_filter (with hidden pointer-chasing, AFAICS):
>         PPPIOCSPASS PPPIOCSACTIVE
>
> Pretty much all of them take pointers.  What's more, reaction to
> unknown is -ENOTTY, not -ENOIOCTLCM, so that patch will have
> prevent the translated ones from reaching do_ioctl_trans()

Good point, this patch sequence does break bisection.

> What am I missing here?  Why not simply do
>
> compat_ppp_ioctl()
> {
>         PPPIOCSCOMPRESS32 => deal with it
>         PPPIOCGIDLE32 => deal with it
>         PPPIOCSPASS32 / PPPIOCSACTIVE32 => deal with it
>         default: pass compat_ptr(arg) to ppp_ioctl() and be done with that
> }
>
> with BPF-related bits (both compat and native) taken to e.g. net/core/bpf-ppp.c,
> picked by both generic and isdn?  IDGI...

I was trying to unify the native and compat code paths as much
as possible here. Handling the four PPPIO*32 commands in
compat_ppp_ioctl would either require duplicating large chunks
of ppp_ioctl, or keeping the extra compat_alloc_user_space()
copy from the existing implementation.

I'll try to come up with a different way to structure the patches.

      Arnd
