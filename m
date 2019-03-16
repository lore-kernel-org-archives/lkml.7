Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5578BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 20:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250FA218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 20:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpdF4C3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfCPUn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 16:43:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36464 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbfCPUnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 16:43:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id h18so638826wml.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 13:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AejRBanAMnPFcqlSTWjPLzja2LEpfcTXb5Bp+fGLbCg=;
        b=jpdF4C3m8LSN09idxC3OC9uSgGBId54oANYZLgB6f/duEStFL7x6Xjn22DQMONUJ4V
         jazIkudGRCbjiIBImHErNqGfhJmp/mzJxWTbCCot7WCWWNWV/M+GcQ6TKPVPlACZpplx
         Jtm3CCU4UkhK6CAkyQKw4otVwjYixMbkVTPtwVgIfVhOwsVA+6hl+L9qabqfW9EFuIeG
         Vnn2AqtZvMuOhFOyqHOnsbnLrQ+4QsEgTJUyQCuoaJqJLFFylSqd0AlLMhM/6v633t/L
         /GZQbo1v48Fgiu33SmlB68i3/Rk1sCaqFUQA36JuARVrg392HPS5LpUXyyXH2erSPdmv
         50NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AejRBanAMnPFcqlSTWjPLzja2LEpfcTXb5Bp+fGLbCg=;
        b=OWB4EqmXSJ9c50jn2H8qUAWk4v4C2n5j5+Q0msghj37sA0DbSdNk+nLiXSz7sDrWA0
         NYmyhyHue5sT+Hwhk0/EscEzGx+TIb7p9xVyu6yi7/2G64vy/BAJ52H69dQzW2HhBB0C
         XRo1LpRq66ztBxjzkGXvkfOCmcgQYQTY2EPAE3qdJ7gbgYxiIwoNkFTtY3W03zQObaQ0
         +NTLdU7EDBOriXx3rey3zEJKEPGeeslEIW/bqDRDtw3pNt6TurAlUdLhptqG6EjUJ6if
         HYWS9NIbtr8uJi7VJmw3LquJ+UeBnmvK04iDIcPxctKGWdOW6fEekxlgBdP0LiUY+Ku9
         NfxA==
X-Gm-Message-State: APjAAAUF/9Xqgp8mmwE5+R624ZFSAkHzmzJwEUedDGsXgc7GhfLeXV+B
        m7UednxaLpLvlH1VY+8P5jkbEB2J
X-Google-Smtp-Source: APXvYqyHdteGcvplRfWyzYptxdu412iiAloKzSF1GpZefCbDtnDN3iylpa58Dog39N7ckBq0NBjl9Q==
X-Received: by 2002:a7b:c84b:: with SMTP id c11mr6015283wml.108.1552769002493;
        Sat, 16 Mar 2019 13:43:22 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id y7sm8684315wmi.34.2019.03.16.13.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 13:43:21 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 3/3] habanalabs: cast to expected type
Date:   Sat, 16 Mar 2019 22:43:17 +0200
Message-Id: <20190316204317.28279-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190316204317.28279-1-oded.gabbay@gmail.com>
References: <20190316204317.28279-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix the following sparse warning:

drivers/misc/habanalabs/goya/goya.c:3646:14: warning: incorrect type in
assignment (different address spaces)
drivers/misc/habanalabs/goya/goya.c:3646:14:    expected void *base
drivers/misc/habanalabs/goya/goya.c:3646:14:    got void [noderef] <asn:2> *

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 538d8d59d9dc..ea979ebd62fb 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3009,7 +3009,7 @@ void *goya_get_int_queue_base(struct hl_device *hdev, u32 queue_id,
 
 	*dma_handle = hdev->asic_prop.sram_base_address;
 
-	base = hdev->pcie_bar[SRAM_CFG_BAR_ID];
+	base = (void *) hdev->pcie_bar[SRAM_CFG_BAR_ID];
 
 	switch (queue_id) {
 	case GOYA_QUEUE_ID_MME:
-- 
2.17.1

