Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970E9C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2BB2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHw1dAYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfDCSmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:42:24 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33347 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCSmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:42:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id k14so246159qtb.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 11:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=Y9HM4CK+8MJO/F7HDDAXWPQvp3Wfc1pJeE88EELKdWM=;
        b=gHw1dAYzJleMKfurB6oYODrCX0x1TzdPEGyM1DwhRpP0dcZi5bUYy1BBFU1hPjxzRQ
         JfQgz3rxtWHuXnLg662nzfxVe35CPS5B/cYZk2yy1Em/7UaAE9tY2b9kyWN470VTUkgw
         OYBxlhml6JE0aJNdVAVo60UYicxRbu4ki1FM/Lxk13zXTlcIQ3Sy7T2WUMxgUSkjE7K6
         by5r2Wf+ciyTiZ2T/6p5mfL9h6P1Bt/GiQNQ72v8eidWqeCDoxcYXS/f2zfchcA+veNM
         7A/AkRlwVlHUIx2NYro/nB4PxYz+juuD89HkTxrSFBhGiZglyexd1JhpBS4gMBCoPE//
         R3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Y9HM4CK+8MJO/F7HDDAXWPQvp3Wfc1pJeE88EELKdWM=;
        b=msDFi3zMk5xZCoDNSqH5oe1mtXUSa5mCijwIlf4EUEQlO22XnJnlfwu8HxiW3k1R3i
         4trOFEE/P61mHZgiHslowEWlJhP4yQnr95abLrp96+MOpfu4TxY/X/P4tFKPjOfgL6lm
         Jc0Mq4uBeEfKZ2u0bJKSM98cEVU5LppLXOG1+1kCfzqABvqiiCZza4gDY/1CfHHL40Xx
         ATz7Q2gyvgAfVWsPDR0DnwR8V7Sh81FyM34dLYsF4dIjrbewE6cHQ22Jom3wJ5LgoyDV
         zv4fASNDlnYuGJo9hRdHVZx0l4LUTrGCYhwWlNdHLf2cJuCuw1CAy3jUqp312LWRBMjf
         bw8g==
X-Gm-Message-State: APjAAAUUTzscRN2EFA6ItmSUW5zh/MpbvNMg7WfeqwK06K2DUOYR3G9S
        jklpHDad/wwrT9gsghg2tfw=
X-Google-Smtp-Source: APXvYqwqyWGjSmlsE5pqtJ6Tz/WnYaN1nSA5066jvrNkFBPMIb8OqLndlHQef3IjhNj58O3U1Gl8wQ==
X-Received: by 2002:ac8:44c3:: with SMTP id b3mr1337076qto.349.1554316942982;
        Wed, 03 Apr 2019 11:42:22 -0700 (PDT)
Received: from redir.lsd.ic.unicamp.br ([143.106.24.168])
        by smtp.gmail.com with ESMTPSA id q50sm11306116qtq.34.2019.04.03.11.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 11:42:22 -0700 (PDT)
From:   Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: [PATCH] staging/rtl8723bs: Fix code indent.
Date:   Wed,  3 Apr 2019 15:42:12 -0300
Message-Id: <20190403184212.7704-1-martinsdecarvalhobeatriz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix Error: code indent

Signed-off-by: Beatriz Martins de Carvalho <martinsdecarvalhobeatriz@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 828b328adab8..fc49cdfcd477 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -1723,7 +1723,7 @@ s8 phy_get_tx_pwr_lmt(struct adapter *adapter, u32 reg_pwr_tbl_sel,
 	idx_rate_sctn = get_rate_sctn_idx(data_rate);
 
 	if (band_type == BAND_ON_5G && idx_rate_sctn == 0)
-                DBG_871X("Wrong rate 0x%x: No CCK in 5G Band\n", DataRate);
+		DBG_871X("Wrong rate 0x%x: No CCK in 5G Band\n", DataRate);
 
 	/*  workaround for wrong index combination to obtain tx power limit, */
 	/*  OFDM only exists in BW 20M */
-- 
2.17.1

