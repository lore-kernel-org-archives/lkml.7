Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBE2C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F623206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PGy/fco8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387961AbfGaMkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:40:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35161 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbfGaMkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:40:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so59656689wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 05:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xe8le1rAv9c22BBejf6Z3Lo2hw7eI8a1UNBXoRk+Yi0=;
        b=PGy/fco8tRozJWdUNRKJw//67DCItYzo0GDNZdudkaCV2yG+Rw8+yQWdoVaNY8+QU1
         0PIu8KXUHfLeBH5NfYmCwWTM6C31+kCNYxGVCPPM9onPEivGwRibufEoEiWuzU6VzP3A
         HSuLJewrwWp80zR9pq8ZgR9bKGWUioXhe6VXJAKpQs8NdTGblynjD0TfTuInDyo+sGW3
         7AK5n+ERxPpoDG4qX+34eyJhW8D9VtTNK2RLoPFSPC8jgyEFujPJWFKIY4WQDN4qKdnK
         5q1gRL3RAcWJSYHpTM1uIaJMpbtnCsTMBed8DY7bH0v1LA4R8AQzIEeuEiJooDFHP/NA
         QRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xe8le1rAv9c22BBejf6Z3Lo2hw7eI8a1UNBXoRk+Yi0=;
        b=d71SkaV2LxG78VyBqeiEvQvyOluC6q66ypbYCbJUiADJrEnLSbBw1qdgo4vGMLwEFf
         H3PsN27bamqpmOmQ/JIiWURSPwDNoQifYk9TgeU0ojZNk7TilrQF4kbNbOqi5IRb3uma
         7yF9Kksn/wby3DJZtbfPPUs75kor4JKrnLdaG6ILdz6rQcc177vir/yqiqAodVMpugGq
         w3I49LUEV9KwH3noIRm7h7LuDafaXSNgmo76P1Yh/VWI/iUsZ0YC+2edeEUP3QTHn4hZ
         Uy6HYFBHK9NqrbNe+ediVj7UL5kqMMawYU1OajUgQw5RRQyOe66Ono2G/nHH5H5TPhin
         rmaQ==
X-Gm-Message-State: APjAAAUEbZKJoczqSXOdB35iAEK5IUhM67jdBiBIIWRBgG0id8zDyRtz
        YIwKcvp6CzJ1TehG6uZk7AnOag==
X-Google-Smtp-Source: APXvYqywTaw2xEUJ8dm/vPRRqzOvCCaKYRb7o4Drdbuga9kRSBPZbcQ8wxouvF1zlJTXZWYegGf9ww==
X-Received: by 2002:a1c:6a0e:: with SMTP id f14mr117570578wmc.154.1564576806140;
        Wed, 31 Jul 2019 05:40:06 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x185sm62504271wmg.46.2019.07.31.05.40.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 05:40:05 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com
Subject: [PATCH 3/6] dt-bindings: arm: amlogic: add bindings for the Amlogic G12B based A311D SoC
Date:   Wed, 31 Jul 2019 14:39:57 +0200
Message-Id: <20190731124000.22072-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731124000.22072-1-narmstrong@baylibre.com>
References: <20190731124000.22072-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a specific compatible for the Amlogic G12B bases A311D SoC used
in the Khadas VIM3.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 3c3bc806cd23..efa032d12402 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -135,6 +135,11 @@ properties:
               - amlogic,u200
           - const: amlogic,g12a
 
+      - description: Boards with the Amlogic Meson G12B A311D SoC
+        items:
+          - const: amlogic,a311d
+          - const: amlogic,g12b
+
       - description: Boards with the Amlogic Meson G12B S922X SoC
         items:
           - enum:
-- 
2.22.0

