Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FDEC41514
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B93E22CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YB1NsLBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfH3HL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:11:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38145 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfH3HL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:11:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id w11so2945262plp.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 00:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zGXEjPktSO6/eCakesqWqwUsuQP/GfUPtsfF6K82e5g=;
        b=YB1NsLBLEhmD0oNselr4ivtcFAkIpTsQyXY8vV2ci3dxFZlPdQOrUdftyHVPuBIcGi
         A8CjH5QGbEp36b0D3NtQ0PN/e3nlDU5HtnzDcappEjeXv6b0YdhFlTWVM/B8ILDNTj8p
         a/71OE9Hk+34UQ+4y2NUjS2g+GRxnk7/QFbAh+IB0hvVyJE3kA5cI/TzB3IdoaRM8q1M
         Yb2DNeLkV809OrvsNpoaliyRyx1A05ZiO63XsbpKCdNOQLRDL11+Vg9LRzhwoNq9RzuD
         lE9e7lHlgjr8WlrPz8PUQZTC7BN2gOT+FwB70oPTkpy2NdUMCXAEze/vUW+Ur9fTfCVs
         vfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zGXEjPktSO6/eCakesqWqwUsuQP/GfUPtsfF6K82e5g=;
        b=TcC2MOO44/J769D423pSZXQy5xh9Z+3D6YlspRx4DLgmR5M4/gDqXRKjwTorTVVkXt
         ggmKZsTscVQeeaGj2oB0zHw0OSLEqpTy4HOxH5m3ycnByuwwbvVRTaJPK9vAAzCXxEyi
         qNB6e+dfXCL0ejo35dxrUxxUlStJLZIJ2OZ7z2G8ck3FKrhVk0P/N4n6WbJAyeb75aE2
         3bkycy2GfaKSxI6hCUUh6NGdS3CK3oJAatJSMtS+bOmREQDUXqSX9Da/K3Sd4dd8/n6p
         X5hbsxLDiQsD0m9fi3agidRCL5sB5QVNNjmp3TMFSPXfK/fZqIkqEN8BaA4Sfh5kkCAd
         POxQ==
X-Gm-Message-State: APjAAAWeY6x5+h8MczXp01yv4qZdOjrrf9oySDVZ+UAh5sMPKi8PAYTU
        63Tyhb8bS4p/LWMBPo2EjtHgShNVqL8=
X-Google-Smtp-Source: APXvYqy4/8ZGIXdnPqiFeBroCo7zDWSSo61cs6V5zAkV0r8nLFChBSZVvz2SPCX5X4SaRy0OXCeW2w==
X-Received: by 2002:a17:902:e592:: with SMTP id cl18mr14104977plb.291.1567149115174;
        Fri, 30 Aug 2019 00:11:55 -0700 (PDT)
Received: from MeraComputer ([117.220.112.100])
        by smtp.gmail.com with ESMTPSA id 143sm5614739pgc.6.2019.08.30.00.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 00:11:54 -0700 (PDT)
Date:   Fri, 30 Aug 2019 12:41:44 +0530
From:   Prakhar Sinha <prakharsinha2808@gmail.com>
To:     gregkh@linuxfoundation.org, kim.jamie.bradley@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rts5208: Fixed checkpath warning.
Message-ID: <20190830071144.GA29987@MeraComputer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch solves the following checkpatch.pl's message in drivers/staging/rts5208/rtsx_transport.c:397.

WARNING: line over 80 characters
+                               option = RTSX_SG_VALID | RTSX_SG_END | RTSX_SG_TRANS_DATA;

Signed-off-by: Prakhar Sinha <prakharsinha2808@gmail.com>
---
 drivers/staging/rts5208/rtsx_transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 8277d7895608..3fc83875fe7c 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -394,7 +394,8 @@ static int rtsx_transfer_sglist_adma_partial(struct rtsx_chip *chip, u8 card,
 			*index = *index + 1;
 		}
 		if ((i == (sg_cnt - 1)) || !resid)
-			option = RTSX_SG_VALID | RTSX_SG_END | RTSX_SG_TRANS_DATA;
+			option = RTSX_SG_VALID | RTSX_SG_END | 
+				 RTSX_SG_TRANS_DATA;
 		else
 			option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;
 
-- 
2.20.1

