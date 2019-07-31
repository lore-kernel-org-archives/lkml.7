Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DE0C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03B7206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 19:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="HATQcLFP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbfGaTDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 15:03:13 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:43151 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfGaTDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 15:03:13 -0400
Received: by mail-ua1-f68.google.com with SMTP id o2so27409936uae.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 12:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=J5/+IUoPptMz/YeYl61+AP3g0++j4c3MOC/Y5yEL2qE=;
        b=HATQcLFPHZEzIoIUXwWPccuYHMZ+4nnFAzajfaPcfN3EwltBjedf8FD0RE8hmYFRx7
         4RGOTw6JRUJ5Mntnm6Ze+biSI6fsEgWFeqc6SDP0j0x6NYKDUyZRfFR4M96N3rG5k9DT
         CfCXnfwNC8vEsHbYhyL+ArGfhqYOct/UYpZ7B68hSo99HGyW6s/0pSTf72e90DB0EIye
         7xBUW681oTpYSdaUj0WP13i6xRzsmtwGcGa108EiAPvIcThJXXF0+Vlm5v317dHnFTTY
         zrHO1D8r8g9hz+xjDiVoBECYGmdREzVqWjuAI80aqnsg9bzo3tBqd1Pz/1lp1shFI1Di
         Y+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J5/+IUoPptMz/YeYl61+AP3g0++j4c3MOC/Y5yEL2qE=;
        b=SzzbakNKi2mHNj/wBkx4gYnRhPzMGB8pmFNxfuYflKjx8Fs69NYVD8XWUVLJ5akauW
         /y5VhjOOql45mo272vylejwhtPAU+345EF6jCiX8EEgAC7RYT7viyVewczRvz3ttPUQ6
         fSjI3OkXpSSJcFJcgOWfpuwuUoFB1n3QWHcTWQE7Jpe+lWCUDGuOf8nA0tHksTCj75eg
         lfVkuB76RIjHml8Jcp1I8wxgoG1HHcs7E2xXr0YleM8BFLHlYIRRsPz5njijzinHKq4i
         7oAHjEyjEqT2f2rbO0XTDGA8pO/RIO0T60UAs9nrEIl7AELBeCXVR4x2CqMqlL2j89Wv
         VsvA==
X-Gm-Message-State: APjAAAWSeQq2Fr8DJINIGDN50Ps66nkv3JB2No3p6n7dj7WCVpWBhDIC
        ct9CPI7Lg1H+y73Mes8CSt5LIw==
X-Google-Smtp-Source: APXvYqxLrPoBT6tozNTlLxfWSGNpbXIDJEQxqIF21mwBqXnn9Ziv/BwZfVt42oSoyl9MpzGphibvWg==
X-Received: by 2002:ab0:3007:: with SMTP id f7mr30759872ual.12.1564599791912;
        Wed, 31 Jul 2019 12:03:11 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n187sm69530779vkd.9.2019.07.31.12.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 12:03:11 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     davem@davemloft.net
Cc:     saeedm@mellanox.com, tariqt@mellanox.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] net/mlx5e: always initialize frag->last_in_page
Date:   Wed, 31 Jul 2019 15:02:53 -0400
Message-Id: <1564599773-9474-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 069d11465a80 ("net/mlx5e: RX, Enhance legacy Receive Queue
memory scheme") introduced an undefined behaviour below due to
"frag->last_in_page" is only initialized in
mlx5e_init_frags_partition() when,

if (next_frag.offset + frag_info[f].frag_stride > PAGE_SIZE)

or after bailed out the loop,

for (i = 0; i < mlx5_wq_cyc_get_size(&rq->wqe.wq); i++)

As the result, there could be some "frag" have uninitialized
value of "last_in_page".

Later, get_frag() obtains those "frag" and check "rag->last_in_page" in
mlx5e_put_rx_frag() and triggers the error during boot. Fix it by always
initializing "frag->last_in_page" to "false" in
mlx5e_init_frags_partition().

UBSAN: Undefined behaviour in
drivers/net/ethernet/mellanox/mlx5/core/en_rx.c:325:12
load of value 170 is not a valid value for type 'bool' (aka '_Bool')
Call trace:
 dump_backtrace+0x0/0x264
 show_stack+0x20/0x2c
 dump_stack+0xb0/0x104
 __ubsan_handle_load_invalid_value+0x104/0x128
 mlx5e_handle_rx_cqe+0x8e8/0x12cc [mlx5_core]
 mlx5e_poll_rx_cq+0xca8/0x1a94 [mlx5_core]
 mlx5e_napi_poll+0x17c/0xa30 [mlx5_core]
 net_rx_action+0x248/0x940
 __do_softirq+0x350/0x7b8
 irq_exit+0x200/0x26c
 __handle_domain_irq+0xc8/0x128
 gic_handle_irq+0x138/0x228
 el1_irq+0xb8/0x140
 arch_cpu_idle+0x1a4/0x348
 do_idle+0x114/0x1b0
 cpu_startup_entry+0x24/0x28
 rest_init+0x1ac/0x1dc
 arch_call_rest_init+0x10/0x18
 start_kernel+0x4d4/0x57c

Fixes: 069d11465a80 ("net/mlx5e: RX, Enhance legacy Receive Queue memory scheme")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 47eea6b3a1c3..96f5110a9b43 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -336,6 +336,7 @@ static void mlx5e_init_frags_partition(struct mlx5e_rq *rq)
 
 	next_frag.di = &rq->wqe.di[0];
 	next_frag.offset = 0;
+	next_frag.last_in_page = false;
 	prev = NULL;
 
 	for (i = 0; i < mlx5_wq_cyc_get_size(&rq->wqe.wq); i++) {
-- 
1.8.3.1

