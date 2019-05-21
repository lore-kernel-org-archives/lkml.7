Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E143C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FE3217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfEUKgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:36:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34195 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbfEUKgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:36:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id p27so28699791eda.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 03:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=8RfPufMa3HqwhdEyx05OxfiupMkKyekwoF0H9MJSyDg=;
        b=ga6148DV/VqUL9zB7ZvPggSPcMvWNfc1TQBHnX4iZJEsTxY1aO3WyQ2weHZMPfyjT3
         HjkjEwGsxES0Mtq5g0dbiwzZNChkv8nHf53sG8NQDD1i7rQ/5PHyj605UH/5SrlCqkmI
         l34PcV6hO2g4mm6X0I3CxElEcDZBhXnKrIwEt4rUbZANP53KaH114mYXVnpmJuZT+Vsl
         zwuG56IaJ8MXij0hwaT+9k2KdZQi86NM8Xx6KEmaDmr+a0e6j7jOG4MMrF9p2sQaMyp9
         USzNn15sYohMAFb5nY277wVNtRcWUw7oM+BjJjjPLeci7EaTKsz9khUtl76MNNROesbF
         uG2A==
X-Gm-Message-State: APjAAAVChoqZbwdidJqA/YWEQx2gZa8gdvU1ZMvjvF9Hlwd7cAzRSJuH
        Tnw0iU/N+dyAxqdXvo8I9MTD7Yc59ET+EL/ezcuDiWXjYkJJWhJAF8rki7lFwWkVkFdJknHThU7
        3OABFat5BncKD0aKL
X-Google-Smtp-Source: APXvYqzvSL/hShohKCzVE7yqXSTyYlRnEwlsVmuEB6NTByIayC3kwlFUvM+IPASXPZk8yT2yog7+ag==
X-Received: by 2002:a17:906:eca3:: with SMTP id qh3mr31146094ejb.139.1558434999212;
        Tue, 21 May 2019 03:36:39 -0700 (PDT)
Received: from localhost ([194.105.145.90])
        by smtp.gmail.com with ESMTPSA id g11sm6207876eda.42.2019.05.21.03.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 03:36:38 -0700 (PDT)
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Subject: [PATCH v1 4/6] ASoC: sgtl5000: Fix charge pump source assignment
Date:   Tue, 21 May 2019 13:36:17 +0300
Message-Id: <20190521103619.4707-5-oleksandr.suvorov@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
References: <20190521103619.4707-1-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If VDDA != VDDIO and any of them is greater than 3.1V, charge pump
source can be assigned automatically.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

 sound/soc/codecs/sgtl5000.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git sound/soc/codecs/sgtl5000.c sound/soc/codecs/sgtl5000.c
index e813a37910af..ee1e4bf61322 100644
--- sound/soc/codecs/sgtl5000.c
+++ sound/soc/codecs/sgtl5000.c
@@ -1174,12 +1174,16 @@ static int sgtl5000_set_power_regs(struct snd_soc_component *component)
 					SGTL5000_INT_OSC_EN);
 		/* Enable VDDC charge pump */
 		ana_pwr |= SGTL5000_VDDC_CHRGPMP_POWERUP;
-	} else if (vddio >= 3100 && vdda >= 3100) {
+	} else {
 		ana_pwr &= ~SGTL5000_VDDC_CHRGPMP_POWERUP;
-		/* VDDC use VDDIO rail */
-		lreg_ctrl |= SGTL5000_VDDC_ASSN_OVRD;
-		lreg_ctrl |= SGTL5000_VDDC_MAN_ASSN_VDDIO <<
-			    SGTL5000_VDDC_MAN_ASSN_SHIFT;
+		/* if vddio == vdda the source of charge pump should be
+		 * assigned manually to VDDIO
+		 */
+		if (vddio == vdda) {
+			lreg_ctrl |= SGTL5000_VDDC_ASSN_OVRD;
+			lreg_ctrl |= SGTL5000_VDDC_MAN_ASSN_VDDIO <<
+				    SGTL5000_VDDC_MAN_ASSN_SHIFT;
+		}
 	}
 
 	snd_soc_component_write(component, SGTL5000_CHIP_LINREG_CTRL, lreg_ctrl);
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


