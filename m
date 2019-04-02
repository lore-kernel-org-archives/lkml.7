Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70784C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 323212148E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 03:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wRI1x3ju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfDBDZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 23:25:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55225 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfDBDZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 23:25:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id c1so1589730wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 20:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EaDH5mVy9H1IxC+aXukrSGRQ2xbXyuvs0kvOzLPC9L4=;
        b=wRI1x3jufsb+0onlkhKrWJMepUX/FbpL82t/AvaWv1SWCY2Ez0jCQ2m8cK+JNjrV83
         rSP/FRHM3RUrtq3sav4LasUfmHhGAbyFdfjxWHes8y8MRf6a2JMyyfb4mX0kaBpZCsXV
         QEYtqWae/peRNgdT9bS9n0gkz9pqHXjWO5NDkbJaN37McLS53QTdr+jav6EOMMIJO6Rb
         HudZS+xja9pRzOJ6lOldSNpBBPBTnTAQtgcWQXgaggi2g4SX9HnOAwx3iIs/Fl6bwnJz
         P13I9Vdc1t+S3kwfIuhkX62fHZ7jWTCQ6m4rjQav7bZOaWmeWIivMGyg8uLK6yk6XY37
         c9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EaDH5mVy9H1IxC+aXukrSGRQ2xbXyuvs0kvOzLPC9L4=;
        b=hGXZ0I2rAqU+7Dba/aaqwh9VFFUJE/69p/86sG8xql3xvAf7FxmYWwkuhn2sipLBoa
         5KfXGPll/SymGULRzNgI12b6j6S+Wpt9V3LMJPLwcO29wiQb2KVHYMLSvVd19f5byDZ9
         a7Usw0FcKeixcyThE6MZPR6590KKhMuGPNwkUYu/hkyCDpRhr9LstabqbP33yKoUgw+q
         DSiEm+1wtOtqrQz6V0gHbhzfHWYLyatjMmRtPmiErYiNsdsY4s4vd+goxIjJL/OzecoX
         ZeM0smq8tKBju2FIs+xnc88TFXz8hJ4Dv0K2WlApg46hsxEjEzqXk3rhttq6YzCZVuvo
         bDIg==
X-Gm-Message-State: APjAAAXn/3iWeviTiPnCOct+ko4/3M9/LrX3gWO7zEoI55vfAl4jjJ+C
        R1YdHeP0q4nbS9lPa4ECeJJ+jKUoo+ubWRU+WQR+ng==
X-Google-Smtp-Source: APXvYqyBtNJfU8/VZFyrIPkbdGIkWfv8PXJ+K8Uo25nadDdV8BaOwau+LyxRlvHh4JvDA4VGRvT3BNOSzXS0C8Gp/gw=
X-Received: by 2002:a7b:c00e:: with SMTP id c14mr1319807wmb.110.1554175519436;
 Mon, 01 Apr 2019 20:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <1553059940-127038-1-git-send-email-fei.yang@intel.com>
