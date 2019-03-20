Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EA4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E652184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYZESArF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfCTO3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:29:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43524 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfCTO3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:29:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id f18so2298941lja.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 07:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OWJECjfMNPeLEisMY9HoUOhxK8huQ3dZk/QSLy3zcFM=;
        b=KYZESArFWhLE6UL34WXkKjp6FlX7SRTOscsE2pkAucvzVeAxuQF2o2EYijMSdknjkT
         foW183YRsZrc5z98e+4ptjoWl/Y1XDAd3YBz9S0VecihwLcRnw8emhooc5iRruhfZf8X
         dSryYAxVC+j/j4eQ16q3Qk0dUGePGGYg2XIpj5dsCERjfK+zZlnYedRAojVRA/vHs28d
         0PQ41F8/FlRKn1fn6oO0DBl/3MrXZTYggNnoDqxruWSTTf1oO6Vzw4Wgle82sbl61pd2
         B+Gm9MmeaDGTXcY37oiTzFe1+WBxFgxqMAM2a2Fe7siLzSGEVUxehrEopsxXDfTkKoh6
         K+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OWJECjfMNPeLEisMY9HoUOhxK8huQ3dZk/QSLy3zcFM=;
        b=Os/1us6sRKhpWkXqOP/SKzKPRBeFMGwByupbKUUqfMOOzalrw+srieGFnn7NGLlzd9
         UUFxU8gWTTi+LTvKmbf+iTRsG7M41beWxF6f09J6eeqNhI3T4nPckEMu2BTrT7/usbQA
         ou/SxfvOqnCY33qI6PwuDHx0pHfkONgQgKLrSd0448+YUkfw3Umo4sIapDw8oy6d33jW
         YNK0xgvXZvX1I1AZ4Bcm3E07ULT8kiCeWNMkXvKi+y1xMctbNPNI104xgjmXz7VtGoE6
         lgPWnDi/OlUK/BztsPWUgLxgmawW+1Z0knrtjig6sYkoshEMG1a0YwlLwWWN6LNh4F/9
         elbQ==
X-Gm-Message-State: APjAAAVeD/JMiRcpmro1Um+vOJ525MsSYIf3dtsUFGV3SIEjqU/8oYra
        m9TXaiu4YV1XIyGZze5ntwg=
X-Google-Smtp-Source: APXvYqw709tflUm7/fyM0SRHPJiAV+DTWsiFxnRyQvudHayEYMBh6yjnRCjv++fB2Ii/myfMuryfng==
X-Received: by 2002:a2e:884a:: with SMTP id z10mr7955873ljj.21.1553092184336;
        Wed, 20 Mar 2019 07:29:44 -0700 (PDT)
Received: from alpha ([178.71.210.108])
        by smtp.gmail.com with ESMTPSA id q3sm398391lff.23.2019.03.20.07.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 07:29:43 -0700 (PDT)
Received: (nullmailer pid 17708 invoked by uid 1000);
        Wed, 20 Mar 2019 14:32:18 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] staging: r8188eu: refactor recvframe_defrag()
Date:   Wed, 20 Mar 2019 17:31:44 +0300
Message-Id: <20190320143144.17663-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local variables pfhdr and prframe always have a same value,
so one of them is unnecessary.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_recv.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index 90eb1a025051..9075e3a2755a 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -1325,7 +1325,7 @@ static struct recv_frame *recvframe_defrag(struct adapter *adapter,
 	struct list_head *plist, *phead;
 	u8 wlanhdr_offset;
 	u8	curfragnum;
-	struct recv_frame *pfhdr, *pnfhdr;
+	struct recv_frame *pnfhdr;
 	struct recv_frame *prframe, *pnextrframe;
 	struct __queue *pfree_recv_queue;
 
@@ -1334,11 +1334,10 @@ static struct recv_frame *recvframe_defrag(struct adapter *adapter,
 
 	phead = get_list_head(defrag_q);
 	plist = phead->next;
-	pfhdr = list_entry(plist, struct recv_frame, list);
-	prframe = pfhdr;
+	prframe = list_entry(plist, struct recv_frame, list);
 	list_del_init(&prframe->list);
 
-	if (curfragnum != pfhdr->attrib.frag_num) {
+	if (curfragnum != prframe->attrib.frag_num) {
 		/* the first fragment number must be 0 */
 		/* free the whole queue */
 		rtw_free_recvframe(prframe, pfree_recv_queue);
@@ -1377,15 +1376,15 @@ static struct recv_frame *recvframe_defrag(struct adapter *adapter,
 		skb_pull(pnextrframe->pkt, wlanhdr_offset);
 
 		/* append  to first fragment frame's tail (if privacy frame, pull the ICV) */
-		skb_trim(prframe->pkt, prframe->pkt->len - pfhdr->attrib.icv_len);
+		skb_trim(prframe->pkt, prframe->pkt->len - prframe->attrib.icv_len);
 
 		/* memcpy */
-		memcpy(skb_tail_pointer(pfhdr->pkt), pnfhdr->pkt->data,
+		memcpy(skb_tail_pointer(prframe->pkt), pnfhdr->pkt->data,
 		       pnfhdr->pkt->len);
 
 		skb_put(prframe->pkt, pnfhdr->pkt->len);
 
-		pfhdr->attrib.icv_len = pnfhdr->attrib.icv_len;
+		prframe->attrib.icv_len = pnfhdr->attrib.icv_len;
 		plist = plist->next;
 	}
 
-- 
2.19.2

