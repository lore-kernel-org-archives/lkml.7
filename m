Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7194DC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FD2214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="neXNGxoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388875AbfETOM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:12:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36040 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388345AbfETOMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:12:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so6876501pgb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=bw14u18P9i//6PFBBpNeMD35DBcnBuJpaE6hMWzLBZ0=;
        b=neXNGxozyGNOnI4VsziWA4VruFF8zUCzBysSiP5LjXEiF8fHcIMiigECAhrR2GFm6B
         QBVMG98vXqb0BIqvNBwJbsU8PuXQ54Ih/NWwWJaLD7xJ/ng2UE4UFK2Ih7Tgbt0X4KHp
         LdmwQFTNTzaqgjGTJOE6QJEO4UWxz3lyH7pAaakcN41ujsiFXAgwo+I0zySeK8uOyZhc
         m5BKaNr08paRzhkoyv1IHakeg5qKRsvNfV1HHKy1TVuwx2jZewdKSu7oZwf+WyAnT5mt
         rlcrM2RE+GNbV16AVFvjHOrP+0H3k/vnUtMmipdu0qOENw5+VZ/Ti0vU2QbTPFA4SwLT
         Vuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=bw14u18P9i//6PFBBpNeMD35DBcnBuJpaE6hMWzLBZ0=;
        b=SSMC3cvFlvKTiBcKy21yLneRVt1Yqx/QplHa1C/vRi84wdEFV5qNOzKqEspuLuXBjX
         6VFyRKrSfbcpM9FBVlPnWzAN7pFsYy2l8nlZyVzxyJ1A/MSiBNU8exRj6YLezi+E7I3d
         xS9AjMwATA3rd4Fbd6sNOca5TWaPT+C4rrccWeTx9pBpUI8dkeY+kGTA5oNZT0aX/nYr
         5rLsS6mGPh/yiQuYjdIahq4FDZ2FAk6GsCdyqIQtFxWa15C2mO+S1ezDh5Iefl9y9RK+
         9tIlYmNNzdX6D+6+xJ8ZLRAaNEdaewm7ch43gSBaYKRu4WPjEDihdTiPMQslwXO6Vq8p
         lANA==
X-Gm-Message-State: APjAAAW+xgzzd8zrWGFQSoyEw5KvS0tJHN4P7klfHDboFqtin+G/m8HI
        5NA9Uc0GyaB9ITMFxUsmZCXIQg==
X-Google-Smtp-Source: APXvYqwx23KuGQQBy9STDE5n426D1HSIXniwr8IKWPZNfYVVORKQwGVsqu5A72EeHAWoa2liK0MOsA==
X-Received: by 2002:a63:f703:: with SMTP id x3mr73780717pgh.394.1558361544460;
        Mon, 20 May 2019 07:12:24 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id a9sm26388248pgw.72.2019.05.20.07.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:12:23 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com,
        andrew@lunn.ch, palmer@sifive.com, paul.walmsley@sifive.com,
        sagar.kadam@sifive.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] dt-bindings: i2c: extend existing opencore bindings.
Date:   Mon, 20 May 2019 19:41:16 +0530
Message-Id: <1558361478-4381-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558361478-4381-1-git-send-email-sagar.kadam@sifive.com>
References: <1558361478-4381-1-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add FU540-C000 specific device tree bindings to already
available i2-ocores file. This device is available on
HiFive Unleashed Rev A00 board. Move interrupt and interrupt
parents under optional property list as these can be optional.

The FU540-C000 SoC from sifive, has an Opencore's I2C block
reimplementation.

The DT compatibility string for this IP is present in HDL and available at.
https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/i2c/I2C.scala#L73

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 Documentation/devicetree/bindings/i2c/i2c-ocores.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
index 17bef9a..b73960e 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-ocores.txt
@@ -2,8 +2,11 @@ Device tree configuration for i2c-ocores
 
 Required properties:
 - compatible      : "opencores,i2c-ocores" or "aeroflexgaisler,i2cmst"
+                    "sifive,fu540-c000-i2c" or "sifive,i2c0".
+		    for Opencore based I2C IP block reimplemented in
+		    FU540-C000 SoC.Please refer sifive-blocks-ip-versioning.txt
+		    for additional details.
 - reg             : bus address start and address range size of device
-- interrupts      : interrupt number
 - clocks          : handle to the controller clock; see the note below.
                     Mutually exclusive with opencores,ip-clock-frequency
 - opencores,ip-clock-frequency: frequency of the controller clock in Hz;
@@ -12,6 +15,8 @@ Required properties:
 - #size-cells     : should be <0>
 
 Optional properties:
+- interrupt-parent: handle to interrupt controller.
+- interrupts      : interrupt number.
 - clock-frequency : frequency of bus clock in Hz; see the note below.
                     Defaults to 100 KHz when the property is not specified
 - reg-shift       : device register offsets are shifted by this value
-- 
1.9.1

