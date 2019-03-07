Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A87C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D7520675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfCGKdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:33:25 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:49583 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfCGKdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:33:25 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MRT6b-1hP8M1035J-00NUFT; Thu, 07 Mar 2019 11:33:12 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: catu: fix clang build warning
Date:   Thu,  7 Mar 2019 11:32:58 +0100
Message-Id: <20190307103309.1574563-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:c5ju05gEucBB6zZY3P2Gk3MADAkbnTmVeAGJvJqDf5glRpyqIKz
 SGjkw2CZoQ9rt/Ae524B9YFCtf7CeF18XjAMG9uSa20NT4qfNcFfG2sEgOcCDTgx+mGIRpb
 U5iM2yS4u0JBP+VOTZMq+KIZ7U2qW/cOAmoC2Ykl1CLPbD64RHGCPAW2Itpvi5m31h8u6Fo
 +MVEzvx6oO6PWxJ71tNnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IeNdZLy7GZk=:QA6Nm190tOEmM3iweydNGz
 /rAw6+PCEAC0pqAqagUcsIu8SJZB5b9Gi7pDNzrdlmPYS93fBPgXLkNZqUIUQ3htO1Vz7y5M7
 9q2S5BS++bpQN6iIBh+XwOZqcLLb7cuAN7lpyM9ufu6feJ9eS+YGUaV22Adq+3JHFYSQ9Sz7R
 esQUUoYgOifiobfBkiuVoAHEy0gRZVGiLzJCbcnC4uLPbnaYOEIiDaRIvTTcEjYVaU/DfF0+O
 5LHNMmUmRboBHqVuS+x3Q3op/5lvVBnZjt7R2konLcoNaOXRB2GmuZaXZKmZcI5E/tSuV7j9T
 FYkp3jylh4CwNnreQHOn+GLQPzWh9lGToeYXpvU0T+k6Uufsp2PkB2bQkvtBcpdrlPmYt9izN
 6MfMG0G/iHRCECfoE0keA0qvMsv8vQlgapxm1GbhivaHL8AJFz515cNGppfZEkfPhg761YL8+
 vfZ8JPd3M718SeA+GucQ4AkXxZJb20C8dYM61/ujJVOIPSOx5jUHfqhe8UpgtvgNdscF2F40M
 hCgwdQLMA3SLCk2BzhMsWq2d0aWIhAtr9c71/t6LwTbZqqMkhDmCH0AMJjtJSwZKWP+O/uI90
 +KPPLRrQsTV3m1PSzmB1e1UGQDwVLxboRntpV8LGoQiPAmXceZ6TLHSKqoSQzbwTjajTNNa2A
 OuFPA3VD40rFPxsx780Uu73HQYL5Vc2ga7iTXQvep/yKTXkPA1GNEaOTmWjvCta565qhjdr7G
 gfaQALgulNQ8X+HbhwT2mjyix7T91aQuCOsrRw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang points out a syntax error, as the etr_catu_buf_ops structure is
declared 'static' before the type is known:

In file included from drivers/hwtracing/coresight/coresight-tmc-etr.c:12:
drivers/hwtracing/coresight/coresight-catu.h:116:40: warning: tentative definition of variable with internal linkage has incomplete non-array type 'const struct etr_buf_operations' [-Wtentative-definition-incomplete-type]
static const struct etr_buf_operations etr_catu_buf_ops;
                                       ^
drivers/hwtracing/coresight/coresight-catu.h:116:21: note: forward declaration of 'struct etr_buf_operations'
static const struct etr_buf_operations etr_catu_buf_ops;

This seems worth fixing in the code, so replace pointer to the empty
constant structure with a NULL pointer. We need an extra NULL pointer
check here, but the result should be better object code otherwise,
avoiding the silly empty structure.

Fixes: 434d611cddef ("coresight: catu: Plug in CATU as a backend for ETR buffer")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hwtracing/coresight/coresight-catu.h    | 5 -----
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 4 ++--
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
index 1b281f0dcccc..1d2ad183fd92 100644
--- a/drivers/hwtracing/coresight/coresight-catu.h
+++ b/drivers/hwtracing/coresight/coresight-catu.h
@@ -109,11 +109,6 @@ static inline bool coresight_is_catu_device(struct coresight_device *csdev)
 	return true;
 }
 
-#ifdef CONFIG_CORESIGHT_CATU
 extern const struct etr_buf_operations etr_catu_buf_ops;
-#else
-/* Dummy declaration for the CATU ops */
-static const struct etr_buf_operations etr_catu_buf_ops;
-#endif
 
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index f684283890d3..6378c3dece6b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -772,7 +772,7 @@ static inline void tmc_etr_disable_catu(struct tmc_drvdata *drvdata)
 static const struct etr_buf_operations *etr_buf_ops[] = {
 	[ETR_MODE_FLAT] = &etr_flat_buf_ops,
 	[ETR_MODE_ETR_SG] = &etr_sg_buf_ops,
-	[ETR_MODE_CATU] = &etr_catu_buf_ops,
+	[ETR_MODE_CATU] = IS_ENABLED(CONFIG_CORESIGHT_CATU) ? &etr_catu_buf_ops : NULL,
 };
 
 static inline int tmc_etr_mode_alloc_buf(int mode,
@@ -786,7 +786,7 @@ static inline int tmc_etr_mode_alloc_buf(int mode,
 	case ETR_MODE_FLAT:
 	case ETR_MODE_ETR_SG:
 	case ETR_MODE_CATU:
-		if (etr_buf_ops[mode]->alloc)
+		if (etr_buf_ops[mode] && etr_buf_ops[mode]->alloc)
 			rc = etr_buf_ops[mode]->alloc(drvdata, etr_buf,
 						      node, pages);
 		if (!rc)
-- 
2.20.0

