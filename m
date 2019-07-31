Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A409C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D21206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZ5z8q9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfGaSQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:16:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36194 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfGaSQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:16:27 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so30858739plt.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 11:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1sAf77R4gzWxgPq//0aLYDWVurwEB8Tct+N6+vCkoJc=;
        b=aZ5z8q9c46G8wcw6ld8aAEI1c+wkY1etCcS/Tbmn4AXFNj33c9L8ZADUA7eMWeL3Zw
         SFHr7AwDd4SogjhF/pE+j74/n9LEUjDCx4q0d16aWsrK9qdqQ06fUwj8kS3wD7Vqh0Ph
         I5H8pGITJWZnyhdQ9spWiM0XPpdQsMJ76W4uMSWcn8nAmSBBA7P9opI/wYTIoZon9HWU
         9EECv/PwKYFP7gpP/oZJSJsldD7M8jhz+5konnUPg25dnA5fWy+4xRAF6djP9ayvUsyX
         xBpn1WdzfGv+cnuOkyHxtIfftCCtTFPBGAi2N+6Kpd86e3wPDKFpMfSeoe/P5NWJXm7x
         e4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1sAf77R4gzWxgPq//0aLYDWVurwEB8Tct+N6+vCkoJc=;
        b=bgihUNct+VJyZuXSADuRzX5JnEtI+7LRvnb4Eu9g9bP0mbi7tPE7aOhWSEpHDe7zkN
         FcTtaTlIafUIheqdlwEtDqBkDxuC52PWSpR7zA/xwhYS0FeEvHKbZkCx8RdCAFHNZoEq
         Errdfp1wnFbl92kao4u6iTGa2yDvy3pnPAjl8J2H7SyNwk8MiDA5On4G8OioY1Y+kFra
         gTtWY+T8KU6DoKbijgL1WBRJbSgENBl98SI/LBRrkvW5a+WYlboocXbMQ0ow1J34NNa5
         pdH78BAQS0LnFUNSmlCyahOf4bieJev5k9usDo1aU74itucQ4RduO7GX9DAxLSLBu8TJ
         j50A==
X-Gm-Message-State: APjAAAUf3Sxgn3MZvjifki/ehkXqwkIlBGdC2+f3gOnw8lP+XVXH+pIb
        jSTxvTvrUM7YdK3JyJJpF4X+/PQy
X-Google-Smtp-Source: APXvYqywWgXVVa5HAchsaX6hhd9H/38bF3HhZwHjO20BOhCrJBxjBrpY0iPQjqb34gwf22YhlpGbPA==
X-Received: by 2002:a17:902:28e9:: with SMTP id f96mr116875790plb.114.1564596987105;
        Wed, 31 Jul 2019 11:16:27 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id l1sm89746867pfl.9.2019.07.31.11.16.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 11:16:26 -0700 (PDT)
Date:   Wed, 31 Jul 2019 23:46:21 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Josenivaldo Benito Jr <jrbenito@benito.qsl.br>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com
Subject: [Patch v2 04/10] staging: rtl8723bs: hal: Remove function argument
 padapter
Message-ID: <20190731181621.GA9349@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function argument "padapter" in rtl8723bs_init_recv_priv function
as its not being used

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
v4 - Add patch number

 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 4 ++--
 drivers/staging/rtl8723bs/include/recv_osdep.h | 2 +-
 drivers/staging/rtl8723bs/os_dep/recv_linux.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 032d018..7fbe6c6 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -479,7 +479,7 @@ s32 rtl8723bs_init_recv_priv(struct adapter *padapter)
 		precvpriv->free_recv_buf_queue_cnt = 0;
 		for (i = 0; i < n ; i++) {
 			list_del_init(&precvbuf->list);
-			rtw_os_recvbuf_resource_free(padapter, precvbuf);
+			rtw_os_recvbuf_resource_free(precvbuf);
 			precvbuf++;
 		}
 		precvpriv->precv_buf = NULL;
@@ -518,7 +518,7 @@ void rtl8723bs_free_recv_priv(struct adapter *padapter)
 		precvpriv->free_recv_buf_queue_cnt = 0;
 		for (i = 0; i < n ; i++) {
 			list_del_init(&precvbuf->list);
-			rtw_os_recvbuf_resource_free(padapter, precvbuf);
+			rtw_os_recvbuf_resource_free(precvbuf);
 			precvbuf++;
 		}
 		precvpriv->precv_buf = NULL;
diff --git a/drivers/staging/rtl8723bs/include/recv_osdep.h b/drivers/staging/rtl8723bs/include/recv_osdep.h
index 1056f61..47689f6 100644
--- a/drivers/staging/rtl8723bs/include/recv_osdep.h
+++ b/drivers/staging/rtl8723bs/include/recv_osdep.h
@@ -29,7 +29,7 @@ void rtw_os_recv_resource_free(struct recv_priv *precvpriv);
 void rtw_os_free_recvframe(union recv_frame *precvframe);
 
 
-void rtw_os_recvbuf_resource_free(struct adapter *padapter, struct recv_buf *precvbuf);
+void rtw_os_recvbuf_resource_free(struct recv_buf *precvbuf);
 
 _pkt *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_Length, u8 *pdata);
 void rtw_os_recv_indicate_pkt(struct adapter *padapter, _pkt *pkt, struct rx_pkt_attrib *pattrib);
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index 643cacc..a5070fb 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -43,7 +43,7 @@ void rtw_os_recv_resource_free(struct recv_priv *precvpriv)
 }
 
 /* free os related resource in struct recv_buf */
-void rtw_os_recvbuf_resource_free(struct adapter *padapter, struct recv_buf *precvbuf)
+void rtw_os_recvbuf_resource_free(struct recv_buf *precvbuf)
 {
 	if (precvbuf->pskb) {
 		dev_kfree_skb_any(precvbuf->pskb);
-- 
2.7.4

