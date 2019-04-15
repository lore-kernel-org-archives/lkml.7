Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455A5C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102A620848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 20:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bh4Etreu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfDOU1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 16:27:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37823 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfDOU1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 16:27:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id c16so15652887otn.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 13:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WkM4j4aIdPKGONOje49qtYbSE4hWkNyrbI/TPWgw/z0=;
        b=bh4EtreuKMqJiq5bSGidkjfz3EGnMIMlsOEw2xHpChB9+fOf/iCPBcACYbgESzFEmw
         8U0ifobHdK6OaBMMTQaC23cHaGQmTnqlVS6tt0Y6IR9e4L+WzNr6tZEYUKer7hWxG9wL
         lNA93mcqzAWKLfmgS3wsZopn7kxe0rwsLrq9KJP6IleD6D+tqPwEul6RGlfxlzYBwTym
         JGLH4NcZmSS5WpcstFwMqBmchkMGZY8gM2wCKF/vRcYZDcQs48styP/p8GywJtU8Mfj/
         9Nsf7dXBkYVJZf6ldLI/7qzMEb5PHpcXDtv18bMeosBSv/bi9T1iUcnoCJJgqCc85yXi
         4l3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WkM4j4aIdPKGONOje49qtYbSE4hWkNyrbI/TPWgw/z0=;
        b=gTk8XkqoUZ+n/LcmllQ/9Bljpl+GUPMLzGybbkRLx8E3qcvcPUy988JNwzkA5Os/u8
         0looyoQZnIbT+WwsTLUqjyFcT5RD+Kp9RRr/DTgWPexRv+izNSIKvNiqrGPPUw3+lgPx
         xgEIcV0rMz4+CpxDoLhfuL5tzu1ckP3F0qmhtWM0jvSIWMeizKWWR3lH3nU7YKS5Geb+
         Q0P3NOsyGYVatYRvBYysK+dQUQQ4i8Kwbxc5ZfubKofbrRUZr1pHErIJhETPCLCxjjIA
         puB12V0blMUA4GRrqrQDiVc3d9biKd55VkBQkqtUhk759rbSR+PQzaMHLO6jjxSmSpzm
         BKfQ==
X-Gm-Message-State: APjAAAWK7ReH+f4+uUAVglRBv2QiwiQCmd5/JsVPtgsFd1O5pZjPwYmv
        i6mo/BCDrUKbGh8FDrSwE2I=
X-Google-Smtp-Source: APXvYqyClyMlU3yre3CPriCBN0Imqf+ZEDQ1VSwQ8Vas+9kEgBc4ntxaIHbRTeROoGIt4+IDHOemqg==
X-Received: by 2002:a9d:5919:: with SMTP id t25mr49040180oth.133.1555360031592;
        Mon, 15 Apr 2019 13:27:11 -0700 (PDT)
Received: from madhuleo ([2605:6000:1023:606d:95f5:9dbc:648:48d7])
        by smtp.gmail.com with ESMTPSA id w2sm19575049otk.73.2019.04.15.13.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 13:27:11 -0700 (PDT)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Subject: [PATCH 1/3] Staging: rtl8723bs: Remove typedef in struct ieee_param_ex
Date:   Mon, 15 Apr 2019 15:27:02 -0500
Message-Id: <5d8187a99cd1be13aed21a5b0ea784728a43869c.1555358247.git.madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1555358247.git.madhumithabiw@gmail.com>
References: <cover.1555358247.git.madhumithabiw@gmail.com>
In-Reply-To: <cover.1555358247.git.madhumithabiw@gmail.com>
References: <cover.1555358247.git.madhumithabiw@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove typedef in struct ieee_param_ex, as the struct that
has elements that can reasonably be directly accessed should
never be a typedef.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 drivers/staging/rtl8723bs/include/ieee80211.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 9efb4dcb9d3a..8077465402c6 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -242,11 +242,11 @@ typedef struct ieee_param {
 	} u;
 }ieee_param;
 
-typedef struct ieee_param_ex {
+struct ieee_param_ex {
 	u32 cmd;
 	u8 sta_addr[ETH_ALEN];
 	u8 data[0];
-}ieee_param_ex;
+};
 
 struct sta_data{
 	u16 aid;
-- 
2.17.1

