Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F74C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DFB2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfDDAOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:14:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38971 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfDDAOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:14:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id m13so413077lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jsAdlS1nyk/IS3iZ4UY8wJIltrKe6lJEVq6hJlFMKY8=;
        b=HtPrKJhSmsE1V9G42Lr9YWZiRm1dnYKS8hh+qhN077L6JVTtrx/KqkJvHgJiZ0kf+g
         7Qv6uTV+tMv9YGsgfnY3ARfUdOIwN/LtQYuZHy+FFAVzDG6wL91Y3wxBE/gov3L3Hi+R
         bv3RgEY30pHkA9OMtJY4nO82micjGxhczvgFaSl4U7ZvLTdj/w0g48qzIMxPmftelWBZ
         Dn5aztvM/2y8OrCwxJ37XZSxVuXfMM8CMFR0ZWg6u+g6+mV29J2ozjEpoDJcRMfKwwNX
         JCOPV0BEjIr3BF0L/0bf0Eya+M0OW8qmTXwXBUz150Z8nSpT6DL5bPkI14rdsNjwikwU
         PJOw==
X-Gm-Message-State: APjAAAUQKcEpPVEW0mNm3Cxd6bMqWYOCR6087nqWFXDsUDN95Eh6pDpr
        X0hngaJE+fNU7mnhrGI0JuWj0E3I8LAAgSU6UJWMdQ==
X-Google-Smtp-Source: APXvYqzci+3Q7xZuTbozP8hwW8C0qkpCGnkrSL5oDiV2btPU393JwPGyD5eThIaEX3cOQriRNgwR3jGFVcSYyGeN3TU=
X-Received: by 2002:ac2:4551:: with SMTP id j17mr1309759lfm.141.1554336845554;
 Wed, 03 Apr 2019 17:14:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190328130306.25384-1-mcroce@redhat.com> <CAGXu5jLnu3-Gxb-4Gv8vtA9B3o582tX0GiOfug_wRZ78RDaW=g@mail.gmail.com>
In-Reply-To: <CAGXu5jLnu3-Gxb-4Gv8vtA9B3o582tX0GiOfug_wRZ78RDaW=g@mail.gmail.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Thu, 4 Apr 2019 02:13:29 +0200
Message-ID: <CAGnkfhxJncMO6QwQjQeD_3SzYFr-Gw4q1u=Pkbnz17-e0UWpTw@mail.gmail.com>
Subject: Re: [PATCH] kernel/sysctl.c: fix out of bounds access in fs.file-max
To:     Kees Cook <keescook@chromium.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 7:41 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Mar 28, 2019 at 6:03 AM Matteo Croce <mcroce@redhat.com> wrote:
> >
> > fs.file-max sysctl uses proc_doulongvec_minmax() as proc handler, which
> > accesses *extra1 and *extra2 as unsigned long, but commit 32a5ad9c2285
> > ("sysctl: handle overflow for file-max") assigns &zero, which is an int,
> > to extra1, generating the following KASAN report.
> > Fix this by changing 'zero' to long, which does not need to be duplicated
> > like 'one' and 'one_ul' for two data types.
> >
> > ==================================================================
> > BUG: KASAN: global-out-of-bounds in __do_proc_doulongvec_minmax+0x2f9/0x600
> > Read of size 8 at addr ffffffff8233dc20 by task systemd/1
> >
> > CPU: 0 PID: 1 Comm: systemd Not tainted 5.1.0-rc2-kvm+ #22
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/2014
> > Call Trace:
> >  print_address_description+0x67/0x23d
> >  kasan_report.cold.3+0x1c/0x36
> >  __do_proc_doulongvec_minmax+0x2f9/0x600
> >  proc_doulongvec_minmax+0x3a/0x50
> >  proc_sys_call_handler+0x11d/0x170
> >  vfs_write+0xd7/0x200
> >  ksys_write+0x93/0x110
> >  do_syscall_64+0x57/0x140
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > RIP: 0033:0x7f67d33e8804
> > Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 48 8d 05 f9 5e 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89 f5 53
> > RSP: 002b:00007fffd9992ed8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f67d33e8804
> > RDX: 0000000000000015 RSI: 00005586ce2607b0 RDI: 0000000000000004
> > RBP: 00007fffd9992f30 R08: 000000000000c0c0 R09: ffffffffffff0000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
> > R13: 0000000000000015 R14: 00005586ce2607c4 R15: 00007fffd9992f70
> >
> > The buggy address belongs to the variable:
> >  0xffffffff8233dc20
> >
> > Memory state around the buggy address:
> >  ffffffff8233db00: 00 00 00 00 00 00 00 00 fa fa fa fa 04 fa fa fa
> >  ffffffff8233db80: fa fa fa fa 04 fa fa fa fa fa fa fa 04 fa fa fa
> > >ffffffff8233dc00: fa fa fa fa 04 fa fa fa fa fa fa fa 00 00 00 00
> >                                ^
> >  ffffffff8233dc80: fa fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
> >  ffffffff8233dd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ==================================================================
> >
> > Fixes: 32a5ad9c2285 ("sysctl: handle overflow for file-max")
> > Signed-off-by: Matteo Croce <mcroce@redhat.com>
> > ---
> >  kernel/sysctl.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index e5da394d1ca3..3e959d67d619 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -124,7 +124,7 @@ static int sixty = 60;
> >
> >  static int __maybe_unused neg_one = -1;
> >
> > -static int zero;
> > +static long zero;
> >  static int __maybe_unused one = 1;
> >  static int __maybe_unused two = 2;
> >  static int __maybe_unused four = 4;
>
> This seems okay to me; thanks for the fix! (I think it's fine to keep
> this merged instead of a distinct long_zero, as long as we're not
> seeing type warnings during the build.)
>
> Acked-by: Kees Cook <keescook@chromium.org>
>
> -Kees
>
> --
> Kees Cook

No warnings with gcc version 8.3.1 20190223

  CC      kernel/sysctl.o
  AR      kernel/built-in.a
...

-- 
Matteo Croce
per aspera ad upstream
