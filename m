Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DFBC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632FB20825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557258213;
	bh=yn7oS6FbPulnWCg/NO5lfTSUJjdhQNavqt5cQamhJcQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=MsNqW2aQ8dtWQ8oEAoY9WvhRyi59uh+w/9biQKz5k2g7ROf+qlAOeUDf/jJyA6YQv
	 rTFxt4aSusNVSMyzjAdM41o87HTIbCYN7TS/vq9zrMYcH6P+NlLN2vQUY8z7S8GMqA
	 UM+/k6kSkeuJ5m0/fMBrTV+f3OiwX7WJWBKPtIaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfEGTnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 15:43:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39257 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGTnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:43:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id w22so7509838pgi.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 12:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ewkuTpRG7XAqOKCyoArod5p1Qyn37L7LNzmlcvLqB88=;
        b=iaxTt/J7Mu++c4BvPt+8sUIKonluie6X4FyPKnFx5lzl4fhH4OHwwYoV4+NJTnPLtm
         YHlTeRcQFo5oR4Y0UT+1aYdzQrDQFLD6vdHpwZOm0Mg9y4WLRBoo2B8ZuZ0833hHIob3
         v8vjA8gUeQtcyo92ovRpzL9PKuU2WnZPf3Y1luBL5EECCU9JBpQovkuGHslGz3yeqMn7
         /FLo7FCKBWa6ww3lphu3i8iNBfO3YsorUQt14Ii7mKkMhoauUNQb1N0twi8KtnnilMFY
         QC521xSjyRNfUJR+9ipYeH+XUXL6epLgs4Fk5f6Q3QSmwmxhoalLTFryG3yZbLfbR83W
         y1+Q==
X-Gm-Message-State: APjAAAWHvsjbVo6HqNqnhvBJoBuIv7tzejMxSFVD7kyqCX7FzRiy4GMp
        bVISErR7q9JKzgq0s84VHnZAkg==
X-Google-Smtp-Source: APXvYqzBkEu3Inaaw5RJcp14jDR73QiaQstLX9sXE/2auF/4QH+BQhdInVPnwxoNgO9g7hlwJL4HxQ==
X-Received: by 2002:a62:e50a:: with SMTP id n10mr43912680pff.55.1557258210936;
        Tue, 07 May 2019 12:43:30 -0700 (PDT)
Received: from localhost ([2601:647:4700:2953:ec49:968:583:9f8])
        by smtp.gmail.com with ESMTPSA id s79sm31216845pfa.31.2019.05.07.12.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 12:43:29 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     atull@kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
        Moritz Fischer <mdf@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2] fpga: zynqmp-fpga: Correctly handle error pointer
Date:   Tue,  7 May 2019 12:43:13 -0700
Message-Id: <20190507194313.1618-1-mdf@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following static checker errors:

drivers/fpga/zynqmp-fpga.c:50 zynqmp_fpga_ops_write()
error: 'eemi_ops' dereferencing possible ERR_PTR()

drivers/fpga/zynqmp-fpga.c:84 zynqmp_fpga_ops_state()
error: 'eemi_ops' dereferencing possible ERR_PTR()

Note: This does not handle the EPROBE_DEFER value in a
      special manner.

Fixes commit c09f7471127e ("fpga manager: Adding FPGA Manager support for
Xilinx zynqmp")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Changes from v1:
- Address Alan's feedback regarding handling both occurences.

---
 drivers/fpga/zynqmp-fpga.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
index f7cbaadf49ab..b8a88d21d038 100644
--- a/drivers/fpga/zynqmp-fpga.c
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -47,7 +47,7 @@ static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
 	char *kbuf;
 	int ret;
 
-	if (!eemi_ops || !eemi_ops->fpga_load)
+	if (IS_ERR_OR_NULL(eemi_ops) || !eemi_ops->fpga_load)
 		return -ENXIO;
 
 	priv = mgr->priv;
@@ -81,7 +81,7 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
 	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 	u32 status;
 
-	if (!eemi_ops || !eemi_ops->fpga_get_status)
+	if (IS_ERR_OR_NULL(eemi_ops) || !eemi_ops->fpga_get_status)
 		return FPGA_MGR_STATE_UNKNOWN;
 
 	eemi_ops->fpga_get_status(&status);
-- 
2.21.0

