Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E129C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B55E20815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ1lreXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfEPQBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:01:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38597 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbfEPQA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:00:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id w11so5980239edl.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 09:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8WgMWkot3W6frdZDEhuKoWGYZZnnA8ggjmWUdQkxVUg=;
        b=VQ1lreXFzVPz7qMf6CbZsyHyEK8BaUPzViIbtM9m26OmLDc9tKQb+Ww5BzyPFxvKVr
         MJrT5hYOZFr1qqbinjNi0tc9Y7K9TrxawuH+WidxXbg7JTXsX7z3gzTQWohuiByopt7m
         4ryVrr07Qa7xoWkcqKuFRHHW6UpEbZSNoCQ5aRG612xPXgDlckr7b6De7pLUdaxjaiQV
         hcsybkXuOdvGi1Mxsfms0QU4V/9nnmPkZ/AeYezrL2lSFkfpmZ8cwUfcwzQnmC99Or34
         ynutTND6GIF1CpSUzaGCAKL/ehYJFRu0Vyi2/xwYYLD0u/S4b3IEcTBNrrSgbmRaMxxB
         JCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8WgMWkot3W6frdZDEhuKoWGYZZnnA8ggjmWUdQkxVUg=;
        b=IX6GABiKxuROH9E20h/Q1q7ItcwcHOB/1Zsz1xQYwjUnAa7atmCtJPEWxoInudqsaR
         phcyh4po8fAEL0U3oHEh4isAqq7WOHGn9xVtUtm6aBHMp9NGyDGEH0cUjsnjw7NT6lLm
         MRoJ+dx7pfP42XtA9tDkdw155YWC/ppXlyoN6h/Sx3zku+l3iPumwZG54YGpPxTJyNwE
         WLx66lm1r+GSwBLXw9uWz0rFkGBikYQUWkr9ghY0+ggkfKYOxIJLZ8Mf9R+UL6KhnE/R
         Oyv+qfookCom1Q/QixLhVj4rWlgFLR3rVIRvDXUbULpeqgc2NluKet5KjHdJ7LXPfejS
         COfQ==
X-Gm-Message-State: APjAAAUXD7eIKbT+kzL3pb/lchVpcXBPLBxKtSgxe2nniHLPyAcQT2DX
        Cqe6aDAYTHQfbITXBMOnoyA=
X-Google-Smtp-Source: APXvYqyMxBN1sByOco4/CKLlBrCsf2Soi/E7L6cLHGLDX2cIXMgHdQjhgFGhYUdXaJFeCs5VE9Ln+Q==
X-Received: by 2002:a17:906:8398:: with SMTP id p24mr25198362ejx.8.1558022458538;
        Thu, 16 May 2019 09:00:58 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id n8sm348307ejk.45.2019.05.16.09.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 09:00:57 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2 2/2] mtd: nand: raw: brcmnand: When oops in progress use pio and interrupt polling
Date:   Thu, 16 May 2019 11:45:40 -0400
Message-Id: <1558022399-24863-2-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1558022399-24863-1-git-send-email-kdasu.kdev@gmail.com>
References: <1558022399-24863-1-git-send-email-kdasu.kdev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If mtd_oops is in progress switch to polling for nand command completion
interrupts and use PIO mode wihtout DMA so that the mtd_oops buffer can
be completely written in the assinged nand partition.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index a30a7f0..dca8eb8 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -835,7 +835,6 @@ static inline void disable_ctrl_irqs(struct brcmnand_controller *ctrl)
 	}
 
 	disable_irq(ctrl->irq);
-
 	ctrl->pio_poll_mode = true;
 }
 
-- 
1.9.0.138.g2de3478

