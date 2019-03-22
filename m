Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F97C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25954218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254499;
	bh=ZqfuIsqRUjaCQflKmQwpKRPI9zjIMyW814Y3yH+muDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JjPUv751+G3a5TlgExqoOuAlkau5XaVavXttZcf82G1bD1t9Ahy4+UvyYHn4AssPN
	 VnISzHhTqrJaeMvhAX9FFAIYBKgVHUiJ+CliLtyxhhp3+PjZlBIM78CWVoBtz98IDM
	 I052mciZm1SY2HrrwPQIotjPIOT22hGDBgdKmgdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbfCVLe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:34:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730494AbfCVLez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:34:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C49321917;
        Fri, 22 Mar 2019 11:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254494;
        bh=ZqfuIsqRUjaCQflKmQwpKRPI9zjIMyW814Y3yH+muDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XeEUurhpLmgF4giQJ7K81WPj5Z8+aouy4mRW55JIYd9WBeQGwcSKvJUvMbcuEOCSJ
         Nb+MGLBefomLqVaOttEK1wTQO4bu6itaknAo1/6vIVSiGskOHcErz2N5k37ViMGsSa
         UOOb3BBOb0rpGRed8ciTDonpxHI9nMQ4K5MFjzzI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 135/230] net/mlx4_core: Fix qp mtt size calculation
Date:   Fri, 22 Mar 2019 12:14:33 +0100
Message-Id: <20190322111246.167081702@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

[ Upstream commit 8511a653e9250ef36b95803c375a7be0e2edb628 ]

Calculation of qp mtt size (in function mlx4_RST2INIT_wrapper)
ultimately depends on function roundup_pow_of_two.

If the amount of memory required by the QP is less than one page,
roundup_pow_of_two is called with argument zero.  In this case, the
roundup_pow_of_two result is undefined.

Calling roundup_pow_of_two with a zero argument resulted in the
following stack trace:

UBSAN: Undefined behaviour in ./include/linux/log2.h:61:13
shift exponent 64 is too large for 64-bit type 'long unsigned int'
CPU: 4 PID: 26939 Comm: rping Tainted: G OE 4.19.0-rc1
Hardware name: Supermicro X9DR3-F/X9DR3-F, BIOS 3.2a 07/09/2015
Call Trace:
dump_stack+0x9a/0xeb
ubsan_epilogue+0x9/0x7c
__ubsan_handle_shift_out_of_bounds+0x254/0x29d
? __ubsan_handle_load_invalid_value+0x180/0x180
? debug_show_all_locks+0x310/0x310
? sched_clock+0x5/0x10
? sched_clock+0x5/0x10
? sched_clock_cpu+0x18/0x260
? find_held_lock+0x35/0x1e0
? mlx4_RST2INIT_QP_wrapper+0xfb1/0x1440 [mlx4_core]
mlx4_RST2INIT_QP_wrapper+0xfb1/0x1440 [mlx4_core]

Fix this by explicitly testing for zero, and returning one if the
argument is zero (assuming that the next higher power of 2 in this case
should be one).

Fixes: c82e9aa0a8bc ("mlx4_core: resource tracking for HCA resources used by guests")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
+++ b/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
@@ -2652,13 +2652,13 @@ static int qp_get_mtt_size(struct mlx4_q
 	int total_pages;
 	int total_mem;
 	int page_offset = (be32_to_cpu(qpc->params2) >> 6) & 0x3f;
+	int tot;
 
 	sq_size = 1 << (log_sq_size + log_sq_sride + 4);
 	rq_size = (srq|rss|xrc) ? 0 : (1 << (log_rq_size + log_rq_stride + 4));
 	total_mem = sq_size + rq_size;
-	total_pages =
-		roundup_pow_of_two((total_mem + (page_offset << 6)) >>
-				   page_shift);
+	tot = (total_mem + (page_offset << 6)) >> page_shift;
+	total_pages = !tot ? 1 : roundup_pow_of_two(tot);
 
 	return total_pages;
 }


