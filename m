Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309D1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F102A218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bUn2PwUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfCUIV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:21:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35076 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbfCUIV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:21:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so3731358pgf.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 01:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6aoqLYQZIT86Ut1f16fYi5QgoUZkcEWYGhmNaJd7vFc=;
        b=bUn2PwUhGhtRsvxfvBhnRmxvWHNn+TEEOcyTTd98twmTXS08GHaL3kLBCO1HuLJ9ZN
         kLrq73FA30qGy93HxrPEWPjFyE/zJNXYab9hvg50NfDT2A9hGercLlksLmDLss/2QWK0
         +bHoADzzOiKVmyvfVdS/qs6AhOgVRK0juJZ68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6aoqLYQZIT86Ut1f16fYi5QgoUZkcEWYGhmNaJd7vFc=;
        b=ui+rQquqXv/lG2kYBU84ha3uxcuVBFvWKHYkSFktmfcJkC6w2hlmMm94ux7qWUGofs
         kJEmUkGo1lH1DefV2WbmN/7mioryyRUgsqE9ty20RozszcynrD7RoLLPERNvOd8erJzT
         dUcd7618bXehWj9JLwGaeM/WWxnl2l8lRzeehXi6qWlhTxx0uhA4LdSP83im6AV+gAiv
         V2l3YSJ04pdutj47F01oGrVeN2xit0gjZ7b1ok7BUx51uUsSrf0O5pIFwhHQZ/p0J6de
         X5K3+7IVJ+PbWW11b0okaaGr5Vid+gCTAAEg/RQwqKubdrhhUngI7swKKj49QNhW0wfH
         80pg==
X-Gm-Message-State: APjAAAVcYMVLW/RzQRUW5eEF3aCc2ZuPRhBnah4LeeQVcOo8DRSP/4ol
        XY2QKMqjpLHojq3bb2Sb9/dYAE0QTac=
X-Google-Smtp-Source: APXvYqymoM32RrBaGjgzQUiIP4RtxwvVP/neCuILi0DhT4kmeyYgQamdl1OlR8q6Ahy0c3Re5eLILQ==
X-Received: by 2002:a62:e502:: with SMTP id n2mr2146664pff.242.1553156488261;
        Thu, 21 Mar 2019 01:21:28 -0700 (PDT)
Received: from localhost.localdomain ([49.206.202.234])
        by smtp.gmail.com with ESMTPSA id b138sm6288681pfb.48.2019.03.21.01.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 01:21:27 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v7 3/4] dt-bindings: input: touchscreen: goodix: Add GT5663 compatible
Date:   Thu, 21 Mar 2019 13:51:03 +0530
Message-Id: <20190321082104.2874-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190321082104.2874-1-jagan@amarulasolutions.com>
References: <20190321082104.2874-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GT5663 is capacitive touch controller with customized smart
wakeup gestures, it support chipdata which is similar to
existing GT1151 and require AVDD28 supply for some boards.

Document the compatible for the same.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
index 255673250bbd..fc03ea4cf5ab 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
@@ -3,6 +3,7 @@ Device tree bindings for Goodix GT9xx series touchscreen controller
 Required properties:
 
  - compatible		: Should be "goodix,gt1151"
+				 or "goodix,gt5663"
 				 or "goodix,gt5688"
 				 or "goodix,gt911"
 				 or "goodix,gt9110"
-- 
2.18.0.321.gffc6fa0e3

