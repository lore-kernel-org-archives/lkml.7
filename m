Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3960BC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10037212F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6Z4giGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfFDOhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:37:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39347 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbfFDOhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:37:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id j2so12809791pfe.6;
        Tue, 04 Jun 2019 07:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qzbfu0dliCkkEmJ1UFnYukQdP9RWNNavonlb+Fp2x7g=;
        b=B6Z4giGie6KhK2KkxWuIhscXtPyiQHeMiQvlupiBP6cuxnHxnkXC7r77dL910UfzOp
         NbF6jRlrR+fe5PwMr2YdnxhZNvwetSZZa3fSdtJDlWfp2SL6I309qlCdjHgsmEeIhY4X
         4ZrmS2LFhTrynTLrQxkzzst9w2U0QbfyK5S8C2eHE4lo4WlNv6bg+GxASJxWiLvLJYJZ
         4vraMmMpkN9pYK7SgbT+8yeb9DtD+3+r+D4rN7oN0ni70urCpD9eRBY3MFNoaI45wugG
         ECx1VtVgxzw4ohf0wQgQ7/gIGbYiBRYngTDo7tdYImb28Rq0OSmIb06tELlMUi0p4pv0
         Tscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qzbfu0dliCkkEmJ1UFnYukQdP9RWNNavonlb+Fp2x7g=;
        b=DIjg6BRk4P+XgQ7nfgoj+xgE0Cw9up3T1hwFFts3vDZWuNj0Cag3YJeDdSa3STHU+B
         24nNFcpKYCKdAJFa92U0HRqgfXk746D28s0LmakouCUr5N0LQVSx7JOGcfJVmC0gjETj
         VgAm8LuCI84YHdKxdzaLDScryBkZLQqBmviGg51+M/XpMRJP+KXy0o+lrdqnYaDQcfyL
         JwyP5RzXaxdPIkQR9W6mxyQDuaPxkTcL3NAZfhS0Jp6s/0Lrz9+sJPX9rTZXy4bcJdmj
         +DmznlTmaS5C0T3xfpJDa07CAAiUADTP+i9jRNjTrwxjS1w3kmgvJI5p5anpQ1nDtYPs
         GSgg==
X-Gm-Message-State: APjAAAUpPif+CsMMSd4Sntyww4oMRvAvDsNvEgaysW0YBsAmqAN0T0hj
        DeWGQ3ElEe11ajP8ns2AUoE=
X-Google-Smtp-Source: APXvYqxODlBBHGGcFQeLSbBlxK42pdQc5O3+h4I1eh+4EBYLKe4wKcH39RExLE1ACFUyrK4KVJo6gA==
X-Received: by 2002:a62:f201:: with SMTP id m1mr32199419pfh.217.1559659057712;
        Tue, 04 Jun 2019 07:37:37 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id m6sm24156872pjl.18.2019.06.04.07.37.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 07:37:37 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 3/3] dt: bindings: mtd: brcmand: Add brcmnand,brcmnand-v7.3 support
Date:   Tue,  4 Jun 2019 10:36:31 -0400
Message-Id: <1559659013-34502-3-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1559659013-34502-1-git-send-email-kdasu.kdev@gmail.com>
References: <1559659013-34502-1-git-send-email-kdasu.kdev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added brcm,brcmnand-v7.3 as possible compatible string to support
brcmnand controller v7.3.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
index 0b7c373..ad4cd30 100644
--- a/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
+++ b/Documentation/devicetree/bindings/mtd/brcm,brcmnand.txt
@@ -28,6 +28,7 @@ Required properties:
                          brcm,brcmnand-v7.0
                          brcm,brcmnand-v7.1
                          brcm,brcmnand-v7.2
+                         brcm,brcmnand-v7.3
                          brcm,brcmnand
 - reg              : the register start and length for NAND register region.
                      (optional) Flash DMA register range (if present)
-- 
1.9.0.138.g2de3478

