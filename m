Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFF5C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC7C2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 18:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0ukqF3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfCJSaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 14:30:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40743 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfCJS3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 14:29:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id t6so2661944wrw.7;
        Sun, 10 Mar 2019 11:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZJP0uSysrKqxMdkD0rooOPSq232fgyZKPEkO+ikkTC4=;
        b=L0ukqF3ECEMRyx8eAJNrP5m22TA2MYGkAYBIYwClYLWKvAFlSHKCIU68+xskLyGxqv
         GKrTd2CXIXYZwKPiZqpoQzGXMnsmZWtcywkE81DEuZL2T8lR0jgVdun6ONDtUcDArA+x
         R52mcoHhzwAXW3Ne6bu0ghNDQT5hAjC6p3dyV85y4q1qb3K43oDbcqFDiw8zVJyfcwUV
         sEOuGg/woSDj3b83Ot0MVBf1SjV+ZWh6hgLR3E9C5eI7YXtFJ6z4GViBAV1jRJB3MfJQ
         AvRPm3NyKoS9lAgkiLV8bLpY1fKw14qyAGrZHs8Z4L+Rrd8/AK4+oULo1Poxob0qKz2g
         tftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZJP0uSysrKqxMdkD0rooOPSq232fgyZKPEkO+ikkTC4=;
        b=VJQnvTjLkd4/USa5IcQtXiyDS19vRl1ZWmi2d7LYNP0mDhtrTmSZ0/Pn5+c7bqPAvh
         wHMVsgMivTG5Tl4jmfrEFfzPzdSlY8/SMHGYfhkKQ+sDcqDc9NRNFnwiwUS06bl9KgYj
         WYbmBB7UmuJXJjrMtSmSa9GHXzlsPPmj45vRs+LZm+xtStaLTRDI36E3viMdhBlBM/Q6
         7Y9SJsZtSCnrv8Qf/35O4aRlY7cN67eK5RA8+1dPDNR4yGeIBQv0lHi0eUaBLN/WwZki
         h7zXVQCtSz0134fXsx/PLwKbs9+qKyHK0GtdmbuvnP9EhJbcnZnKmF8h11MltUB+jLOH
         Yzog==
X-Gm-Message-State: APjAAAX69udVyFUS6XNVTv/WeC4cL6QyAy1eeMALD8O1F3m5vtVyH9tu
        vflk49kUqLTx39nJtLjDncp27SGrw9w=
X-Google-Smtp-Source: APXvYqwsAnKDbcsLkFslD50fHsrm2wDqfYw8CGoZ0oiFSdmiRuJY7ZQyq+NeK9LRQ7M6c3jk93XTAQ==
X-Received: by 2002:a5d:44c3:: with SMTP id z3mr17148846wrr.329.1552242555507;
        Sun, 10 Mar 2019 11:29:15 -0700 (PDT)
Received: from myhost.home (bgt124.neoplus.adsl.tpnet.pl. [83.28.83.124])
        by smtp.gmail.com with ESMTPSA id h13sm5807469wrt.89.2019.03.10.11.29.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 11:29:15 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pavel@ucw.cz, robh@kernel.org, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 14/25] dt-bindings: lm36010: Add function and color properties
Date:   Sun, 10 Mar 2019 19:28:25 +0100
Message-Id: <20190310182836.20841-15-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refer to new "function" and "color" properties and mark "label"
as deprecated.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/leds/leds-lm3601x.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3601x.txt b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
index a88b2c41e75b..157b68d3db89 100644
--- a/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
+++ b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
@@ -22,9 +22,14 @@ Required properties for flash LED child nodes:
 	- led-max-microamp : Range from 2.4mA - 376mA
 
 Optional child properties:
-	- label : see Documentation/devicetree/bindings/leds/common.txt
+	- function : see Documentation/devicetree/bindings/leds/common.txt
+	- color : see Documentation/devicetree/bindings/leds/common.txt
+	- label : see Documentation/devicetree/bindings/leds/common.txt (deprecated)
 
 Example:
+
+#include <dt-bindings/leds/common.h>
+
 led-controller@64 {
 	compatible = "ti,lm36010";
 	#address-cells = <1>;
@@ -33,7 +38,8 @@ led-controller@64 {
 
 	led@0 {
 		reg = <1>;
-		label = "white:torch";
+		function = LED_FUNCTION_TORCH;
+		color = LED_COLOR_NAME_WHITE;
 		led-max-microamp = <376000>;
 		flash-max-microamp = <1500000>;
 		flash-max-timeout-us = <1600000>;
-- 
2.11.0

