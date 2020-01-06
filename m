Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5EDC32767
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 06:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E47B2072C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 06:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Qx9hJxqS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgAFG0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 01:26:08 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:39465 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgAFG0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 01:26:07 -0500
Received: by mail-pj1-f54.google.com with SMTP id t101so7347971pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 22:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oF6knoEIXIh5/2ho9eTkMDQ7i4T1em2sODYcYmaIN5c=;
        b=Qx9hJxqSoeByPnDu5I6N8nLqYmnD/n/TFizYFSxkokDBcGr9HZGOz/YmHxE9KWiBQQ
         vTMdnGLmUbAzuVa8C8/5DsVHVYPsom3mnAZ6P2Y7g6qzv53Ycovd58KswcOdQStRrPEx
         QhDffY24zViPnDYARO/2ujDursTTjRJTfXW48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oF6knoEIXIh5/2ho9eTkMDQ7i4T1em2sODYcYmaIN5c=;
        b=crt7Stf2NqU/oeecjsAUyG7vNn1TZNnM2Nq3s0XTUklRFoS7hwtU6j0xxTSvxbloUJ
         rGCZBpbvAoTA/NJ8KMjKzAbbU8pA/KmkRg69EP6N2crToWvvGNQt6o+pQoKvnIPaF7Vp
         ySDuW7bu0d/1RfZvMYNdp6/tTempWgjluTEc/f5tUnzjorz9zJL0AVlvMMA45TX68VB9
         wHQA8kggGI23RonKy3tLZFbOqsXTnY7al/81lErbCyu05S+THqN2okYETX4sIuAnTljg
         QmsdBuhTcIJlvYrd46pX312tkwvKfZ2naJ9XW33+S8z3YiN5Mvoql91k4sfv8TAJgpGo
         qSfQ==
X-Gm-Message-State: APjAAAXTZiz0qO3ERa2PsYMZ9hFz7hNtGltuMK0SrIT5AJtamRLx+8oD
        IhmZlKSNw53kNBdVzCcMVeILvA==
X-Google-Smtp-Source: APXvYqyoEbhHG23Net99CSVTZkoLeCXvBLndpYwq4e+TTbG9IrD3BVjtQW9FzAL0L05mswcPYvmoLw==
X-Received: by 2002:a17:90a:b10b:: with SMTP id z11mr42304735pjq.132.1578291967278;
        Sun, 05 Jan 2020 22:26:07 -0800 (PST)
Received: from Ninja.ibn.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id o16sm70704250pgl.58.2020.01.05.22.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Jan 2020 22:26:06 -0800 (PST)
From:   Vikas Gupta <vikas.gupta@broadcom.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Cc:     vikram.prakash@broadcom.com, vasundhara-v.volam@broadcom.com,
        Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH v1] firmware: tee_bnxt: Reduce shm mem size to 4K
Date:   Mon,  6 Jan 2020 11:54:03 +0530
Message-Id: <1578291843-27613-2-git-send-email-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1578291843-27613-1-git-send-email-vikas.gupta@broadcom.com>
References: <1578291843-27613-1-git-send-email-vikas.gupta@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce shm memory size as maximum size supported by optee_shm_register
API is 4K.

Fixes: 246880958ac9 (“firmware: broadcom: add OP-TEE based BNXT f/w manager”)
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 drivers/firmware/broadcom/tee_bnxt_fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
index 5b7ef89..8f0c61c6 100644
--- a/drivers/firmware/broadcom/tee_bnxt_fw.c
+++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
@@ -12,7 +12,7 @@
 
 #include <linux/firmware/broadcom/tee_bnxt_fw.h>
 
-#define MAX_SHM_MEM_SZ	SZ_4M
+#define MAX_SHM_MEM_SZ	SZ_4K
 
 #define MAX_TEE_PARAM_ARRY_MEMB		4
 
-- 
2.7.4

