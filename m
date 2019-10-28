Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC3CCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14700208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAUIkKm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbfJ1PhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:37:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36319 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfJ1PhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:37:23 -0400
Received: by mail-qt1-f196.google.com with SMTP id x14so4866032qtq.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wYGdeMVsSnldJ5HK72RXM3BlWxjO1W9juajBwhBiRmQ=;
        b=LAUIkKm4R+xKNzfWQS0cBKJSNG+zrwONod38afnFR3WzsQRmJr5Jv9KT/fkcJEuY39
         va3oNiXQreaCiQAwbKnZA9xOfIK0pyHLlmH8WgMUEyE6zcaPKNCfx2oZTw62GNZtAiZP
         ty0gdpzwWQJ/gTifeMJ7dnXtU2IwMRAvz9QKnU7uwc+oEICXwUv3lToSpwm7bgtw+RSV
         Dta/RNvaPH/5njoKM9jhOA+mlH3mZRVI/PpPc3IJtQTDG+GXtQ6I7g/zdrKXwzSa3iQM
         vFq1xCF7qdOSaVb6whT1USIgMjHt16PW9RPzUySYFZO40zi8f5uJ+QBT1Yd356RUPb3r
         4bZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wYGdeMVsSnldJ5HK72RXM3BlWxjO1W9juajBwhBiRmQ=;
        b=i6wlChXE2VPWQXyBGeEhlTf6hhf4H8yji1hdLTwb2q6wWEJmpLFg7LfBlFxS0XUaPZ
         Q3drTlJ9lvANcr8uZ2xy1ECd9vhENp0ut9HYFdIq7grMo6lBEmwC6gUiJcRrWMqu7z10
         oLrh0sNrry4HsJ/i1XFs3cC1bHGpSVM+pGmRYIxBR9tkRhJD05xih/GTR9eNlPvrwLDX
         H5YORjd6fTh0AjmjHbndy5VUHM5dPoLpoJgqMrgCiJvKs7un3By4bgoMtcKNYLMzxgLs
         xFcWd5zb1M+IYoHwa0/HiZZZgvfMR0XeJUE4A2Laa+VtTrTbBiDDVPTp6RFGtvPKC0GG
         opYQ==
X-Gm-Message-State: APjAAAWD8JAtfuKtjj4lt3yF+qRRuMpvdfhkdPbzdpY+I5AACapyJLI5
        W+lHwCkaphK7KpU1Urm+UGw=
X-Google-Smtp-Source: APXvYqzydOlOyVPnakhiweMWIf6wc2YI0kjz18I8kvINF86MjD2eLrQgokBZzC2PN4fgpEHOVFZYbQ==
X-Received: by 2002:ac8:2c45:: with SMTP id e5mr17690657qta.256.1572277042182;
        Mon, 28 Oct 2019 08:37:22 -0700 (PDT)
Received: from cristiane-Inspiron-5420 ([131.100.148.220])
        by smtp.gmail.com with ESMTPSA id r6sm4882288qtp.75.2019.10.28.08.37.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 08:37:21 -0700 (PDT)
Date:   Mon, 28 Oct 2019 12:37:16 -0300
From:   Cristiane Naves <cristianenavescardoso09@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] staging: rtl8712: Fix Alignment of open parenthesis
Message-ID: <2a6e8fbef7b9e72d95b7c4a7cbcce08a9e231d07.1572276208.git.cristianenavescardoso09@gmail.com>
References: <cover.1572276208.git.cristianenavescardoso09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572276208.git.cristianenavescardoso09@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix alignment should match open parenthesis. Issue found by checkpatch.

Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_recv.c | 36 +++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
index af12c16..36d5d2c 100644
--- a/drivers/staging/rtl8712/rtl8712_recv.c
+++ b/drivers/staging/rtl8712/rtl8712_recv.c
@@ -61,13 +61,13 @@ void r8712_init_recv_priv(struct recv_priv *precvpriv,
 		precvbuf->ref_cnt = 0;
 		precvbuf->adapter = padapter;
 		list_add_tail(&precvbuf->list,
-				 &(precvpriv->free_recv_buf_queue.queue));
+			      &(precvpriv->free_recv_buf_queue.queue));
 		precvbuf++;
 	}
 	precvpriv->free_recv_buf_queue_cnt = NR_RECVBUFF;
 	tasklet_init(&precvpriv->recv_tasklet,
-	     (void(*)(unsigned long))recv_tasklet,
-	     (unsigned long)padapter);
+		     (void(*)(unsigned long))recv_tasklet,
+		     (unsigned long)padapter);
 	skb_queue_head_init(&precvpriv->rx_skb_queue);
 
 	skb_queue_head_init(&precvpriv->free_recv_skb_queue);
