Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0064EC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBD8208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 05:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfHlaRcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfFSFIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 01:08:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46679 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfFSFIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 01:08:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id e5so6662501pls.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 22:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jSH5fDeAs54mlrpilUpBLxAoqJ2qJpdxNbsPKIIaGgg=;
        b=DfHlaRcylEglRmUMlEUIlg9DsCDXgLsn42FTCMV9hrwj9HWTFz4PQFfqxT8CZEcBEU
         KMUZjw7mxzY5RtOndbLokhuE89J0BiPtkn3ZzO7Z71mb22x9PgxSAELaqEO9FDFD4P5h
         s0Ilp7HyM7zfzq/fXQPc5Ro2A8kPZO/p3Wb5qnUirv2vL26TW9gjtnl2rxlGj8QwUIDC
         LG2AzoasLr0PEH+AMGtGlU8jtVa6r3EJJcqRDqQr8oHGtk2qifg0zlNLdEXHdeI/MdHb
         Ahhbm2gCCo9rHk/4ru/QQ8dLmttxjY0jC0mXQ2C0XHtUDCzweB3dFthoy5XesCcLyP7Z
         GTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jSH5fDeAs54mlrpilUpBLxAoqJ2qJpdxNbsPKIIaGgg=;
        b=Nwk7bURcSXvMXY7Y4jkcDJkECpozd/fkizCfbP9rdmrVtSDJeMhvrR6G46RIdQpq31
         AfuyeSFMjG8Bh2h71SHfgVyEobRyYmK100cq/ZSIIN8jDFov9qfGw4ImInQ7t/zoSUcx
         LuZ4NzOJaGW+RxrH/SHLQU5ikNPkOuzEHwWpxTwwwpRu4lnK5ReNe2c0PqjNtup/xnMq
         XvZZrAoJfo0feFubqHs6NMRjkpTH91UXPSyes0TQO7cPbf609C2Yvfyn3S+OvF74tOQO
         HLMLHSzUk5cSTbVzl2i6qGMxt6a2w0HincVBi6y66xG7E1f7mFTHheuGXG43V3Kui2bj
         TecQ==
X-Gm-Message-State: APjAAAVc//FFKXDUHDGH6Sgvv7mq9xUtLY3cYgXGKca0pb5N8XgKPn44
        ueapXaV8JuagC9gGdoKMqEsIeuuE
X-Google-Smtp-Source: APXvYqzCzGuQyc99YvRwZDJTlcuB8YG4jBrABMnGRIX/kShGMUTWOAothvO8mID23wQAH9/3Avdkmg==
X-Received: by 2002:a17:902:bd0a:: with SMTP id p10mr42084223pls.134.1560920896404;
        Tue, 18 Jun 2019 22:08:16 -0700 (PDT)
Received: from localhost ([175.223.10.253])
        by smtp.gmail.com with ESMTPSA id q63sm9039650pfb.81.2019.06.18.22.08.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 22:08:15 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:08:11 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        nouveau@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: nouveau: DRM: GPU lockup - switching to software fbcon
Message-ID: <20190619050811.GA15221@jagdpanzerIV>
References: <20190614024957.GA9645@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614024957.GA9645@jagdpanzerIV>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/14/19 11:50), Sergey Senozhatsky wrote:
> dmesg
> 
>  nouveau 0000:01:00.0: DRM: GPU lockup - switching to software fbcon
>  nouveau 0000:01:00.0: fifo: SCHED_ERROR 0a [CTXSW_TIMEOUT]
>  nouveau 0000:01:00.0: fifo: runlist 0: scheduled for recovery
>  nouveau 0000:01:00.0: fifo: channel 5: killed
>  nouveau 0000:01:00.0: fifo: engine 6: scheduled for recovery
>  nouveau 0000:01:00.0: fifo: engine 0: scheduled for recovery
>  nouveau 0000:01:00.0: firefox[476]: channel 5 killed!
>  nouveau 0000:01:00.0: firefox[476]: failed to idle channel 5 [firefox[476]]
> 
> It lockups several times a day. Twice in just one hour today.
> Can we fix this?

Unusable

