Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB3CC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 22:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF6626288
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 22:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6vjmWjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfE3WSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 18:18:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34831 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfE3WSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 18:18:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id p26so11384652edr.2;
        Thu, 30 May 2019 15:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qzbfu0dliCkkEmJ1UFnYukQdP9RWNNavonlb+Fp2x7g=;
        b=N6vjmWjy73gJGAwNl3ai5Uybv0PFyuyvJaAPxAibzRxqUVjyvhUg2NhHoega74+C8c
         B1nVuyy3hJ9/oHxD9EMRLQ9Rp3o0aMiKODRU3frOrC616DVBH9SAaW6w8NX37vRyhW/O
         L2G7hByWBQr2BCsqkm+KpOmOLAZmcS7FobnGSvlGeKWLpUriE8ZAZZ3zQeMFdS7WUH5b
         vWS+n+5SATB6kCzCtSLQrCdtIdVYsHxiBmWZugnMX0mNrpziiDRxpy4VVfo4mUzNLCN1
         T9DKSmHlkGChdIlLj1LoCb3UqZXMPTjyLxBtlNKx1ue7I6z8bdFeI8LyEZnTrKLt6D5i
         lrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qzbfu0dliCkkEmJ1UFnYukQdP9RWNNavonlb+Fp2x7g=;
        b=E8VuGNGlDNTcZNq7E6zo1ocpFqCV3P3WXpwLG9M9yuz3/2yyWnukKHbxBV1CNHsXXL
         bDMukssXSz97ZYI49PCV9e1pR32kaVaRJF6E34d7+pOTCYWRPoE46Kjpm2Ej9Zc5Gjrn
         ogYWgOIZmqjoiIAn7JQz0/sMyJGiv/gPsgbNh3PcccGOfP4dF23jx1XMwF7cPEK3soWv
         z95Mh0aU2dlwNkLVTmBYrmBoisDIKa3t0kzK21jSjv70aRwBZ0m3RW6zhIUD3AIT04Xu
         ZajVTuiOr8WaBZr2bPUvjEx4NGMFAkpMqnGfLzIAClSKZyC9sGDqboltftCMdOiHj8cX
         4o4w==
X-Gm-Message-State: APjAAAWOEcMBuNvtUX02UGiUJhj6c0wtNZ2zbYIUq/xb6BtxdZc5E/Sg
        RVk/IAnzAduHOrLJNiJrwkrRDMD/
X-Google-Smtp-Source: APXvYqzRR8gKNI+QpfK/2N0R8st5YfVLx33/T/e2b+X2T7vDp5V2dfBvEgtcUFXa4rQ2gOUlOrnsNw==
X-Received: by 2002:a17:906:3b8f:: with SMTP id u15mr5624827ejf.6.1559251284636;
        Thu, 30 May 2019 14:21:24 -0700 (PDT)
Received: from mail.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id h25sm597082ejz.10.2019.05.30.14.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 14:21:24 -0700 (PDT)
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
Subject: [PATCH 3/3] dt: bindings: mtd: brcmand: Add brcmnand,brcmnand-v7.3 support
Date:   Thu, 30 May 2019 17:20:37 -0400
Message-Id: <1559251257-12383-3-git-send-email-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1559251257-12383-1-git-send-email-kdasu.kdev@gmail.com>
References: <1559251257-12383-1-git-send-email-kdasu.kdev@gmail.com>
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

