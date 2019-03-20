Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945D3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED27213F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYgAEAsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfCTQkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:40:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56255 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfCTQki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:40:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so21250577wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 09:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CSpxD+Em8c1yn0zP54uXSGGJszwaxnNkwEeBQYwfo0A=;
        b=DYgAEAsE/rVesKg354nCw5eEVFy78snfgi0HyFpp7blxU7A67XEZUYAqKlx5nw+UbP
         hVRIxDt9UD4ggyr/ryn/DdWa3jGxBCRo1CfdowoqP5DawfOTMfHEBSVuFbsrjMzLBSTx
         57+JQTF6rGwRj7nkiTu0qBzMw/GlliKuFtwGKW/57px9TOKBFlX85+3wk86ZK6wDCaQz
         wqF53dhhDKUop+FAZ3ba7W0JwhtSLMSQckwotPzu5R190cFKfYk3Wd5OKXoflEFBY1zh
         SW/JnXqlYe9saX3MqqoYODKLhaFPrkMQfcJkmXJwQLjE6c/WF2ew9Tx4Z1nW2Xb8ejzp
         d42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CSpxD+Em8c1yn0zP54uXSGGJszwaxnNkwEeBQYwfo0A=;
        b=X97ytUyJSY205A9rdvK7rvkw52C00SpEnKLzgxpdK+7Yh1AXbfFO2MJOpRkV4ZuCc9
         AHnEc4b3caaneewR5A/DkUR8nPtwVlpIgktAXMPBJIYvwc20yUKSrEg+nOQEpLQBU6w5
         aK5B2qbBo+UwWQo5zguO9ALLjrGzYM3UVreg4MYvepMouR/38KBv5+fVDW2a7pjFwJD/
         5eGQWoYPWnBQkzp8oFvw1p3Lvvc99DpOth29iCglObTz3lfd607sjCwlYhqprQJlAnZ5
         Rv4/Cb1iqafULb78zwAjv450SLqqWExibuTvWPayjhIEy0ASX1p4VLfIP51MB2I1b58N
         ItdA==
X-Gm-Message-State: APjAAAX0iwAfFcin3O6OgpDnyx/dnpeupJrk2fuddbaBVJJBTUz53g+2
        HCmryXVxHlR+zGz5PiEY+6F5qNxSX4xMBtTNvRIqDw==
X-Google-Smtp-Source: APXvYqybCeEgGDy14hvBneety12aezej9o+puIYjTjgbLpYonKCoZe2hbdAKTf73ylFtg0jYgqPDsa/QuKpcjKZYV1k=
X-Received: by 2002:a1c:7311:: with SMTP id d17mr9338945wmb.115.1553100036057;
 Wed, 20 Mar 2019 09:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <1553059940-127038-1-git-send-email-fei.yang@intel.com>
In-Reply-To: <1553059940-127038-1-git-send-email-fei.yang@intel.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 20 Mar 2019 09:40:25 -0700
Message-ID: <CALAqxLUW9XCq0WqTzpYGZ7B_4CVdsXY6t_dyuwhnOTJ7HajrwQ@mail.gmail.com>
Subject: Re: [PATCH V2] usb: gadget: f_fs: don't free buffer prematurely
To:     fei.yang@intel.com
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, andrzej.p@collabora.com,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Josh Gao <jmgao@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Shen Jing <jingx.shen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 10:32 PM <fei.yang@intel.com> wrote:
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


Hey Fei,
  So while this patch does resolve the issues I was seeing with
mainline kernels and recent changes to adbd, Josh pointed out that it
wouldn't resolve the issues I was seeing with older kernels which is
slightly different (but still related to aio usage).

On the older kernels I'm hitting scheduling while atomic on reboot,
which seems to be due to ffs_aio_cancel() taking a spinlock then
calling usb_ep_dequeue() which might sleep.

It seems a fix for this was tried earlier with d52e4d0c0c428 ("usb:
gadget: ffs: Fix BUG when userland exits with submitted AIO
transfers") which was then reverted by a9c859033f6e.

Elsewhere it seems the ffs driver takes effort to drop any locks
before calling usb_ep_dequeue(), so this seems like that should be
addressed, but it also seems like recent change to the dwc3 driver has
been made to avoid sleeping in that path (see fec9095bdef4 ("usb:
dwc3: gadget: remove wait_end_transfer")), which may be why I'm not
seeing the problem with mainline (and your patch here, of coarse).
But that also doesn't clarify if its still a potential issue w/
non-dwc3 platforms.

So for older kernels, do you have a suggestion of which approach is
advised?  Does usb_ep_dequeue need to avoid sleeping or do we need to
rework the ffs_aio_cancel logic?

thanks
-john
