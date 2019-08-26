Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB47DC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0612184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lu16lKE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731929AbfHZUpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:45:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55806 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbfHZUpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:45:14 -0400
Received: by mail-wm1-f66.google.com with SMTP id f72so785981wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9a/nmo4HleHfZCRi8ScPQm/5Ra82K05ffJZThzk2QTs=;
        b=lu16lKE1wbTcy6ZNuBOuRforM5MbT2Ne+jnJr2rCMLswpVp64GS5nb7iwRBo7I8c6M
         rX+O3u3ymVJkV9apnlC3ZI/cMWFyT9Rz7DEJJG9EzUyal8EppWDAr9sK1sD6wwDVhlVj
         XaOL2s+XnmCRx9ULx5G322klxXolV0bnJUOnMAiUtjUy3AqXOgljde2E0gh2eA03YngG
         bGxbow8Yj1Fx8zoJ7LmY5tiObI3fpgUivUiGxLdUwIsDRl3Z7Qe/n9UXvVb0NpY/ojOu
         +17bew2ZTM3RKOe1K6F5rfbLo4EACqJQM1I4MUBka47TkaOtmvHoHASXAjISRmbbwCmV
         7nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9a/nmo4HleHfZCRi8ScPQm/5Ra82K05ffJZThzk2QTs=;
        b=QdGzY/m372TQDO7zPmfio8cK7fPfER0qWjXXvM8lUFwXZKxLqQJ5DOQMkqyNcZ5t6/
         GDOHHFVFWk2cawX6PEZWikxzDbb77UdTPBuzlgqg/hye/Ut319sYxwUOZUYMhBrcVs3n
         bDx7Ord+ZzzGRsSdk5Mfjm5SsaQvI/JSeNgML9x/RFpSyOgvB+XMnczkI5JhJw84mwzA
         mQltlvpc6hlX03oLXP4vTdh47dqPcdWMFLO4Nl2qa8OWb6rc2NNnepVuaMCIDDsc/ttK
         M8rzcxWHhnFvm+uNiFOoVUUmIY5jRCTDkVWrRne2JpTRP98LWzm+OjIwwgeAk7jVxxOV
         QmLw==
X-Gm-Message-State: APjAAAUsFqkMitulOfpYLxT6DV4wQ17WOPI93+u0DWVNgb8/oXs0jDcm
        0iYO/Ys57/jUZtJ+q98NSNsR7kG4aRU=
X-Google-Smtp-Source: APXvYqx3Dz9/5ZvakUdr4CZeHz/47q/CU+TUCt1PKvnuarTxbBhLbHMD+LdPq1NbxDU77er27jsg1w==
X-Received: by 2002:a7b:cd17:: with SMTP id f23mr24509458wmj.177.1566852312285;
        Mon, 26 Aug 2019 13:45:12 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab])
        by smtp.gmail.com with ESMTPSA id 20sm549557wmk.34.2019.08.26.13.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:45:11 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Magnus Damm <damm+renesas@opensource.se>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 14/20] dt-bindings: timer: renesas, cmt: Add CMT0234 to sh73a0 and r8a7740
Date:   Mon, 26 Aug 2019 22:44:01 +0200
Message-Id: <20190826204407.17759-14-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826204407.17759-1-daniel.lezcano@linaro.org>
References: <df27caba-d9f8-e64d-0563-609f8785ecb3@linaro.org>
 <20190826204407.17759-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Document the on-chip CMT devices included in r8a7740 and sh73a0.

Included in this patch is DT binding documentation for 32-bit CMTs
CMT0, CMT2, CMT3 and CMT4. They all contain a single channel and are
quite similar however some minor differences still exist:
 - "Counter input clock" (clock input and on-device divider)
    One example is that RCLK 1/1 is supported by CMT2, CMT3 and CMT4.
 - "Wakeup request" (supported by CMT0 and CMT2)

Because of this one unique compat string per CMT device is selected.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index c5220bcd852b..45840d475050 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -22,6 +22,10 @@ Required Properties:
 
     - "renesas,r8a73a4-cmt0" for the 32-bit CMT0 device included in r8a73a4.
     - "renesas,r8a73a4-cmt1" for the 48-bit CMT1 device included in r8a73a4.
+    - "renesas,r8a7740-cmt0" for the 32-bit CMT0 device included in r8a7740.
+    - "renesas,r8a7740-cmt2" for the 32-bit CMT2 device included in r8a7740.
+    - "renesas,r8a7740-cmt3" for the 32-bit CMT3 device included in r8a7740.
+    - "renesas,r8a7740-cmt4" for the 32-bit CMT4 device included in r8a7740.
     - "renesas,r8a7743-cmt0" for the 32-bit CMT0 device included in r8a7743.
     - "renesas,r8a7743-cmt1" for the 48-bit CMT1 device included in r8a7743.
     - "renesas,r8a7744-cmt0" for the 32-bit CMT0 device included in r8a7744.
@@ -54,6 +58,10 @@ Required Properties:
     - "renesas,r8a77980-cmt1" for the 48-bit CMT1 device included in r8a77980.
     - "renesas,r8a77990-cmt0" for the 32-bit CMT0 device included in r8a77990.
     - "renesas,r8a77990-cmt1" for the 48-bit CMT1 device included in r8a77990.
+    - "renesas,sh73a0-cmt0" for the 32-bit CMT0 device included in sh73a0.
+    - "renesas,sh73a0-cmt2" for the 32-bit CMT2 device included in sh73a0.
+    - "renesas,sh73a0-cmt3" for the 32-bit CMT3 device included in sh73a0.
+    - "renesas,sh73a0-cmt4" for the 32-bit CMT4 device included in sh73a0.
 
     - "renesas,rcar-gen2-cmt0" for 32-bit CMT0 devices included in R-Car Gen2
 		and RZ/G1.
-- 
2.17.1

