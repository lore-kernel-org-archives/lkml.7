Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D19CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2F620818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 20:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzEVLDql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKLUAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 15:00:18 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36722 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfKLUAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 15:00:17 -0500
Received: by mail-qk1-f195.google.com with SMTP id d13so15630554qko.3;
        Tue, 12 Nov 2019 12:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sUgul/A9cCSF36Xg/vqaHA0cEImiVIRh9iAQCFNRdHQ=;
        b=HzEVLDql49dOVwTMZt9IJDllV61HRuag1vF5aQdcuQ4PoiQNz/LWZ1bbSiAEI1/Vw7
         DW9kfGONyd8NihhAqJNDEPWlb7bjjYSmv/FjLZR52t+3EMmdg73bCOuUj/2CMsSSFiES
         5yjBHKF+UMnr3FObFsxN3msgz2Di972TS6wdu9ztmhlPFITx37jINsXm1fgrKxb/lAos
         SCHrJsZFHTmL/YfLZUIy8WfHtYntAaVYkyy9pF2SAmDSXBJV5qxQTDpssyoa5W1DzfGE
         6+MWvd8AlcA5s7yDaH1ZW3mgT30vZsuGLvbBPD68VNYbZtnSJg7eQIfZFHSOk4f63JQm
         o1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sUgul/A9cCSF36Xg/vqaHA0cEImiVIRh9iAQCFNRdHQ=;
        b=lB7BpEa6MJXOHUeNta4/wRpbUBUROmQnG8yaW/kOyrnpUqxKX53Hy20uRvXrxFUp00
         YgkSzeAYrHp2OWf7x1YDKakyduTvRztcfL56CYmaOYVRfFIH7BjWb3JJWu2VyDFmLmAd
         05OzOyVuKcdXevDDkHISXhTW93sLzE9psIp4+FGL6pRadSvzptXg2EZ7zCPjxxNXUyCS
         0ij3kGVktUOqKmr9OSTyCYmTw7NyJgjwhL2K1MHX1otc1W5z3M7s91VSvl230fp1VjBt
         QHwfjMNhGigxDy+U6FtfsLqe2dmeSeJdFbvPW/esJe5NNNmtiMju4vc8s3RUi0eeh46h
         g00w==
X-Gm-Message-State: APjAAAW6Q6xFOHLLm7o2Ru0oQUkh9ZA4+yZ/lqUWUnPg34tIa7IJhI+M
        ecB2Ew5Q6ePeSLRBIek3owE=
X-Google-Smtp-Source: APXvYqy1f9ekVu+VnvCTbNVtKxjC7eHIzuOiXxnRVAjWeIcCFuTmMakBzLxZOfrwLbUN6A2aMk6Vmw==
X-Received: by 2002:a37:f915:: with SMTP id l21mr17001532qkj.209.1573588816759;
        Tue, 12 Nov 2019 12:00:16 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id h186sm9436141qkf.64.2019.11.12.12.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 12:00:16 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        rfontana@redhat.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, allison@lohutok.net
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: as102_fe.c: fix checkpatch.pl error
Date:   Tue, 12 Nov 2019 16:52:48 -0300
Message-Id: <20191112195248.36084-1-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

This patch fixes the following scripts/checkpatch.pl error:

ERROR: open brace '{' following function definitions go on the next line
+static int as102_fe_get_tune_settings(struct dvb_frontend *fe,
+			struct dvb_frontend_tune_settings *settings) {

Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 drivers/media/dvb-frontends/as102_fe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/as102_fe.c b/drivers/media/dvb-frontends/as102_fe.c
index 496ebb8176c0..bc72d954dc1f 100644
--- a/drivers/media/dvb-frontends/as102_fe.c
+++ b/drivers/media/dvb-frontends/as102_fe.c
@@ -290,7 +290,8 @@ static int as102_fe_get_frontend(struct dvb_frontend *fe,
 }
 
 static int as102_fe_get_tune_settings(struct dvb_frontend *fe,
-			struct dvb_frontend_tune_settings *settings) {
+			struct dvb_frontend_tune_settings *settings)
+{
 
 	settings->min_delay_ms = 1000;
 
-- 
2.24.0

