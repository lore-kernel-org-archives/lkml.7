Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB3DC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3F920836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 15:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="X8jT4uZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfLJPmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 10:42:23 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36003 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfLJPmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:42:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id p17so3721077wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 07:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ES7zD3uxlvMthMTJeBASrOUMdYjQARPGfunzD6tXJe0=;
        b=X8jT4uZR6MmsuKUFlUo+O7GD+IvoNdjgsBhv+m2LFeSvD/6qVwx9LA/tt83TuoGTIW
         TVaZUhpvng9Z/VHVXJO4Lclf7r2kgZFqJE+FJhIV4jftaWqAzdcxyNpgtw+RS7Ohs5TN
         t4183tREGV5PYcRta6UPO37g8lDJWWbsB/PZcYcMAnImpnGcTDP8FTSDCJuVQcYej736
         8QORMjuqdmx3SrpGWbtE+m4x2vNIyUT+CC0btkuZFdB/0j2r9QxNFE7++GYuW18027YU
         vWEX8iasdwWMxU+XAJm8nzETjvHjgp7oUG5OWkMMjC5ivI7DUftea84sTh0Sk1P5QMS7
         YRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ES7zD3uxlvMthMTJeBASrOUMdYjQARPGfunzD6tXJe0=;
        b=hNJGdVWzN2foEfd69PgJWXpX/zEuGM4aTZy9YqEebgC9gWiW5kbQDYzD+HOFVKvf+K
         cFGOc5psZFCTzKEVg9k8EzMwxZb09meMH5AK3Gp/q8C27fyKi7e6wEAVgRV05EqCxB4F
         ORxGGJ0A5bjnAlrIP8KGed+jWt4aaN6ZD1HTFKOF52MWZsQPBd4zs+fVkBbeTMG8KqQ2
         bPZtMKIBqG1nLGH33oj9okGxm7adzzWZfvay0fjCOsIjX54Uhsy83o5KVHVyKdczQNsW
         O2Y50dCVuV+bZCpDeRGpOVUQWwhWFtHxlgO413Mepydl1bwWpq+u6LfMar23tD24+ebO
         /cvw==
X-Gm-Message-State: APjAAAWuXzWd4ivleypQlA8LwnuVnwGkeD5l8BzfegxfSzWNNPo9ojpb
        R+/ze87XailUqQvCP+dmBynkzg==
X-Google-Smtp-Source: APXvYqxBTD7o5rvQZLec1VR+5T1kdaqLV9SOyPbERAX/fk12Q7zu8qsu+W3shzPDVpllGWyq17o63w==
X-Received: by 2002:a1c:8095:: with SMTP id b143mr6047465wmd.7.1575992538051;
        Tue, 10 Dec 2019 07:42:18 -0800 (PST)
Received: from khouloud-ThinkPad-T470p.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o7sm3469085wmc.41.2019.12.10.07.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 07:42:17 -0800 (PST)
From:   Khouloud Touil <ktouil@baylibre.com>
To:     bgolaszewski@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, srinivas.kandagatla@linaro.org,
        baylibre-upstreaming@groups.io
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-i2c@vger.kernel.org, linus.walleij@linaro.org,
        Khouloud Touil <ktouil@baylibre.com>
Subject: [PATCH v2 3/4] dt-bindings: at24: remove the optional property write-protect-gpios
Date:   Tue, 10 Dec 2019 16:41:56 +0100
Message-Id: <20191210154157.21930-4-ktouil@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210154157.21930-1-ktouil@baylibre.com>
References: <20191210154157.21930-1-ktouil@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVMEM framework is an interface for the at24 EEPROMs as well as for
other drivers, instead of passing the wp-gpios over the different
drivers each time, it would be better to pass it over the NVMEM
subsystem once and for all.

Removing the optional property form the device tree binding document.

Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
---
 Documentation/devicetree/bindings/eeprom/at24.yaml | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
index e8778560d966..75de83708146 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.yaml
+++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
@@ -145,10 +145,7 @@ properties:
       over reads to the next slave address. Please consult the manual of
       your device.
 
-  wp-gpios:
-    description:
-      GPIO to which the write-protect pin of the chip is connected.
-    maxItems: 1
+  wp-gpios: true
 
   address-width:
     allOf:
@@ -181,7 +178,6 @@ examples:
           compatible = "microchip,24c32", "atmel,24c32";
           reg = <0x52>;
           pagesize = <32>;
-          wp-gpios = <&gpio1 3 0>;
           num-addresses = <8>;
       };
     };
-- 
2.17.1

