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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF96DC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6322089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 07:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlPxnTWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfFGH0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 03:26:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46021 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfFGH0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 03:26:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id s11so665142pfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 00:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RHp0gi/48bOa8/Rqc3wrZHO7g1dd2fqBOo8d3cKHVd8=;
        b=YlPxnTWs1Db3XxOmrIVpsiS+zz1DOoim8YylrKOUIvOP+KfoTF8EJAfKwgtA+PuB1n
         wIbK2dxr0BzsPS1EkncyM9+PzxvSDPIAMVm8yVC5no4JKGsE1R9SC9noMOOUWRdqqgVL
         aa7DCNeCsS+L7dKEpz8mVQp1yeeFt9d70mEODCR45xBjBICw8K52ZzVTWWK1+icbrnZM
         6p7s/Rrn2pFrxfEd0RJEBxzw82gJt1gxnDCyd6kkzdgSI2pBXAiwHu6UoT++0jn/5AMK
         CMEQjaHWwgg9IEQP6RqulACHcsIZdhenauihd0XSrmyQNptxxf1dWFj44T1q5/UQJD9D
         AR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RHp0gi/48bOa8/Rqc3wrZHO7g1dd2fqBOo8d3cKHVd8=;
        b=E3gunOpBsQYIADLFUA/9rc/tSNeEvDUWpG4CYs9bJIXYxTd/4AYUnclcIKMHU7qmUa
         mUHyzSB4SLY11ub8gRYmpC89JZIB8kfTV6XF6gXulp14blcPtUSsBS4RyaSkDMO+cgy4
         z3rK5pouNAtCYnShy1ZMiglxjV+TCXpOD3lx8Mug5IWi46pK7CkOzJY/DrZqNt3PgsjZ
         uuE0GFKJdBM6dwP3WywsNMkt4BpmrWOYwXIrA+HqHL6xGOBftcxir7hlvzjvJfwMKY4M
         IVYy5ZulXh/yvkZUMsyxxxci6ymOXl+Kc14QMROUgNHHFUKrDMPli7AcFjyseJraRszK
         385A==
X-Gm-Message-State: APjAAAWTrmLyNU6S4zBt+dkv9wZEQ7gDeHG37osnZxFZow0g1HWfSzd2
        Z0Uz2q1XyUfMEcvZyrmAcGE=
X-Google-Smtp-Source: APXvYqyFFpgVvXGUljtZMEgXl89xecDcSzKMmLa6XlYTpXlwWL6P++R4tmpvuvlORrtyAaof4A0P2w==
X-Received: by 2002:a62:5801:: with SMTP id m1mr57777269pfb.32.1559892380106;
        Fri, 07 Jun 2019 00:26:20 -0700 (PDT)
Received: from localhost.localdomain ([110.227.95.145])
        by smtp.gmail.com with ESMTPSA id c9sm1955344pfn.3.2019.06.07.00.26.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 07 Jun 2019 00:26:19 -0700 (PDT)
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Subject: [PATCH 1/2] staging: rtl8723bs: rtw_os_recv_resource_alloc(): Change type
Date:   Fri,  7 Jun 2019 12:56:08 +0530
Message-Id: <20190607072609.28620-1-nishkadg.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove assignment of the return value of rtw_os_recv_resource_alloc as
this assignment at the call site is never used.
Remove return statement from rtw_os_recv_resource_alloc() as its return
variable is never used.
Change the type of the function to void.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c      | 2 +-
 drivers/staging/rtl8723bs/include/recv_osdep.h | 2 +-
 drivers/staging/rtl8723bs/os_dep/recv_linux.c  | 6 +-----
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index b9c9bba1a335..687ff3c6f09f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -67,7 +67,7 @@ sint _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 
 		list_add_tail(&(precvframe->u.list), &(precvpriv->free_recv_queue.queue));
 
-		res = rtw_os_recv_resource_alloc(padapter, precvframe);
+		rtw_os_recv_resource_alloc(padapter, precvframe);
 
 		precvframe->u.hdr.len = 0;
 
diff --git a/drivers/staging/rtl8723bs/include/recv_osdep.h b/drivers/staging/rtl8723bs/include/recv_osdep.h
index 6fea0e948271..0e1baf170cfb 100644
--- a/drivers/staging/rtl8723bs/include/recv_osdep.h
+++ b/drivers/staging/rtl8723bs/include/recv_osdep.h
@@ -22,7 +22,7 @@ int	rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
 void rtw_free_recv_priv (struct recv_priv *precvpriv);
 
 
-int rtw_os_recv_resource_alloc(struct adapter *padapter, union recv_frame *precvframe);
+void rtw_os_recv_resource_alloc(struct adapter *padapter, union recv_frame *precvframe);
 void rtw_os_recv_resource_free(struct recv_priv *precvpriv);
 
 
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index 67ec336264e5..45145efa3f68 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -21,13 +21,9 @@ void rtw_os_free_recvframe(union recv_frame *precvframe)
 }
 
 /* alloc os related resource in union recv_frame */
-int rtw_os_recv_resource_alloc(struct adapter *padapter, union recv_frame *precvframe)
+void rtw_os_recv_resource_alloc(struct adapter *padapter, union recv_frame *precvframe)
 {
-	int	res = _SUCCESS;
-
 	precvframe->u.hdr.pkt_newalloc = precvframe->u.hdr.pkt = NULL;
-
-	return res;
 }
 
 /* free os related resource in union recv_frame */
-- 
2.19.1

