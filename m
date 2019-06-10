Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_MED,UPPERCASE_50_75,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1C4C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672F5206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h7LC7ANd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389567AbfFJTPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 15:15:18 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:40059 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389246AbfFJTOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:14:38 -0400
Received: by mail-qk1-f201.google.com with SMTP id n5so8927202qkf.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 12:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EO7j56MdfFzt2mRyj8hcm1iy8vmSJAjtXZ/C0wTp1G8=;
        b=h7LC7ANdx3e2J44+ya0wOf/+L99eKH6ZAkhtZrEe1sUe9coeBLBFp3f5wxwwOlq8Tr
         nOY3PBwhwmmYAeW+zdl5LlEKj/6vTj1ygxVdgMpVittriy27WWV3t1qCk+iolDBw5Kub
         STjNeWhktsSS7q5RSwIGk22YvHod/drcBYEx2jLpawLjzFmJSCfqoO1Wi6Fe8uh8mxu+
         MGf73/Y71GX+IH+nueRLGPW0N6vHEBR9zKekYA+ACJOtls3vs5pxLFXgcFyQR0t/FzkP
         wfAhI686yfg3nxgigE/tiafWJ6z18PHqRKRF122uEePQtFgIEFc3Iy3cH73wPGeFa2eG
         Vxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EO7j56MdfFzt2mRyj8hcm1iy8vmSJAjtXZ/C0wTp1G8=;
        b=XN0PjShlJk6KwECWqK2UY/kL8Z4+Jpc2yLNKRZrOEVOBdzaCwUiI5h+49YJ0Ne/Ycv
         3lMmnpcYz4KKwYmyMQImdLjNmTExmX3TkZtCVaTmqPe8iPfPnJzOBrYNr7Vs/v5qvRHA
         bM5i0SkVo5OdrYJbPEu0G023SdWFyl1v7UvKgb1G0+ditdn0FfEEDhxmjIEIIebA4j+4
         3yCIfHvSfL1EvPw6Bc/j/vKRiTtpPadh2d6RgmVvLrp+NKrfKo4w5kTTSQnQfRInQo4K
         jW+GMRcA8WxQrcN61mEp/6c3vj/ofOyHuBu9+4RZUfmw2sRrGNUsSZGdh28S5ew5bP35
         yAmA==
X-Gm-Message-State: APjAAAWVDbSqiXiuJojrHdQKWmWID7eVvkg+aIUaARsCq+S0tFV5b/DL
        6oyVn1n4SUksM+Zl/NGw1JrcJ9ADrg==
X-Google-Smtp-Source: APXvYqxNPnIFxxINIYDtDDu/aEs3s+8rHjgSUxnJ/V0Z/39cRDAChET+x4aUy8tGTPerYWUaS2zaXE3dZg==
X-Received: by 2002:ac8:19ac:: with SMTP id u41mr42837147qtj.46.1560194077300;
 Mon, 10 Jun 2019 12:14:37 -0700 (PDT)
Date:   Mon, 10 Jun 2019 21:14:22 +0200
In-Reply-To: <20190610191422.177931-1-elver@google.com>
Message-Id: <20190610191422.177931-2-elver@google.com>
Mime-Version: 1.0
References: <20190610191422.177931-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v2 2/2] EDAC, ie31200: Reformat PCI device table
From:   Marco Elver <elver@google.com>
To:     bp@alien8.de, tony.luck@intel.com, jbaron@akamai.com
Cc:     linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reformat device table after Coffee Lake additions to be more readable.

No functional change.

Signed-off-by: Marco Elver <elver@google.com>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
---
 drivers/edac/ie31200_edac.c | 80 ++++++++++---------------------------
 1 file changed, 20 insertions(+), 60 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index cdb26014d929..af4ca4ee7df2 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -564,66 +564,26 @@ static void ie31200_remove_one(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id ie31200_pci_tbl[] = {
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_1), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_2), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_3), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_4), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_5), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_6), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_7), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_8), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_9), PCI_ANY_ID, PCI_ANY_ID, 0, 0,
-		IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_1), PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_2), PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_3), PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_4), PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_5), PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_6), PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_7), PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_8), PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_9), PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, IE31200},
-	{
-		PCI_VEND_DEV(INTEL, IE31200_HB_CFL_10), PCI_ANY_ID, PCI_ANY_ID,
-		0, 0, IE31200},
-	{
-		0,
-	}            /* 0 terminated list. */
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_1),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_2),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_3),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_4),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_5),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_6),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_7),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_8),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_9),      PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_1),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_2),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_3),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_4),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_5),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_6),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_7),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_8),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_9),  PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ PCI_VEND_DEV(INTEL, IE31200_HB_CFL_10), PCI_ANY_ID, PCI_ANY_ID, 0, 0, IE31200 },
+	{ 0, } /* 0 terminated list. */
 };
 MODULE_DEVICE_TABLE(pci, ie31200_pci_tbl);
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

