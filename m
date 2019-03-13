Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60621C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6FC21019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1/VM9qY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfCMOzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:55:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40409 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfCMOzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:55:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id g20so2173793wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 07:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Ti9fP67vZs3ENLJSiC8CLzWopXAoY3Qb++Mr5iSUrs=;
        b=i1/VM9qYQtUzY3WS1ibVSG717xN0wt8E2srHMsUXUUFd6YyskZvtdw2+vc/NJj6XmX
         jZL8mRC6SHZoYoDStJfLP1OkjGvTKcwIq2Kci5+U4AhYmwGSVWwmcjjonTXGYE1GxUyR
         hBj7zLosK3SoD5uU3R/YAf//yfaNfQkpdvjNAaJnCFeNp0EnhSLHg5qKnWJeQvw5f1Az
         bMHCy0CZjMruxzaQu7hGCrnMnGvs8cW/SFN29kuyY2MtFLQ0FHr6nYEzLPnwUW3o1jiG
         EpICk5lAja55aQR85/9fsSaruPuVRP1Q0qzdQqFgEsrDl8vcUVwjqPKM9s5sw/Jieuup
         HRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Ti9fP67vZs3ENLJSiC8CLzWopXAoY3Qb++Mr5iSUrs=;
        b=TxAmFmlV6pzA/2+JE/p6KBfJj0RdMzfIvjMQ8Mcv/ShDQkj9Rw8Kbm7Qz/NXSw4zxW
         Qzb7ql/JPc89ovpVolfVVOMThYTIyPbAU3twL7Ybcu4RjMR88LyNH0vo/FiRMkZanBkP
         UFwEtHo7UyzU4w5ZUVRWcuAg5FoJ6hkqiKgCcFuSUh0fNiDnb25EyzgtGDkVCrkrxQEs
         w6cKX/8IE4lMqktIlggpwDrHc8d3GbknGT372yb7OhbF9vdpD9kRATw4bnrvzYFw0JNR
         zxJseN687pG/7MFTpPBEcxIh6HGlyFVEamw5wDNJWo34lN/NtaOfHw1JSXm6IHpDMtwT
         GZTA==
X-Gm-Message-State: APjAAAVGmPxA1MxSH7KAstPKLLUnra+BvcrECK9F+D30DzDzGA7aXpBM
        b3Z6+IakHOIbJZB7FmgMpQ==
X-Google-Smtp-Source: APXvYqy50DZ5EM7o6Gba+JqGkpTdNLgR+j99exHOhmHi1EE5Tium2qP47cVcJ44DJfdXBwjc3xWhKg==
X-Received: by 2002:a1c:4408:: with SMTP id r8mr2589084wma.149.1552488944658;
        Wed, 13 Mar 2019 07:55:44 -0700 (PDT)
Received: from localhost.localdomain (cpc102034-bagu16-2-0-cust471.1-3.cable.virginm.net. [81.97.71.216])
        by smtp.gmail.com with ESMTPSA id p68sm1329218wme.45.2019.03.13.07.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 07:55:44 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH v3 2/2] staging: rtl8192e: remove boilerplate license text
Date:   Wed, 13 Mar 2019 14:53:20 +0000
Message-Id: <20190313145320.26782-3-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313145320.26782-1-jbi.octave@gmail.com>
References: <20190313145320.26782-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove boilerplate license text.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
index 6d57abedaa34..82c11caeee7a 100644
--- a/drivers/staging/rtl8192e/dot11d.c
+++ b/drivers/staging/rtl8192e/dot11d.c
@@ -2,14 +2,6 @@
 /******************************************************************************
  * Copyright(c) 2008 - 2010 Realtek Corporation. All rights reserved.
  *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * The full GNU General Public License is included in this distribution in the
- * file called LICENSE.
- *
  * Contact Information:
  * wlanfae <wlanfae@realtek.com>
  ******************************************************************************/
-- 
2.20.1

