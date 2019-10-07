Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8C7ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B54206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570454955;
	bh=bVuSLpTvdW4BifGY1uYuDsq1DfGbsMyMvoeNSs5oiYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=scGfdwqOcBNA8K6OEpgfCAn0KcgklxRXk+DTGz3GetwuRKyvCNW9dEh48TgA/SKF3
	 ZVif/SweDqg0+EcUIdDpWZS7LvTCsSWEM5WLoqK7jzxKvSuNAkkh3R6R0SZvAeYgOC
	 RQo40juDULI5YZN/xb9ufcimJohAmcT0Mofb2MYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfJGN3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:29:15 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40059 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728676AbfJGN3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:29:10 -0400
Received: by mail-lj1-f196.google.com with SMTP id 7so13657579ljw.7;
        Mon, 07 Oct 2019 06:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=85dVJxc5Go/ZeDNecXfIZl1Or+Zhk6XQDSwO01sY1ps=;
        b=gzNNeeBszqp3/KV+na3cTXka/kkqVPVugqBXLgWKMFoCoXTBSHjHHko9SwborGKmro
         i3FOMrRfuAr6eNVgbbb+STpckXS9/1u07qLcHEDcUdktf28+PGsEg4k7i33rf6+KrclB
         MdhvzaV5dXo+P7ECoAeCtiSR45lJhpXOLUsCGLnrVz5n2RuKZcC6+9La7sxCqEKvoSBC
         PYxzMsBbyC4W7BmPArWDiN8CiA/WdhMV7FgYkij8D+7W+ysd9qWcAoygLZuT+T5dJ/ur
         ThoZ5lG9RtdKOWLdqy06dX0BtqdZ3w+gzsfARcx41q3qDKz9OqVF4H4QIaApr/feYFDV
         9yHg==
X-Gm-Message-State: APjAAAWXvLxNY05aRBsPf5PO4+Ohoojzd2CibXZ4zeGIRwnmj5UqHuHQ
        M+IbXCUzzDy7J8yWANfxUN8=
X-Google-Smtp-Source: APXvYqwvWME0xvLnEG+UUjHxN+U6aEntTPN2I+EsnnNToVC4+03YuG+aEVvV70wTSxZ0eO6UvOobTw==
X-Received: by 2002:a2e:84ce:: with SMTP id q14mr11639389ljh.250.1570454948315;
        Mon, 07 Oct 2019 06:29:08 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id f22sm2702245lfk.56.2019.10.07.06.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 06:29:07 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ribalda@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Sakari Ailus <sakari.ailus@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ribalda@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v8 5/6] media: ad5820: DT new compatible devices
Date:   Mon,  7 Oct 2019 15:28:55 +0200
Message-Id: <20191007132856.27948-6-ribalda@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191007132856.27948-1-ribalda@kernel.org>
References: <20191007132856.27948-1-ribalda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new compatible devices.

Cc: devicetree@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ribalda@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 Documentation/devicetree/bindings/media/i2c/ad5820.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/i2c/ad5820.txt b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
index db596e8eb0ba..5764cbedf9b7 100644
--- a/Documentation/devicetree/bindings/media/i2c/ad5820.txt
+++ b/Documentation/devicetree/bindings/media/i2c/ad5820.txt
@@ -2,7 +2,10 @@
 
 Required Properties:
 
-  - compatible: Must contain "adi,ad5820"
+  - compatible: Must contain one of:
+		- "adi,ad5820"
+		- "adi,ad5821"
+		- "adi,ad5823"
 
   - reg: I2C slave address
 
-- 
2.23.0

