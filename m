Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4254BC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 21:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E587E218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 21:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/wm28kE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731940AbfJIVjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 17:39:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44750 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJIVjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 17:39:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id z9so4910072wrl.11;
        Wed, 09 Oct 2019 14:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tcMFZrYzkXthDN2tPL7urUoh2Atq6M3SFm7VW5KGajA=;
        b=u/wm28kEkru3TyprTgddW261vX/5XbEce1Ws5zmBXcfUf86jiP3Djy4kG4KxmxxUK9
         S+zhx24CvvPULDAfFFD2kFVkW4DRwrjnX9utOwcH92CSl5YKmfbNg9XpeZF132H7zSYW
         BgNF4fWC5tGSlU9/dumZWgq+xHME9yHEqQ5LBs9I9FhBY9TvNuOJt3NFpX7BInPeC3Hx
         iIyzQvFQkqpJzQXd8VUBNbfbgnwvoxm3DgpbN5vkWBWOGw2Vuf/7MedZnz2h24lBEATp
         oBEmCJ0XnLkbxX+hEmPpelZVHP1oH1/yqeMIo4rZze1m/qHEnHk0C+z734FNqo/EXXE9
         mXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tcMFZrYzkXthDN2tPL7urUoh2Atq6M3SFm7VW5KGajA=;
        b=iPTeIVL6irSBueLe5kKrVYU5Ybc+UiQeeybXaR6C12sRw6ZkmiD06fipozpqav+nN/
         Gvh2SBTzYZzthhDKmOj2NvCTPbfbQ/4Mt4UCW8V4s2TE0TN1HJfZonxfhGjZDmbHCFgN
         VVT4Y7DLpq+9TUrkTgikDKrXlm7e3zUypuUt5U+i2mwmV4ArX1ZVDARs0kZ/Lr7mRCK0
         9La9BmpFpIaRfTr60Z6I91DNFbTaGSFTFpBgNxoMQ73M/UTNmz/dZfE1cmYzAWEHkwtF
         +OfkGULkHNvcW/xsgeJOpgqlsvpOaU/oikU9WAzd7P1DWL3ishJObYfcc5zal3ALZrva
         87UQ==
X-Gm-Message-State: APjAAAXU2HaY3aANCd6rwZ+OR3e9qcUlmh7LPW3hJsfR02yBbipfpozh
        Pv3KIS/kdEtbLgOex2hz7g==
X-Google-Smtp-Source: APXvYqz9GgQL7LY/Prh1ynW6SbQqAmf4NSYqACjsQLaU2Yfg3bbHUaT8l8/n5bdfBvFPpdpcDfsvxQ==
X-Received: by 2002:adf:f2cc:: with SMTP id d12mr4943049wrp.105.1570657187704;
        Wed, 09 Oct 2019 14:39:47 -0700 (PDT)
Received: from ninjahub.lan (host-2-102-13-201.as13285.net. [2.102.13.201])
        by smtp.googlemail.com with ESMTPSA id a3sm6025741wmc.3.2019.10.09.14.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 14:39:46 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, GR-Linux-NIC-Dev@marvell.com,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH v2] staging: qlge: correct  a misspelled word
Date:   Wed,  9 Oct 2019 22:39:36 +0100
Message-Id: <20191009213936.11532-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a misspelling of "several" detected by checkpatch

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/qlge/qlge_dbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/qlge/qlge_dbg.c b/drivers/staging/qlge/qlge_dbg.c
index 5599525a19d5..28fc974ce982 100644
--- a/drivers/staging/qlge/qlge_dbg.c
+++ b/drivers/staging/qlge/qlge_dbg.c
@@ -354,7 +354,7 @@ static int ql_get_xgmac_regs(struct ql_adapter *qdev, u32 *buf,
 
 	for (i = PAUSE_SRC_LO; i < XGMAC_REGISTER_END; i += 4, buf++) {
 		/* We're reading 400 xgmac registers, but we filter out
-		 * serveral locations that are non-responsive to reads.
+		 * several locations that are non-responsive to reads.
 		 */
 		if ((i == 0x00000114) ||
 			(i == 0x00000118) ||
-- 
2.21.0

