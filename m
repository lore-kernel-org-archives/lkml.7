Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540F2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A88D20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732180AbfDAITF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:19:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:21695 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731802AbfDAITD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:19:03 -0400
X-UUID: e959a15f1d2a4210b80322792f393526-20190401
X-UUID: e959a15f1d2a4210b80322792f393526-20190401
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <maoguang.meng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1607990482; Mon, 01 Apr 2019 16:18:47 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 1 Apr 2019 16:18:45 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 1 Apr 2019 16:18:43 +0800
From:   <maoguang.meng@mediatek.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Tiffany Lin <tiffany.lin@mediatek.com>
CC:     Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        <gtk_ruiwang@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>
Subject: [PATCH,v1] media: mtk-vcodec: fix vp9 content playback error with show exist frame
Date:   Mon, 1 Apr 2019 16:18:38 +0800
Message-ID: <1554106718-23107-1-git-send-email-maoguang.meng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maoguang Meng <maoguang.meng@mediatek.com>

Update referenced frame buffer's reference count when playing vp9
content which has show_existing_frame flag, and copy enough buffer
data to current shown frame.

Signed-off-by: Maoguang Meng <maoguang.meng@mediatek.com>
---
 .../media/platform/mtk-vcodec/vdec/vdec_vp9_if.c   |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c b/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
index bc8349b..d950837 100644
--- a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
+++ b/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
@@ -481,15 +481,15 @@ static void vp9_swap_frm_bufs(struct vdec_vp9_inst *inst)
 		 */
 		if ((frm_to_show->fb != NULL) &&
 			(inst->cur_fb->base_y.size >=
-			frm_to_show->fb->base_y.size)) {
+			frm_to_show->fb->base_y.size) &&
+			(inst->cur_fb->base_c.size >=
+			frm_to_show->fb->base_c.size)) {
 			memcpy((void *)inst->cur_fb->base_y.va,
 				(void *)frm_to_show->fb->base_y.va,
-				vsi->buf_w *
-				vsi->buf_h);
+				frm_to_show->fb->base_y.size);
 			memcpy((void *)inst->cur_fb->base_c.va,
 				(void *)frm_to_show->fb->base_c.va,
-				vsi->buf_w *
-				vsi->buf_h / 2);
+				frm_to_show->fb->base_c.size);
 		} else {
 			/* After resolution change case, current CAPTURE buffer
 			 * may have less buffer size than frm_to_show buffer
@@ -895,7 +895,7 @@ static int vdec_vp9_decode(unsigned long h_vdec, struct mtk_vcodec_mem *bs,
 
 		if (vsi->resolution_changed) {
 			if (!vp9_alloc_work_buf(inst)) {
-				ret = -EINVAL;
+				ret = -EIO;
 				goto DECODE_ERROR;
 			}
 		}
@@ -924,14 +924,12 @@ static int vdec_vp9_decode(unsigned long h_vdec, struct mtk_vcodec_mem *bs,
 
 		if (vsi->show_existing_frame && (vsi->frm_to_show_idx <
 					VP9_MAX_FRM_BUF_NUM)) {
-			mtk_vcodec_err(inst,
+			mtk_vcodec_debug(inst,
 				"Skip Decode drv->new_fb_idx=%d, drv->frm_to_show_idx=%d",
 				vsi->new_fb_idx, vsi->frm_to_show_idx);
 
 			vp9_ref_cnt_fb(inst, &vsi->new_fb_idx,
 					vsi->frm_to_show_idx);
-			ret = -EINVAL;
-			goto DECODE_ERROR;
 		}
 
 		/* VPU assign the buffer pointer in its address space,
-- 
1.7.9.5

