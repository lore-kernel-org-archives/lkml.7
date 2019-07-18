Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBB8C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48F92173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 07:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA3UCLHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389352AbfGRHps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 03:45:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33589 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfGRHps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 03:45:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so13397125plo.0;
        Thu, 18 Jul 2019 00:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yFxTAg75DiLly5zn9XvgtkjCH+JOZJ6WOJQ/240CnJM=;
        b=iA3UCLHCBvCdyYdatB0DvKP1H1A/rmz3DyfPw9DZEeJYraSkpZ08/sLQFUfv0uiGzs
         mBV/17aADRGptUoJ0J/JsY3zNqMRMkC/n2ZEJGwPn4qQu255W1kETvfo1qExxg/S933T
         fLpjOJB0mJtIejm/weQRBfvVhdrwRMHakgShHkR572Gv/q7E1s/Nhdr/hKzjqnmLnq2e
         7ZIJ7KIOckk2+uL/8DcxQg7c1nSpuCBBgHhcvQ1SZ/1mGqJ9InYLJKc9SPEJJNUlawY8
         x6TVoAKDYqImfQguvNb+yg10wE1rrvamSFphvf9he+qip4ZnuHJWwQarD5nN9fNOpikg
         uqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yFxTAg75DiLly5zn9XvgtkjCH+JOZJ6WOJQ/240CnJM=;
        b=XK67Ooqg0+p0oJD3U0TVISRwinomSBVTIt2wAtsaMn8Cu/TcnhzyxN6qqfRk8mqroj
         w3EhJ/Ze/egaurxamytBVEiQMNG2m/PctIRVMB7qKvOITaC23LnymYyJauG5jqLpwYtR
         myZR3VcOQLxK1ooX6qPI0ragRs5eFmztXcOe6aYGxlEKCAlifHn1+6iecU3wu4VOU9bb
         Jjngvf1pXSegl8XMshI6vnBmXTM9oJssWz8c6eRVI9BUBhvsk1T9QWYYat3fTkhBTjvB
         /0EoQg8d37tQtc1MawRwECCM5U6/w53inkAv2dvMsX0FZyBWitbNu2/yCUgxZMCXZa8o
         Gctw==
X-Gm-Message-State: APjAAAWD5djXgYsrV0CdSyp/n0soaI0wWXwhq99n0zAXknmKkAIwhqZu
        xaugdhcCu4b8WCrj2wBPh88=
X-Google-Smtp-Source: APXvYqyV/OiMUzT0LAf4SWQZH5bo52B3+WdwthDRmAqFlPMVAIiJ5WOlM4+aU6x9iGnOaB4ixUQYTw==
X-Received: by 2002:a17:902:9897:: with SMTP id s23mr48196033plp.47.1563435947579;
        Thu, 18 Jul 2019 00:45:47 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id b26sm31098317pfo.129.2019.07.18.00.45.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 00:45:47 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Derek Chickles <dchickles@marvell.com>,
        Satanand Burla <sburla@marvell.com>,
        Felix Manlunas <fmanlunas@marvell.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 2/3] liquidio: Replace vmalloc + memset with vzalloc
Date:   Thu, 18 Jul 2019 15:45:42 +0800
Message-Id: <20190718074542.16329-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vzalloc and vzalloc_node instead of using vmalloc and
vmalloc_node and then zeroing the allocated memory by
memset 0.
This simplifies the code.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/net/ethernet/cavium/liquidio/request_manager.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/request_manager.c b/drivers/net/ethernet/cavium/liquidio/request_manager.c
index fcf20a8f92d9..032224178b64 100644
--- a/drivers/net/ethernet/cavium/liquidio/request_manager.c
+++ b/drivers/net/ethernet/cavium/liquidio/request_manager.c
@@ -218,15 +218,13 @@ int octeon_setup_iq(struct octeon_device *oct,
 		return 0;
 	}
 	oct->instr_queue[iq_no] =
-	    vmalloc_node(sizeof(struct octeon_instr_queue), numa_node);
+	    vzalloc_node(sizeof(struct octeon_instr_queue), numa_node);
 	if (!oct->instr_queue[iq_no])
 		oct->instr_queue[iq_no] =
-		    vmalloc(sizeof(struct octeon_instr_queue));
+		    vzalloc(sizeof(struct octeon_instr_queue));
 	if (!oct->instr_queue[iq_no])
 		return 1;
 
-	memset(oct->instr_queue[iq_no], 0,
-	       sizeof(struct octeon_instr_queue));
 
 	oct->instr_queue[iq_no]->q_index = q_index;
 	oct->instr_queue[iq_no]->app_ctx = app_ctx;
-- 
2.20.1

