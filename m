Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4296C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 05:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9665420818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 05:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JMBjAjqj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfEPFJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 01:09:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44307 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbfEPFJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 01:09:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id z16so921474pgv.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 22:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=bw14u18P9i//6PFBBpNeMD35DBcnBuJpaE6hMWzLBZ0=;
        b=JMBjAjqj9Bt/mtPeNVVFnwrG6sxggttpsGf3yrrSUASc87Irj9E9jhvOrZ6OxSc4pm
         3oweA6sqM0iqogIExq9o+Er5Wtj62ppqTiDzoyWk95Ebb4+W5do0a66GqvVBiL6cNBFL
         2OkBNVSw3s+rYw7I92PJ9orjWwAsPwsq0GPBRAqP1uhxgPUIIqbi+wqRsSxiBhrnkEax
         b2gLSylHqEuhL3gzcj5Jt5t1XEE7luk6bwfSx9J6nOtyU6y0TMiBtG5r1R8FzkL0b6D3
         qj4K7GsCIs9w3K+ZDiz3Tv3At8nVqFuTHKCo0hltnNFFBDX/F+BP0LISx4mPRlEtLmC7
         /sDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=bw14u18P9i//6PFBBpNeMD35DBcnBuJpaE6hMWzLBZ0=;
        b=ZmwFsx8UtP2FUO5TX0PjjX6VLqJ27HfBHoVQqhp/TkmKDoOgAr4lpIQYHY6RaG0yuy
         Qy6ZONFs8OkvZWAQvpAmjDIiVMY6r8ScZtfPH7zI7gHySa4c5ArLwwVdeuWPILKK9sr6
         eKu09/SlvvJwTB/LiayxCfLEukfR9+wcmas7SyQaf9iw2LWC0TGNdLmTMnePiOX0cbo0
         ZcLl1Ugq0lJruzeJEU51O8SWNavcwQeumjnmHgkhZnp0SOFnQj1/lo/TUw9Cekak2l2B
         WfpRpdkkmw1wpGC9P2dxaa5uT5iYm2qFBSOQgkhmdXVDDkoS17eiqFYR9rOaLUfof3Dh
         Zbxg==
X-Gm-Message-State: APjAAAXV2j/iVf3NgB8PYwUqPOn/DRscQgeI1aSDc88lFFHuHE6xGzxr
        Zbj6jior+npHLpxGi+zfRJuCow==
X-Google-Smtp-Source: APXvYqyY6RdF/VL9iKR+Dn640qMh2T+dCAVMBAhbWxEWLJANF3ujtebGYHqiEGcZX5ca2hsGtxbCWg==
X-Received: by 2002:a62:e718:: with SMTP id s24mr51969126pfh.247.1557983371371;
        Wed, 15 May 2019 22:09:31 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id u6sm5929531pfa.1.2019.05.15.22.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 May 2019 22:09:30 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com,
        andrew@lunn.ch, palmer@sifive.com, paul.walmsley@sifive.com,
        sagar.kadam@sifive.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: i2c: extend existing opencore bindings.
Date:   Thu, 16 May 2019 10:38:38 +0530
Message-Id: <1557983320-14461-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557983320-14461-1-git-send-email-sagar.kadam@sifive.com>
References: <1557983320-14461-1-git-send-email-sagar.kadam@sifive.com>
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

