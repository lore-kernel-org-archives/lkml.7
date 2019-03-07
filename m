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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08124C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C156320854
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmGPR2/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfCGXRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:17:16 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38091 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfCGXRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:17:15 -0500
Received: by mail-ed1-f68.google.com with SMTP id h58so14920791edb.5;
        Thu, 07 Mar 2019 15:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HsuGuRy3d52TH3/+/DqsLafhOS+JbhzuIEVMSFmYeK4=;
        b=pmGPR2/n5RJ8ycfqhJYyqjix29UDU6asQ3On5X36FpXAj9kWlMNX1SkOcz35sk1YJw
         w0U6/p8QmXgFqxNr5TKGFAkrOEhpzcAAHwCAkaMtcrxiw1ZBn9iFrwg5QKfAyKLVH1tp
         AjZgammH6lLcj2l99huNc2VdODAmOiWo9hCUaEfTHBygDIAfGkYpejZZKohqBA7WJ0Tk
         X3FORKAbLSKwKjAM/RmRFzkP+rfpcQLzqEQ6eX39RNGb8f+yqHfsDQ5sOX3tM1fM5Z8i
         PN7SzvT7QdphLgGfpKfrOp4cDzx/S58llAZxSxJBMwOFC9T7tZ0GsO2s3ZS1ryptntOH
         MFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HsuGuRy3d52TH3/+/DqsLafhOS+JbhzuIEVMSFmYeK4=;
        b=PG0WxJXdwb1YxSK2wCdsml0qG/9ubaruyTVdI6RyhNbKFddP7dOKELYJFtl+tghStR
         ad7mqDqFq4UGLPbfCLZYs3kTS9KmcvJPn4qgSf2ia40qYHMRv3BtJAFRMfqHrB6l6xoZ
         O0oaXP9R4SzuAeyQgi/VTonLXplA+Nk+e/ve8dKFh4xd7bV3jQCHMqF8zGW4FlHrG1Tb
         PXhCR5WLc81yIbLPQparutWqjonPiJkRc8bivvfwp9CGmF4wgoPIRPYBIOZFxR84oIH7
         LGg+ruNoKBiTNrRC6I2F85+bDBvhVRbZHYBaJicyyiqXTIb6VWJyHocZY3CyCwbuHTdp
         zXtw==
X-Gm-Message-State: APjAAAV9x/z8T8iR0sHopQzSlsG1DZJZ9ApXEWF6kiJ8S5Ofgs3+W29w
        0xdMTXbFScWRhNQAdExc1ug=
X-Google-Smtp-Source: APXvYqzXD2pMqcA1w7D+cEiEnferuYyx16OL2Zp9nPmEQxlji+sBvFwzSyhQ7VTywPkuMugF4FeMhg==
X-Received: by 2002:a17:906:7c49:: with SMTP id g9mr9561245ejp.31.1552000633584;
        Thu, 07 Mar 2019 15:17:13 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id b10sm1667590edy.80.2019.03.07.15.17.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 15:17:12 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     QLogic-Storage-Upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] scsi: qla4xxx: Don't call dma_free_coherent when buf is NULL
Date:   Thu,  7 Mar 2019 16:15:35 -0700
Message-Id: <20190307231534.2640-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307184125.21419-1-natechancellor@gmail.com>
References: <20190307184125.21419-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with -Wsometimes-uninitialized, Clang warns:

drivers/scsi/qla4xxx/ql4_os.c:5915:7: warning: variable 'buf_dma' is
used uninitialized whenever 'if' condition is false
[-Wsometimes-uninitialized]

Don't call dma_free_coherent when buf is NULL, meaning that we never
called dma_alloc_coherent and initialized buf_dma.

Fixes: 2a991c215978 ("[SCSI] qla4xxx: Boot from SAN support for open-iscsi")
Link: https://github.com/ClangBuiltLinux/linux/issues/391
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Check that buf is not NULL, which matches how dma_free_coherent is
  called in the rest of the tree. This still fixes the warning.

 drivers/scsi/qla4xxx/ql4_os.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 16a18d5d856f..9f56dafc3cda 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -5982,7 +5982,8 @@ static int get_fw_boot_info(struct scsi_qla_host *ha, uint16_t ddb_index[])
 			  ddb_index[1]));
 
 exit_boot_info_free:
-	dma_free_coherent(&ha->pdev->dev, size, buf, buf_dma);
+	if (buf)
+		dma_free_coherent(&ha->pdev->dev, size, buf, buf_dma);
 exit_boot_info:
 	ha->pri_ddb_idx = ddb_index[0];
 	ha->sec_ddb_idx = ddb_index[1];
-- 
2.21.0

