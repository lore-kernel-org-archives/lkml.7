Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33BFC28CC2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EED26374
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v1Im+dSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfEaDyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 23:54:35 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35876 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfEaDyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 23:54:16 -0400
Received: by mail-io1-f66.google.com with SMTP id h6so7037255ioh.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 20:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AD2v4+YBh23vSrSakkquxEV0xAfLkc+oDW+gsObgm4g=;
        b=v1Im+dSykIZ/o17BF2dZBN6qKUORfLiTIwGOO21jMWRdRFVgvCgye8wMMCE2pTy9mO
         dzHZGVmPOV+yUJSAChQU8I1hW74bryP1A8PNhrYJyXRDQHkatWnUORM7hhHV//8JIVqq
         1vJu4XMk1QmOluxXtFqS/p16+wp7r+E82bnLZNBw5zk9lMr988zMbe44q+gzQgxsqULY
         hUWB3Asp1j5ktucxfoyRCUrr6xbSwwX1rUURVIB0V5NIosbfr7BARxFvkJb9TYnCkFMa
         Tm3ZpQq7ApNQPFkYHvQ+uWJjGJDXjch4E2gN7wC/sYMAOaJZVC3PpOeVFaLRpsxkfm3B
         J//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AD2v4+YBh23vSrSakkquxEV0xAfLkc+oDW+gsObgm4g=;
        b=EWQQV69GHiboMVOZrUcY8YAgDfLDC+soOQpn/SaYfHC0GWCWi1syKIEBWPVOecaQiX
         a7Qd8NvnrPWFzNkC+dJQVpb2WwxsV/NG2LGl22WgyqhhFcAN8QAlry0XRItKwl4NgC6w
         OyDC+294vRtE3La47ftHhsulcgfna87EJeamZPCzhsupURTzoLZakJJe/VMAeERiMVWW
         2Ie9iwYdAuHTNQbbU8z5qZjTIMQxWyZofzdCVWiSuM/x8vFaN7/00NEEfwHFFfePUqBb
         15NloyAmmvgfThesCQ17iZF705IC8dabgwQLCHpHwhuoTMLc2LKT/t+LUZluGq4mKckt
         w56A==
X-Gm-Message-State: APjAAAXRvRZy9ccUmcfY9EOXcqKDgYldXebyzh8SnkNK4PsBQWUoOCE6
        4ipjXOQhJEtjQ3eIofQRAsSyCg==
X-Google-Smtp-Source: APXvYqycI8C7GJZADcTmt8i31xiUOJTKNoLAX+58tPg2SEvn+jL2s46fJt29gnMhTlelRCo9iy5FmA==
X-Received: by 2002:a05:6602:50:: with SMTP id z16mr5477434ioz.302.1559274855582;
        Thu, 30 May 2019 20:54:15 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id q15sm1626947ioi.15.2019.05.30.20.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 20:54:15 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org
Cc:     evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        cpratapa@codeaurora.org, syadagir@codeaurora.org,
        subashab@codeaurora.org, abhishek.esse@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 15/17] MAINTAINERS: add entry for the Qualcomm IPA driver
Date:   Thu, 30 May 2019 22:53:46 -0500
Message-Id: <20190531035348.7194-16-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531035348.7194-1-elder@linaro.org>
References: <20190531035348.7194-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry in the MAINTAINERS file for the Qualcomm IPA driver

Signed-off-by: Alex Elder <elder@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 429c6c624861..a2dece647641 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12872,6 +12872,12 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/qcom/
 
+QCOM IPA DRIVER
+M:	Alex Elder <elder@kernel.org>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/net/ipa/
+
 QEMU MACHINE EMULATOR AND VIRTUALIZER SUPPORT
 M:	Gabriel Somlo <somlo@cmu.edu>
 M:	"Michael S. Tsirkin" <mst@redhat.com>
-- 
2.20.1

