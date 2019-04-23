Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE5CC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D5492177B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="B3OrmrRO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfDWKlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:41:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39715 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDWKk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:40:58 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so18201233wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 03:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G3GYI2FxkpdfJQ+eVvCSxZoqI6TwHuQxK0boZZx16TA=;
        b=B3OrmrROTGl2X3K6zG/3aEl63Oq1sNJMJb3o17M+6f/Sl5AeHuRQ9g/EqEhsJuoe41
         Bz8d+gqLomYzOVbwz8DXBIcXU//h1bNl/C16ysl059kn3/DUlH2+ZMQBZtRYzzHKajhO
         od2J+G8b4xzAlaPfhjikY0aJxlNzNuhorb81y7vQjbdRhyOXB0BEkUn1wdm6zZIt/Ayv
         Dr+GyFJLhqnJuLuTpYnVrnLxRPX0k7qVqt7pLj+7zaIh24fHD1KG/DpvZ+DK8EyUNF4t
         /DEjXMgioKBP4pSObmvQlAnKUIo6P/645JqhIePf3QnLWUiwPFQWr5X8qrgCzSWL7MFM
         eHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G3GYI2FxkpdfJQ+eVvCSxZoqI6TwHuQxK0boZZx16TA=;
        b=gwY0cyCjZSPP7tvZVtVszvCrkIFkhYq/11cPl+J8WgqVxV0lFi8k37O9GDf0irUb45
         DrkP9Q61935Bbgk8ZTKjcpSmgWa6JRbJgwFR2WQEyVpiK3o2FBRbh1ToglhwPh46djFo
         MbBevLkRAxs9beHHA4Rnz/m9gRsVzMJjh5z3SQMyj62GUkP6W1gmTgxm2Hyca+7CL9mS
         9teADUTlPxagB3JSbDrNzVXzXxhhEWUL2cQpEi6sXISpuGOlE5Nvn0ucsWPxus086HGr
         hE/RvYVmw7oTR6Ovwqmqk4Vc4BPwfhAo+VkXz4qsuTfZp4riDlauVNJcwbFV+MVOC2J3
         PBgA==
X-Gm-Message-State: APjAAAVTZCj718+0hACHpmuhTVLH6PyYVCSuRkwF169ZkaxxLb1Rbt59
        4cChsRtunNibewtbo7VkEOdhrw==
X-Google-Smtp-Source: APXvYqwQ1uzs8F8z1CssOf8ZnYtzfOmmff/D8NI8IHTXx93yoHJto/pDs03YfUTKFEEzbFAx7OEJEg==
X-Received: by 2002:a1c:c00b:: with SMTP id q11mr1872082wmf.38.1556016056713;
        Tue, 23 Apr 2019 03:40:56 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id y5sm13329421wrw.23.2019.04.23.03.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 03:40:56 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v2 1/3] dt-bindings: Add pixart vendor
Date:   Tue, 23 Apr 2019 10:40:44 +0000
Message-Id: <1556016046-31231-2-git-send-email-amergnat@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556016046-31231-1-git-send-email-amergnat@baylibre.com>
References: <1556016046-31231-1-git-send-email-amergnat@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PixArt Imaging Inc. is expertized in CMOS image sensors (CIS),
capacitive touch controllers and related imaging application development.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 8162b0eb4b50..dbd889395b74 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -313,6 +313,7 @@ phicomm PHICOMM Co., Ltd.
 phytec	PHYTEC Messtechnik GmbH
 picochip	Picochip Ltd
 pine64	Pine64
+pixart	PixArt Imaging Inc.
 pixcir  PIXCIR MICROELECTRONICS Co., Ltd
 plantower Plantower Co., Ltd
 plathome	Plat'Home Co., Ltd.
-- 
2.17.1

