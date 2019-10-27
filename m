Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873A8CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 13:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D71721850
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 13:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmKC8Mt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfJ0NGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 09:06:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34962 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfJ0NGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 09:06:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id v6so6447966wmj.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 06:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q7+ITGPF3JM+lAUTt3VXVFdC2laXS2ImbyjZp+wnQkw=;
        b=fmKC8Mt16jXkc4PKFgndhqbChVqmzKGwWDi85jHuZEmLwlE1uf35csN1Plu96qz69f
         nNDSavXTztJ/l540EdD1hwTTOp/7GwO+PuubXwLcW8HTTpXTk+k5RiF37ExwJO+YhWJV
         KFILhc8Pmb/1iBb3fuT2zHRQZmWE6SO4m3gm62DAkOE0fO+kj3QkpK+d8MxhC5h0nJ/A
         xhl6T6nWOS7vYxvjUV3B/15Qyg0cWcz8no6jk1//3VpMohFeafFqCsJc0OTuuWc0rS9D
         BAuOOTx8jfFOkH4s3VvFTBF/dQdhLdTSIuYG2StnROaIKT8FmnfASvYvkQFYpLQ5kWcY
         Di3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q7+ITGPF3JM+lAUTt3VXVFdC2laXS2ImbyjZp+wnQkw=;
        b=O33IYt6zSbd//d93nuHRT1zwy9EHhaCi9iagL9+0jRVFofJGYDl+1nbhE5BAsFdBzo
         yL98G7ztoGuqA0O6vjukbvEN1n++WggHQmLH47imlfdIPzKUOGxovjkCrAUXE86uFZbl
         pdV5DxHxaOVHNznPFggiQxBkQECXAAzPDJ6AqXG/SGBubBqvyxn3ucgyaa3Txuirn+rA
         /uWl6J2liUZcePrwnb0zHdLoXL+9PhW7QkoDp03pkNARWORTk+VFhzGvrgrd0F67NFGV
         26bhp19rRh5UE5EKFV2QeiUCbUmpiVSB2Jc2cJdG8JizzZm4ZaKyYXbX0GxnCHrGuI7q
         2rVQ==
X-Gm-Message-State: APjAAAVHfclc/CLqEbePF/WxBdvGrJpgPbaAnAzvTd1cXliKa11OTjMU
        7DMiqnU2At0EuYwbys9La6gF12bI
X-Google-Smtp-Source: APXvYqxs3IK7zhapjHaGamTvhkE6gKWudgHFpIba5HV0aUuxyC8ucqXisVIWTW+330hRoLVlJ9Qi8g==
X-Received: by 2002:a7b:cc89:: with SMTP id p9mr10805931wma.99.1572181592820;
        Sun, 27 Oct 2019 06:06:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96bf:e0ab:2b68:5d76:a12a:e6ba])
        by smtp.gmail.com with ESMTPSA id 126sm8127371wma.48.2019.10.27.06.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 06:06:32 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: rtl8188eu: replace tabs with spaces - style
Date:   Sun, 27 Oct 2019 14:06:04 +0100
Message-Id: <20191027130604.68379-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027130604.68379-1-straube.linux@gmail.com>
References: <20191027130604.68379-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces where appropriate to cleanup whitespace.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_sta_mgt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
index 8b7adb9e76c2..73f2cb5ebaa6 100644
--- a/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8188eu/core/rtw_sta_mgt.c
@@ -167,7 +167,7 @@ struct sta_info *rtw_alloc_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 {
 	s32 index;
 	struct list_head *phash_list;
-	struct sta_info	*psta;
+	struct sta_info *psta;
 	struct __queue *pfree_sta_queue;
 	struct recv_reorder_ctrl *preorder_ctrl;
 	int i = 0;
@@ -318,7 +318,7 @@ u32 rtw_free_stainfo(struct adapter *padapter, struct sta_info *psta)
 
 		spin_lock_bh(&ppending_recvframe_queue->lock);
 
-		phead =		get_list_head(ppending_recvframe_queue);
+		phead = get_list_head(ppending_recvframe_queue);
 		plist = phead->next;
 
 		while (!list_empty(phead)) {
-- 
2.23.0

