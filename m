Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A3CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F3E2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbDLzk3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbfDBT0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:26:11 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37520 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfDBT0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:26:11 -0400
Received: by mail-it1-f194.google.com with SMTP id u65so7290147itc.2;
        Tue, 02 Apr 2019 12:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tUxq8ZRrlrpgDO5LniwDZ3RrQi7SaZkkYARRmsQ3S3k=;
        b=YbDLzk3LumQpGxKgExEYC2k4E2NaPHuNIHvR2QLSbcFg0EoGcV1Jnw1mR7x0fREWmz
         bbB3vZ276Ge8CnQ8vEVlmn6ADKGuNvHNU9UV9qeJe8nKAKsbp4AjzmpJ61EG1K6IddWQ
         iIJKGsZpvYiKGUYFN3aNevRfXtvNDJjiV4soSGgxy9aKcaxMKC4KNMtsA/gbqcpssMDf
         C+wIP+xsLBScaMYB9gadZSFgZHRY5kNpSKtNXqJ41+eDOxn3WK+NQOB7EzNx4AkMxGNC
         FzTSvjCa7lF0QHA3Ez8IU8n2Ohvx5HdzHJNA2GkeZszycbjcxU2S1cwRJ8NrTPYxsoB4
         Jb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tUxq8ZRrlrpgDO5LniwDZ3RrQi7SaZkkYARRmsQ3S3k=;
        b=GGaGUQiGbEPieZz79jcD96L4lG6ZkD3lujFmDwSDAClLpcepIKjaJa4fbN23HlCFac
         X794KHVltts3/7Abf8DhTPK5vU9+xNNRw/TCq90RYAMF1L7GEsLujdGEgT1yNCKlmk/F
         hTD+1jqo2MSKUkVea6KET7d0uMy1ROM6Ov834DfRGwYo7FQZJiYaSv8bEFNBB85PhV6F
         oEISNzRl2dOZ2ZLlM8wKvWU6pIh7VuGa8MGoo4EK30OzPlg4B5UAVi/q2p1JYO4eeP1w
         inmj82/H6C0gYZonUGuxsRmbO/Yf/dL/EvrzLfCwCbW6vwnNfgNpKXxS/5v89ftBmksr
         z9MA==
X-Gm-Message-State: APjAAAUsDwhFFlXzjW+02L0BOLqiN4gRIv9RyVNVlV7ypgayRZtYdED/
        Xgyawz8zHJpBkOqpqVaYTh8=
X-Google-Smtp-Source: APXvYqxSmDFi8O2nL1IYGCD/o1nX5ky9E1cEkLVbUPVmXFLQ7ax57tLneMjYgSgZ1BMTuv1LLWxUdg==
X-Received: by 2002:a24:90:: with SMTP id 138mr5393214ita.69.1554233170181;
        Tue, 02 Apr 2019 12:26:10 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id 139sm7328400itk.28.2019.04.02.12.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 12:26:09 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     adam.ford@logicpd.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] ARM: dts: imx6q-logicpd: Enable Analog audio capture
Date:   Tue,  2 Apr 2019 14:25:45 -0500
Message-Id: <20190402192547.4538-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original submission had functional audio out and was based
on reviewing other boards using the same wm8962 codec. However,
the Logic PD board uses an analog microphone which was being
disabled for a digital mic.  This patch corrects that and
explicitly sets the gpio-cfg pins all to 0x0000 which allows the
analog microphone to capture audio.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  Remove 'fixes' note reference Shawn's request.

diff --git a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
index e31b6923cb72..db6b5b900826 100644
--- a/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
+++ b/arch/arm/boot/dts/imx6-logicpd-baseboard.dtsi
@@ -248,9 +248,9 @@
 		gpio-cfg = <
 			0x0000 /* 0:Default */
 			0x0000 /* 1:Default */
-			0x0013 /* 2:FN_DMICCLK */
+			0x0000 /* 2:FN_DMICCLK */
 			0x0000 /* 3:Default */
-			0x8014 /* 4:FN_DMICCDAT */
+			0x0000 /* 4:FN_DMICCDAT */
 			0x0000 /* 5:Default */
 		>;
 	};
-- 
2.17.1