In-Reply-To: <1553059940-127038-1-git-send-email-fei.yang@intel.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 2 Apr 2019 10:25:06 +0700
Message-ID: <CALAqxLWJj2RxXejETpj_Ytk6vhgQc7UKRjjX80UyoSGsiMqZnQ@mail.gmail.com>
Subject: Re: [PATCH V2] usb: gadget: f_fs: don't free buffer prematurely
To:     "Yang, Fei" <fei.yang@intel.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jerry Zhang <zhangjerry@google.com>, andrzej.p@collabora.com,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Shen Jing <jingx.shen@intel.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 12:32 PM <fei.yang@intel.com> wrote:
>
> From: Fei Yang <fei.yang@intel.com>
>
> The following kernel panic happens due to the io_data buffer gets dealloc=
ated
> before the async io is completed. Add a check for the case where io_data =
buffer
> should be deallocated by ffs_user_copy_worker.
>
> [   41.663334] BUG: unable to handle kernel NULL pointer dereference at 0=
000000000000048
> [   41.672099] #PF error: [normal kernel read fault]
> [   41.677356] PGD 20c974067 P4D 20c974067 PUD 20c973067 PMD 0
> [   41.683687] Oops: 0000 [#1] PREEMPT SMP
> [   41.687976] CPU: 1 PID: 7 Comm: kworker/u8:0 Tainted: G     U         =
   5.0.0-quilt-2e5dc0ac-00790-gd8c79f2-dirty #2
> [   41.705309] Workqueue: adb ffs_user_copy_worker
> [   41.705316] RIP: 0010:__vunmap+0x2a/0xc0
> [   41.705318] Code: 0f 1f 44 00 00 48 85 ff 0f 84 87 00 00 00 55 f7 c7 f=
f 0f 00 00 48 89 e5 41 55 41 89 f5 41 54 53 48 89 fb 75 71 e8 56 d7 ff ff <=
4c> 8b 60 48 4d 85 e4 74 76 48 89 df e8 25 ff ff ff 45 85 ed 74 46
> [   41.705320] RSP: 0018:ffffbc3a40053df0 EFLAGS: 00010286
> [   41.705322] RAX: 0000000000000000 RBX: ffffbc3a406f1000 RCX: 000000000=
0000000
> [   41.705323] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 00000000f=
fffffff
> [   41.705324] RBP: ffffbc3a40053e08 R08: 000000000001fb79 R09: 000000000=
0000037
> [   41.705325] R10: ffffbc3a40053b68 R11: ffffbc3a40053cad R12: fffffffff=
ffffff2
> [   41.705326] R13: 0000000000000001 R14: 0000000000000000 R15: fffffffff=
fffffff
> [   41.705328] FS:  0000000000000000(0000) GS:ffff9e2977a80000(0000) knlG=
S:0000000000000000
> [   41.705329] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   41.705330] CR2: 0000000000000048 CR3: 000000020c994000 CR4: 000000000=
03406e0
> [   41.705331] Call Trace:
> [   41.705338]  vfree+0x50/0xb0
> [   41.705341]  ffs_user_copy_worker+0xe9/0x1c0
> [   41.705344]  process_one_work+0x19f/0x3e0
> [   41.705348]  worker_thread+0x3f/0x3b0
> [   41.829766]  kthread+0x12b/0x150
> [   41.833371]  ? process_one_work+0x3e0/0x3e0
> [   41.838045]  ? kthread_create_worker_on_cpu+0x70/0x70
> [   41.843695]  ret_from_fork+0x3a/0x50
> [   41.847689] Modules linked in: hci_uart bluetooth ecdh_generic rfkill_=
gpio dwc3_pci dwc3 snd_usb_audio mei_me tpm_crb snd_usbmidi_lib xhci_pci xh=
ci_hcd mei tpm snd_hwdep cfg80211 snd_soc_skl snd_soc_skl_ipc snd_soc_sst_i=
pc snd_soc_sst_dsp snd_hda_ext_core snd_hda_core videobuf2_dma_sg crlmodule
> [   41.876880] CR2: 0000000000000048
> [   41.880584] ---[ end trace 2bc4addff0f2e673 ]---
> [   41.891346] RIP: 0010:__vunmap+0x2a/0xc0
> [   41.895734] Code: 0f 1f 44 00 00 48 85 ff 0f 84 87 00 00 00 55 f7 c7 f=
f 0f 00 00 48 89 e5 41 55 41 89 f5 41 54 53 48 89 fb 75 71 e8 56 d7 ff ff <=
4c> 8b 60 48 4d 85 e4 74 76 48 89 df e8 25 ff ff ff 45 85 ed 74 46
> [   41.916740] RSP: 0018:ffffbc3a40053df0 EFLAGS: 00010286
> [   41.922583] RAX: 0000000000000000 RBX: ffffbc3a406f1000 RCX: 000000000=
0000000
> [   41.930563] RDX: 0000000000000001 RSI: 0000000000000001 RDI: 00000000f=
fffffff
> [   41.938540] RBP: ffffbc3a40053e08 R08: 000000000001fb79 R09: 000000000=
0000037
> [   41.946520] R10: ffffbc3a40053b68 R11: ffffbc3a40053cad R12: fffffffff=
ffffff2
> [   41.954502] R13: 0000000000000001 R14: 0000000000000000 R15: fffffffff=
fffffff
> [   41.962482] FS:  0000000000000000(0000) GS:ffff9e2977a80000(0000) knlG=
S:0000000000000000
> [   41.971536] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   41.977960] CR2: 0000000000000048 CR3: 000000020c994000 CR4: 000000000=
03406e0
> [   41.985930] Kernel panic - not syncing: Fatal exception
> [   41.991817] Kernel Offset: 0x16000000 from 0xffffffff81000000 (relocat=
ion range: 0xffffffff80000000-0xffffffffbfffffff)
> [   42.009525] Rebooting in 10 seconds..
> [   52.014376] ACPI MEMORY or I/O RESET_REG.
>
> Fixes: 772a7a724f6 ("usb: gadget: f_fs: Allow scatter-gather buffers")
> Signed-off-by: Fei Yang <fei.yang@intel.com>
> Reviewed-by: Manu Gautam <mgautam@codeaurora.org>
> Tested-by: John Stultz <john.stultz@linaro.org>
> ---
> V2: add tag: "Fixes: 772a7a724f6 ......", Reviewed-by and Tested-by.
>

Felipe:  Just wanted to follow up on this, as I've still not seen this
land in your tree. Is there any objection with this fix?

thanks
-john
