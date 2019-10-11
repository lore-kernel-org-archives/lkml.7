Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6798CECE597
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E33206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jGbJQ5JM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfJKLvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:51:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46350 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbfJKLvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:51:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id o18so11545413wrv.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 04:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kodoLoyPrKRnVAF+K+EdOTtW7yGJ3QkaMW1QSIvhoF0=;
        b=jGbJQ5JMqNq8n2Maht6D+4YbnqkUTKgpChRW0VgtygxZ5Vi2/uo3cM/jodo2JKSxGE
         PCozf/Cr4DlbczByFjrow+g0c6LBsYXk93zMLCVE8Shl+/U3nDf74dCYDar4WYVyednQ
         JOlLW6sFTVF9xFiD/v/Djp6E1oG1wniynomgyTWBVPolp94ggS3BNKCb+XlRU2kaLvTo
         Kk87dNDMdxbP5uHhIpa4Vh7EctvMgr+kr9vwyuk2aFZTJUdi/4K+0gDgS+Gzq7/4/hNX
         evInzJ9b0BFxVhaukUkam6IIkEo5Vwka8ruoo+kqPXvo7zzjSRg1FGgC3eiDWkTyYGqi
         /63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kodoLoyPrKRnVAF+K+EdOTtW7yGJ3QkaMW1QSIvhoF0=;
        b=lWEDC3KBIHKPoeRiy2SF0LVKvQtgBnv8k918p8hJwx57WlV6nV4SCe/hevAmMlJqEr
         GYqFP/tQC6uaCEgNcQFD2OFu7wSasxAW2SSyEeG0sThx3sEemYAi/XjJvr/uplAojYJE
         NpoiYQzJEP39tRRmi7uC/NwTBbFjWer2mJ4OvqjnskzFOfRfByIKYkxEgICtmDH4zZeZ
         bdWE3C7yVdKbTd/DM3u+KFZiYoflCtuylOYgRVn9c2zkgiFAZNemd1R3Ytxn0yTddLWp
         J06p308l6EbQkmopCb1OiFHFbU7V0705rxbzKFxodMeDKpy+Tk+G6UKi/BoQOSMqyL/y
         bT1w==
X-Gm-Message-State: APjAAAV7UFj3+/2oKr4YwKJVuQCSSxxeorVNxjDeZAQCgtrCGYaNNPS+
        zrFdT5qq9ynKtnjR/0+r0Uczd5Gf+05Ia2X41Pkf17BviYUPTA==
X-Google-Smtp-Source: APXvYqxXLXYceWRVQghxCNJD0DAXY2PJ4HKrMEkj4VUYjozp4rA/GfJ6cV2QjV+pUcYyiKzcDgwgUQu+Axfy520GlHI=
X-Received: by 2002:a5d:5142:: with SMTP id u2mr12967653wrt.221.1570794708517;
 Fri, 11 Oct 2019 04:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007d25ff059457342d@google.com> <b8b1e4fef9f3ece63909c38b3302621d76770caa.camel@gmail.com>
