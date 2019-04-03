Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85D7C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3072147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=in.bosch.com header.i=@in.bosch.com header.b="jzX7NuqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDCNZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:25:44 -0400
Received: from de-deferred2.bosch-org.com ([139.15.180.217]:46410 "EHLO
        de-deferred2.bosch-org.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726155AbfDCNZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:25:42 -0400
Received: from de-out1.bosch-org.com (unknown [139.15.180.215])
        by fe0vms0193.rbdmz01.com (Postfix) with ESMTPS id 44Z65r5cNcz2fv;
        Wed,  3 Apr 2019 15:16:00 +0200 (CEST)
Received: from si0vm1947.rbesz01.com (unknown [139.15.230.188])
        by fe0vms0186.rbdmz01.com (Postfix) with ESMTPS id 44Z65q0xPHz1XLFjd;
        Wed,  3 Apr 2019 15:15:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=in.bosch.com;
        s=2015-01-21; t=1554297359;
        bh=5JmXTCA8402bhLcSZ4Bm03a+Df0e1eFcN7hmyjl8vSI=; l=10;
        h=From:From:Reply-To:Sender;
        b=jzX7NuqJMBk8PMsDXzF7/KfgdultFLhbko0eRKJqDweUF61wQyyj+2lGOiIRY6AO0
         HTuswTWVRbqZw150FPIJvjr/54SHZ6o0j01jo9FCLjFztHk0bmM1SB4gQiE8OzX5B5
         7DeiIbXPqD4xvhWyvbSt3hO/4vwby+dQl0JrZWE8=
Received: from fe0vm7918.rbesz01.com (unknown [10.58.172.176])
        by si0vm1947.rbesz01.com (Postfix) with ESMTPS id 44Z65q0nCDz6CjQSh;
        Wed,  3 Apr 2019 15:15:59 +0200 (CEST)
X-AuditID: 0a3aad10-03fff70000007f88-9a-5ca4b20ecfd8
Received: from si0vm1950.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm7918.rbesz01.com (SMG Outbound) with SMTP id 64.BF.32648.E02B4AC5; Wed,  3 Apr 2019 15:15:58 +0200 (CEST)
Received: from SI-HUB2000.de.bosch.com (si-hub2000.de.bosch.com [10.4.103.108])
        by si0vm1950.rbesz01.com (Postfix) with ESMTPS id 44Z65p5P4Fz525;
        Wed,  3 Apr 2019 15:15:58 +0200 (CEST)
Received: from localhost.localdomain (10.47.103.88) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Wed, 3 Apr 2019
 15:15:57 +0200
From:   <VenkataRajesh.Kalakodima@in.bosch.com>
To:     <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC:     kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>,
        Harsha M M <harsha.manjulamallikarjun@in.bosch.com>
Subject: [PATCH 7/8] drm: rcar-du: update gamma and ctm properties in commit tail
Date:   Wed, 3 Apr 2019 18:44:43 +0530
Message-ID: <1554297284-14009-8-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
References: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.103.88]
X-Brightmail-Tracker: H4sIAAAAAAAAA21SbUxbVRjuuf3gtuvF01vKXltgesecokNgbruKMfsxE6KJ0+g0MY3zIhfa
        QCm5t5CxGCTMrPJVUdwHZGlZZFNJVOiyrXxskzoYK2STQQzVZUzZHCOIDFwyIqD3Ulj7wz8n
        532e93menCeHVNLtcWbSXuzihWKuiNHoVLoXvk3eEu9vtWYExraxvotX1Ozo/b807L26G2p2
        pOuYhj19d4bYqc4Zr71E5Mz7U14n3tW9mMcX2ct44dmX3tfZ7ixNo5I/kvf98t2QqhJdghqk
        JQE/B3/3jqIapCNpfJSAmuMeIjL0IPjsUE9cZJhG4L65oJElGrwFLnR0rBAJ+BsEtTNnCZlQ
        4g+hvrFVIkjSiN+A6sAuGVbhVLg60a+U7xTeA1UnG1WR6BQIX6lewbX4bfAN3Frxp6Ud34M5
        dWTfAJebbqki9gC9k5NK2R7wY9B5XNOAcHPMVnPMVgsi2pApn88oc+x4PpNNF3J5cX9GZvoH
        TocfRerEAdQZyg8iTCJGT91oarXSaq5MLHcE0TaSYEzU9goJis915pXbONG2Vygt4kXGTCX9
        9IqVNj6ExdJch10U7c7iIAJSySRQQ5+2WGkqjyvfzwvOiCyILKSKWU8VkLutNC7gXHwhz5fw
        whqbTZIMUAkdUqBB4Av4ffn2ItcazSRTSKFQ0ImxTGwsQWqDaCupl7I7v5csKLGEc4j2glX5
        oxE5vYZGpSG0w7yeWtcuabDM2kqLH6aakyjFba+VNsUQUeUUCiOpNyO1JAfqpZ8azQPKIldk
        WAWjoqwTkgYfWAd33ZUI5vtOIRirm0LgDdxHcLH7sBoeTE7GwXj4jBYG2kJauD7cpofRO716
        mP26noKFc8OPgKffjWHuZtAIg2dCRjh/sN4E3pkuE5zyngVoXJq1gD+0kARe74kUWByf2wBj
        15elY/nHx8Hb1cfAsGeEAc/nExvB39SQCkf7+zZB4NrgJhi45nlCtt88JZVJSGWypT65TBfn
        +p8yV9Ho68yVyPHOxPmhf04fOXwPFrO+2EU9mRVXe8z5Z0XOfMbHtt+5GbZyg+GZ+decn2T/
        JhguHNmcuGyp2pNmie85qPhy8Slwn/v35fea09KTfwg34L6tO9lXR9zd7W8eSE0MWzxXt/9a
        99ZXuwfrK+xV4Y2zppbLYUt158nC2x9Nl/uyme6fC/c+zahEG5eZphRE7j/+11aAQwQAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>

