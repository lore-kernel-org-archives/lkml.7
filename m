Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4A2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5446420835
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fBLCTT+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfCTAJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:09:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33191 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfCTAJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 20:09:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id z6so5653949wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xvfv2m5HhdtAxqfOGPn85TVTEjKOkALU502AwFzYvsc=;
        b=fBLCTT+KcaOCkHkRw4yaU5lNY05lpDc5a3zpaDFF7fEE/FPQJnLVJNe9PZ+Yof2kIV
         bLka4yqPIvkPLv+0YGifbpccvOhdTraMXjTRi6q4NuS/y24KaUH6vgUjlVTyGjPf9g4p
         wQCvgdYriXDCubvBI1B5Yah1r6+DUSLXVh7FOomuGWHzvBRM0R+czA5ucDuz2kZuy+FR
         asWsmUXuWtpS0f9mziQS7/DTmSz/ksF477QMsCDM0jd/h7i+IB86EGkXkFhTwRAeyfSo
         hOKAmxf/+0a1yovnc5r/+GhKujz/EIvGAHRtLxon6Rh/FOa+y6BOnnKcq+YrXNznWKLg
         +Y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xvfv2m5HhdtAxqfOGPn85TVTEjKOkALU502AwFzYvsc=;
        b=dNGNG0jTXvoGsoxgamZ2x/6b7TB2yxypkU/SJfppR9VkXVQi9Y8XxrOhgelIxquWXb
         dWv/1ApcIu1yaS5XY8gGf+FZ2VM3k5W/80JBiqTJcRBetKsVr5sLeznv9x2YHvHy5SID
         xG0IiHMj+IyhaRJ1OxdTKbs62Qptl0rK9T9S7MGpK4eRy7C2W5uQ6ucBxE0xpqaGurpO
         /ChQdIIdSzAzPRqhEF9/+KM9n/WJ0hhtpIIpVbWIMQPL1Fh4A3SYAgrGIYBNjsqLDer3
         T2ktcZbLNvIfPYHVe2v2IAQPa/4XOhhEVZTqth/tavOQfaDF7fTTjnSEThmC6FGUX/Ln
         NwPw==
X-Gm-Message-State: APjAAAW1AMYYJvH/SP+MlOJ5uyAGsRdAg2f0DUXcz/8m7lC3tj6zHH43
        vv6gWTgWqJ5Y5Ge6tYsRFFSzzPiKNboU67k1+87lHw==
X-Google-Smtp-Source: APXvYqz2WXFO5+tHGvkUb56XzsjQzXhs/UkjTSx2aoQBfXBtKhhskpD/tXStrF5StZWYdr/yqQRm4p4+ryWNqJxrPUg=
X-Received: by 2002:a1c:c90e:: with SMTP id f14mr5462272wmb.23.1553040555843;
 Tue, 19 Mar 2019 17:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <1553037915-85931-1-git-send-email-fei.yang@intel.com>
In-Reply-To: <1553037915-85931-1-git-send-email-fei.yang@intel.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 19 Mar 2019 17:09:03 -0700
Message-ID: <CALAqxLUkw0iDq+mFk-MRDT5hQDx3e2eLZg_bGUyokst0zQma9Q@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: f_fs: don't free buffer prematurely
To:     fei.yang@intel.com
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, andrzej.p@collabora.com,
        Vincent Pelletier <plr.vincent@gmail.com>,
        jingx.shen@intel.com, Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Josh Gao <jmgao@google.com>,
        Alistair Strachan <astrachan@google.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 4:25 PM <fei.yang@intel.com> wrote:
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
> Signed-off-by: Fei Yang <fei.yang@intel.com>

Awesome! Seems to resolve the crash I was seeing!

Tested-by: John Stultz <john.stultz@linaro.org>

Do be sure to mark it for -stable, as I was seeing crashes all the way
back to 4.9 (and it probably affects 4.4 too).

thanks
-john