In-Reply-To: <b8b1e4fef9f3ece63909c38b3302621d76770caa.camel@gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 11 Oct 2019 13:51:37 +0200
Message-ID: <CAG_fn=WsN0d8VO6=4jtDP9rHqBMp0zBvJQ7qrvQhZkkaj6NNsg@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in alauda_check_media
To:     Jaskaran Singh <jaskaransingh7654321@gmail.com>
Cc:     syzbot <syzbot+e7d46eb426883fb97efd@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        usb-storage@lists.one-eyed-alien.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 1:23 PM Jaskaran Singh
<jaskaransingh7654321@gmail.com> wrote:
>
> On Mon, 2019-10-07 at 12:39 -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    1e76a3e5 kmsan: replace __GFP_NO_KMSAN_SHADOW with
> > kmsan_i..
> > git tree:       https://github.com/google/kmsan.git master
> > console output:
> > https://syzkaller.appspot.com/x/log.txt?x=3D1204cc63600000
> > kernel config:
> > https://syzkaller.appspot.com/x/.config?x=3Df03c659d0830ab8d
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=3De7d46eb426883fb97efd
> > compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> > 80fee25776c2fb61e74c1ecb1a523375c2500b69)
> > syz repro:
> > https://syzkaller.appspot.com/x/repro.syz?x=3D123c860d600000
> > C reproducer:
> > https://syzkaller.appspot.com/x/repro.c?x=3D110631b7600000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the
> > commit:
> > Reported-by: syzbot+e7d46eb426883fb97efd@syzkaller.appspotmail.com
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > BUG: KMSAN: uninit-value in alauda_transport+0x462/0x57f0
> > drivers/usb/storage/alauda.c:1137
> > CPU: 0 PID: 12279 Comm: usb-storage Not tainted 5.3.0-rc7+ #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine,
> > BIOS
> > Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0x191/0x1f0 lib/dump_stack.c:113
> >   kmsan_report+0x13a/0x2b0 mm/kmsan/kmsan_report.c:108
> >   __msan_warning+0x73/0xe0 mm/kmsan/kmsan_instr.c:250
> >   alauda_check_media+0x344/0x3310 drivers/usb/storage/alauda.c:460
> >   alauda_transport+0x462/0x57f0 drivers/usb/storage/alauda.c:1137
> >   usb_stor_invoke_transport+0xf5/0x27e0
> > drivers/usb/storage/transport.c:606
> >   usb_stor_transparent_scsi_command+0x5d/0x70
> > drivers/usb/storage/protocol.c:108
> >   usb_stor_control_thread+0xca6/0x11a0 drivers/usb/storage/usb.c:380
> >   kthread+0x4b5/0x4f0 kernel/kthread.c:256
> >   ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355
> >
> > Local variable description: ----status@alauda_check_media
> > Variable was created at:
> >   alauda_check_media+0x8e/0x3310 drivers/usb/storage/alauda.c:454
> >   alauda_transport+0x462/0x57f0 drivers/usb/storage/alauda.c:1137
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > Kernel panic - not syncing: panic_on_warn set ...
> > CPU: 0 PID: 12279 Comm: usb-storage Tainted:
> > G    B             5.3.0-rc7+
> > #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine,
> > BIOS
> > Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0x191/0x1f0 lib/dump_stack.c:113
> >   panic+0x3c9/0xc1e kernel/panic.c:219
> >   kmsan_report+0x2a2/0x2b0 mm/kmsan/kmsan_report.c:131
> >   __msan_warning+0x73/0xe0 mm/kmsan/kmsan_instr.c:250
> >   alauda_check_media+0x344/0x3310 drivers/usb/storage/alauda.c:460
> >   alauda_transport+0x462/0x57f0 drivers/usb/storage/alauda.c:1137
> >   usb_stor_invoke_transport+0xf5/0x27e0
> > drivers/usb/storage/transport.c:606
> >   usb_stor_transparent_scsi_command+0x5d/0x70
> > drivers/usb/storage/protocol.c:108
> >   usb_stor_control_thread+0xca6/0x11a0 drivers/usb/storage/usb.c:380
> >   kthread+0x4b5/0x4f0 kernel/kthread.c:256
> >   ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355
> > Kernel Offset: disabled
> > Rebooting in 86400 seconds..
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > syzbot can test patches for this bug, for details see:
> > https://goo.gl/tpsmEJ#testing-patches
>
> #syz test: https://github.com/google/kmsan.git 1e76a3e5
This didn't work, let's try with the master:
#syz test: https://github.com/google/kmsan.git master

>
> diff --git a/drivers/usb/storage/alauda.c
> b/drivers/usb/storage/alauda.c
> index ddab2cd3d2e7..bb309b9ad65b 100644
> --- a/drivers/usb/storage/alauda.c
> +++ b/drivers/usb/storage/alauda.c
> @@ -452,7 +452,7 @@ static int alauda_init_media(struct us_data *us)
>  static int alauda_check_media(struct us_data *us)
>  {
>         struct alauda_info *info =3D (struct alauda_info *) us->extra;
> -       unsigned char status[2];
> +       unsigned char *status =3D us->iobuf;
>         int rc;
>
>         rc =3D alauda_get_media_status(us, status);
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/b8b1e4fef9f3ece63909c38b3302621d76770caa.camel%40gmail.com=
.



--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
