Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E636BC5DF60
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CEE21A4A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 00:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jfzwzkAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387492AbfKFAaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 19:30:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43835 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730636AbfKFAaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 19:30:13 -0500
Received: by mail-pf1-f196.google.com with SMTP id 3so17406963pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 16:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wC1fV3XmJiisvf6Wmub25EKlo5Tq9rK55tShjUn1JT0=;
        b=jfzwzkArakv+2H4BiI7PnShrmXYvKyjGhz5dkAGMEfFJ0oHIdHV+dH9FeVwkQZ/N3e
         IjSijEYi3wNSpL6nPpXlTgw3sUkN5qGSgM14CN6r6afhxVqPjhZE+ztJb7XGJSXpzzHE
         YLxvo2fiKlwZHtPwoxvq6eiNnYKj2pOSN6OrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wC1fV3XmJiisvf6Wmub25EKlo5Tq9rK55tShjUn1JT0=;
        b=qTdQDZdbL6CZaRkHi7jcBc98tlq166uTTtclDYkXRdM9V2rkBlj29zTLBjbBPAttpE
         VrRlLaEpTGrBWqF0wD1pv3z7LrpLB9RaXhmwn3L3cVZG+yBCXGe1upy0AbcTfhQxJAoc
         jnNkK/WhHJfUCoyNBmcwdaOmyrJKIosgfAMdWTw0CUUm89lkzT42coe5F852M/BX0A0P
         8oauEvV+FJa5uKsR0/uT5qXdiAI21+rlLVwTKeFkSkGL+FcwL7pdvUmjJdTOj+nkfJDZ
         waAJYAAUvfhHf1KP+QEg5kaVkCifbz+KhAi1qoNooouiM+weGoIVV9BVoOZuBOwrGgMJ
         CjyA==
X-Gm-Message-State: APjAAAX3st9/q/Xvcc7Yx4G92ls0rQl1X+aW2QbfmWGjuXwXt2Vs334c
        7PN64ajwXVAfeI5CaWlTRxjHPQ==
X-Google-Smtp-Source: APXvYqx47hh5YbDuUa3YWMzpsYd8LTO0GxdEdRVR/2Z/sRZoF/LYzFRNgsN5YHICZtVdUUY1kfyW0w==
X-Received: by 2002:a17:90a:989:: with SMTP id 9mr13112pjo.35.1573000210856;
        Tue, 05 Nov 2019 16:30:10 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id k9sm21032835pfk.72.2019.11.05.16.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 16:30:10 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 4/4] dt-bindings: net: bluetooth: update broadcom-bluetooth
Date:   Tue,  5 Nov 2019 16:29:23 -0800
Message-Id: <20191106002923.109344-5-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191106002923.109344-1-abhishekpandit@chromium.org>
References: <20191106002923.109344-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for pcm-parameters.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

---

 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index c749dc297624..ae60277b5569 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -29,6 +29,9 @@ Optional properties:
    - "lpo": external low power 32.768 kHz clock
  - vbat-supply: phandle to regulator supply for VBAT
  - vddio-supply: phandle to regulator supply for VDDIO
+ - pcm-parameters: When set, will configure PCM parameters on the device. The
+   contents should be a 10-byte array corresponding to the pcm params (see
+   btbcm.h for more information).
 
 
 Example:
@@ -40,5 +43,6 @@ Example:
        bluetooth {
                compatible = "brcm,bcm43438-bt";
                max-speed = <921600>;
+               pcm-parameters = [1 2 0 1 1 0 0 0 0 0];
        };
 };
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

