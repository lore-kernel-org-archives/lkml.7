Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F66C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304DF20840
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099796;
	bh=jv/8gljX84a+VucxrOBDI2DmiV4NZyXg7ZLVkX1FFF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ww/UCT3G8DJXeVhy7splIW3jC53Qq23RQXKKawU1ugwLLjfa38AKd7VUqjVbcuidT
	 o2WB9EYD6G/Fsp+xTCAzbkNQm20i21TK1YKtgUISyisWJ+OZPR5SyDwzxMUAdK7qoe
	 2FeLxq3PVKiX88HI5lQzInhnQVs/CjEKRmAGmPQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388377AbfFIRDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:03:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388367AbfFIRDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:03:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3DD02084A;
        Sun,  9 Jun 2019 17:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099791;
        bh=jv/8gljX84a+VucxrOBDI2DmiV4NZyXg7ZLVkX1FFF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v6loinIpda8HWXsJQBVFz3LFCzMv3UkEyqdj34X8Kgojg1tRTPUd1Gl6Xbe4i48Ds
         vDlMJbensrmgrVcmlcVxnrxh2LfHmy8rNGCdA921lkDghTJPSYklIkSL0S644pI/S+
         2/Gag8pw9NhyrRusYNl3c3Aw6YryYUiCRAPXBwZA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 166/241] media: wl128x: prevent two potential buffer overflows
Date:   Sun,  9 Jun 2019 18:41:48 +0200
Message-Id: <20190609164152.566439086@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 9c2ccc324b3a6cbc865ab8b3e1a09e93d3c8ade9 ]

Smatch marks skb->data as untrusted so it warns that "evt_hdr->dlen"
can copy up to 255 bytes and we only have room for two bytes.  Even
if this comes from the firmware and we trust it, the new policy
generally is just to fix it as kernel hardenning.

I can't test this code so I tried to be very conservative.  I considered
not allowing "evt_hdr->dlen == 1" because it doesn't initialize the
whole variable but in the end I decided to allow it and manually
initialized "asic_id" and "asic_ver" to zero.

Fixes: e8454ff7b9a4 ("[media] drivers:media:radio: wl128x: FM Driver Common sources")

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/radio/wl128x/fmdrv_common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/radio/wl128x/fmdrv_common.c b/drivers/media/radio/wl128x/fmdrv_common.c
index ebc73b0342496..51639a3f7abe4 100644
--- a/drivers/media/radio/wl128x/fmdrv_common.c
+++ b/drivers/media/radio/wl128x/fmdrv_common.c
@@ -494,7 +494,8 @@ int fmc_send_cmd(struct fmdev *fmdev, u8 fm_op, u16 type, void *payload,
 		return -EIO;
 	}
 	/* Send response data to caller */
-	if (response != NULL && response_len != NULL && evt_hdr->dlen) {
+	if (response != NULL && response_len != NULL && evt_hdr->dlen &&
+	    evt_hdr->dlen <= payload_len) {
 		/* Skip header info and copy only response data */
 		skb_pull(skb, sizeof(struct fm_event_msg_hdr));
 		memcpy(response, skb->data, evt_hdr->dlen);
@@ -590,6 +591,8 @@ static void fm_irq_handle_flag_getcmd_resp(struct fmdev *fmdev)
 		return;
 
 	fm_evt_hdr = (void *)skb->data;
+	if (fm_evt_hdr->dlen > sizeof(fmdev->irq_info.flag))
+		return;
 
 	/* Skip header info and copy only response data */
 	skb_pull(skb, sizeof(struct fm_event_msg_hdr));
@@ -1315,7 +1318,7 @@ static int load_default_rx_configuration(struct fmdev *fmdev)
 static int fm_power_up(struct fmdev *fmdev, u8 mode)
 {
 	u16 payload;
-	__be16 asic_id, asic_ver;
+	__be16 asic_id = 0, asic_ver = 0;
 	int resp_len, ret;
 	u8 fw_name[50];
 
-- 
2.20.1



