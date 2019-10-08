Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F8BC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 04:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77E021479
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 04:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oklm+8Ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbfJHELX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 00:11:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37976 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfJHELW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 00:11:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id h195so10027421pfe.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 21:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0hAZOMXp2CaLrNPsyGzyjqb4W+kYM5nZsLInRcfqbCA=;
        b=oklm+8IcMIe723rEMdES47HqUGCLulOB/MBXJ+7JC5O6UGHHJ4zFoFpNnka5L+cKD1
         tkKvaGkqgDsoRV3JVUMiAuqVGF4rDBJ6dsaOUcw8MC8t935RWS/jJiMavEH1l0jbmTrV
         ha1z80VDb60cjm3JthEuFx394Jut8AIxJy7Iq1sCft1mGTOLNNwUqWMC280Dg0DC4NsL
         xEGxBzGsrGdneeSQDv9lNQ9G9+rKYSh3bOF8M1ntrvZN1isDMskuFChc+l5EEEVKoAe6
         +91F8nEEu743pPQ22O5wZMrMPGpw1uX8zqvyCXlGFaQ/KYSeKTnoZKRycGtxt+kI/wvA
         gWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0hAZOMXp2CaLrNPsyGzyjqb4W+kYM5nZsLInRcfqbCA=;
        b=B9jqiFjOLqKFlbVCDXzjBh8KgCd9Qv0PfQnii/1LrFBQ59ht+WQqbe5tfBuFwVm8o+
         VuZSBofwi7nu5jckQ3bX4DKqUwILAae/C72js2vRtcetTqtvXCeOvhN28Nmrnc3t2hgs
         sCxAOJRyEs1iQENkOW/LQthlB3nVi2d+lxLbAl8xq1fd5ZH9x7sTUszQc8b9NpFQzfme
         obtEahij+nsjnyMycd6nyujES8nLxQAg1QYVBNVyf2/oGzeGCNqHiQbRhEf0PsHc/cQZ
         RQrkpKdSEZJjFUMKzozVg5zL51FDJSB376agGxDWggNjKg5SKWfCtHUZ+349xZ/gzdHI
         sP2A==
X-Gm-Message-State: APjAAAUEoRHnY3aOd6+9JU5HAc7IlK4DRrpXHZgpWEuQFtGzyvoITRvt
        0PtAMPQZvV3x529wZBsXFws=
X-Google-Smtp-Source: APXvYqzrF/0AfjNm0p93eHMKgTGtRz16stvERm1u+s1t+id9ATEmMb0CZdM7zKjlhYxMNV9yIy1GOA==
X-Received: by 2002:aa7:800d:: with SMTP id j13mr36834733pfi.187.1570507882041;
        Mon, 07 Oct 2019 21:11:22 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id h4sm15705696pgg.81.2019.10.07.21.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 21:11:21 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH] staging: octeon: Remove typedef declaration
Date:   Tue,  8 Oct 2019 07:09:43 +0300
Message-Id: <20191008040943.9283-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl warning: do not add new typedefs in
drivers/staging/octeon/octeon-stubs.h:41

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/staging/octeon/octeon-stubs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index a4ac3bfb62a8..773591348ef4 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -38,7 +38,7 @@
 #define CVMX_NPI_RSL_INT_BLOCKS		0
 #define CVMX_POW_WQ_INT_PC		0
 
-typedef union {
+union cvmx_pip_wqe_word2 {
 	uint64_t u64;
 	struct {
 		uint64_t bufs:8;
@@ -114,7 +114,7 @@ typedef union {
 		uint64_t err_code:8;
 	} snoip;
 
-} cvmx_pip_wqe_word2;
+};
 
 union cvmx_pip_wqe_word0 {
 	struct {
@@ -183,7 +183,7 @@ union cvmx_buf_ptr {
 typedef struct {
 	union cvmx_wqe_word0 word0;
 	union cvmx_wqe_word1 word1;
-	cvmx_pip_wqe_word2 word2;
+	union cvmx_pip_wqe_word2 word2;
 	union cvmx_buf_ptr packet_ptr;
 	uint8_t packet_data[96];
 } cvmx_wqe_t;
-- 
2.23.0

