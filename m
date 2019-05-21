Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201FFC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07C7217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="m4gDvS+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbfEUPUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:20:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35723 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728754AbfEUPT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:19:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id q15so3326152wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 08:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2UEmu+PQTJMEzkzxShtce1PUS0kwGjqD32xVaKXEq8k=;
        b=m4gDvS+OKNfl4tPhdhYIPSGwDI5QUMCD0qa2ChEKnlS1dVhLQFGx+t+skeULPeKIKK
         va6KX7ohP5NII4ATmVhU8vtjZUELDtjDNotPuBJ3nHzves6U656GVJdsKOkZd0eHJorR
         Jj/RLpv3ksfacmK2rjHOhbG4J/ioBy0yNuvKQh8d0JZQGO6D2cRj7SMUmGfa4AnOHEAf
         swr/rdaEmrXl6s+NHLTg1RMS48bUJOD8eSBGFyQ/gAuF08dEdG9ns6/8nsTW/BH3GFq3
         Bqs9KuArvqeZRBuCVhg9axNdwF6RNS94r1Mz1Ha2E+EJl5HqB+a/ovi7zDRdOTsma/Pe
         EkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2UEmu+PQTJMEzkzxShtce1PUS0kwGjqD32xVaKXEq8k=;
        b=KR3Aq4HWiei/wm1QHBC1O99cQnhM3phh8/ILH14u2Dft2kxSzAt0f3NqYQWaKTBwmh
         +bXLGqrZbid8Gysoay8bIfh627Z0+L6O8qaEovbY9+ZXLLHwQPyCQOvhEI/DtymgOgNc
         w+hYv23Ii2MNZxlTtCESTAELIj9Tg77nx2iwH2oSgfAJwtCRElTstpNUu5xMbqeTTxvX
         zV+mMpXoy3cSxgUYBzmfeTL7O45UT8FvSL0ZXAUvIl9XzYu+BWzUlEYbLwQb3il7DzyF
         taetSL3I6oEmZNRLBBTzXcWY9/3hbt2PQ6O+EJIPh9VVllAUOj6mNzxcDrq4cRhFvhX3
         Oh2g==
X-Gm-Message-State: APjAAAXrpjzS0CMvww6YTnGrq1tIPdBIPKTI7ImCtRv2zdHkRVVKkXJn
        ptsjZ2297zceLNUvxv2TPMy9YA==
X-Google-Smtp-Source: APXvYqwk2IBY1kdDxl8FarpdDrMnx6sRXqje8GLIZs5Bg3e9TU58EJrEreRIcvDw7cnoTqyedCYF8A==
X-Received: by 2002:a1c:ba87:: with SMTP id k129mr3900600wmf.132.1558451996629;
        Tue, 21 May 2019 08:19:56 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p17sm3945677wrq.95.2019.05.21.08.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 08:19:55 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 2/3] dt-bindings: arm: amlogic: add Odroid-N2 binding
Date:   Tue, 21 May 2019 17:19:51 +0200
Message-Id: <20190521151952.2779-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521151952.2779-1-narmstrong@baylibre.com>
References: <20190521151952.2779-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the Amlogic G12B (S922X) SoC based Odroid-N2 SBC
from HardKernel.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Rob, Martin,

I converted the patch you acked in yaml, I kept the Reviewed-by,
is it ok for you ?

Neil
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 28115dd49f96..f75df4471c0a 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -139,6 +139,8 @@ properties:
 
       - description: Boards with the Amlogic Meson G12B S922X SoC
         items:
+          - enum:
+              - hardkernel,odroid-n2
           - const: amlogic,g12b
 
 ...
-- 
2.21.0

