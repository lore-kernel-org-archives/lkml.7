Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3553C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB44721A49
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="il1oX2YP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfKLXK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:10:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39683 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfKLXKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:10:16 -0500
Received: by mail-pf1-f194.google.com with SMTP id x28so173450pfo.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 15:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZbIDTwp4tu6O0c9hAtlHVKFNN3DvpyKyTnrVQEjbRfE=;
        b=il1oX2YPsQrYMYIPzDIlTQIh1b0A2P3+Rmp3gsKmtutrIWhcWhHRaEQez9k38Ayfsx
         0gbgSYFgYoiEG2l/1WeVvkysdhKbYgNph0ZBrVPBLm8xqhuHZK/ZBOyaMP5lZ1+IzWCq
         KKTy9UiqaLlDIl2kVkhacl2qrBxf9XKs0PslM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZbIDTwp4tu6O0c9hAtlHVKFNN3DvpyKyTnrVQEjbRfE=;
        b=LroA049G/sxp6WqrjyEflDT9RwtjutD2rouv0uKe3DG+te2dw5EgdVQhGXhv3H297E
         dYhtuEoe2RqCbON92qTvDIxVwCw676Bq2Kbz0ugdBvS+nKxS5hXu6Ds/Dz4km0n58vMY
         tXnnvAwlvdenvF+j+M33xm+rrgL/ACH/IFW07I8FPQ4AQUMuJg7G/Wb7GpzMYfqx4YHR
         0X5jlhbNMv50hRrxvnUkqTTpjbdFXSteTst27GZw6Szi4iiO86dWKHf+VSOisDE77b6E
         cFJ+nvAmunxUb9NJFvUkTAGtMkEw3/VlSEk0LolIYQGq7Mk1aqsu13uaOJq3mwxeAXvk
         RMsQ==
X-Gm-Message-State: APjAAAXHjutMcTfShL1M5Sl20fyg+lg8mG1s7yAfWiQm2WeojTnE10GG
        VcCo071j/RLSPjiLQwdnOlrHAg==
X-Google-Smtp-Source: APXvYqzsH+SDlUbcUJurNNVAosVjMz2moIaL9KfA7litYXqwpXEsiF4OSGVI4gGDP/cK6fbe4dc6Rw==
X-Received: by 2002:a63:1e4e:: with SMTP id p14mr17554pgm.127.1573600215428;
        Tue, 12 Nov 2019 15:10:15 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id w27sm67694pgc.20.2019.11.12.15.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 15:10:14 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-bluetooth@vger.kernel.org, dianders@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v4 4/4] dt-bindings: net: broadcom-bluetooth: Add pcm config
Date:   Tue, 12 Nov 2019 15:09:44 -0800
Message-Id: <20191112230944.48716-5-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191112230944.48716-1-abhishekpandit@chromium.org>
References: <20191112230944.48716-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for pcm parameters.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

---

Changes in v4:
- Fix incorrect function name in hci_bcm

Changes in v3:
- Change disallow baudrate setting to return -EBUSY if called before
  ready. bcm_proto is no longer modified and is back to being const.
- Changed btbcm_set_pcm_params to btbcm_set_pcm_int_params
- Changed brcm,sco-routing to brcm,bt-sco-routing

Changes in v2:
- Use match data to disallow baudrate setting
- Parse pcm parameters by name instead of as a byte string
- Fix prefix for dt-bindings commit

 .../devicetree/bindings/net/broadcom-bluetooth.txt    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
index c749dc297624..42fb2fa8143d 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
@@ -29,6 +29,11 @@ Optional properties:
    - "lpo": external low power 32.768 kHz clock
  - vbat-supply: phandle to regulator supply for VBAT
  - vddio-supply: phandle to regulator supply for VDDIO
+ - brcm,bt-sco-routing: 0-3 (PCM, Transport, Codec, I2S)
+ - brcm,pcm-interface-rate: 0-4 (128KBps, 256KBps, 512KBps, 1024KBps, 2048KBps)
+ - brcm,pcm-frame-type: 0-1 (short, long)
+ - brcm,pcm-sync-mode: 0-1 (slave, master)
+ - brcm,pcm-clock-mode: 0-1 (slave, master)
 
 
 Example:
@@ -40,5 +45,11 @@ Example:
        bluetooth {
                compatible = "brcm,bcm43438-bt";
                max-speed = <921600>;
+
+               brcm,bt-sco-routing = [01];
+               brcm,pcm-interface-rate = [02];
+               brcm,pcm-frame-type = [00];
+               brcm,pcm-sync-mode = [01];
+               brcm,pcm-clock-mode = [01];
        };
 };
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