@@ -140,7 +140,7 @@ void r8712_free_recvframe(union recv_frame *precvframe,
 }
 
 static void update_recvframe_attrib_from_recvstat(struct rx_pkt_attrib *pattrib,
-					   struct recv_stat *prxstat)
+						  struct recv_stat *prxstat)
 {
 	u16 drvinfo_sz;
 
@@ -177,7 +177,7 @@ static void update_recvframe_attrib_from_recvstat(struct rx_pkt_attrib *pattrib,
 
 /*perform defrag*/
 static union recv_frame *recvframe_defrag(struct _adapter *adapter,
-				   struct  __queue *defrag_q)
+					  struct  __queue *defrag_q)
 {
 	struct list_head *plist, *phead;
 	u8 wlanhdr_offset;
@@ -379,26 +379,26 @@ static void amsdu_to_msdu(struct _adapter *padapter, union recv_frame *prframe)
 		/* convert hdr + possible LLC headers into Ethernet header */
 		eth_type = (sub_skb->data[6] << 8) | sub_skb->data[7];
 		if (sub_skb->len >= 8 &&
-		   ((!memcmp(sub_skb->data, rfc1042_header, SNAP_SIZE) &&
-		   eth_type != ETH_P_AARP && eth_type != ETH_P_IPX) ||
-		   !memcmp(sub_skb->data, bridge_tunnel_header, SNAP_SIZE))) {
+		    ((!memcmp(sub_skb->data, rfc1042_header, SNAP_SIZE) &&
+		      eth_type != ETH_P_AARP && eth_type != ETH_P_IPX) ||
+		     !memcmp(sub_skb->data, bridge_tunnel_header, SNAP_SIZE))) {
 			/* remove RFC1042 or Bridge-Tunnel encapsulation and
 			 * replace EtherType
 			 */
 			skb_pull(sub_skb, SNAP_SIZE);
 			memcpy(skb_push(sub_skb, ETH_ALEN), pattrib->src,
-				ETH_ALEN);
+			       ETH_ALEN);
 			memcpy(skb_push(sub_skb, ETH_ALEN), pattrib->dst,
-				ETH_ALEN);
+			       ETH_ALEN);
 		} else {
 			__be16 len;
 			/* Leave Ethernet header part of hdr and full payload */
 			len = htons(sub_skb->len);
 			memcpy(skb_push(sub_skb, 2), &len, 2);
 			memcpy(skb_push(sub_skb, ETH_ALEN), pattrib->src,
-				ETH_ALEN);
+			       ETH_ALEN);
 			memcpy(skb_push(sub_skb, ETH_ALEN), pattrib->dst,
-				ETH_ALEN);
+			       ETH_ALEN);
 		}
 		/* Indicate the packets to upper layer */
 		if (sub_skb) {
@@ -472,7 +472,7 @@ static int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl,
 }
 
 static int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl,
-			      union recv_frame *prframe)
+				     union recv_frame *prframe)
 {
 	struct list_head *phead, *plist;
 	union recv_frame *pnextrframe;
@@ -499,8 +499,8 @@ static int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl,
 }
 
 int r8712_recv_indicatepkts_in_order(struct _adapter *padapter,
-			       struct recv_reorder_ctrl *preorder_ctrl,
-			       int bforced)
+				     struct recv_reorder_ctrl *preorder_ctrl,
+				     int bforced)
 {
 	struct list_head *phead, *plist;
 	union recv_frame *prframe;
@@ -530,7 +530,7 @@ int r8712_recv_indicatepkts_in_order(struct _adapter *padapter,
 			plist = plist->next;
 			list_del_init(&(prframe->u.hdr.list));
 			if (SN_EQUAL(preorder_ctrl->indicate_seq,
-			    pattrib->seq_num))
+				     pattrib->seq_num))
 				preorder_ctrl->indicate_seq =
 				  (preorder_ctrl->indicate_seq + 1) % 4096;
 			/*indicate this recv_frame*/
@@ -555,7 +555,7 @@ int r8712_recv_indicatepkts_in_order(struct _adapter *padapter,
 }
 
 static int recv_indicatepkt_reorder(struct _adapter *padapter,
-			     union recv_frame *prframe)
+				    union recv_frame *prframe)
 {
 	unsigned long irql;
 	struct rx_pkt_attrib *pattrib = &prframe->u.hdr.attrib;
@@ -624,7 +624,7 @@ void r8712_reordering_ctrl_timeout_handler(void *pcontext)
 }
 
 static int r8712_process_recv_indicatepkts(struct _adapter *padapter,
-			      union recv_frame *prframe)
+					   union recv_frame *prframe)
 {
 	int retval = _SUCCESS;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-- 
2.7.4