Update gamma and ctm properties if there is a change.

Signed-off-by: Harsha M M <harsha.manjulamallikarjun@in.bosch.com>

   - Fix compilation issues when for_each_crtc_in_state is not defined
   - Resolved checkpatch errors
   - Resolved merge conflicts according to latest version

Signed-off-by: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_kms.c | 25 +++++++++++++++++++++++++
 include/drm/drm_atomic.h              | 25 +++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
index f0bc7cc..4d9a19c 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
@@ -246,6 +246,10 @@ static int rcar_du_atomic_check(struct drm_device *dev,
 static void rcar_du_atomic_commit_tail(struct drm_atomic_state *old_state)
 {
 	struct drm_device *dev = old_state->dev;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+	struct rcar_du_crtc *rcrtc;
+	int i;
 
 	/* Apply the atomic update. */
 	drm_atomic_helper_commit_modeset_disables(dev, old_state);
@@ -253,6 +257,27 @@ static void rcar_du_atomic_commit_tail(struct drm_atomic_state *old_state)
 					DRM_PLANE_COMMIT_ACTIVE_ONLY);
 	drm_atomic_helper_commit_modeset_enables(dev, old_state);
 
+	/* Update gamma and ctm properties for all crtc in present
+	 * state. Update is done only if there is a change
+	 */
+	for_each_crtc_in_state(old_state, crtc, crtc_state, i) {
+		rcrtc = to_rcar_crtc(crtc);
+
+		if (rcrtc->lut_handle) {
+			rcar_du_cmm_update_lut_and_free
+			  (rcrtc->lut_handle,
+			   (struct drm_color_lut *)crtc->state->gamma_lut->data,
+			   (crtc->state->gamma_lut->length /
+			   sizeof(struct drm_color_lut)));
+			rcrtc->lut_handle = NULL;
+		}
+		if (rcrtc->clu_handle) {
+			rcar_du_cmm_update_clu_and_free
+			  (rcrtc->clu_handle,
+			   (struct drm_color_ctm *)crtc->state->ctm->data);
+			rcrtc->clu_handle = NULL;
+		}
+	}
 	drm_atomic_helper_commit_hw_done(old_state);
 	drm_atomic_helper_wait_for_flip_done(dev, old_state);
 
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 1e71315..d22ccd8 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -693,6 +693,31 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
 			     (new_connector_state) = (__state)->connectors[__i].new_state, 1))
 
 /**
+ * for_each_crtc_in_state - iterate over all connectors in an atomic update
+ * @__state: &struct drm_atomic_state pointer
+ * @crtc: &struct drm_crtc iteration cursor
+ * @crtc_state: &struct drm_crtc_state iteration cursor
+ * @__i: int iteration cursor, for macro-internal use
+ *
+ * This iterates over all CRTCs in an atomic update. Note that before the
+ * software state is committed (by calling drm_atomic_helper_swap_state(), this
+ * points to the new state, while afterwards it points to the old state. Due to
+ * this tricky confusion this macro is deprecated.
+ *
+ * FIXME:
+ *
+ * Replace all usage of this with one of the explicit iterators below and then
+ * remove this macro.
+ */
+#define for_each_crtc_in_state(__state, crtc, crtc_state, __i)	\
+	for ((__i) = 0;						\
+	     ((__i) < ((__state)->dev->mode_config.num_crtc)) &&	\
+	     ((crtc) = ((__state)->crtcs[__i].ptr),			\
+	     (crtc_state) = ((__state)->crtcs[__i].state), 1);	\
+	     (__i)++)						\
+		for_each_if(crtc_state)
+
+/**
  * for_each_oldnew_crtc_in_state - iterate over all CRTCs in an atomic update
  * @__state: &struct drm_atomic_state pointer
  * @crtc: &struct drm_crtc iteration cursor
-- 
2.7.4

