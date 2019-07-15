Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01181C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D3B2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563202968;
	bh=0Bgi0YSXLFbXE7fMMsBZyv5DRfzZzaNOaviqSvdjufA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QYDaQ2+TyMduShd22JC7IGh8ZSi7x0opq0b1DBf/oQAT5kXt1SwfqRBBR+2UMrYWZ
	 m5MOMhMhz+nMTeyNMuZdmRLMaHCeoR9FhJ6mYxgb+NkaYReK+UDpY3g7La4RiHrq+g
	 BYZ39Nu6edtShqfuJgiMzYeWJnLT27NOTgB5Kddc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390074AbfGOPCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 11:02:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388617AbfGOOLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:11:50 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 246272081C;
        Mon, 15 Jul 2019 14:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199909;
        bh=0Bgi0YSXLFbXE7fMMsBZyv5DRfzZzaNOaviqSvdjufA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vid3Q2bYufmlNwr1SrMyOSp7NbKQZ5z2VGUoPqPFiLApmILNTIMdnpF7+v4AMjHRG
         lKlRnz+xgrO94VW7mLvTiwrIZsB3aA4zi8HFxVYFXaWSAJm7LCKfsZbTUuUx1nQ/Tt
         i+IzDjRpu5mhmolI1LYCFenJXS0kugPdABehyFFM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 134/219] media: coda: fix last buffer handling in V4L2_ENC_CMD_STOP
Date:   Mon, 15 Jul 2019 10:02:15 -0400
Message-Id: <20190715140341.6443-134-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Felsch <m.felsch@pengutronix.de>

[ Upstream commit f3775f89852d167990b0d718587774cf00d22ac2 ]

coda_encoder_cmd() is racy, as the last scheduled picture run worker can
still be in-flight while the ENC_CMD_STOP command is issued. Depending
on the exact timing the sequence numbers might already be changed, but
the last buffer might not have been put on the destination queue yet.

In this case the current implementation would prematurely wake the
destination queue with last_buffer_dequeued=true, causing userspace to
call streamoff before the last buffer is handled.

Close this race window by synchronizing with the pic_run_worker before
doing the sequence check.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
[l.stach@pengutronix.de: switch to flush_work, reword commit message]
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/coda/coda-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
index fa0b22fb7991..9bf2116ffc76 100644
--- a/drivers/media/platform/coda/coda-common.c
+++ b/drivers/media/platform/coda/coda-common.c
@@ -1007,6 +1007,8 @@ static int coda_encoder_cmd(struct file *file, void *fh,
 	/* Set the stream-end flag on this context */
 	ctx->bit_stream_param |= CODA_BIT_STREAM_END_FLAG;
 
+	flush_work(&ctx->pic_run_work);
+
 	/* If there is no buffer in flight, wake up */
 	if (!ctx->streamon_out || ctx->qsequence == ctx->osequence) {
 		dst_vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
-- 
2.20.1

