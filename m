Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39827C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6F022CF6
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+8970Ob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbfHSXsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:48:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33698 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbfHSXsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:48:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so2148246pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lQDNdRIDsrfByKdWclsgiLu5o6EPo6fOoPt7hg1xhn8=;
        b=j+8970ObdyCKHy/+UoDrc+05m+hWvJNJG2qzOu88xTMa17yHAD64/pAdmkJoG3rUlq
         lh/kv8j6ql1G22DuIZWnIM2eEWBn9VNfepRJOjanpvwSXTEOCn68OaF/2zRyN+vXR/9i
         HHCy05NmdvzHJGDjT8nincGyBmkNrLgCWhAd4Jmf9Erzong/0UMNYo6utGEeFpk8cYJq
         uNIoijtzeu9wivPWDLWS86e0eYb64Af+T7A4ri/rxlXge0LO+FMZ5NmppKrv//vGeyeX
         J5Yn2OQdoscv+nvZX7oi7zZ1/VQVX9QC/Eh0qSY3nx7vbYritd+hiTXsqqktqOD8TtCH
         sMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lQDNdRIDsrfByKdWclsgiLu5o6EPo6fOoPt7hg1xhn8=;
        b=mHZuR6X8pLnOL3ZyK4Pq/HC9OkfcnJSpbVyEtxUCQyRLPtMrIY/NukVdUDgdN2kH9f
         srUL/I1DCZSLFG4C+MdTAe/XXvs0vJfWby/gmdD3DC5jBcHKmqgsb4L41tjgzi4ApImb
         sx0kaHvnq8/icMMS9kwL+n4Pwm4G+hZkcgK/+YlWz+cYiYfrfgzvNMXShdff2uU/L9rE
         OyzDmGGOPFD0wJYufAGoJkjPBn9C6SzQh4U17bPzlKGx5VeKWFIUmJX3HoLlOKiiM8++
         I5hXXg4tGZAoo051TBRS7GCl0Ui82XuDOQavJlf4uMNY7hiZF/OlKHWkbkdqIwpuLVZU
         VoOA==
X-Gm-Message-State: APjAAAWEVb3ROHI5K52dse3yClBev1SiEkF/6aay5EQukk5a3tduoxxJ
        H4/1ROzM33DTdqt3sQNO4OuaB7BHd4M=
X-Google-Smtp-Source: APXvYqyG2bGpvXD+cv5Riz6fGjbJ4+cU+bFTeZSKQxqoj5uquFux67PipWDb9QA2yJsp6eP5B6hVMg==
X-Received: by 2002:a63:f907:: with SMTP id h7mr16006795pgi.418.1566258529203;
        Mon, 19 Aug 2019 16:48:49 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id 185sm18769681pfa.170.2019.08.19.16.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:48:48 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Griffin <peter.griffin@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 2/3] dt-bindings: reset: hisilicon: Update compatible documentation
Date:   Mon, 19 Aug 2019 23:48:39 +0000
Message-Id: <20190819234840.37786-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819234840.37786-1-john.stultz@linaro.org>
References: <20190819234840.37786-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Griffin <peter.griffin@linaro.org>

The reset driver now supports the ao reset controller, so update the
documentation to match.

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../devicetree/bindings/reset/hisilicon,hi6220-reset.txt         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi6220-reset.txt b/Documentation/devicetree/bindings/reset/hisilicon,hi6220-reset.txt
index c25da39df707..ea0a6a9734c1 100644
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
2.17.1

