Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C83AC00523
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047E421775
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 01:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf0asTzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgAFBes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 20:34:48 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37176 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbgAFBeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 20:34:44 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so35352542lfc.4;
        Sun, 05 Jan 2020 17:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Ys0tzVmoHrFmSSc5qitpcji+ruTEJL6SzwhqsUjqgw=;
        b=jf0asTzGPKdmQ1tarA9D8fk4rIJRpIU323nKyXaHOBPf46lx8M85FLfaCsAe8RAhMS
         tXjAfJ6G4DBNJtU7vm7sfRGJ6BCRa5TGpYROjnynKSVvTWEySQzPDU9peGDk9xXF+z9z
         nqlcr4jcw555t9AddHN2m22leeAA1i5Cmo5+oPgA6yonJNjue4hlOIVMnGoTA6Su6tV6
         0ihECe6YKOnnN3xfhuhjKyAuDf7SZpqFptN3kwC7CA2vQThDgLU02hCIGdLetaZL01bY
         PUztdJWXTilZFNQZHhoToQmGJfYeKqb0lKciEnndWv53NQxwTUx1u+a08Vu1sBO+3Raa
         RzIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Ys0tzVmoHrFmSSc5qitpcji+ruTEJL6SzwhqsUjqgw=;
        b=BrTmk62nu5xX7Z/Yi8UEvuE8Sn+ajaEmI+nS04BFtS70DxauUwTxO0p1W8u/Up7AGp
         tlaLeS+G+zQWavlFfuSzzj6EPDgPs+SMzfFDPcjbDV6gQHCTiHKCkBhHRmX7w5jF0wyT
         yFcE4m1Rz2mEzUDJwBeg38GZtp+IVm7A66dNAhJzbolFXS0IfLx67TakD+uEcsMYRWu3
         v7DWsxhzWdqUIs+dSlR4lRkM33QQJuw8UBQOh0VxlIT2M78y3EhQlpBPwvkG6T5OSS1a
         HaMXe3csXcV+uTERPPiLDJ18yaFKCQriMqcWuZa6GCpCgguWiq/DsO+hIGj6a+sO7pNZ
         ozQw==
X-Gm-Message-State: APjAAAU/uTEWbGDG2KS7/74a78z3seKk47eKSDAsOH39JCOOnccB4ePu
        98oJnqiLw0k3iGeiM+qXuWk=
X-Google-Smtp-Source: APXvYqyCTYR6RkaTQrJpMs5Kuhsa7hg7AiHmnc1dp8TrLfTa6zDhaT5O2wOXP1xYL9OAAScFzki70w==
X-Received: by 2002:a19:4901:: with SMTP id w1mr55338942lfa.168.1578274481881;
        Sun, 05 Jan 2020 17:34:41 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id h10sm28235739ljc.39.2020.01.05.17.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2020 17:34:41 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 01/20] dt-binding: usb: ci-hdrc-usb2: Document NVIDIA Tegra support
Date:   Mon,  6 Jan 2020 04:33:57 +0300
Message-Id: <20200106013416.9604-2-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200106013416.9604-1-digetx@gmail.com>
References: <20200106013416.9604-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVIDIA Tegra SoCs use ChipIdea silicon IP for the USB controllers.

Acked-by: Peter Chen <peter.chen@nxp.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
index cfc9f40ab641..51376cbe5f3d 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
@@ -15,6 +15,10 @@ Required properties:
 	"qcom,ci-hdrc"
 	"chipidea,usb2"
 	"xlnx,zynq-usb-2.20a"
+	"nvidia,tegra20-udc"
+	"nvidia,tegra30-udc"
+	"nvidia,tegra114-udc"
+	"nvidia,tegra124-udc"
 - reg: base address and length of the registers
 - interrupts: interrupt for the USB controller
 
-- 
2.24.0

