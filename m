Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C42CC17449
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33861222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LsEHNxuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfKLAUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 19:20:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36953 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfKLAUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 19:20:08 -0500
Received: by mail-pg1-f196.google.com with SMTP id z24so10592285pgu.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 16:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3QVtv45Axk545voSCTdnsYQERVAGrIgwCeqw/o3MX4=;
        b=LsEHNxuNOsi4smeIUmloCDxQwN5wRT573S/dAcRBGQmdn1PyWUEE9OCntdlNebllY0
         tqwl/eRcJss7RnMsihQjohvTPAUWT6tFej9W29LueU8pO2WEFNtm6j4GfDXuGHLZstU8
         wgYDR0ZZNkcghB2cgaOOxCjkKmEDYo8vR2E8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3QVtv45Axk545voSCTdnsYQERVAGrIgwCeqw/o3MX4=;
        b=O7ykHQQDIhMzkE+DzaGtXrXmNPgsuQ0y9hxz4MUG6i7RXsogW2xmy4srQREZqo24Nk
         013uhPVDpbdbP8lb4AU5CedXjvTzWBzHKClYuHvrBjRHEeftGGxL/Vh7ozZnnU3G6DQx
         OE9F3l+I+R63+kMsb5pN3jBT16+FbP9WrhhtIFSBUuqwYcnjKgQFiTCoIDXDjdWqmXGx
         7BgYzNZ2KdkehojZi8n3S+SA8L08Vjoqnym2gtQBzP8ydcenKreNGOkVVa56Ydkefk0P
         YZbx6OVv7YaBoTT5Les4Wz+DwN+n741Fu6XkMvqUecwod7WiRjAKx9q8s5lXVLL4tKRp
         i2eg==
X-Gm-Message-State: APjAAAUz7v+vGeRBnqtapTvyQ9TjC1nFT76SSh98mzvrGXMutM6gnCWv
        tU4dQscEYCHlLxXKrnlbW+1LyA==
X-Google-Smtp-Source: APXvYqxzTENXdlmig2BxhIs7QT2d4w+X0eoLnSbb7/QBWfE3yeHGYTXXdZ2kzCALg0JoqA1Yj05w6Q==
X-Received: by 2002:aa7:9e52:: with SMTP id z18mr32297912pfq.149.1573518007037;
        Mon, 11 Nov 2019 16:20:07 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id h23sm8430898pgg.58.2019.11.11.16.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 16:20:06 -0800 (PST)
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
Subject: [PATCH v3 4/4] dt-bindings: net: broadcom-bluetooth: Add pcm config
Date:   Mon, 11 Nov 2019 16:19:49 -0800
Message-Id: <20191112001949.136377-5-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
In-Reply-To: <20191112001949.136377-1-abhishekpandit@chromium.org>
References: <20191112001949.136377-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for pcm parameters.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

---

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

