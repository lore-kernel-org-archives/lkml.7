Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59E9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F4A218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bb8GRx70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfCUOnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:43:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51106 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUOnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:43:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so3093899wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 07:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+/wXPUd/kMUWh/yd/zwhi/sHCVpsvr5i8zEbLLtmVCw=;
        b=Bb8GRx70Nwe/ZEWNeH4UY/uclrOU/MnHK2P7eWRyP6bMGiQYt0C46nLTdMiIJNUpSa
         gvSUtVp9C+xrsZVXV5dQ/1vyrFhexofr9Fb2sMDTdRTmv2+lrx3zFQL2GPFFi8E+jpoX
         +i3NsMFGr/8PlRQ794svVcec9ef6Eq3O5M46ZmJXu6hHZOcE1mWz/D+uTaSy3lTYVNfn
         /COfd11egzjfTgl2JBL2QmF0bxDKqxLjX/gND09HytLWUDIx6L4MuFkB98o2pm8C7m+3
         TmgD3s67VXkKFdeIJwKkt3QLm/USsGrslh0aif0YxaqtdhY9Sm7We5T/rZAgI3d27eI/
         ixGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+/wXPUd/kMUWh/yd/zwhi/sHCVpsvr5i8zEbLLtmVCw=;
        b=DAFZORgewZjdahIivH0PTMLhEo9MSb1AG4IH3gN0unfVsvUH+uavmTHzzVdxDXFodZ
         tDosf7Z7okSJ5rz6uZY5YtJVdJ5Nu5f7XLSToBOxfKO48+PnTourk+R7bVnxakNV86fF
         qwIUEXas1hf9rqe47PTtlvYdcOeciZteyf+frcvYVBZ/lbfTae/AF6yTq7KvduA0Mtoy
         heQPi0GQKmxfrkMPEjNuTjbbZblMX5oEhIVF1WKyarTcTYxmSV/o0qGaM7a4XV0tkW5S
         OBkAel0hmhMRuoupTBgdl3owOdlNLkJr7NudpCC174U2fHf3QhcK4/s/RY+7naJHOQDa
         gC4Q==
X-Gm-Message-State: APjAAAXj/5a94aeq3bddsbWZdczH4tp24igjf8gqTV6Ih3BkG3EdePRe
        S7vHxNwDFvNpTgsWdpOICZh6yWhU
X-Google-Smtp-Source: APXvYqzjmUMKazVMZjapNT0xiB30L9h8wy540efKiIdAI0CdrFULohjsmNS3F42ry+loDIz32kZ9Ig==
X-Received: by 2002:a1c:7dd7:: with SMTP id y206mr2799944wmc.81.1553179420366;
        Thu, 21 Mar 2019 07:43:40 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id g3sm5075409wmk.32.2019.03.21.07.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 07:43:39 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Dalit Ben Zoor <dbenzoor@habana.ai>
Subject: [PATCH 1/2] habanalabs: set new golden value to tpc clock relaxation
Date:   Thu, 21 Mar 2019 16:43:34 +0200
Message-Id: <20190321144335.32299-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dalit Ben Zoor <dbenzoor@habana.ai>

On init or context switch, set TPC clock relaxation counter
register to a golden value.

Signed-off-by: Dalit Ben Zoor <dbenzoor@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index a4bb963e33fa..b14380834322 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -1437,6 +1437,7 @@ static void goya_init_golden_registers(struct hl_device *hdev)
 	 */
 	WREG32(mmDMA_CH_0_CFG0, 0x0fff0010);
 	WREG32(mmDMA_CH_1_CFG0, 0x0fff00F0);
+	WREG32(mmTPC_PLL_CLK_RLX_0, 0x200020);
 
 	goya->hw_cap_initialized |= HW_CAP_GOLDEN;
 }
@@ -4459,6 +4460,7 @@ static int goya_context_switch(struct hl_device *hdev, u32 asid)
 		return rc;
 	}
 
+	WREG32(mmTPC_PLL_CLK_RLX_0, 0x200020);
 	goya_mmu_prepare(hdev, asid);
 
 	return 0;
-- 
2.17.1

