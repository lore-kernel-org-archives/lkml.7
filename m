Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39593C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0738022ADA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 13:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VE6f3B/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfGXNdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 09:33:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37990 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfGXNdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 09:33:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so20978386pfn.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 06:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J0GhZpS0srXIOnUiUqnG1RMs2asMr9aCIfA9MEV0O0k=;
        b=VE6f3B/j/Hloq91g34w7cU6EJwSi1nIsFo5cpqcKPB4wSjLqKtCjrk6xV/Qo+dRQOj
         ustHBXwbg8hQtIVMrjFZDuKIMOWob41/CDoTVSQR15xSnaEqk3DSfWoxxEkNXfSiEuNB
         79J9NqA3VyqEPRGuxPUzsUAWpzzgTU8YTkYQLsfl7Q8uCiez7HeRd9MLqvNP/n8gPFEE
         z9mztfOCLm560W8DqpGZgC7TS/+uLCZMQsTPil2XheMQfCvJpd3L4u4uKlER48iLnFao
         vcyF62OzJgmLEUHKUAchb1ImUpaGkLw4B7CoaK6xFUvEB+Zmup6CFM7xKaT7zTKO4liY
         awHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J0GhZpS0srXIOnUiUqnG1RMs2asMr9aCIfA9MEV0O0k=;
        b=r6oMkfn9I5mkpI7cBRpOLhtGQjfllWKgWlJJSfyc0WjkV/FWZhkVchciyFJKLEYt2w
         d9uJzM4E0g6StISc6HurZdWyHVXMzU3MLx6esUaqR8SmRNWmIcjdYDolYghCdRF2rlrv
         t8hSHpy5xpnbsCUwWrm8pvpVMkaLpsDdffg3CPEw21o2rdkKMWruDWtoUNfuhr1ZygIB
         Er/ro+zvRi92LLB4mU06dl7zZKx9JtFJc1wNzIn6Bzj5MvZ9NhaNSv/YIn5ms5XjJ5VB
         lI39yFAnQ+Fc/FLMqCpGvhRIYou4qW02CNLnFQC1JNFq4ZztdJvPK5iJ9/ZK6ouQltfA
         66Lg==
X-Gm-Message-State: APjAAAVFD/OG/lKRNE8xP5ZB2Q6fmBvFrTIFAan1x4TPtqLaiQQSEdHL
        biM3S5GbC05iFf7Lnl46gx13WwalHydrvh64rzZZrA==
X-Google-Smtp-Source: APXvYqyIpN5q5sz17jm2tXisdxSgvqQnfx2AqqarX+pX6yvcEDL6Esp3HraF93WgvRR0H/jzRHcEuZasgMbwifhPGjY=
X-Received: by 2002:a63:c442:: with SMTP id m2mr82713180pgg.286.1563975213181;
 Wed, 24 Jul 2019 06:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000acb99a058b0d5741@google.com> <000000000000ac8f77058e0d11e9@google.com>
 <CAAeHK+zT+VhrxPDNFxCoVDrgBhmTiAuRjQv_A6SC91x8w0HmoQ@mail.gmail.com> <s5hlfwn376e.wl-tiwai@suse.de>
In-Reply-To: <s5hlfwn376e.wl-tiwai@suse.de>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 24 Jul 2019 15:33:21 +0200
Message-ID: <CAAeHK+x_P3WHxMmgimSKrHwew_HCyi9a67Tw3qPu5TTESAhL3w@mail.gmail.com>
Subject: Re: WARNING in snd_usb_motu_microbookii_communicate/usb_submit_urb
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+d952e5e28f5fb7718d23@syzkaller.appspotmail.com>,
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

On Wed, Jul 24, 2019 at 3:15 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 23 Jul 2019 19:03:29 +0200,
> Andrey Konovalov wrote:
> >
> > (Takashi, with your helper check syzkaller now generates a new bug
> > report (not reported by syzbot yet due to breakage during kernel boot
> > on 5.3-rc1, so see below) and I guess this has to do with a missing ep
> > != NULL check).
> >
> > kasan: CONFIG_KASAN_INLINE enabled
> > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > general protection fault: 0000 [#1] SMP KASAN
> > CPU: 1 PID: 74 Comm: kworker/1:1 Not tainted 5.3.0-rc1+ #40
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > Workqueue: usb_hub_wq hub_event
> > RIP: 0010:snd_usb_pipe_sanity_check+0x80/0x130 sound/usb/helper.c:75
> > Code: 48 c1 ea 03 80 3c 02 00 0f 85 b3 00 00 00 48 8b 6d 00 c1 eb 1e
> > 48 b8 00 00 00 00 00 fc ff df 48 8d 7d 03 48 89 fa 48 c1 ea 03 <0f> b6
> > 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 7b 48 b8 00 00
> > RSP: 0018:ffff88806c33f0a8 EFLAGS: 00010246
> > RAX: dffffc0000000000 RBX: 0000000000000001 RCX: ffffffff833819c2
> > RDX: 0000000000000000 RSI: ffffffff833819dc RDI: 0000000000000003
> > RBP: 0000000000000000 R08: ffff88806c330000 R09: fffffbfff0d1a792
> > R10: fffffbfff0d1a791 R11: ffffffff868d3c8f R12: 0000000000000000
> > R13: dffffc0000000000 R14: ffff88806975cc80 R15: ffff88806975c4a0
> > FS:  0000000000000000(0000) GS:ffff88806d100000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007fcc3a48c000 CR3: 000000006861c003 CR4: 0000000000160ee0
> > Call Trace:
> >  snd_usb_accessmusic_boot_quirk sound/usb/quirks.c:835 [inline]
> >  snd_usb_apply_boot_quirk+0xa19/0xc60 sound/usb/quirks.c:1267
> >  usb_audio_probe+0x2ec/0x1f40 sound/usb/card.c:576
> (snip)
>
> So it's a NULL pointer returned from usb_pipe_endpoint() with an
> invalid pipe.  The fix patch is attached below.

Thanks for the fix! Do you think it makes sense to reuse the already
existing usb_urb_ep_type_check() function instead of
snd_usb_pipe_sanity_check() as Hillf suggested? They seem to be doing
essentially the same thing.

>
>
> thanks,
>
> Takashi
>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: usb-audio: Fix NULL dereference at pipe sanity check
>
> The newly introduced helper for a sanity check of a pipe causes an
> Oops due to the NULL pointer returned from usb_pipe_endpoint() with an
> invalid pipe.  Let's fix it.
>
> Fixes: 801ebf1043ae ("ALSA: usb-audio: Sanity checks for each pipe and EP types")
> Reported-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/usb/helper.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/usb/helper.c b/sound/usb/helper.c
> index 71d5f540334a..919d69e0aba3 100644
> --- a/sound/usb/helper.c
> +++ b/sound/usb/helper.c
> @@ -72,6 +72,8 @@ int snd_usb_pipe_sanity_check(struct usb_device *dev, unsigned int pipe)
>         struct usb_host_endpoint *ep;
>
>         ep = usb_pipe_endpoint(dev, pipe);
> +       if (!ep)
> +               return -EINVAL;
>         if (usb_pipetype(pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
>                 return -EINVAL;
>         return 0;
> --
> 2.16.4
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/s5hlfwn376e.wl-tiwai%40suse.de.
