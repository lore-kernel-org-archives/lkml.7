Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D87C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90C820830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=in.bosch.com header.i=@in.bosch.com header.b="wIn5Vtav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfDCN1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:27:08 -0400
Received: from de-deferred1.bosch-org.com ([139.15.180.216]:41828 "EHLO
        de-deferred1.bosch-org.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbfDCNZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:25:44 -0400
Received: from de-out1.bosch-org.com (unknown [139.15.180.215])
        by si0vms0224.rbdmz01.com (Postfix) with ESMTPS id 44Z65j5x4qz2B7;
        Wed,  3 Apr 2019 15:15:53 +0200 (CEST)
Received: from fe0vm1650.rbesz01.com (unknown [139.15.230.188])
        by si0vms0216.rbdmz01.com (Postfix) with ESMTPS id 44Z65h17Xnz1XLG6y;
        Wed,  3 Apr 2019 15:15:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=in.bosch.com;
        s=2015-01-21; t=1554297352;
        bh=5JmXTCA8402bhLcSZ4Bm03a+Df0e1eFcN7hmyjl8vSI=; l=10;
        h=From:From:Reply-To:Sender;
        b=wIn5Vtavye/rf6cEcqrKUWBXG6QzQvdITVPu2UguBBmN0tQsihMGnLaUYvzryY2gF
         4XT0P7LoWKe7Exf+PV+x61b73KTU9wcHNRGGMbl300N7y8//M1WL5M8FzSaEqXPwqn
         Mb+ukwLv4jKT1UkuUAp7wXtZqvVfXNldR7R0FAgQ=
Received: from si0vm4642.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1650.rbesz01.com (Postfix) with ESMTPS id 44Z65h0m1wz1Cj;
        Wed,  3 Apr 2019 15:15:52 +0200 (CEST)
X-AuditID: 0a3aad12-be3ff70000006e39-4a-5ca4b207a31e
Received: from si0vm1949.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm4642.rbesz01.com (SMG Outbound) with SMTP id B2.3D.28217.702B4AC5; Wed,  3 Apr 2019 15:15:51 +0200 (CEST)
Received: from SI-HUB2000.de.bosch.com (si-hub2000.de.bosch.com [10.4.103.108])
        by si0vm1949.rbesz01.com (Postfix) with ESMTPS id 44Z65g6KBpz6CjZqr;
        Wed,  3 Apr 2019 15:15:51 +0200 (CEST)
Received: from localhost.localdomain (10.47.103.88) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Wed, 3 Apr 2019
 15:15:50 +0200
From:   <VenkataRajesh.Kalakodima@in.bosch.com>
To:     <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC:     kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>,
        Harsha M M <harsha.manjulamallikarjun@in.bosch.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH 3/8] drm: rcar-du: Give a name to clu table samples
Date:   Wed, 3 Apr 2019 18:44:39 +0530
Message-ID: <1554297284-14009-4-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
References: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.103.88]
X-Brightmail-Tracker: H4sIAAAAAAAAA22SfUxTVxjGObdfl64XDheKry1VcyPZYoJDR1mjxrnsH7JswWRjC1udu4xr
        29gPcm8hgsYwMcLaiRqJE0KoLJgAus02ouVjw5VOkDmVQszYcGyJSyhRURhTXMa8l4LtH/vv
        Pc/z/s6T8+SQMrpXpSNtTjfHO1k7o1TL1Vu+MuSoAm3m3IHFrSZf+IbCNDY/ozR1/neYMD36
        /DeFabSnWWnqij4gdigLmmrPqQomvYNEwVxgzU7ZB+ptpZzdVsHxL2//WG2dGBgiyjz6fS0d
        w/JqdFTrQckk4DwYuzCn9CA1SePTBPxz/4pCMmjcj+BKHxsz7iGI1HjkkqHEOdDv96skIwN3
        IPA+uExIBxk+i6CmK7SEp+M3oCbwF5JmOV4P11tnl2YKF0Hw1O8olr0Gxm98JpPmZPwe+Ibu
        KmPRReB7MquI7afBtca7S8kyDPD91JS4T4rsOuhuVR5HuClhqylh6wwiOpFWsOVWOPLy8zZv
        5Es4oSp308ZPXI4AijVLB5H/9p4QwiRiNNRIY5uZVrAVQqUjhIwkwWip/IOilFLiKq20soJ1
        N19u5wRGR2XdetNMpz+XhfISh00QbC5nCAEpYzKo68fOmGmqlK2s4nhXDAshPSlnVlEWstBM
        Ywvr5vZyXBnHr7hbSZIBKsMvBqbxnIXbt8dmd6/YjIFCSUlJdGaikxhLkMkh9AqpEbMJ6QpK
        KGMdgs2yjK+O4fSKGkeH0au6VdROicGSay13Pk/VZVFJf7aYaW2CESen0TgSe0un/v1GhDXi
        p43nAaWXKkpbFuPQ5rMigz0aiNZWI2gJziNoP3FEDr6rDQr47tSMAnrbvCqI9DSpYHL8UjI0
        NgTV0NzZp4FrtXc08LD9KAXRwboUmPsinAIL346kQnc4mgonvo5oYWLoQibU1x1aDcd+Devg
        XjSoh8Wb4SwIDC9kwZO2HwxwfubLtTA2V78OTv50kYGTfQMMjNSPMrB427MegpEfs+HiHe+L
        02KZhFimqdwnlelm3f9T5rIaf52uGjnUs3Xz9k8naco+pevKsU728JYDC+Oz5OHUtwoN54tz
        posm8jsiu97J3PFLT3ro6uNA9uBoY/VUw0tVwQN/GN6ffqG49fWqR8dl+4sWFU+PpBTv3p+t
        b7/Z/dHAudc+3NDv7zb+7Xy713m6sDD3Z2zk9M58Yy2qbyjuMI6FLrve9TJywcpu2iDjBfYZ
        vQA+Uk4EAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>

