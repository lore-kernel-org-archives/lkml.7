Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE80C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4E422314
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DtYrm5MU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgACQW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 11:22:27 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:39654 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgACQW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:22:26 -0500
Received: by mail-wr1-f45.google.com with SMTP id y11so42927244wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 08:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oF6knoEIXIh5/2ho9eTkMDQ7i4T1em2sODYcYmaIN5c=;
        b=DtYrm5MUavfkQB19MOkx+e5+C6/cUcDApFUtzA9WpER0cVl9741KQrWYWRUtX6n6Gs
         fFoxSyYEmQBKM1VecUnS5KUvtYBX/TeLISjUuwRuPFf/PC3MCNpPylQ0tY4D8EmDQbil
         GGP1ypD3cqATXzVXaH5cgIExNEKkc3p903rtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oF6knoEIXIh5/2ho9eTkMDQ7i4T1em2sODYcYmaIN5c=;
        b=FLJG3jY9Llgaszk06FtK98ScM2p2/gWc+MNRjEFXXwT8+u+OAjlLkYwz+3GwIUSaYv
         pMbMFdXN/UfIgEEm/lQa48e5sVGjFsTLFD+cFhIdF/1p0uUbi5nCoHG3ra2UkdwwRs3D
         NJJ0+Rvgyr1juAXReOP6sbAOZtfmSB/9Yfs5wwErczHC9Jmafd3z6Wqm4fg/wfMaVB4R
         w/SrhOSCnwGEq9pIqnhyBM9cAOL+5QYtYMFgt4Ss1VgbKW2RiHZQMyLNSQ0J4QbDFU6n
         Nnzb3NaPLbBZoQJu5RZfZn+W1bESVr1Cy1mHk5qLD36rWKf9lrd8L5qvubqpu7GPubVb
         Pe1A==
X-Gm-Message-State: APjAAAX1ZpRaMHJwmsvruGKStDy1iV8HHV/BWVK74sbhVv2pERKuBoqr
        N2W8qMsZPhWXpV+fAuI+4fjnAg==
X-Google-Smtp-Source: APXvYqxvBE16IVnnlgPkedV5XAxfpmeejqjdDd74lI7Zi2q0EV/30uX7B9ylxWLNiSGHHHvtMdqAog==
X-Received: by 2002:a5d:6048:: with SMTP id j8mr88887949wrt.41.1578068544506;
        Fri, 03 Jan 2020 08:22:24 -0800 (PST)
Received: from Ninja.ibn.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id n8sm61348706wrx.42.2020.01.03.08.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Jan 2020 08:22:24 -0800 (PST)
From:   Vikas Gupta <vikas.gupta@broadcom.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
        netdev@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Cc:     vasundhara-v.volam@broadcom.com, vikram.prakash@broadcom.com,
        Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH INTERNAL v2] firmware: tee_bnxt: Reduce shm mem size to 4K
Date:   Fri,  3 Jan 2020 21:50:04 +0530
Message-Id: <1578068404-26195-2-git-send-email-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1578068404-26195-1-git-send-email-vikas.gupta@broadcom.com>
References: <1578068404-26195-1-git-send-email-vikas.gupta@broadcom.com>
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

