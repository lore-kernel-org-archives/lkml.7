Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD85C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FAB20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfRQwrdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbfDPXQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:16:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39833 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfDPXQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:16:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id a96so11065250pla.6;
        Tue, 16 Apr 2019 16:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SJrdIOnMZscAX3/lUO7sU8M0Yhf+BeHX0BuUUJgATp4=;
        b=FfRQwrdQnaM0FXPdkha6ruAJA2Vv0gqqHk8SCEtsf0Z3m5+fSOvlfcmzTam5quIfTw
         DILB7M+Fs7Sr64MnSSmkeTJZXL8rcHl2iFAayFzLTToEQiSy3a7LKzzHG4dEP9iZAE3Q
         kBp2MmuzbAAOOq6WaN9pVhAfHOjrpWxZqVFHzqPK1Arj8RwUzxOGJ5DdxoxXrjl3vRO3
         22dTaKWaQiwzqIfgPtQBDOXTmuVEMzfQqTdmr2i2sVLr52j0hln7Iy2AyRUHJ09hDUR6
         GaNSMjrETd6anOT6BW4U0IJ3HSogJU1yb/j0ctJFVgjXnw+nGirD0ll27KKOhJPiZTYC
         tOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SJrdIOnMZscAX3/lUO7sU8M0Yhf+BeHX0BuUUJgATp4=;
        b=WELsBKT/Qdcumxau7+pJ+Tx1JT3IpcbPxpY1j2Irt8ExmrP/IXIRbh8NRREBjrUZ7O
         p0mmKSCV59h52Fd6UL13SNbwNVN5bUry1cq5k2qFYdaTBb2j98ZnCLlFfUcM6eh87wGw
         gaVHGSRkzx6KWCgr8AJhopUzLDfHa1OSh28OnNxp1GjVPmDfjxr6xpRUfbQuUgXwLPe4
         r26Y3kRh42JqnJpd9biZrlR8lqrcjkm3vr5EoOBuqsq4P7IfxL35xTQoGBwPDD0U2uD3
         m73s6asU4iQQVSgMyGhsnpHfpAzq1DWNe+Gw8d9gpt/lY5x3YOp0Jc9PZHha3ip5RIbu
         V9nQ==
X-Gm-Message-State: APjAAAXMznaDwjfgs5qS17fD7tIUCm+At2SoN+NDjmIS1ZhUBeSmIAm/
        FGoEw9WM8ULY/yvkQqdZwtinvWLocxCBjhKplrE2UWZc
X-Google-Smtp-Source: APXvYqx0nrC7rPCkGRTUFuYDfHJ0Whe745e75S26fT/nd1jMODEQF5PZ81sQg6puaH4+Ve5LW/aPvKtJa+G3eUdRRBE=
X-Received: by 2002:a17:902:9a89:: with SMTP id w9mr86279265plp.126.1555456580630;
 Tue, 16 Apr 2019 16:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190416213351.28999-1-xiyou.wangcong@gmail.com> <20190416214634.GP31772@zn.tnic>
In-Reply-To: <20190416214634.GP31772@zn.tnic>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 16 Apr 2019 16:16:08 -0700
Message-ID: <CAM_iQpVd02zkVJ846cj-Fg1yUNuz6tY5q1Vpj4LrXmE06dPYYg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ras: fix an off-by-one error in __find_elem()
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 2:46 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Apr 16, 2019 at 02:33:50PM -0700, Cong Wang wrote:
> > ce_arr.array[] is always within the range [0, ce_arr.n-1].
> > However, the binary search code in __find_elem() uses ce_arr.n
> > as the maximum index, which could lead to an off-by-one
> > out-of-bound access right after the while loop. In this case,
> > we should not even read it, just return -ENOKEY instead.
> >
> > Note, this could cause a kernel crash if ce_arr.n is exactly
> > MAX_ELEMS.
>
> "Could cause"?
>
> I'm still waiting for a demonstration. You can build a case through
> writing values in the debugfs nodes I pointed you at or even with a
> patch ontop preparing the exact conditions for it to crash. And then
> give me that "recipe" to trigger it here in a VM.

It is actually fairly easy:

1) Fill the whole page with PFN's:
for i in `seq 0 511`; do echo $i >> /sys/kernel/debug/ras/cec/pfn; done

2) Set thresh to 1 in order to trigger the deletion:
echo 1 > /sys/kernel/debug/ras/cec/count_threshold

3) Repeatedly add and remove the last element:
echo 512 >> /sys/kernel/debug/ras/cec/pfn
(until you get a crash.)

In case you still don't get it, here it is:

[   57.732593] BUG: unable to handle kernel paging request at ffff9c667bca0000
[   57.734994] #PF error: [PROT] [WRITE]
[   57.735891] PGD 75601067 P4D 75601067 PUD 75605067 PMD 7bca1063 PTE
800000007bca0061
[   57.737702] Oops: 0003 [#1] SMP PTI
[   57.738533] CPU: 0 PID: 649 Comm: bash Not tainted 5.1.0-rc5+ #561
[   57.739965] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29
04/01/2014
[   57.742892] RIP: 0010:__memmove+0x57/0x1a0
[   57.743853] Code: 00 72 05 40 38 fe 74 3b 48 83 ea 20 48 83 ea 20
4c 8b 1e 4c 8b 56 08 4c 8b 4e 10 4c 8b 46 18 48 8d 76 20 4c 89 1f 4c
89 57 08 <4c> 89 4f 10 4c 89 47 18 48 8d 7f 20 73 d4 48 83 c2 20 e9 a2
00 00
[   57.748150] RSP: 0018:ffffbe2ec0c8bdf8 EFLAGS: 00010206
[   57.749371] RAX: ffff9c667a5c1ff0 RBX: 0000000000000001 RCX: 0000000000000ff8
[   57.751018] RDX: 00000007fe921fb8 RSI: ffff9c667bca0018 RDI: ffff9c667bc9fff0
[   57.752674] RBP: 0000000000000200 R08: 0000000000000000 R09: 0000015c00000000
[   57.754325] R10: 0000000000040001 R11: 5a5a5a5a5a5a5a5a R12: 0000000000000004
[   57.755976] R13: ffff9c6671787778 R14: ffff9c6671787728 R15: ffff9c6671787750
[   57.757631] FS:  00007f33ca294740(0000) GS:ffff9c667d800000(0000)
knlGS:0000000000000000
[   57.759689] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   57.761023] CR2: ffff9c667bca0000 CR3: 000000007061e000 CR4: 00000000000406f0
[   57.762681] Call Trace:
[   57.763275]  del_elem.constprop.1+0x39/0x40
[   57.764260]  cec_add_elem+0x1e4/0x211
[   57.765129]  simple_attr_write+0xa2/0xc3
[   57.766057]  debugfs_attr_write+0x45/0x5c
[   57.767005]  full_proxy_write+0x4b/0x65
[   57.767911]  ? full_proxy_poll+0x50/0x50
[   57.768844]  vfs_write+0xb8/0xf5
[   57.769613]  ksys_write+0x6b/0xb8
[   57.770407]  do_syscall_64+0x57/0x65
[   57.771249]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

I will leave it as a homework for explaining why the crash is inside
memmove(). ;)

Thanks.
