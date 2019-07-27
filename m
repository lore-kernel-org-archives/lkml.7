Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926C9C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 12:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5BD2085A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 12:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9FogJPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbfG0Mgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 08:36:42 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34959 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfG0Mgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 08:36:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so25755521plp.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 05:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=BcNT+MFCkxdPKPzetxscvcsG7DH/SGCqmRYrqRRIav8=;
        b=t9FogJPyaEYktz+rgn930epLshe+hxaW1YbRK3b7otL2/m53rWbC7Mfrz1R/8BEemu
         PfHYVYDlNHh8X1rgH47s7tNIxECURl0fPvD746WU8S7y9NNB/EMMIlYn89sGU0G92CUv
         VKDI5M/s6SZntF3LPSEmvgg0JvrGby6PFFYq3x3B1lB6JjNPf8pFdpW3n6ZDs5sxGJZw
         d2oEPd37Hb2rgoJWJurflOIxaFOYALZg81RBt3c71LnNywXMCPwoRWMhkQshy6zMng9/
         ThQclJMiOd79DmFc4thzcYW6SSOrvHXxZi11iP6XEoC1IYE092za6Gej0lK/MWvTHtSS
         EVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BcNT+MFCkxdPKPzetxscvcsG7DH/SGCqmRYrqRRIav8=;
        b=Gdy33dkZV75lgP8fo+87DVcwY+fLIGwFqArU2RwMr5DYDxO5eKe+CIiuOXRDCdiJ3e
         iNQT8kiNnOgbSGHjd3G6eAboO2Z9Cj2l/K6FxU3XLqVrOopur2Afn6+Edx1Zo3iQko30
         2t1iP60LhcKb0Iqv8unLlmMN05yElbPlOTJWtAJWfLhu3GQ8dgrP1PhMKEeU8wCjw/I0
         ZzooLp8Fb4XpxyZ639NKwl8uc0IkW/BLNxJ35fYjjuLdXP9mgxMpex8A/0t4tVtYZYwj
         WXcOZUK2hbQChi9qVAHLjM+I1xqdBDYy97lCFVnOQTvo0UpzP5AaLCVvsLzpuyjIcqPc
         3O/w==
X-Gm-Message-State: APjAAAXo8htW2xcdAzR5gJuqbUKjLW29qs3q+F87ZXsnbto9P37xnitr
        vnGifo2gJ1x0Ehe5db0bpXQ=
X-Google-Smtp-Source: APXvYqyy2ApCW47XDeDmB6DunhoI/d98KYyUxu1caSkKE93oDf+RvAIeTJDyNX18mJKLmClqoRZ0mg==
X-Received: by 2002:a17:902:4124:: with SMTP id e33mr94564573pld.6.1564231001740;
        Sat, 27 Jul 2019 05:36:41 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id s185sm82919285pgs.67.2019.07.27.05.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 05:36:40 -0700 (PDT)
Date:   Sat, 27 Jul 2019 18:06:35 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Josenivaldo Benito Jr <jrbenito@benito.qsl.br>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com
Subject: [PATCH] staging: rtl8723bs: hal: Remove function argument padapter
Message-ID: <20190727123635.GA6797@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function argument "padapter" in rtl8723bs_init_recv_priv function
as its not being used.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 4 ++--
 drivers/staging/rtl8723bs/include/recv_osdep.h | 2 +-
 drivers/staging/rtl8723bs/os_dep/recv_linux.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index e23b39a..022f8fd 100644
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
@@ -519,7 +519,7 @@ void rtl8723bs_free_recv_priv(struct adapter *padapter)
 		precvpriv->free_recv_buf_queue_cnt = 0;
 		for (i = 0; i < n ; i++) {
 			list_del_init(&precvbuf->list);
-			rtw_os_recvbuf_resource_free(padapter, precvbuf);
+			rtw_os_recvbuf_resource_free(precvbuf);
 			precvbuf++;
 		}
 		precvpriv->precv_buf = NULL;
diff --git a/drivers/staging/rtl8723bs/include/recv_osdep.h b/drivers/staging/rtl8723bs/include/recv_osdep.h
index 1056f61..00b0e2b 100644
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

