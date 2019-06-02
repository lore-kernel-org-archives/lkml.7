Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD02C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 15:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4BAA27978
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 15:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="unIx9W0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfFBP7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 11:59:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41615 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfFBP7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 11:59:18 -0400
Received: by mail-qt1-f193.google.com with SMTP id s57so6811825qte.8
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 08:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4D6xYVcx65ci50EYrgxQnh1AMljYTOBoiJu7xzeER1s=;
        b=unIx9W0jhTmqnG9YbWNxmFBYkYOu1c+99DsdX5RP0YBV10dmsAlSUWyUWQF/XW2vV3
         jfFGdxogecSbQd8quDfv12r8VwBhnX/pH6Ke6XEsellp7vonq3MRgJXKCVi2yVRneRrN
         rsyInvy4+oH/ch/G28xH8s8rdOmCVheirMaUx056OyphhsC/e5XeXevPeKDnqdWz0lUF
         BbvWRAcHPTDQAkRR7ZEaoOKskY3iyGLaAjG8sU0jX93kWCbE+GfhvJbnyJrk2Col+1we
         eeVBl4eQEoOoTgXzmcVZLxJis3AaLcF0iS82WHIjOECoDiNKprBGN3Rd1WnYDrGXAr+H
         YwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4D6xYVcx65ci50EYrgxQnh1AMljYTOBoiJu7xzeER1s=;
        b=ExFhtOdDnklJKd/BcZrK44ntX1Rw9gmo99e7YfsmLXZS9zli7VwLOnFVU1/RjLVTpT
         zle5m4ODWBHAF19l/wphphCcWU72FG4uxZ3N9jOzBZDDwSSFXLj3R1CTR045ueFzCHoY
         qU0WnV69jQ0wtuwDoZzz1LNIFDHkiYo4Guc/rOTCHIEzuhfKLeYluplGdMLac4NxW6oY
         tZ+YLH5IkS11h1gxSAEmpCKAv4f6QkyyiDwprekmsr8wGKWhfdv8/4rxzjrYsbmsGMHp
         wJNA95xI3gXyqY5qKPMP0P1xk9y1bXOtgU8QFgAcIuXZDtg8+lvY3vhhH+Y6zRlhVIze
         vK+A==
X-Gm-Message-State: APjAAAWbq3lvgwAUuaT2SZ9GMknXfe91i7N74JCDWb7HRUWINqJPb5EH
        b2IsPYQqKhkm5Ia9TqO9UkA=
X-Google-Smtp-Source: APXvYqzxm+ZYCf86Q6YFFaOaPrlJLDQeGGr8n2GIrsIyvcINgZRGq20pyTD/qQqEJ3UdQfn1v3RPKw==
X-Received: by 2002:ac8:7381:: with SMTP id t1mr19772251qtp.387.1559491157557;
        Sun, 02 Jun 2019 08:59:17 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id n7sm7378589qkd.53.2019.06.02.08.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 08:59:17 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jeremy Sowden <jeremy@azazel.net>, Mao Wenan <maowenan@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Geordan Neukum <gneukum1@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] staging: kpc2000: kpc_spi: column-align switch and subordinate cases
Date:   Sun,  2 Jun 2019 15:58:34 +0000
Message-Id: <8a940c89d43ca59bb4c70100cf1b33529501ff5b.1559488571.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559488571.git.gneukum1@gmail.com>
References: <cover.1559488571.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux style guide prescribes that switch statements and their
subordinate case labels should be column-aligned rather than
double-indenting the case label. Make kpc2000_spi.c follow the desired
style with respect to switch/case alignment.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index ef7e062bf52c..13c4651e1fac 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -502,13 +502,13 @@ kp_spi_probe(struct platform_device *pldev)
 	}
 
 	switch ((drvdata->card_id & 0xFFFF0000) >> 16){
-		case PCI_DEVICE_ID_DAKTRONICS_KADOKA_P2KR0:
-			NEW_SPI_DEVICE_FROM_BOARD_INFO_TABLE(p2kr0_board_info);
-			break;
-		default:
-			dev_err(&pldev->dev, "Unknown hardware, cant know what partition table to use!\n");
-			goto free_master;
-			break;
+	case PCI_DEVICE_ID_DAKTRONICS_KADOKA_P2KR0:
+		NEW_SPI_DEVICE_FROM_BOARD_INFO_TABLE(p2kr0_board_info);
+		break;
+	default:
+		dev_err(&pldev->dev, "Unknown hardware, cant know what partition table to use!\n");
+		goto free_master;
+		break;
 	}
 
 	return status;
-- 
2.21.0

