Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9C0C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1163220861
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PdcwmOol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389019AbfFJJaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 05:30:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40166 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388830AbfFJJaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 05:30:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so8408433wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 02:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K7MVo1cgFDsjyODbl6UghYby+bBwKYEV5/hf6CSHL9M=;
        b=PdcwmOolU+DR3UXS67c/dbknAixfIB6BAAUZEspd9wDp8PMOhN39gnYC0eapuEOiC1
         aFG98jm7zoSkAheGUfj8EcPISGb+mi/wG6RQk+SMw7WADqYB13HMJ18QeIAAktbgeGKY
         G0s2b15j7vucUqYCFwqvwBK88rJSkCK/oHExtIKywFDOinv8BCE+RjqLnfu7IdWHEKWF
         Eoh8MnVEskZisOOjwYXr75rArB2ywhoIf2/5ynnb/iOXLbTy7tWn/MqO4qYo8tirFPUs
         7wGuB9K5as3QP4YfyMBKWclAM2+bOuZM+IVNvPi1yIRLw715NPKgMPm8DbCgPrsUlRCq
         1izA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K7MVo1cgFDsjyODbl6UghYby+bBwKYEV5/hf6CSHL9M=;
        b=rn4subVht55V4CwjtD+0uZY9a8Xj85O0xHS5GEygZD8T04WMNPUYCEamqkENSnH7pN
         MSoSUsmKniFPgryiXPdUuyh6JYvtZ6xazXIF3LO+tM5MJsjpvAWW2ZKfvgu5p6uKaCN/
         u00XBKiNd3lXiTu/xNrBGTh339MLUeYyfEhGPYK0/1/bpKH3nTjRTXDnsTlMpiCBkWLP
         b8TXWels9jKioxmtOWpzQTpIqAQ44dld8xu4AV9cnILfnY1imccNTLL7gVZCHCnkH4H1
         pVy8EWWXEiWmflQrvdFG5Dq12FQw5T4ZX3fcxwzkH9rSGhxU/gQz1pacjoPjy4XirLC8
         jwCA==
X-Gm-Message-State: APjAAAV7tL2QLVwy70JHcw4IRBna8a63Ej9ZYjHzjO3UAcVtWrrL4Ykx
        9obFUdF+rjIL6UhFAIbsDVgfpQ==
X-Google-Smtp-Source: APXvYqzr69NtjqIVYizI4AHwsA7Ue7AMQESfDQNRiKtZik8+bmA2WO5jYTbbg/jFlShRf2phVGMaOQ==
X-Received: by 2002:a05:6000:1289:: with SMTP id f9mr5928481wrx.125.1560159033542;
        Mon, 10 Jun 2019 02:30:33 -0700 (PDT)
Received: from pop-os.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j123sm11881943wmb.32.2019.06.10.02.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 02:30:33 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v3 2/3] dt-bindings: iio: position: Add docs pat9125
Date:   Mon, 10 Jun 2019 11:29:44 +0200
Message-Id: <20190610092945.6330-3-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610092945.6330-1-amergnat@baylibre.com>
References: <20190610092945.6330-1-amergnat@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the optical tracker PAT9125 and
"position" directory for chip which can provides position data.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../bindings/iio/position/pat9125.txt          | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/position/pat9125.txt

diff --git a/Documentation/devicetree/bindings/iio/position/pat9125.txt b/Documentation/devicetree/bindings/iio/position/pat9125.txt
new file mode 100644
index 000000000000..4028aeef9b42
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/position/pat9125.txt
@@ -0,0 +1,18 @@
+PixArt Imaging PAT9125 Optical Tracking Miniature Chip device driver
+
+Required properties:
+	- compatible: must be "pixart,pat9125"
+	- reg: i2c address where to find the device
+	- interrupts: the sole interrupt generated by the device
+
+	Refer to interrupt-controller/interrupts.txt for generic
+	interrupt client node bindings.
+
+Example:
+
+pat9125@75 {
+	compatible = "pixart,pat9125";
+	reg = <0x75>;
+	interrupt-parent = <&gpio3>;
+	interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
+};
-- 
2.17.1

