Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15231C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9B42081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t2goOSTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfCGXTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:19:03 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46842 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfCGXTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:19:02 -0500
Received: by mail-ed1-f68.google.com with SMTP id f2so14909718edy.13;
        Thu, 07 Mar 2019 15:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M2fjlHAsB2R0OqPYdzdWtmmJ2rA66bO9eeNPnQ1mfmg=;
        b=t2goOSTCfFl7D4inBUFVhZ7Uk0viJWtS4+1eEyBp6o2iNZXFvoJ0MBMOx1JX4mHSfi
         cIWRlFrSNFGDvu6j0Avg1nkKmo6aSJRX+JSgnYv5qO6SQiW7AD1bANj3AOT6IQJ0vyN1
         nl+iOBIYVjf+MawsnrNAt4w8lfOK1OlBpvY6YJYIoemt5R+pTqi2PjwZG+YNdFP2wvad
         wTmKlhWZUy9twus+PN9uTNDyF86kzYTlCC1A+hCvplF4MbNzEuTINSUl/KagWDWSqVuY
         bU0sP2gcyEGlryzLwb8+SzmNByNJBMPFnVlI/sMIlGvs1myioZ6vNtdJi6htbolZNrHw
         +/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M2fjlHAsB2R0OqPYdzdWtmmJ2rA66bO9eeNPnQ1mfmg=;
        b=h9gQGjcoS2k70z3+jZ1MZafNfubVJzem2m7nZwAchhaOO9pyaViAOj4ChYgHS2PZAB
         NXpnDODIAic/K8gDUzw7ve7xUmFy6Imd5HFGy/GqZWnc+xQOtcTW2KS2Ccac2o7BemRN
         BWey8k1Bo0pA5zh3qxy80ghCR8DtH7uqFuvlKiKLP/jYtLYbbniFRKk3rpXIq8jUax73
         qPci/3VwHMqiArQhm0JZzzVkNXtg+rGQUpmc56LRBNue1b4vIl6Lw/2LHvtRnZz8Sr1f
         nHrW9w1tEexBwR2oOTTHheGekpdhW7opqynl98zqe3BfPvyTy6WfU218q5/qjquF5luu
         UMbw==
X-Gm-Message-State: APjAAAXJ7f+jStctzNQmMQfrc/b0+OwD/HPUhyN6TjPQeSO6OVsDaFW1
        ScJtu4+YMfeBd5CLFleN7rYoy0ALMXZsbw==
X-Google-Smtp-Source: APXvYqz03A4JCGQ/2jpQ8HEQ3n+zuC9VfZEQfhpQXX/2A6qGn0d7t7UCJ7lE9e3yYp7POQZ8lqbHxw==
X-Received: by 2002:a50:92d0:: with SMTP id l16mr30347137eda.153.1552000740746;
        Thu, 07 Mar 2019 15:19:00 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id gx5sm1117073ejb.37.2019.03.07.15.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 15:19:00 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Achim Leubner <achim_leubner@adaptec.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] scsi: gdth: Only call dma_free_coherent when buf is not NULL in ioc_general
Date:   Thu,  7 Mar 2019 16:18:39 -0700
Message-Id: <20190307231839.3330-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

drivers/scsi/gdth.c:3662:6: warning: variable 'paddr' is used
uninitialized whenever 'if' condition is false
[-Wsometimes-uninitialized]

Don't attempt to call dma_free_coherent when buf is NULL (meaning that
we never called dma_alloc_coherent and initialized paddr), which avoids
this warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/402
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/scsi/gdth.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/gdth.c b/drivers/scsi/gdth.c
index e7f1dd4f3b66..0ca9b4393770 100644
--- a/drivers/scsi/gdth.c
+++ b/drivers/scsi/gdth.c
@@ -3697,8 +3697,9 @@ static int ioc_general(void __user *arg, char *cmnd)
 
 	rval = 0;
 out_free_buf:
-	dma_free_coherent(&ha->pdev->dev, gen.data_len + gen.sense_len, buf,
-			paddr);
+	if (buf)
+		dma_free_coherent(&ha->pdev->dev, gen.data_len + gen.sense_len,
+				  buf, paddr);
 	return rval;
 }
  
-- 
2.21.0

