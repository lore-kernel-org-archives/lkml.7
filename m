Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF7CC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 102E82084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBeT57H/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfDIUQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:16:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42678 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfDIUQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:16:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so181788qtc.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 13:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TSJw8QrTgtq0/fMbgMKXAUGr/UxoJ9UE174j5JKUCJE=;
        b=PBeT57H/qVgVcc8ZYJSqm3+Cx368SlcthrZhougajpcDQA1BiqT0/0Ia3u46GJMlYE
         N3BrA/OAD7/fshseRb554GoUETNw4Jhrh36olojxwfpNnp7PuVcPKeVvuYb/ytxT4wDl
         ECudKde2EJQdhpmJ6RjYvakIrCT63yPnwzdmxt3Ki0ApWC8nll3Q98QxbDd71fADe7Ns
         85t6afmQu44UuMjSmgRYrSS9Ju6l+bftiwzvDvBcK7VswAYBGDOrBRBhHeMklKNR9lli
         f1+ccHZCt0d9uZozCVkkz9aMYuC9jp4er6Zf6dnMnUcGjjgE2oHQOy+2EycAj8J+6fgY
         yFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TSJw8QrTgtq0/fMbgMKXAUGr/UxoJ9UE174j5JKUCJE=;
        b=Fpz9lDmZClnh+VA+sv7IWcqUD6lLRoRj83odMsCR0/vanP7d/vHGLrxDLbCRspSYJB
         8X3LLR2SK2YI/bC8KyYCzUa+Noz0J0kWEgI2xCON9NcbiBMpq2HgvPqZ4zefd4mKRn6s
         mnZaMO2VJT+sDHG5BTYSYCneOXY8NTgVq/ZWADcq25SzTsQm8y1P6/Q01Q5Weulc8uuT
         w4mLb1SiKt5lENg63T8mUZkfR/67Yd1u0IGPi1Y+TDwj3lq63nGUuBlLZbSlgCZmYF5B
         +ElB39zQ2Fnxb0SJZDdyAnyWhayV3c6qSqoksqg4DX06JdE68YHjuMkqGLFg7TYfaAVl
         O/BA==
X-Gm-Message-State: APjAAAXYMZNCsRIKvXfO5xTaP2cm+PDGqDSMISKf2LhbItk+Brz/qI0t
        fRCXI0apbLX0Xj5+PnLyQ6s=
X-Google-Smtp-Source: APXvYqzagx+HJj8GTAbjrzpp5ORbTFmhhIE16PUtYKDW9WLIh3bl68mQnRFb9AseuNGnl+2G511+4A==
X-Received: by 2002:aed:3e13:: with SMTP id l19mr32956752qtf.125.1554840986672;
        Tue, 09 Apr 2019 13:16:26 -0700 (PDT)
Received: from GBdebian.ic.unicamp.br (wifi-177-220-85-238.wifi.ic.unicamp.br. [177.220.85.238])
        by smtp.gmail.com with ESMTPSA id e18sm3188542qki.82.2019.04.09.13.16.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 13:16:26 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH] staging: rtl8192e: Remove a not necessary blank line before a close brace '}'
Date:   Tue,  9 Apr 2019 17:16:11 -0300
Message-Id: <20190409201611.8924-1-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a coding style issue.

Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index 73497d559b77..ac8851812564 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -1631,5 +1631,4 @@ void rtl92e_scan_op_backup(struct net_device *dev, u8 Operation)
 			break;
 		}
 	}
-
 }
-- 
2.11.0

