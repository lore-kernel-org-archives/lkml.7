Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1A4C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70384206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lepqg45i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgAIIBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:01:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36683 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbgAIIBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:01:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id k3so2843689pgc.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 00:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rnct3rScuo5UCOrZPVZUn6yaCZ4Hz2wyB5PJl2dXsyQ=;
        b=lepqg45iW0x0wIXzB9W1OISEWmZF8wGXjcpktX5kTjFE9A/zNltobhwCGrIT9SCeZT
         vbTg1L38xmQ7S2IjvKnDbq6OTnY8mNqWjopnVUclb6wn1psZgD8QUaNBV1qeHbpmqE9M
         DWWZtCsiW2J18ax3sTRNO0HoiATt/m6isRFl62RXJlfEvLnm2wk0lBumEX4jWDaTsIrZ
         J6ZVYRFs85Rr6WVN6Nv+pQ4DZG5piMclU/QWVnlbdeeHN5PcRV0E6zxz8/eJPbE1wXuv
         a4nlnUTY+ZO5MDAsnS7CTYnLI55KZw3DBOWwwkCCLvqLqWVy8iZRXrpYFEGfE+gW5gt8
         ylVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rnct3rScuo5UCOrZPVZUn6yaCZ4Hz2wyB5PJl2dXsyQ=;
        b=odbZH77EfUcnkIwATnzLBgYVJ4ob2vHOBgd2EK6ov+yd6/sG7ZmLBrcw3F+25NUziB
         sqJJP0bHOAsxY1TUAcMJv99aBkqspmUHJLeSv412stTOrTmb53WumtlSD1RKIdlmEYRK
         o9rxchPbB7QE4ridt7QHjkeUVqYxgBXGI/mbdQBRbbO0t8tfN6mNR2b3PaafkMHFYQ6M
         F1FsN5xFSquxg5VxO6sOhQS+D2xos+u/YvJnsYzEC6yxUI82Q6JzgsOg7BMqZIsXT1PN
         w1VZP4q4TSRV5/TOc2qO6klXXS7Xwis90e01mBYUTHzlTxisQUySo320igawwRZ+97UA
         crkA==
X-Gm-Message-State: APjAAAVNCMRX0QFGFQKW94dGp91D7BetqARm3WhjtG588Vbvd6y0w1aK
        rfS4dyIqZevqpJLTBSO4lhKUMjkYVmtGUw==
X-Google-Smtp-Source: APXvYqyXZgRI88AzUaKA5gkc6klLUtcliBwJ8O3HqkjQM5lsLt+BQzm1FAYECTQpDgENRC+rUjLFww==
X-Received: by 2002:a63:7705:: with SMTP id s5mr9628789pgc.379.1578556903816;
        Thu, 09 Jan 2020 00:01:43 -0800 (PST)
Received: from localhost.localdomain ([240e:379:970:fa70::fa3])
        by smtp.gmail.com with ESMTPSA id 100sm1861175pjo.17.2020.01.09.00.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 00:01:43 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Weijie Gao <hackpascal@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-dts: fix register range of memc node in mt7621.dtsi
Date:   Thu,  9 Jan 2020 16:00:03 +0800
Message-Id: <20200109080120.362110-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memc node from mt7621.dtsi has incorrect register resource.
Fix it according to the programming guide.

Signed-off-by: Weijie Gao <hackpascal@gmail.com>
Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/staging/mt7621-dts/mt7621.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-dts/mt7621.dtsi b/drivers/staging/mt7621-dts/mt7621.dtsi
index a4c08110094b..d89d68ffa7bc 100644
--- a/drivers/staging/mt7621-dts/mt7621.dtsi
+++ b/drivers/staging/mt7621-dts/mt7621.dtsi
@@ -138,7 +138,7 @@ i2s: i2s@a00 {
 
 		memc: memc@5000 {
 			compatible = "mtk,mt7621-memc";
-			reg = <0x300 0x100>;
+			reg = <0x5000 0x1000>;
 		};
 
 		cpc: cpc@1fbf0000 {
-- 
2.24.1