Replace the hardcoded value of clu table sample count with a
meaningful name.

Signed-off-by: Harsha M M <harsha.manjulamallikarjun@in.bosch.com>

This is the out-of-tree patch for DU CMM driver support from
    Yocto release v3.6.0. The part of this patch adding CMM support to
    the new Rcar E3 (R8A77990) SoC was filtered out due to lack of
    Yocto v3.6.0 (i.e. rcar-3.6.2) kernel updates on staging-414.

    Link: https://github.com/renesas-rcar/du_cmm/commit/53973b806881ed8f54500b0d42bdc40aaca60476.patch

    Following is from the patch description:

    Subject: [PATCH] du_cmm: Release for Yocto v3.6.0

    This patch made the following correspondence.

      - R-Car E3(R8A77990) device support.
      - Fix rewritting of parameter procedure in rcar_du_cmm_postclose

Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>

      - Resolved checkpatch errors
      - Resolved merge conflicts according to latest version

Signed-off-by: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_cmm.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_cmm.c b/drivers/gpu/drm/rcar-du/rcar_du_cmm.c
index ac613a6e..d380dd9 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_cmm.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_cmm.c
@@ -75,9 +75,9 @@
 #include <linux/clk.h>
 
 /* #define DEBUG_PROCE_TIME 1 */
-
+#define CMM_CLU_SAMPLES 17
 #define CMM_LUT_NUM 256
-#define CMM_CLU_NUM (17 * 17 * 17)
+#define CMM_CLU_NUM (CMM_CLU_SAMPLES * CMM_CLU_SAMPLES * CMM_CLU_SAMPLES)
 #define CMM_HGO_NUM 64
 /* rcar_du_drm.h Include */
 #define LUT_DOUBLE_BUFFER_AUTO		0
@@ -211,11 +211,11 @@ static inline u32 index_to_clu_data(int index)
 {
 	int r, g, b;
 
-	r = index % 17;
-	index /= 17;
-	g = index % 17;
-	index /= 17;
-	b = index % 17;
+	r = index % CMM_CLU_SAMPLES;
+	index /= CMM_CLU_SAMPLES;
+	g = index % CMM_CLU_SAMPLES;
+	index /= CMM_CLU_SAMPLES;
+	b = index % CMM_CLU_SAMPLES;
 
 	r = (r << 20);
 	if (r > (255 << 16))
@@ -630,9 +630,9 @@ static int clu_table_copy(struct rcar_du_cmm *du_cmm)
 	}
 
 	rcar_du_cmm_write(du_cmm, dst_addr, 0);
-	for (i = 0; i < 17; i++) {
-		for (j = 0; j < 17; j++) {
-			for (k = 0; k < 17; k++) {
+	for (i = 0; i < CMM_CLU_SAMPLES; i++) {
+		for (j = 0; j < CMM_CLU_SAMPLES; j++) {
+			for (k = 0; k < CMM_CLU_SAMPLES; k++) {
 				rcar_du_cmm_write(du_cmm, src_addr,
 						  (k << 16) | (j << 8) |
 						  (i << 0));
@@ -912,9 +912,9 @@ int rcar_du_cmm_pm_suspend(struct rcar_du_crtc *rcrtc)
 	}
 
 	index = 0;
-	for (i = 0; i < 17; i++) {
-		for (j = 0; j < 17; j++) {
-			for (k = 0; k < 17; k++) {
+	for (i = 0; i < CMM_CLU_SAMPLES; i++) {
+		for (j = 0; j < CMM_CLU_SAMPLES; j++) {
+			for (k = 0; k < CMM_CLU_SAMPLES; k++) {
 				rcar_du_cmm_write(du_cmm, CMM_CLU_ADDR,
 						  (k << 16) | (j << 8) |
 						  (i << 0));
@@ -1014,6 +1014,8 @@ void rcar_du_cmm_postclose(struct drm_device *dev, struct drm_file *file_priv)
 	for (crtcs_cnt = 0; crtcs_cnt < rcdu->num_crtcs; crtcs_cnt++) {
 		rcrtc = &rcdu->crtcs[crtcs_cnt];
 		du_cmm = rcrtc->cmm_handle;
+		if (!du_cmm)
+			continue;
 		if (du_cmm->authority && du_cmm->pid == task_pid_nr(current)) {
 			du_cmm->authority = false;
 			du_cmm->pid = 0;
-- 
2.7.4

