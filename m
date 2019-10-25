Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9976ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DA521D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 21:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mVoUJAap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfJYVz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 17:55:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36926 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfJYVzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 17:55:25 -0400
Received: by mail-pl1-f195.google.com with SMTP id p13so1984985pll.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 14:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7uKa34kYvsX7BroFGlpYBz0Sd8dZ85UkHcONCBB1nmI=;
        b=mVoUJAapx+uOBznFP8kPMazgbHKDh/1nmbF+I3B+I6pGY1Bc0SXxsWWOwS6ZqaoJ8s
         MZwQqVJx/GAL3Dx9IjsemZnfdzeglMPrWkMYkWqz0w97Ar+Oo94dGyVVXX910/Ivgo/8
         UOyu6jroYVgGEnJcyAEBMuAzV/hMF9wsf+NvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7uKa34kYvsX7BroFGlpYBz0Sd8dZ85UkHcONCBB1nmI=;
        b=S6ob0+elpbG3+AohUrNxPV9T15DcG5kKTW0WDhM5igBmjrfM6iq7ir0ZP0Zqlz+5VL
         k2iUVQUZySPCE5d1RLbHjWQpBeTFuNmSxJHMAMrigCm5WJyQHbTcZFWDIUVvWWeyv+O0
         RmVgJT7xShyk5pjMvCFz6AXlCo8pW8dNv/aFVNoIxrInJLRSlXZC/UNkhRjYvlbQ/07i
         xkDKO9GWTpzQ0rzr0VDhiGJPE97qVlcwbKOJ5SXvGkxxkECJzjAUHg9mQ2u9iDybPJw2
         SVztoWAd+H5xEyZ9MW0md8o3346hvi4j4vFKPxQw6INd5OYG0VOXLrSg6+HhsaQm1eb2
         ldYQ==
X-Gm-Message-State: APjAAAXIcJuAj/DBtiwTUGf/foVVpQeEPe3gf9znl4i9aDY34eLv8T5T
        BfHgcPSm7wYess8aAlE+bIrCt/++o8A=
X-Google-Smtp-Source: APXvYqz/ooBuyGY1IHf6DZksSTGAVttn8pjAAVhvqvN5QaSKbLw1d5alO5D0UMlMwup7Kjy2l0zWiw==
X-Received: by 2002:a17:902:b687:: with SMTP id c7mr6367753pls.214.1572040525016;
        Fri, 25 Oct 2019 14:55:25 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id y80sm3815110pfc.30.2019.10.25.14.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 14:55:24 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH 2/3] dt-bindings: net: broadcom-bluetooth: Add BCM43540 compatible string
Date:   Fri, 25 Oct 2019 14:54:27 -0700
Message-Id: <20191025215428.31607-3-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
In-Reply-To: <20191025215428.31607-1-abhishekpandit@chromium.org>
References: <20191025215428.31607-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM43540 is a 802.11 a/b/g/n/ac WiFi + Bluetooth 4.1 chip from
Broadcom. This is present in Azurewave AW-CM195NF WiFi+BT module.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index 4fa00e2eafcf..c749dc297624 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -14,6 +14,7 @@ Required properties:
    * "brcm,bcm4330-bt"
    * "brcm,bcm43438-bt"
    * "brcm,bcm4345c5"
+   * "brcm,bcm43540-bt"
 
 Optional properties:
 
-- 
2.24.0.rc0.303.g954a862665-goog

