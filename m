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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA12C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C49392075B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuS0PA3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbfDJSLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:11:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40718 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731183AbfDJSLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:11:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so1894389plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 11:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=miRN6zeuliQksrBh7t8h/9JVfSqHYFdwsxhjfUwT/zU=;
        b=ZuS0PA3vSJSMf3G2nPel/VjqlfyOgKUZXiesVrA4LP+QbtsJeK/zH7KPGgO29RZYQw
         tHJzutdSXNvEaDDR9r+SoWu20twrCrZULZaRADaFYJdboeahYVng3NewpzNNJ8adUjWe
         8Wg9hOnm/QgsoAO4p11SbM4PrHS0LD1898BJyy7Pxl1i3ucv3+4SxcgEvDql/RqiOJ+o
         PtQ1WiMOAmBholtOywzbYmf7HpMHzhNuXqXPaxxdRESsg/G3PJMoOL60EMZ1Dv9xfLK9
         xsLlnObqR9oHUPVKE39VAhgoKIPMIpaC5OVGq3JlGMmnP3gDLTtYxCRQ6hY/lhys7BB7
         930g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=miRN6zeuliQksrBh7t8h/9JVfSqHYFdwsxhjfUwT/zU=;
        b=FVdbzP6cM/5y2PS+kPHIUQzhxh1GDNSBfly8y++k1Q1KNRImeUFeX2h07t9Jnn23W/
         i860WJ2nSwGPzRat5JqIXvFfNH12773jbdhr9BFSm3o0RcMmp+DLkXJ20K0Hjcbz6g20
         yef4SnEuyGdmZOwaFgnD0a0TqzUF/qAag3M+NFMPQPcic7ph15QxBe81VoWbrc3NY5nb
         WGzdUf2sgvh+rhEY2CEpZ/NxCyo7p7vRUd5kVqP0+yYzDTTs14HlXzBwwq/4270Z8bJr
         zpBPk6FkQgRFfUuns15NvDcUwOha+xDIsRymVwoXx6gppmW081nGSW2slxEdSQKkH3Ww
         d7Cw==
X-Gm-Message-State: APjAAAVlTd93JA+PkJhTnvCp9QFrwnNKAUB89QeIuD7ZpGqWB4IjUdkN
        VWf/cv0u1SPv/kFlqQnn+KImlUSD
X-Google-Smtp-Source: APXvYqyh/GO3kWtrEJNIeEPDJiYJrkZ6Mv5iiX5XoMKQ+uzfnxl1LfZEk3a5H8dlaarSBa0kpBUiAA==
X-Received: by 2002:a17:902:a706:: with SMTP id w6mr45741093plq.91.1554919900932;
        Wed, 10 Apr 2019 11:11:40 -0700 (PDT)
Received: from athina.mtv.corp.google.com ([2620:0:1000:1601:d7a4:903f:6d6b:ec10])
        by smtp.gmail.com with ESMTPSA id w21sm49564073pfn.48.2019.04.10.11.11.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 11:11:40 -0700 (PDT)
From:   =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <zenczykowski@gmail.com>
To:     =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] uml: fix a boot splat wrt use of cpu_all_mask
Date:   Wed, 10 Apr 2019 11:11:23 -0700
Message-Id: <20190410181123.174142-1-zenczykowski@gmail.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190410180908.173650-1-zenczykowski@gmail.com>
References: <20190410180908.173650-1-zenczykowski@gmail.com>
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
index 052de4c8acb2..0c572a48158e 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -56,7 +56,7 @@ static int itimer_one_shot(struct clock_event_device *evt)
 static struct clock_event_device timer_clockevent = {
 	.name			= "posix-timer",
 	.rating			= 250,
-	.cpumask		= cpu_all_mask,
+	.cpumask		= cpu_possible_mask,
 	.features		= CLOCK_EVT_FEAT_PERIODIC |
 				  CLOCK_EVT_FEAT_ONESHOT,
 	.set_state_shutdown	= itimer_shutdown,
-- 
2.21.0.392.gf8f6787159e-goog

