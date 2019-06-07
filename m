Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DFFC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C9D2089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGOzv0eV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfFGH02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 03:26:28 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40065 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfFGH02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 03:26:28 -0400
Received: by mail-pg1-f196.google.com with SMTP id d30so689240pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 00:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZgtTyD3UeV/hG6EXB2fOVsSRbZVCu6x5ymbmsQ+VHSs=;
        b=IGOzv0eVtPNnDuZaptEPGGT7wGVBggqcEtAkNtUhkCWIBlqyuZ5omydOZl+3A8gMfY
         dog/OBlv0+jp+PS9rBIIUeBZyx7sUUQDnPX9EoBGF53bWaNW2YeoHrD8T7lziCt3NFf9
         JmOhhOg+0A92AqiefzOpc0JrW4zNrxEeCg11aGp4GAOi60WvP8oKFgqIBQki0OVH6Jsp
         R3jBFgDhhAq8aeVsZweSGxMmRZ4gzpd5JipiBW5GZNYBeMXasMI9lCPZKjQIQIHp6+2O
         YWTO4XI+zhmNjcojHN+3fXXiYYR/MWod+NqBrTYGpeNOGVnbDO3+9OkM4wU1wPtCmPlK
         tuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZgtTyD3UeV/hG6EXB2fOVsSRbZVCu6x5ymbmsQ+VHSs=;
        b=oA4+3j0A2uXbmbvWe2YiH33QnqzDOpbvRgbnef6ZivHnrE9GUDM/FvfRdet88VZleH
         h7sti+G8BvDLbjo4inpC/dhB7oHFB1d9YbZUEtOQFyapK1X90VM6IRgcbrimEkGVpUc9
         eUsjB7QjFDwZmo+kjVY0P6y1r0GrSPpO/q9itL+jYYwqqffiT+Ev90+I68FxOnKVwpWS
         qAbVL0P4CYLLqU8YkSGGZ4+RWEfvgIAiTi0nR9Sv8FNbGlSQkPzvN/rq5mZZl7UzYpC8
         Nf8CbEisXbN36uC9QubEYPJWIjY3MyngfDbZRrYHO0qoXFGYIYgSlmPjAWu9au6wqLLX
         2i9A==
X-Gm-Message-State: APjAAAWI1cB/W4PIudlVZCh9LSaNBJAPdM3AjN+cZC9Qp2crZnDAp8uV
        R9P1kf4aijeWLVSvf3nK9qADR8G6
X-Google-Smtp-Source: APXvYqwy5jOxhn+olMjPszPvnWPJZ+kbBUFhBHdwPxHHqc8A6ImBkDcZZk8fJG9+wROpQvFhMsqIwA==
X-Received: by 2002:aa7:9293:: with SMTP id j19mr14297872pfa.190.1559892387920;
        Fri, 07 Jun 2019 00:26:27 -0700 (PDT)
Received: from localhost.localdomain ([110.227.95.145])
        by smtp.gmail.com with ESMTPSA id c9sm1955344pfn.3.2019.06.07.00.26.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 00:26:27 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH 2/2] staging: rtl8723bs: rtw_os_recvbuf_resource_free(): Change type
Date:   Fri,  7 Jun 2019 12:56:09 +0530
Message-Id: <20190607072609.28620-2-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190607072609.28620-1-nishkadg.linux@gmail.com>
References: <20190607072609.28620-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change return type of function rtw_os_recvbuf_resource_free to void as
its return value is never stored, checked or otherwise used.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8723bs/include/recv_osdep.h | 2 +-
 drivers/staging/rtl8723bs/os_dep/recv_linux.c  | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/recv_osdep.h b/drivers/staging/rtl8723bs/include/recv_osdep.h
index 0e1baf170cfb..1056f615d0f9 100644
--- a/drivers/staging/rtl8723bs/include/recv_osdep.h
+++ b/drivers/staging/rtl8723bs/include/recv_osdep.h
@@ -29,7 +29,7 @@ void rtw_os_recv_resource_free(struct recv_priv *precvpriv);
 void rtw_os_free_recvframe(union recv_frame *precvframe);
 
 
-int rtw_os_recvbuf_resource_free(struct adapter *padapter, struct recv_buf *precvbuf);
+void rtw_os_recvbuf_resource_free(struct adapter *padapter, struct recv_buf *precvbuf);
 
 _pkt *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_Length, u8 *pdata);
 void rtw_os_recv_indicate_pkt(struct adapter *padapter, _pkt *pkt, struct rx_pkt_attrib *pattrib);
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index 45145efa3f68..3fe9c2255edd 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -46,16 +46,12 @@ void rtw_os_recv_resource_free(struct recv_priv *precvpriv)
 }
 
 /* free os related resource in struct recv_buf */
-int rtw_os_recvbuf_resource_free(struct adapter *padapter, struct recv_buf *precvbuf)
+void rtw_os_recvbuf_resource_free(struct adapter *padapter, struct recv_buf *precvbuf)
 {
-	int ret = _SUCCESS;
-
 	if (precvbuf->pskb)
 	{
 		dev_kfree_skb_any(precvbuf->pskb);
 	}
-	return ret;
-
 }
 
 _pkt *rtw_os_alloc_msdu_pkt(union recv_frame *prframe, u16 nSubframe_Length, u8 *pdata)
-- 
2.19.1

