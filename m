Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B9DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B2220637
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 21:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfLKVUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 16:20:54 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:60715 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfLKVUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 16:20:50 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MgNtR-1i5Ehb062B-00hwBH; Wed, 11 Dec 2019 22:20:32 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v7 3/9] ALSA: Avoid using timespec for struct snd_ctl_elem_value
Date:   Wed, 11 Dec 2019 22:20:19 +0100
Message-Id: <20191211212025.1981822-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191211212025.1981822-1-arnd@arndb.de>
References: <20191211212025.1981822-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iykmUU2XsgojNUhRxWJ9NKMPyV+S5EjEfc7usTwDkBJbIBAqrkL
 3tFrJsChkCKQQP8cc6PcvoPSVrNMveKGCfO//KYYhF5BZEkAz9nv5oL08XPfmj9fljInh8q
 rRf67DV8uhtHRsp9SY1WD/jT2xx1Vqy6lmulsPlTyWWvw6URc0bIQ6o8EfwfYVi0Vv8OvSB
 jF1jI6Q1fulMXykAIa3lg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zyamFrw9k0o=:87xM/lq8CmcweWUktkqZrD
 T1dkqosterDjtfnqKNe+tq0c18geQ4i/1gRHbssNpQfn6DiOsLrEtSz8cyuF1t/R6zL78O7EU
 qFu7RO4yf/7qU9NtMORtsVIZHUnk8LPUYgoTqGOOqNvnqi7s5MCjcrDGOqiokj5d5Wgt5CpEs
 thlc0yK0XV6A28RYJohNo5rtUUxXvJarW70Uj33T6m1SkBgMDI+EEBQ3ASlOwrLxGqfAVje99
 8QlEdo/VqAwsby9HfgNy3J0lqBy6K0fPeBkCyKIPfIlgPSNb2vK3yEhmmf/4wIeLRlCDLL2f7
 k9DFJKnloMSUxZsOVw8J2MXeFACrrMxFnvping3zVkl3us7jfoXxfLmz6tDu3C5UzIuYhTrxz
 2hMrbXcQLj13u8YgPNWefQnxzad0Szy+peaaCaEwMtqTnK43zCxt+NVJ+nqnIma0jeXEFdsjl
 PGJ52Fp8EbZbv2ttcCzB75JJhJ1OxyAEaVXuRBi83G8sO6Upd06+NpIukp7z3wibwPLl7jZQD
 OLF2GgMBst6YVp/JPmJXGEH+b3hx0xHGgJBhK4NnLI+uEc9SeIBPE3gEZB+xWVHo2QcUD2/rg
 XWhk8YRoth4ZzslVgecvX8D/ILyvW06+LZBaFm8IQPofAf1/gFYNnZthNDwxvqKjXmmulhlTR
 ZVlE/AEph24o3styRMjlWspEnDniKtPuQNBOgkx6GqFJjbmO/3LnMznCSIkhprsvjLbBi0adA
 ejPH+nbkYDNVXtdDBCEWCDubvbRr1l921DJ3IknP3NL3F9BdxD0fB39VWTnpXWkt26JvA+TGk
 x0aBuuQ4SkS4y/5CREQlUT2HC0gsU/YrVThX1GumgA9IaBkC6rR6H/YtG3NguumgwkB5e7v81
 GP0tEdDFyR6fVAFHU4jA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

The struct snd_ctl_elem_value will use 'timespec' type variables to record
timestamp, which is not year 2038 safe on 32bits system.

Since there are no drivers will implemented the tstamp member of the
struct snd_ctl_elem_value, and also the stucture size will not be changed
if we change timespec to s64 for tstamp member of struct snd_ctl_elem_value.

From Takashi's comments, "In the library, applications are not expected
to access to this structure directly. The applications get opaque pointer
to the structure and must use any control APIs to operate it. Actually the
library produce no API to handle 'struct snd_ctl_elem_value.tstamp'. This
means that we can drop this member from alsa-lib without decline of
functionality." Thus we can simply remove the tstamp member to avoid using
the type which is not year 2038 safe on 32bits system.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/sound/asound.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 930854f67fd3..40a23d8418fe 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -957,8 +957,7 @@ struct snd_ctl_elem_value {
 		} bytes;
 		struct snd_aes_iec958 iec958;
 	} value;		/* RO */
-	struct timespec tstamp;
-	unsigned char reserved[128-sizeof(struct timespec)];
+	unsigned char reserved[128];
 };
 
 struct snd_ctl_tlv {
-- 
2.20.0

