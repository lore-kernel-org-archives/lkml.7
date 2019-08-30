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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB23C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E054622CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fr2n4Hgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfH3MSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 08:18:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38522 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfH3MSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:18:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id e11so3477853pga.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 05:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=d+u4kAGquV8UHBtexzJEDeIUXA+wS2Qu7dNuoeTxVJ8=;
        b=Fr2n4Hgmslw4/PFIV0ItqyrHA8SleeT0DpVjWEt9WUYA7C8MfZ5kuWmlaIi2Sxv92H
         jrJDiKtbuRBecOcLtk+cdGIjdrnzabaxrcX1+KOpP6Cqfva4z5PfPdQR2/Ig32h/Nif9
         7Ba7CmGhX2OAx3shlP9WAgx9XsmqpyzBZN7nEsSvx+BSu5LHjL52mXdPNWDQoy1nFVyI
         sdDWitbP8stiSWVKfqD3REzQ8h+vBTMJbPLkSuOw1c0XAJYcYqz5miuKOQh2b4Hq5l7m
         yhFETniYe+QbtzI0DPhvF2Ka3iPzmcwi/i7pk3xWzAlXfplvitsOga1GzPjViDmEy9eD
         ZE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=d+u4kAGquV8UHBtexzJEDeIUXA+wS2Qu7dNuoeTxVJ8=;
        b=nzhuILkeQzLfQUHF0N+fxMSQA8ymUjlJDg5Dw1ndoAVytwuN7QNXS9KIVSU/lY+NXW
         S+TwMPib13osrL2H3yDLYKP8thRbtY6iZGbG9qjyDlqQyG89y1OqXUD1LzP8fkCIoAoy
         bChWNJ5/D+9K7UxUdmdxFM+2Eyi6LZPac8Z1o5dZ3JuM2dPlUfhCRSWdHgzJY0m1KFKr
         7/cHLKOTUtWitPx6pi/h+SpkUwtwg4RNZNkezgk5hvmCltJ29ffeCoRgdWc9oAXZt8Pm
         2KvjKF8Yeos2/Ho8mbr8zDrNKYPiX0OgQrtI+e9ENloOXyDk7+D0Z2s6PDUYGw/dOfeh
         Z7xg==
X-Gm-Message-State: APjAAAXtjvgZbnI8PCZBsgl975uzRqIxqQ3S4+tqlm2FgbV/bKbSMjMj
        OakMrM3yyJ8Wc2ySmEejCDc=
X-Google-Smtp-Source: APXvYqw3EyjGxyI8hhrkbOttJeLIcyOCWLux6Ymx0e5OUquaLV4I3gLjRkHoCegaLLDbyNQjyXoUlw==
X-Received: by 2002:a63:3387:: with SMTP id z129mr12667607pgz.177.1567167492633;
        Fri, 30 Aug 2019 05:18:12 -0700 (PDT)
Received: from dell-inspiron ([117.220.112.196])
        by smtp.gmail.com with ESMTPSA id e13sm13887882pfl.130.2019.08.30.05.18.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 05:18:11 -0700 (PDT)
Date:   Fri, 30 Aug 2019 17:48:01 +0530
From:   P SAI PRASANTH <saip2823@gmail.com>
To:     gregkh@linuxfoundation.org, kim.jamie.bradley@gmail.com
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH v2] staging: rts5208: Fix checkpath warning
Message-ID: <20190830121801.GA10295@dell-inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpath warning 
in the file drivers/staging/rts5208/rtsx_transport.c:546

WARNING: line over 80 characters
+                               option = RTSX_SG_VALID | RTSX_SG_END |
RTSX_SG_TRANS_DATA;

Signed-off-by: P SAI PRASANTH <saip2823@gmail.com>
---
Changes in v2:
 -restructured code for better fixing the checkpath warning
 -wrapped commit description

 drivers/staging/rts5208/rtsx_transport.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx_transport.c b/drivers/staging/rts5208/rtsx_transport.c
index 8277d78..48c782f 100644
--- a/drivers/staging/rts5208/rtsx_transport.c
+++ b/drivers/staging/rts5208/rtsx_transport.c
@@ -540,11 +540,10 @@ static int rtsx_transfer_sglist_adma(struct rtsx_chip *chip, u8 card,
 
 			dev_dbg(rtsx_dev(chip), "DMA addr: 0x%x, Len: 0x%x\n",
 				(unsigned int)addr, len);
-
+
+			option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;
 			if (j == (sg_cnt - 1))
-				option = RTSX_SG_VALID | RTSX_SG_END | RTSX_SG_TRANS_DATA;
-			else
-				option = RTSX_SG_VALID | RTSX_SG_TRANS_DATA;
+				option |= RTSX_SG_END
 
 			rtsx_add_sg_tbl(chip, (u32)addr, (u32)len, option);
 
-- 
2.7.4

