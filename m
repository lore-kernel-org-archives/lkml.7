Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC12AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22D320645
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbfDPIyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:54:05 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:40426 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726895AbfDPIyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:54:05 -0400
X-UUID: 6c35619a52e24ebea9d26f45e15a1781-20190416
X-UUID: 6c35619a52e24ebea9d26f45e15a1781-20190416
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <gtk_ruiwang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1735331684; Tue, 16 Apr 2019 16:53:58 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 16 Apr
 2019 16:53:54 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 16 Apr 2019 16:53:54 +0800
Message-ID: <1555404834.22504.9.camel@mhfsdcap03>
Subject: Re: [PATCH,v1] media: mtk-vcodec: fix vp9 content playback error
 with show exist frame
From:   gtk_ruiwang <gtk_ruiwang@mediatek.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        <maoguang.meng@mediatek.com>
CC:     Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <gtk_ruiwang@mediatek.com>
Date:   Tue, 16 Apr 2019 16:53:54 +0800
In-Reply-To: <1554106718-23107-1-git-send-email-maoguang.meng@mediatek.com>
References: <1554106718-23107-1-git-send-email-maoguang.meng@mediatek.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Hans, all,

Could you please help to review this patch?

This is a fix about vp9 show+AF8-existing+AF8-frames.

Sincerely thanks,
BR

On Mon, 2019-04-01 at 16:18 +-0800, maoguang.meng+AEA-mediatek.com wrote:
+AD4 From: Maoguang Meng +ADw-maoguang.meng+AEA-mediatek.com+AD4
+AD4 
+AD4 Update referenced frame buffer's reference count when playing vp9
+AD4 content which has show+AF8-existing+AF8-frame flag, and copy enough buffer
+AD4 data to current shown frame.
+AD4 
+AD4 Signed-off-by: Maoguang Meng +ADw-maoguang.meng+AEA-mediatek.com+AD4
+AD4 ---
+AD4  .../media/platform/mtk-vcodec/vdec/vdec+AF8-vp9+AF8-if.c   +AHw   16 +-+-+-+-+-+-+----------
+AD4  1 file changed, 7 insertions(+-), 9 deletions(-)
+AD4 
+AD4 diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec+AF8-vp9+AF8-if.c b/drivers/media/platform/mtk-vcodec/vdec/vdec+AF8-vp9+AF8-if.c
+AD4 index bc8349b..d950837 100644
+AD4 --- a/drivers/media/platform/mtk-vcodec/vdec/vdec+AF8-vp9+AF8-if.c
+AD4 +-+-+- b/drivers/media/platform/mtk-vcodec/vdec/vdec+AF8-vp9+AF8-if.c
+AD4 +AEAAQA -481,15 +-481,15 +AEAAQA static void vp9+AF8-swap+AF8-frm+AF8-bufs(struct vdec+AF8-vp9+AF8-inst +ACo-inst)
+AD4  		 +ACo-/
+AD4  		if ((frm+AF8-to+AF8-show-+AD4-fb +ACEAPQ NULL) +ACYAJg
+AD4  			(inst-+AD4-cur+AF8-fb-+AD4-base+AF8-y.size +AD4APQ
+AD4 -			frm+AF8-to+AF8-show-+AD4-fb-+AD4-base+AF8-y.size)) +AHs
+AD4 +-			frm+AF8-to+AF8-show-+AD4-fb-+AD4-base+AF8-y.size) +ACYAJg
+AD4 +-			(inst-+AD4-cur+AF8-fb-+AD4-base+AF8-c.size +AD4APQ
+AD4 +-			frm+AF8-to+AF8-show-+AD4-fb-+AD4-base+AF8-c.size)) +AHs
+AD4  			memcpy((void +ACo)inst-+AD4-cur+AF8-fb-+AD4-base+AF8-y.va,
+AD4  				(void +ACo)frm+AF8-to+AF8-show-+AD4-fb-+AD4-base+AF8-y.va,
+AD4 -				vsi-+AD4-buf+AF8-w +ACo
+AD4 -				vsi-+AD4-buf+AF8-h)+ADs
+AD4 +-				frm+AF8-to+AF8-show-+AD4-fb-+AD4-base+AF8-y.size)+ADs
+AD4  			memcpy((void +ACo)inst-+AD4-cur+AF8-fb-+AD4-base+AF8-c.va,
+AD4  				(void +ACo)frm+AF8-to+AF8-show-+AD4-fb-+AD4-base+AF8-c.va,
+AD4 -				vsi-+AD4-buf+AF8-w +ACo
+AD4 -				vsi-+AD4-buf+AF8-h / 2)+ADs
+AD4 +-				frm+AF8-to+AF8-show-+AD4-fb-+AD4-base+AF8-c.size)+ADs
+AD4  		+AH0 else +AHs
+AD4  			/+ACo After resolution change case, current CAPTURE buffer
+AD4  			 +ACo may have less buffer size than frm+AF8-to+AF8-show buffer
+AD4 +AEAAQA -895,7 +-895,7 +AEAAQA static int vdec+AF8-vp9+AF8-decode(unsigned long h+AF8-vdec, struct mtk+AF8-vcodec+AF8-mem +ACo-bs,
+AD4  
+AD4  		if (vsi-+AD4-resolution+AF8-changed) +AHs
+AD4  			if (+ACE-vp9+AF8-alloc+AF8-work+AF8-buf(inst)) +AHs
+AD4 -				ret +AD0 -EINVAL+ADs
+AD4 +-				ret +AD0 -EIO+ADs
+AD4  				goto DECODE+AF8-ERROR+ADs
+AD4  			+AH0
+AD4  		+AH0
+AD4 +AEAAQA -924,14 +-924,12 +AEAAQA static int vdec+AF8-vp9+AF8-decode(unsigned long h+AF8-vdec, struct mtk+AF8-vcodec+AF8-mem +ACo-bs,
+AD4  
+AD4  		if (vsi-+AD4-show+AF8-existing+AF8-frame +ACYAJg (vsi-+AD4-frm+AF8-to+AF8-show+AF8-idx +ADw
+AD4  					VP9+AF8-MAX+AF8-FRM+AF8-BUF+AF8-NUM)) +AHs
+AD4 -			mtk+AF8-vcodec+AF8-err(inst,
+AD4 +-			mtk+AF8-vcodec+AF8-debug(inst,
+AD4  				+ACI-Skip Decode drv-+AD4-new+AF8-fb+AF8-idx+AD0AJQ-d, drv-+AD4-frm+AF8-to+AF8-show+AF8-idx+AD0AJQ-d+ACI,
+AD4  				vsi-+AD4-new+AF8-fb+AF8-idx, vsi-+AD4-frm+AF8-to+AF8-show+AF8-idx)+ADs
+AD4  
+AD4  			vp9+AF8-ref+AF8-cnt+AF8-fb(inst, +ACY-vsi-+AD4-new+AF8-fb+AF8-idx,
+AD4  					vsi-+AD4-frm+AF8-to+AF8-show+AF8-idx)+ADs
+AD4 -			ret +AD0 -EINVAL+ADs
+AD4 -			goto DECODE+AF8-ERROR+ADs
+AD4  		+AH0
+AD4  
+AD4  		/+ACo VPU assign the buffer pointer in its address space,


