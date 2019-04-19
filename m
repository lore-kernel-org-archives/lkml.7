Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDA5C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D5120449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QfQHEsBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbfDSTtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:49:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37357 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfDSTtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:49:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id v14so7379584wmf.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R+rJiqbMseAY0oDXLdqiRPHEvayMMhzkPPex8gF7dgU=;
        b=QfQHEsBYJGmCfbvCkQEdvF68c++DOn6w/o7o8GEiyXAig9Z+9m7DaMhcsQKntFtYnB
         1+dBWaFYLD0GEfWl3RCAhiTptjg6gq0YiusIgprGi0HFOx2851ocy0FX3xae7WuqS/ed
         89IgUPQtsujhvnlMzV/nwNJcdUnDyQ7uXy6pnZw51MxGTen/iof4K2N3blkitkAeyZoE
         9khDqmN2DOxwZrKpMp8Dg5hq37d3r5eoE8OIubk85T/ngEImrFPy/BpUT948YmZNhfZ9
         946tDcmUur+xy03c6QDgSIFTZp8g/+uJT1C3C56JdVClCR22iQH1AkRvuGjs+NG/F4AS
         DbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R+rJiqbMseAY0oDXLdqiRPHEvayMMhzkPPex8gF7dgU=;
        b=KixPUZ2dkCK/Np4q7cg3uAjMYg7cY+iDo5XVRhJo8kpYmHzsa/7D8zw5hIBcHZOQKJ
         qbQTY/aUjayKWHyNj5USBAGxyjXpygq1GhTkcunQNw2YubPt+wyHh82OG0fg/R3XsH1I
         N9gHEgmWseNN/2JV7UNXAT4drSU3rt7Fm/fzgcTbHFILXjlN1I1snLI84EHJBbWP/KPS
         0IvIHccMJbADht75Cuz8nxAYun5VvyB0/yXYRrV3b+pu3b91cflNi0kCyTPNexX/ztzn
         6h8421Hf5tsK1LLvPAwgr1QY0lGQTnBEb7evlhuoP/L30QH7KUp7f7QiHiYTjTILIKb6
         Ir1Q==
X-Gm-Message-State: APjAAAU5mvaIn4oMeqo9WyNnqg6PO//PF178r3X48EnJiU+00NccG7Fb
        v/beqKfn/yxzJvqEjF3fHjlZjERosf4=
X-Google-Smtp-Source: APXvYqycZRtZ6ywKlVhqIl1XavT+h5aoAdbNM/r1Isv8aFT4FLSgI+SBf0CB7Z37wYaGSWHsx0OiDw==
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr1774612wmj.113.1555662905852;
        Fri, 19 Apr 2019 01:35:05 -0700 (PDT)
Received: from localhost.localdomain (cpc89244-aztw30-2-0-cust4998.18-1.cable.virginm.net. [86.31.179.135])
        by smtp.gmail.com with ESMTPSA id t76sm5700147wmt.8.2019.04.19.01.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Apr 2019 01:35:05 -0700 (PDT)
From:   Peter Griffin <peter.griffin@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, p.zabel@pengutronix.de,
        xuwei5@hisilicon.com, mturquette@baylibre.com, sboyd@kernel.org,
        yuq825@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, lima@lists.freedesktop.org
Subject: [PATCH v2 2/6] dt-bindings: reset: hisilicon: Update compatible documentation
Date:   Fri, 19 Apr 2019 09:32:57 +0100
Message-Id: <1555662781-22570-3-git-send-email-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555662781-22570-1-git-send-email-peter.griffin@linaro.org>
References: <1555662781-22570-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reset driver now supports the ao reset controller, so update the
documentation to match.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/reset/hisilicon,hi6220-reset.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi6220-reset.txt b/Documentation/devicetree/bindings/reset/hisilicon,hi6220-reset.txt
index c25da39..ea0a6a9 100644
--- a/Documentation/devicetree/bindings/reset/hisilicon,hi6220-reset.txt
+++ b/Documentation/devicetree/bindings/reset/hisilicon,hi6220-reset.txt
@@ -11,6 +11,7 @@ Required properties:
 - compatible: should be one of the following:
   - "hisilicon,hi6220-sysctrl", "syscon" : For peripheral reset controller.
   - "hisilicon,hi6220-mediactrl", "syscon" : For media reset controller.
+  - "hisilicon,hi6220-aoctrl", "syscon" : For ao reset controller.
 - reg: should be register base and length as documented in the
   datasheet
 - #reset-cells: 1, see below
-- 
2.7.4

