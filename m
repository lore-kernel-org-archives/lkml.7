Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC81C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C4A2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfFXIv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 04:51:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42137 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfFXIv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 04:51:58 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so6464314plb.9;
        Mon, 24 Jun 2019 01:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EONwuevFixr8Kq27JTPWM25beefbW1BHfJwJ19KPbZ0=;
        b=VoDeWW1Ux0XHHnE5tjW1Ew3NZP2ILoWbFvB8O4dysnakAg/LMy2rD0ZaUg9Y+nIVuq
         3ZP9JRJPTKFc1c8LlqClsFQR7vO9Qudd19dsSqbriD7C/fAl7GbHf1R83VPhdnejF5b6
         6UK/C0ncYHCV9zYHs8epyoTom1uyLYdhCTtUdJp5yzldDha0VoN/GorYPTA/u2LSbfIs
         I4+mO8mAVx+nvQLql3JRwfKquBFuBQAS3KlAjQNAk5MbVOYVtlVoWnXPAUJao0/stkrG
         Uv0YshGimN70n3sL147FMU/4rqplWdob5y5LYSL59KPRn4sFjRe/7BrGQy8grg3HV3S5
         moxA==
X-Gm-Message-State: APjAAAVp1oLwHT4BzRLcjph7zdwZodwhhgxV/apiPpAUw1XxRSHphtqb
        g/9K9L/O5T1hay6x/nyF2Vs=
X-Google-Smtp-Source: APXvYqz0GotPOPJXVNKI9Abz1knbO1BSWVLmPw5q+x/BqD/KlbvF9ZAkXpdBtlpnF3K9wADXZB139g==
X-Received: by 2002:a17:902:9a84:: with SMTP id w4mr44099452plp.160.1561366317508;
        Mon, 24 Jun 2019 01:51:57 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id t13sm9828121pjo.13.2019.06.24.01.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 01:51:56 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
Cc:     Denis Efremov <efremov@linux.com>, Helge Deller <deller@gmx.de>,
        "Rolf Eike Beer" <eike-kernel@sf-tec.de>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] parisc: asm: psw.h: missing header guard
Date:   Mon, 24 Jun 2019 11:51:27 +0300
Message-Id: <20190624085127.5310-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190623150920.26422-1-efremov@linux.com>
References: <20190623150920.26422-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The psw.h header file contains #ifndef directive of the guard,
but the complimentary #define directive is missing. The patch
adds the appropriate #define to fix the header guard.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 arch/parisc/include/asm/psw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/include/asm/psw.h b/arch/parisc/include/asm/psw.h
index 76c301146c31..46921ffcc407 100644
--- a/arch/parisc/include/asm/psw.h
+++ b/arch/parisc/include/asm/psw.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _PARISC_PSW_H
-
+#define _PARISC_PSW_H
 
 #define	PSW_I	0x00000001
 #define	PSW_D	0x00000002
-- 
2.21.0

