Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FACBC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C96821773
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Fl3Pw/aW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbfEWV5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 17:57:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40063 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387616AbfEWV5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 17:57:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id u17so3986444pfn.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 14:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5bG8FDPCw5QDc0u1AHZFZoHnM7vNJL8HNA0ePZzdpDk=;
        b=Fl3Pw/aWVCJMn6SdFWbo1CqRqGB0mnVIW3e7yT0Jp6ccc/IaYhJGmLRABpEpkm4chI
         hzN1v219lL1YsQYsp8ulmY3B7xLKFqj+lHIIPnadVhUbsM1kceLOAUawiv/G4mx8sror
         d3mgOjFFOkJjmEG08rzXgIEcVizuEjC23kgWJoheQr2kmJWyapUxyxsN55q8T5Mz3arE
         A33k6AviekRkWiRb7uTEoj6NDqlxJYfQaEv7m5ZbfSUqcS+uRBsGdZcO7ruHsqiydTy0
         O8ju2Wgv+gipF2XFbz6z/arhAzMKA5M30weGAWeVW/ApnJcLxzNUYkrQjkDBZ//BkRrf
         tjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5bG8FDPCw5QDc0u1AHZFZoHnM7vNJL8HNA0ePZzdpDk=;
        b=Lguyz9YNQWLUhvhAf6MKHK/FG/NIlK2l4U35UZGDdVPKQc9kzojNFf549CRGVAVhV2
         jkhwwDXBd0YLCmL1U7jVfUPCIab+xV9u2/czGyGjicw4xp/G1nb8w6eHywUNwcD9cJD6
         1hGWByhNLcfkqEKmzifruifg0WkRuwHZoInEkLNYMcz241VgFEVsF3kkZJgn0C5/BxA+
         G/CGPE84EW9B+lUN/9hWPmLY8OWqEuxK2k5+gdySSCbrjVlAq6xDZiUzO4mqKsr/BpLN
         tGeS9a0iZO6YEgemcpElTro83dMTGXoSDOcYK6QVyhTC4PR3k0ZzJu43MKEapSlTxo1i
         wnGw==
X-Gm-Message-State: APjAAAUENPsMsIsDqoYlIqzOcEQsvJb2Oq9HkIidEOEgpeTcRhLoUB5J
        ZG8aJIdx85Hd1TbkVYsVDvTYwQ==
X-Google-Smtp-Source: APXvYqxPKvovRIfrtaL1O8c2k6QXUDaH/Pjn7UuZ6wkFFjX1eXQhHuYnrqOEHn9sDUqRH4JPFj1wjQ==
X-Received: by 2002:a63:1e5b:: with SMTP id p27mr100433871pgm.213.1558648658166;
        Thu, 23 May 2019 14:57:38 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.2])
        by smtp.gmail.com with ESMTPSA id n37sm321966pjb.0.2019.05.23.14.57.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 May 2019 14:57:37 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-riscv@lists.infradead.org, palmer@sifive.com,
        paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH v2] PCI: endpoint: Clear BAR before freeing its space
Date:   Thu, 23 May 2019 14:57:27 -0700
Message-Id: <1558648647-14324-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Associated pci_epf_bar structure is needed in pci_epc_clear_bar() but
would be cleared in pci_epf_free_space(), if called first, and BAR
would not get cleared.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 27806987e93b..f81a219dde5b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -381,8 +381,8 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 		epf_bar = &epf->bar[bar];
 
 		if (epf_test->reg[bar]) {
-			pci_epf_free_space(epf, epf_test->reg[bar], bar);
 			pci_epc_clear_bar(epc, epf->func_no, epf_bar);
+			pci_epf_free_space(epf, epf_test->reg[bar], bar);
 		}
 	}
 }
-- 
2.7.4

