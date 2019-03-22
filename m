Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC42C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C1D21904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM/Q/LU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfCVJwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 05:52:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43188 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbfCVJwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 05:52:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id d17so1580222wre.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 02:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=WYpH2v40t2tg/Xe8olMyXYxNGIo8fypSheYZFCbF78E=;
        b=jM/Q/LU9KdXHC+CAaZnACyzpY7gbO18aTdQGYHmLx2hbOKQ18q68DUMlie3JXF3QJr
         iBLzczgSdDOq4InHldAGLc6O0m1UD1eh5IQRHCj2qW0zgMjA/dvn58lgAooqNkHuFrtl
         UQOnnr331zB3H2m/scqTZyoFA+1gfeTKithQ9m9IxdfCHWSQHsqsemQK/KQSy2YvgFn7
         h6AKwsIyMvYUy2uHZbn//xr8s2SkaitjrgL54Yt4jItUtFLDJvacjJssoUfLFUnFstax
         zRR+Pkp3dAFmrTF4e5UxrqgolrEMrWwzAy8jOmU0uH+G35/cbe/atsUcT0Levt3NHfoY
         ppxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=WYpH2v40t2tg/Xe8olMyXYxNGIo8fypSheYZFCbF78E=;
        b=U0cVZmQspk8aj/SIit7en9pVdN9HMkcbSkmY4DRJ0CzDiAUEOCeJ5qZZerkTWko88F
         TNCutDKsRYP7xrxPgtSIL990v+zmaTuShx4J0rMrPuR9XwNY6Cc5X7eioiVI0HiM346V
         /BFI290/ur/LqCkDvROcEOI1lKIVOw+aXHM0F8eZgTjTgHBfgfHlgDBx+pOwRXf9E1GG
         6KL5kUJeNevb8BHW0BvMc4nL7Zed3v2PzK0Arei0LiGNSMfEPViXzzVgkCBCrfaF2p7F
         0CCkt7pcB7as09ZvjZpOFKXJyXx7K6a9BHAzWuYCYIrjx/EX+jaVOphf5SFAisjJ7Y9h
         /bTg==
X-Gm-Message-State: APjAAAVEOJNrus+2RDhW3KQ8IkZUHhDj24MwAH1/Sdky23xEAOYyepzh
        lGSyMa+9abN0GWw4hIJ9ODQnSMTISjY=
X-Google-Smtp-Source: APXvYqw/xH5iNbe1LVNBjtS4GsUyOpNtSGJb5jsJCWKU1dA8Z501K+irO8HhqJA4Cljfl+GNno3GKw==
X-Received: by 2002:a5d:5287:: with SMTP id c7mr5996560wrv.127.1553248367794;
        Fri, 22 Mar 2019 02:52:47 -0700 (PDT)
Received: from localhost.localdomain (ip-109-42-2-8.web.vodafone.de. [109.42.2.8])
        by smtp.gmail.com with ESMTPSA id j3sm24438922wrg.54.2019.03.22.02.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 02:52:46 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Subject: [PATCH] staging: olpc_dcon: Add Tabs to define-Macros
Date:   Fri, 22 Mar 2019 10:52:43 +0100
Message-Id: <20190322095244.22348-1-benniciemanuel78@gmail.com>
X-Mailer: git-send-email 2.19.1
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve Code Readability by adding Tabs after #define-Macro
definition.

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/staging/olpc_dcon/olpc_dcon.h        | 24 ++++++++++----------
 drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c |  8 +++----
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/olpc_dcon/olpc_dcon.h b/drivers/staging/olpc_dcon/olpc_dcon.h
index c987aaf894e7..277b19967315 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon.h
+++ b/drivers/staging/olpc_dcon/olpc_dcon.h
@@ -10,18 +10,18 @@
 #define DCON_REG_ID		 0
 #define DCON_REG_MODE		 1
 
-#define MODE_PASSTHRU	BIT(0)
-#define MODE_SLEEP	BIT(1)
-#define MODE_SLEEP_AUTO	BIT(2)
-#define MODE_BL_ENABLE	BIT(3)
-#define MODE_BLANK	BIT(4)
-#define MODE_CSWIZZLE	BIT(5)
-#define MODE_COL_AA	BIT(6)
-#define MODE_MONO_LUMA	BIT(7)
-#define MODE_SCAN_INT	BIT(8)
-#define MODE_CLOCKDIV	BIT(9)
-#define MODE_DEBUG	BIT(14)
-#define MODE_SELFTEST	BIT(15)
+#define MODE_PASSTHRU		BIT(0)
+#define MODE_SLEEP		BIT(1)
+#define MODE_SLEEP_AUTO		BIT(2)
+#define MODE_BL_ENABLE		BIT(3)
+#define MODE_BLANK		BIT(4)
+#define MODE_CSWIZZLE		BIT(5)
+#define MODE_COL_AA		BIT(6)
+#define MODE_MONO_LUMA		BIT(7)
+#define MODE_SCAN_INT		BIT(8)
+#define MODE_CLOCKDIV		BIT(9)
+#define MODE_DEBUG		BIT(14)
+#define MODE_SELFTEST		BIT(15)
 
 #define DCON_REG_HRES		0x2
 #define DCON_REG_HTOTAL		0x3
diff --git a/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c b/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c
index 838daa2be3ef..7972b591d1b8 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon_xo_1_5.c
@@ -31,10 +31,10 @@
  *	DCONSMBCLK connects to VX855 graphics CRTSPCLK
  */
 
-#define VX855_GENL_PURPOSE_OUTPUT 0x44c /* PMIO_Rx4c-4f */
-#define VX855_GPI_STATUS_CHG 0x450  /* PMIO_Rx50 */
-#define VX855_GPI_SCI_SMI 0x452  /* PMIO_Rx52 */
-#define BIT_GPIO12 0x40
+#define VX855_GENL_PURPOSE_OUTPUT	0x44c /* PMIO_Rx4c-4f */
+#define VX855_GPI_STATUS_CHG		0x450  /* PMIO_Rx50 */
+#define VX855_GPI_SCI_SMI		0x452  /* PMIO_Rx52 */
+#define BIT_GPIO12			0x40
 
 #define PREFIX "OLPC DCON:"
 
-- 
2.19.1

