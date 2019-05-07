Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60784C04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359DB20578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 19:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdeQdBMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfEGTiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 15:38:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45450 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEGTiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 15:38:16 -0400
Received: by mail-pl1-f195.google.com with SMTP id a5so3735587pls.12;
        Tue, 07 May 2019 12:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E3cy6coJyOOa2SbBo8UlxqrSWJcV9cpYsmbojY6zx78=;
        b=PdeQdBMH+PUZqj2w9dPXVinwmbVbRY3710/zgoNzmgAAwN1AnPnO68PuvRcTOgHdGC
         ztkUdxZHXvkX6BHIg+H4erw9aGn9DaxXx3diAqZuf3ThTXCSBbfcYT9mckVk1F/RYBI8
         vFPjklCNJW2gmPY9EZSVJmdZO9xxOEsViODA/+Fdy7FjBpKFZi24JMxqOjXFmoBz7vSW
         AFnR5jMbkNZSEt6tRcevkk0cRRxTwksw0LKr9AldUi8bxRDcLXAQ9LB9PRwx/wLbZzk0
         zVGxm/MEOKDNF91YJVNk+Ofsq89/gAt68fo76RXVPNxH40O5HAn2CUzUrYt86PSyg7rt
         FSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E3cy6coJyOOa2SbBo8UlxqrSWJcV9cpYsmbojY6zx78=;
        b=BX9+KgiOhr/qvEWNzxyrTsTp+Gwmx5H1wYg2lIv0KeYOVNFkojB8cvbK/6M1j3RkzL
         mPWpRFxuf1h6UMh9UDkq+L+zB/BAVvGP+dUBZEKb5ceE8iYS5PlQrjufzOPm2ZwPEOHv
         P5379z8Mj+O008DXTenFPWumAHP9XRwipIV5v5/XkDLwNxBuzQgbE2qmOp/oyMWMe9VG
         zrH5yu9onqjD1dnKTBPWqKfPtpLkTyH59kMnZ3w38Tp/SZ/eB//YDAHdkyG3OAkm4ufg
         AsoPoS9Qp9577RVghuXf+/x2QLcirafcXhQz4XItn6QMkZ7TDSXDrzNNlJhZpGyCvYVS
         fVXw==
X-Gm-Message-State: APjAAAUshBVqv/LqBb7IZkvF4joy7CfWAStxNlhHL4BeQ0iFO89tSWcR
        +xxJjqYKWvr1rtmgfPN2XYLt54xn
X-Google-Smtp-Source: APXvYqwSKFH3OcPH0UwFlrAn9EVBXhRUaujmIGC6dieqwuOP4POjIFzGh4hKO76fOOfeE/bNAObGkg==
X-Received: by 2002:a17:902:8a81:: with SMTP id p1mr42323974plo.106.1557257895759;
        Tue, 07 May 2019 12:38:15 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id l21sm5964658pff.40.2019.05.07.12.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 12:38:14 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-hwmon@vger.kernel.org (open list:HARDWARE MONITORING),
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v2 1/3] kernel: Provide a __pow10() function
Date:   Tue,  7 May 2019 12:35:02 -0700
Message-Id: <20190507193504.28248-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190507193504.28248-1-f.fainelli@gmail.com>
References: <20190507193504.28248-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a simple macro that can return the value of 10 raised to a
positive integer. We are going to use this in order to scale units from
firmware to HWMON.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 include/linux/kernel.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2d14e21c16c0..62fc8bd84bc9 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -294,6 +294,17 @@ static inline u32 reciprocal_scale(u32 val, u32 ep_ro)
 	return (u32)(((u64) val * ep_ro) >> 32);
 }
 
+/* Return in f the value of 10 raise to the power x */
+#define __pow10(x, f)(					\
+{							\
+	typeof(x) __x = abs(x);				\
+	f = 1;						\
+	while (__x--)					\
+		f *= 10;				\
+	f;						\
+}							\
+)
+
 #if defined(CONFIG_MMU) && \
 	(defined(CONFIG_PROVE_LOCKING) || defined(CONFIG_DEBUG_ATOMIC_SLEEP))
 #define might_fault() __might_fault(__FILE__, __LINE__)
-- 
2.17.1

