Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB0BC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 04:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAF821721
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 04:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SCunRLc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfE2E2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 00:28:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36655 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfE2E16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 00:27:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id d21so490173plr.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 21:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=/BRFvwHTJGi4mC+l6/NtyYz/ZOf9cjorYo3iOt6cwfc=;
        b=SCunRLc4T0rNk+sSZV9/Xml+fAJUPREjBlQu89pZCipHWUR6B+SVrumnSlUAFodgr/
         /+ouQN5p7X6JofF86wPXAkN1N+QPSaK2irANBHSJawDb4noqMbmnXUFyQ9OzigQy9uTv
         4gI/CMvTfcABsG8DTmgRMLKa/zmITDwOxUyWpsU0ZANP+fsVAO2gqFzonXdIbaOjzmII
         rZDSKKIVNDKP/S5rp4hleCbStov7sYu1mdxgWlFvjeLHH5sRlsbCQ5XaYfcemwTIDJ9p
         II8VFmtwi8k0eDucVVWmpEasuvmH1rKx/wNKLerI5FJhzgCKkJlfknFR/q5jqFLlsWOE
         0TRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=/BRFvwHTJGi4mC+l6/NtyYz/ZOf9cjorYo3iOt6cwfc=;
        b=t1dwuNR6eQe3fihMKkb9/PiGfUnm5F+LJjyqWPxRiP1Axxl7ylnVH5ym1ot3DH9r1g
         LyvmKJgsnnd9wuatvauLk4ohEAjtyH8Bt/M7WlDjF9Fh2OBriaDVmCbjwdApRfhpf4dt
         yDqzarzXg6igrK9vsIyCChqSe2Gb59B7k49zFjB80acFY5NLxFA/1I40kwIWTGcKk/nv
         3AFKL2CqXkjbnQWwIh9N/sdHhz2V/TCKY7XuJui5Ah/IfnZhqO89MIIrLuZI6JeO6fvb
         0HCCaAJnVCsYzh8X5Q5NNpdAIbXih/JHzoYkKr8MBEzt9H3dLmtOG7lGyDrmH+87is43
         qsHA==
X-Gm-Message-State: APjAAAUukDvHoiKXoSXHL4vC/Dk42GrKcYytEC0s4ycL2LNKE2XaaFkF
        1G992SaoTLc7LOJo1Q/Rc0Ddxw==
X-Google-Smtp-Source: APXvYqx+J/LVDOtRKJD6vV3CguLJwpznGJEh2qKtm72f8Qx+c6FbWQyMgSIZL6tuCUCLJ61wz2qm+Q==
X-Received: by 2002:a17:902:8648:: with SMTP id y8mr4690946plt.30.1559104077984;
        Tue, 28 May 2019 21:27:57 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id c15sm16444591pfi.172.2019.05.28.21.27.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 May 2019 21:27:57 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com,
        andrew@lunn.ch, palmer@sifive.com, paul.walmsley@sifive.com,
        sagar.kadam@sifive.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/3] i2c-ocores: sifive: add support for i2c device on FU540-c000 SoC.
Date:   Wed, 29 May 2019 09:57:26 +0530
Message-Id: <1559104047-13920-3-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1559104047-13920-1-git-send-email-sagar.kadam@sifive.com>
References: <1559104047-13920-1-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update device id table for Opencore's I2C master based re-implementation
used in FU540-c000 chipset on HiFive Unleashed platform.

Device ID's include Sifive, soc-specific device for chip specific tweaks
and sifive IP block specific device for generic programming model.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 drivers/i2c/busses/i2c-ocores.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index c3dabee..b334fa2 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -82,6 +82,7 @@ struct ocores_i2c {
 
 #define TYPE_OCORES		0
 #define TYPE_GRLIB		1
+#define TYPE_SIFIVE_REV0	2
 
 static void oc_setreg_8(struct ocores_i2c *i2c, int reg, u8 value)
 {
@@ -462,6 +463,14 @@ static u32 ocores_func(struct i2c_adapter *adap)
 		.compatible = "aeroflexgaisler,i2cmst",
 		.data = (void *)TYPE_GRLIB,
 	},
+	{
+		.compatible = "sifive,fu540-c000-i2c",
+		.data = (void *)TYPE_SIFIVE_REV0,
+	},
+	{
+		.compatible = "sifive,i2c0",
+		.data = (void *)TYPE_SIFIVE_REV0,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ocores_i2c_match);
-- 
1.9.1

