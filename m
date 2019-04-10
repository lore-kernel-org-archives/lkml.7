Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1455C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39CF2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJXTAj92"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbfDJSJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:09:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46223 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbfDJSJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:09:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id y6so1870172pll.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 11:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p7nmSUfozL+kp0FxUIkT/SCEMr7PbtLk3rmE9MVsluc=;
        b=AJXTAj92KObK9w1qMGJs6CoJjYidU9JKVgcn4/YRPFGZkW2ZNQYS7Yn1Sb7AIo5Pi3
         0PzW95Mu0EIs2bDAboglXdg2CY7cL5ZsLUvsoIq3dtH5DJFE0aUeXZi1dh8JipTgpSHc
         Oof2Uqe8jtegpniDDoNBBh/4dtaz/DdPm0L3wsaOx0ymy9/iWPGW68J2Mk+9Qv34ii7V
         VlhsDvxvoPJdhxVBMHIHmeCi0YcnPcgMS+0utTPdYn7u+35c4QVjSmmnwNKTkinl0xcl
         d5lgMPIV3hNaNecSHNXJ6TTWSOpFYOSXr5r1UcbkJAwu9xp7jUc052DmOlkxBdX7zIJq
         wYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p7nmSUfozL+kp0FxUIkT/SCEMr7PbtLk3rmE9MVsluc=;
        b=rxdwLNNvFrdB+yMAZaJvbjBQoN4f7UXDbnKVlVWUJ1ADfx+tD4JjQr6x9bK7dSBlTx
         wWq6Jmp2/CnRgeydehma36RPQPINpYZRSaRQ6RUc9Bo1DiGBeiYuNljBzaNdjUv7xIAa
         v3Y+kaPwdRVxJi53tKTTrZablHTGaMzUIsY3pV8uL2OvEAh3amICt35VFP6EJhni0fRH
         MpJrnybDDngFd1vmhloSAPkITFQEPDdFFzVFfgw7Xfd8adjWjkqaTSQPlq454PAH/zAp
         HJh8vqGurkBrQuJtpoVPz323z2eQwbUtSfMKVp1QgfYRJdFp9m6PvgMJ0OzHpLCdHlUH
         7+nQ==
X-Gm-Message-State: APjAAAXnmdPk5cnWESn6ta6aJDV4EGF+qWhFllHMdFflJQI97FaHGkv6
        l0tb6SS+klvy7kjvV2ywqtm/vUa6
X-Google-Smtp-Source: APXvYqzDY7fCY9Zw0wHp7YAL2PtHnja1bKv5dw2jOrQPJ9G9lTx2QpytXznTM1lUAyOiixRJgcaM2A==
X-Received: by 2002:a17:902:aa85:: with SMTP id d5mr45817483plr.251.1554919766587;
        Wed, 10 Apr 2019 11:09:26 -0700 (PDT)
Received: from athina.mtv.corp.google.com ([2620:0:1000:1601:d7a4:903f:6d6b:ec10])
        by smtp.gmail.com with ESMTPSA id l184sm90615723pfc.98.2019.04.10.11.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 11:09:25 -0700 (PDT)
From:   =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <zenczykowski@gmail.com>
To:     =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] uml: fix a boot splat wrt use of cpu_all_mask
Date:   Wed, 10 Apr 2019 11:09:08 -0700
Message-Id: <20190410180908.173650-1-zenczykowski@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Żenczykowski <maze@google.com>

Memory: 509108K/542612K available (3835K kernel code, 919K rwdata, 1028K rodata, 129K init, 211K bss, 33504K reserved, 0K cma-reserved)
NR_IRQS: 15
clocksource: timer: mask: 0xffffffffffffffff max_cycles: 0x1cd42e205, max_idle_ns: 881590404426 ns
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at kernel/time/clockevents.c:458 clockevents_register_device+0x72/0x140
posix-timer cpumask == cpu_all_mask, using cpu_possible_mask instead
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 5.1.0-rc4-00048-ged79cc87302b #4
Stack:
 604ebda0 603c5370 604ebe20 6046fd17
 00000000 6006fcbb 604ebdb0 603c53b5
 604ebe10 6003bfc4 604ebdd0 9000001ca
Call Trace:
 [<6006fcbb>] ? printk+0x0/0x94
 [<60083160>] ? clockevents_register_device+0x72/0x140
 [<6001f16e>] show_stack+0x13b/0x155
 [<603c5370>] ? dump_stack_print_info+0xe2/0xeb
 [<6006fcbb>] ? printk+0x0/0x94
 [<603c53b5>] dump_stack+0x2a/0x2c
 [<6003bfc4>] __warn+0x10e/0x13e
 [<60070320>] ? vprintk_func+0xc8/0xcf
 [<60030fd6>] ? block_signals+0x0/0x16
 [<6006fcbb>] ? printk+0x0/0x94
 [<6003c08b>] warn_slowpath_fmt+0x97/0x99
 [<600311a1>] ? set_signals+0x0/0x3f
 [<6003bff4>] ? warn_slowpath_fmt+0x0/0x99
 [<600842cb>] ? tick_oneshot_mode_active+0x44/0x4f
 [<60030fd6>] ? block_signals+0x0/0x16
 [<6006fcbb>] ? printk+0x0/0x94
 [<6007d2d5>] ? __clocksource_select+0x20/0x1b1
 [<60030fd6>] ? block_signals+0x0/0x16
 [<6006fcbb>] ? printk+0x0/0x94
 [<60083160>] clockevents_register_device+0x72/0x140
 [<60031192>] ? get_signals+0x0/0xf
 [<60030fd6>] ? block_signals+0x0/0x16
 [<6006fcbb>] ? printk+0x0/0x94
 [<60002eec>] um_timer_setup+0xc8/0xca
 [<60001b59>] start_kernel+0x47f/0x57e
 [<600035bc>] start_kernel_proc+0x49/0x4d
 [<6006c483>] ? kmsg_dump_register+0x82/0x8a
 [<6001de62>] new_thread_handler+0x81/0xb2
 [<60003571>] ? kmsg_dumper_stdout_init+0x1a/0x1c
 [<60020c75>] uml_finishsetup+0x54/0x59

random: get_random_bytes called from init_oops_id+0x27/0x34 with crng_init=0
---[ end trace 00173d0117a88acb ]---
Calibrating delay loop... 6941.90 BogoMIPS (lpj=34709504)

Signed-off-by: Maciej Żenczykowski <maze@google.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/um/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 052de4c8acb2..7c2ea3b57102 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -56,7 +56,7 @@ static int itimer_one_shot(struct clock_event_device *evt)
 static struct clock_event_device timer_clockevent = {
 	.name			= "posix-timer",
 	.rating			= 250,
-	.cpumask		= cpu_all_mask,
+	.cpumask		= cpu_possible_mask, //cpu_all_mask,
 	.features		= CLOCK_EVT_FEAT_PERIODIC |
 				  CLOCK_EVT_FEAT_ONESHOT,
 	.set_state_shutdown	= itimer_shutdown,
-- 
2.21.0.392.gf8f6787159e-goog