[10380.555859] ------------[ cut here ]------------
[10380.556923] nouveau 0000:01:00.0: timeout
[10380.557981] WARNING: CPU: 3 PID: 12845 at drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c:171 gk104_fifo_runlist_commit+0x11d/0x140
[10380.559079] Modules linked in: rndis_host cdc_ether usbnet mii mousedev hid_generic usbhid hid snd_hda_codec_realtek snd_hda_codec_generic r8169 snd_hda_intel realtek libphy snd_hda_codec snd_hda_core snd_pcm coretemp hwmon snd_timer snd i2c_i801 soundcore button xhci_pci xhci_hcd usbcore usb_common
[10380.560390] CPU: 3 PID: 12845 Comm: JS Helper Not tainted 5.2.0-rc5-next-20190617-dbg-00012-g45d135944f17-dirty #3438
[10380.560392] RIP: 0010:gk104_fifo_runlist_commit+0x11d/0x140
[10380.560393] Code: 24 08 48 8b 40 10 48 8b 78 10 4c 8b 77 50 4d 85 f6 74 34 e8 75 ea 06 00 4c 89 f2 48 c7 c7 ba b1 de a8 48 89 c6 e8 4e 8b c2 ff <0f> 0b 41 8b 45 50 85 c0 0f 85 33 1d 00 00 48 83 c4 30 5b 5d 41 5c
[10380.560393] RSP: 0018:ffff962383e179b8 EFLAGS: 00010296
[10380.560394] RAX: 000000000000001d RBX: ffff8b98cc9a7400 RCX: 0000000000000000
[10380.560394] RDX: ffff8b98ceae5218 RSI: ffff8b98cead6348 RDI: ffff8b98cead6348
[10380.560395] RBP: 0000000000002284 R08: ffff8b98cead6348 R09: 00000000000002d7
[10380.560395] R10: 0000000000000001 R11: 00000000ffffffff R12: 0000000000000000
[10380.560396] R13: ffff8b98cb0f9000 R14: ffff8b95c7594b20 R15: 0000000000000000
[10380.560396] FS:  00007fcff2aff700(0000) GS:ffff8b98ceac0000(0000) knlGS:0000000000000000
[10380.560397] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10380.560397] CR2: 000055d2e178b098 CR3: 00000001e3008006 CR4: 00000000001606e0
[10380.560398] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[10380.560398] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[10380.560398] Call Trace:
[10380.560401]  gk104_fifo_runlist_update+0x19e/0x1c0
[10380.560403]  gk104_fifo_gpfifo_fini+0x7d/0xa0
[10380.560404]  nvkm_fifo_chan_fini+0x19/0x20
[10380.560406]  nvkm_object_fini+0xbc/0x150
[10380.560408]  nvkm_ioctl_del+0x2f/0x50
[10380.560409]  nvkm_ioctl+0xdf/0x177
[10380.560410]  nvif_object_fini+0x49/0x60
[10380.560412]  nouveau_channel_del+0x89/0x110
[10380.560413]  nouveau_abi16_chan_fini.isra.0+0xa0/0x110
[10380.560414]  nouveau_abi16_fini+0x2d/0x60
[10380.560416]  nouveau_drm_postclose+0x4c/0xe0
[10380.560418]  drm_file_free.part.0+0x1e0/0x290
[10380.560420]  drm_release+0xa7/0xe0
[10380.591300]  __fput+0xc7/0x250
[10380.592291]  task_work_run+0x90/0xc0
[10380.593271]  do_exit+0x286/0xb10
[10380.594306]  do_group_exit+0x33/0xa0
[10380.595333]  get_signal+0x12d/0x7e0
[10380.596304]  do_signal+0x23/0x590
[10380.597490]  ? __bpf_prog_run64+0x40/0x40
[10380.598441]  ? __seccomp_filter+0x7e/0x430
[10380.599503]  ? __x64_sys_futex+0x12c/0x145
[10380.600477]  exit_to_usermode_loop+0x5d/0x70
[10380.601447]  do_syscall_64+0x21f/0x2e8
[10380.602420]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[10380.603352] RIP: 0033:0x7fd0025bdbac
[10380.604341] Code: Bad RIP value.
[10380.605264] RSP: 002b:00007fcff2afe590 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
[10380.606196] RAX: fffffffffffffe00 RBX: 00007fcff2b06608 RCX: 00007fd0025bdbac
[10380.607241] RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fcff2b06630
[10380.608241] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[10380.609172] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000001ecc
[10380.610097] R13: 00007fcff2b065b0 R14: 0000000000000000 R15: 00007fcff2b06630
[10380.611023] ---[ end trace 3a96e3448f4194de ]---
[10380.611946] nouveau 0000:01:00.0: fifo: runlist 0 update timeout
[10382.850861] nouveau 0000:01:00.0: fifo: SCHED_ERROR 0a [CTXSW_TIMEOUT]
[10382.851777] nouveau 0000:01:00.0: fifo: runlist 0: scheduled for recovery
[10382.852673] nouveau 0000:01:00.0: fifo: channel 5: killed
[10382.853560] nouveau 0000:01:00.0: fifo: engine 0: scheduled for recovery
[10382.854521] nouveau 0000:01:00.0: firefox[12157]: channel 5 killed!
[10395.612848] nouveau 0000:01:00.0: firefox[12157]: failed to idle channel 5 [firefox[12157]]

	-ss
