Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6834C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 23:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 731692073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 23:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkIlXSQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfLKXJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 18:09:26 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:50681 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLKXJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 18:09:26 -0500
Received: by mail-wm1-f53.google.com with SMTP id a5so172223wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 15:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:mime-version:message-id:user-agent
         :content-transfer-encoding;
        bh=+KVhInttHCk8aRWpkeHbpGDkcc8DqG9qr5lNYLpkB+Q=;
        b=LkIlXSQRRleORMf3k4j0Yyq3SEEQdW30hvs2l5wJXpnGm69OqLRRVJob9A3Tv+sOBc
         C2LsnoWYQouQmOCMHz0YcNUVUFe0at5s3R4zEbXXN05Uahkehc68iWqp3pchzQ6DkToA
         EduMtgvVyBtiTG2y+7OPSnJ9rxXA3DuJ0MR/bUZaboged666N06XhMRYOMGhhOLa1wG+
         MFAzmVIaalwXJunMEG8nH5pDja0AOXcw0Xwbt2f8MmNIGcWuEq15fNWi4OfRgzSGjYE4
         tGz4w5hZ08Uv5lwSJ5WcF0GtKcBEmyySGiPHRXKOx4EyhP9aI4fAYg2aBxWc4LTmdVf2
         P2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:mime-version:message-id
         :user-agent:content-transfer-encoding;
        bh=+KVhInttHCk8aRWpkeHbpGDkcc8DqG9qr5lNYLpkB+Q=;
        b=R1i1pdKfdHUtMa6KWUdWxXXgnEKaGdPeZidxe01d7M1QBo3D36wKuL7HP3PA85CV92
         wpo+4j1vHPmgB6/nvuy9Nvryr7GNcb+ArwFztY/+NdLA0blOupFFLEmOFFu2JkTJrzIE
         LggngvN97MBC0A0lKbvicpfnqThsBUYAn0QVx+k+ApN6vMy4eGlRzdl6VkQOBzVSUUZK
         l8dJggDT2Q4qrOw5TTe/vuwF5nFF5tvdpxE7hEj4mCnfhINzZdN/DqMOvkiF1iYHJtm5
         NES6rdNOQjw433vu37OWfYe8lA5E0CgpcGlsflzB4LSzQxY4grQvUOaH1IqWoRFyJY5k
         hP0Q==
X-Gm-Message-State: APjAAAXoZ7HxSop6XFE2ChBSMlTwH9zOslZMf5u9kdnz7xlzuQCofL8L
        cDBztzWfz3xhaKfGOYiewQ0=
X-Google-Smtp-Source: APXvYqzAA/fAeD8EPJ/WI2sdbDUFp8a+mD4mhBG/9aHEwPbxk3D6EVao+Y4pWSOQ8ZmApUr9WXpj8A==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr2579892wml.107.1576105763974;
        Wed, 11 Dec 2019 15:09:23 -0800 (PST)
Received: from localhost ([5.59.90.131])
        by smtp.gmail.com with ESMTPSA id 16sm4025978wmi.0.2019.12.11.15.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 15:09:23 -0800 (PST)
From:   Vicente Bergas <vicencb@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>
Cc:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: WARNING: CPU: 3 PID: 1 at =?iso-8859-1?Q?=5F=5Fflush=5Fwork.isra.47+0x22c/0x248?=
Date:   Thu, 12 Dec 2019 00:09:21 +0100
MIME-Version: 1.0
Message-ID: <5708082a-680f-4107-aaf8-a39d76037d77@gmail.com>
User-Agent: Trojita
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
since v5.5-rc1 four equal consecutive traces appeared that seem related to
rockchip sound. As i wasn't sure to whom sent the report just added
everybody from
./scripts/get_maintainer.pl sound/soc/rockchip/rk3399_gru_sound.c
which is the file containg one of the functions in the trace.

By the way, sound works fine. After all traces, there is this message that
could also be related:
[    0.625354] da7219 8-001a: Using default DAI clk names: da7219-dai-wclk,=20=

da7219-dai-bclk

Regards,
  Vicente.

[    0.607955] ------------[ cut here ]------------
[    0.607967] WARNING: CPU: 3 PID: 1 at __flush_work.isra.47+0x22c/0x248
[    0.607972] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc1 #1
[    0.607973] Hardware name: Google Kevin (DT)
[    0.607977] pstate: 00000005 (nzcv daif -PAN -UAO)
[    0.607980] pc : __flush_work.isra.47+0x22c/0x248
[    0.607982] lr : flush_delayed_work+0x34/0x58
[    0.607984] sp : ffff80001004b950
[    0.607985] x29: ffff80001004b950 x28: ffff8000109f47c8=20
[    0.607989] x27: ffff800010b29890 x26: ffff800010acfdf0=20
[    0.607992] x25: 0000000000000003 x24: 0000000000000001=20
[    0.607994] x23: ffff0000f2779f00 x22: ffff800010c974f0=20
[    0.607997] x21: 0000000000000000 x20: ffff800010c7ca48=20
[    0.608000] x19: ffff0000f277f698 x18: 0000000000000014=20
[    0.608003] x17: 000000007dad679e x16: 00000000be8a3c7e=20
[    0.608006] x15: 0000000072509968 x14: 0000000000000000=20
[    0.608008] x13: 0000000000000000 x12: 0000000000000000=20
[    0.608011] x11: 0000000000000008 x10: 0101010101010101=20
[    0.608014] x9 : 0000000000000000 x8 : 7f7f7f7f7f7f7f7f=20
[    0.608017] x7 : ffff0000f3975800 x6 : 0080808080808080=20
[    0.608019] x5 : dead000000000100 x4 : dead000000000122=20
[    0.608022] x3 : 0000000000000000 x2 : 0000000000000000=20
[    0.608025] x1 : 0000000000000000 x0 : ffff0000f277f698=20
[    0.608028] Call trace:
[    0.608031]  __flush_work.isra.47+0x22c/0x248
[    0.608034]  flush_delayed_work+0x34/0x58
[    0.608040]  soc_free_pcm_runtime.part.19+0x40/0x60
[    0.608043]  snd_soc_remove_dai_link+0x54/0x60
[    0.608047]  soc_cleanup_card_resources+0x160/0x298
[    0.608050]  snd_soc_bind_card+0x248/0x978
[    0.608053]  snd_soc_register_card+0xf0/0x108
[    0.608057]  devm_snd_soc_register_card+0x40/0x90
[    0.608061]  rockchip_sound_probe+0x210/0x2e8
[    0.608066]  platform_drv_probe+0x50/0xa0
[    0.608070]  really_probe+0xd8/0x2f0
[    0.608073]  driver_probe_device+0x54/0xe8
[    0.608075]  device_driver_attach+0x6c/0x78
[    0.608078]  __driver_attach+0x68/0xe8
[    0.608082]  bus_for_each_dev+0x60/0x98
[    0.608085]  driver_attach+0x20/0x28
[    0.608088]  bus_add_driver+0x170/0x1d0
[    0.608091]  driver_register+0x60/0x110
[    0.608093]  __platform_driver_register+0x44/0x50
[    0.608098]  rockchip_sound_driver_init+0x18/0x20
[    0.608102]  do_one_initcall+0x70/0x148
[    0.608105]  kernel_init_freeable+0x1b4/0x254
[    0.608109]  kernel_init+0x10/0xfc
[    0.608113]  ret_from_fork+0x10/0x18
[    0.608117] ---[ end trace fc1c70d7fb870a47 ]---

