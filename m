Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ABDC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF41821743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfEUKgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:36:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44655 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbfEUKgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:36:35 -0400
Received: by mail-ed1-f67.google.com with SMTP id b8so28604356edm.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 03:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=g5+rFA36lwuazIudpaXXvHQFCY1jZEBw2F/UUKE3ovM=;
        b=ixN224lgVGMch1UvnqJALU3FR4WjcJnUYyZIYhVg4KRlN6zMKL4ehITlDDRzCIN3Z3
         1PGGYCZWUIiqVfme5IEvxsha5b1DFH6Oj+VTM62DwTQugE7FwglTOPqzaK9tMSHgotmV
         c394jiGeITKeV589a6aoAA19mSAs9Q63WNbsZdyMOBvl+dMppXitczCmA0x0EvKPnYtZ
         FG4i+UV8XftXodQknnLFWEzqTQRVzH/iuhnkCzVUKVJxunDaGcVG7vpjacFRqDdB0bVO
         +76UswYCNljkiyVtmO7iyAwZkPzDAYWS+OlGpXPMzmLlC/PnmEvqv50+bYwYWR10an9E
         AU6Q==
X-Gm-Message-State: APjAAAX1knhizesi/RoqPrGMIlmJoIe2Lv+QwR4XHhf+C/y8Ub8TDI1G
        RlXDF/F66K5ekG+B0XhJa9FwVqFRNuczZeP4gfLuYZBAqGJTsv+kRmKDUh/JF5a9HFIBQy2r5Tr
        Z63Y5cSBhObL/VCB/
X-Google-Smtp-Source: APXvYqxl2DSayF5AxGHApfnVwCqMXNZzKr/pm83PpOr142/+wqSpO8m+LjGWdsy0o8mJwheCqi8M9g==
X-Received: by 2002:a50:a5fb:: with SMTP id b56mr81501952edc.262.1558434993795;
        Tue, 21 May 2019 03:36:33 -0700 (PDT)
Received: from localhost ([194.105.145.90])
        by smtp.gmail.com with ESMTPSA id c49sm6303644eda.58.2019.05.21.03.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 03:36:33 -0700 (PDT)
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [PATCH v1 1/6] ASoC: sgtl5000: Fix definition of VAG Ramp Control
Date:   Tue, 21 May 2019 13:36:14 +0300
Message-Id: <20190521103619.4707-2-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
References: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGTL5000_SMALL_POP is a bit mask, not a value. Usage of
correct definition makes device probing code more clear.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 sound/soc/codecs/sgtl5000.c | 2 +-
 sound/soc/codecs/sgtl5000.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git sound/soc/codecs/sgtl5000.c sound/soc/codecs/sgtl5000.c
index a6a4748c97f9..5e49523ee0b6 100644
--- sound/soc/codecs/sgtl5000.c
+++ sound/soc/codecs/sgtl5000.c
@@ -1296,7 +1296,7 @@ static int sgtl5000_probe(struct snd_soc_component *component)
 
 	/* enable small pop, introduce 400ms delay in turning off */
 	snd_soc_component_update_bits(component, SGTL5000_CHIP_REF_CTRL,
-				SGTL5000_SMALL_POP, 1);
+				SGTL5000_SMALL_POP, SGTL5000_SMALL_POP);
 
 	/* disable short cut detector */
 	snd_soc_component_write(component, SGTL5000_CHIP_SHORT_CTRL, 0);
diff --git sound/soc/codecs/sgtl5000.h sound/soc/codecs/sgtl5000.h
index 18cae08bbd3a..a4bf4bca95bf 100644
--- sound/soc/codecs/sgtl5000.h
+++ sound/soc/codecs/sgtl5000.h
@@ -273,7 +273,7 @@
 #define SGTL5000_BIAS_CTRL_MASK			0x000e
 #define SGTL5000_BIAS_CTRL_SHIFT		1
 #define SGTL5000_BIAS_CTRL_WIDTH		3
-#define SGTL5000_SMALL_POP			1
+#define SGTL5000_SMALL_POP			0x0001
 
 /*
  * SGTL5000_CHIP_MIC_CTRL
-- 
2.20.1


-- 

Ciklum refers to one or more of Ciklum Group Holdings LTD. and its 
subsidiaries and affiliates each of which is a legally separate entity. 
Ciklum LLC is a limited liability company registered in Ukraine under 
EDRPOU code 31902643, with its registered address at 12 Amosova St., 03680, 
Kyiv, Ukraine.



The contents of this e-mail (including any attachments) 
are confidential and may be legally privileged. If you are not the intended 
recipient of this e-mail, please notify the sender immediately and then 
delete it (including any attachments) from all your systems. Any 
unauthorised use, reproduction, distribution, disclosure and/or 
modification of this message and/or its contents are strictly prohibited. 
We cannot guarantee that this e-mail is secure or error-free. Ciklum cannot 
be held liable for any loss or damage caused by software viruses or 
resulting from any use of or reliance on this email by anyone, other than 
the intended addressee to the extent agreed in a contract for the matter to 
which this email relates (if any). Messages sent to and from Ciklum may be 
monitored; by replying to this e-mail you give your consent to such 
monitoring.  Notice: we do not accept service by e-mail of court 
proceedings, other processes or formal notices of any kind without specific 
prior written agreement. This email does not constitute a binding offer or 
acceptance for Ciklum unless so set forth in a separate document.


