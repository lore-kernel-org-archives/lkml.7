Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF119C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E0F2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=in.bosch.com header.i=@in.bosch.com header.b="KsSr5mfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfDCNZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:25:42 -0400
Received: from de-deferred2.bosch-org.com ([139.15.180.217]:46288 "EHLO
        de-deferred2.bosch-org.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbfDCNZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:25:41 -0400
Received: from de-out1.bosch-org.com (unknown [139.15.180.215])
        by fe0vms0193.rbdmz01.com (Postfix) with ESMTPS id 44Z65q10h0z2Zt;
        Wed,  3 Apr 2019 15:15:59 +0200 (CEST)
Received: from si0vm1947.rbesz01.com (unknown [139.15.230.188])
        by fe0vms0187.rbdmz01.com (Postfix) with ESMTPS id 44Z65n3R47z1XLDQt;
        Wed,  3 Apr 2019 15:15:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=in.bosch.com;
        s=2015-01-21; t=1554297357;
        bh=5JmXTCA8402bhLcSZ4Bm03a+Df0e1eFcN7hmyjl8vSI=; l=10;
        h=From:From:Reply-To:Sender;
        b=KsSr5mfZkWC84xy343neKHvYjnHU2ZDc0SrPG3doa1ZabNcvuZ6zwN+afLtGaTfO0
         HUCBcfrjmBLT+dMMaxG/+5u37sztMO4g5rJL0x0gT2H/UHLVwTol6W3apedsquw822
         ZH05RnQPtngcH3/QeSgbm/Z/LsbpT3kjj2FElSwk=
Received: from fe0vm7918.rbesz01.com (unknown [10.58.172.176])
        by si0vm1947.rbesz01.com (Postfix) with ESMTPS id 44Z65n2q3fz6CjQSN;
        Wed,  3 Apr 2019 15:15:57 +0200 (CEST)
X-AuditID: 0a3aad10-03fff70000007f88-86-5ca4b20d2a59
Received: from fe0vm1652.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm7918.rbesz01.com (SMG Outbound) with SMTP id C1.BF.32648.D02B4AC5; Wed,  3 Apr 2019 15:15:57 +0200 (CEST)
Received: from SI-HUB2000.de.bosch.com (si-hub2000.de.bosch.com [10.4.103.108])
        by fe0vm1652.rbesz01.com (Postfix) with ESMTPS id 44Z65n0R74zVv1;
        Wed,  3 Apr 2019 15:15:57 +0200 (CEST)
Received: from localhost.localdomain (10.47.103.88) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Wed, 3 Apr 2019
 15:15:55 +0200
From:   <VenkataRajesh.Kalakodima@in.bosch.com>
To:     <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC:     kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>,
        Harsha M M <harsha.manjulamallikarjun@in.bosch.com>
Subject: [PATCH 6/8] drm: rcar-du: Implement atomic_check to check for gamma and ctm properties
Date:   Wed, 3 Apr 2019 18:44:42 +0530
Message-ID: <1554297284-14009-7-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
References: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.103.88]
X-Brightmail-Tracker: H4sIAAAAAAAAA22Sb0xTVxjGObf/bjuOOVwovBZqzA2OZBEHDMfdnyzbPqhZtmkyXRbThd3C
        hXZSSnpbIsyYus2RYakuZkYqaYGx+ScYoHNCcYHQKU7sCKIfwCywISaFMdQBCS4Bd68F2w/7
        9ub5ned9znlyaAXToTHQ1kqn4KjkK1i1Tql79aIxFwfbTHm9D3Vc4Oqwiruz9EDNPfJMqLjb
        vU1q7qeZeepN1a7JY9epXQvBTXuo/brXS4UKa7XgePGNT3SWxSYvqvom82BPw4rKjfrT65GW
        BlIIRwO/oHqkoxlymoL2kRWFDBjyM4I+z6cxMIcgWOdXykBNcqG/q0sjgzRyHsGx+W5KBgpy
        CBpOtmnkOZUUQ4unRS3PSpINkbN3pK00jck+GDtSGEveBOPDXz8N05IPIfDrtDoWvA8Cy/+o
        5BmTFLjROK2MrQcYiEafrgGyGUIt6hOI+BJO+RJONSPqAtKXCXnVtqJX8rltDrMg1ublbyux
        24Io1ibpQaGhsjAiNGKT8URjm4lR8dVijS2MttMUq8cvH5akDWZ7aY2FFy3FDleFILIGnDXy
        jolJfSaLLrPNKopWe2UYAa1g03DkeLOJwaV8Ta3gsMdsYZRJK9kMXE7vNjGknHcKBwShSnCs
        09domgWc1iUFpjiEcuFgmbXCuY5ZI0ZJSUlMeiJJjKVobRi9RCdL2aEOaQUWq3ibaC1fs2+M
        2Zl1NW4dQkWGDPxcp+QhMrW4Kp+lGrJw0n2/idEngLhzFo0jqbdUvCIHJksfNZ4HOFOuKGVN
        jJsKvpc85LwWZurcCBY8Ywj8PUsIlqe+pGB1epYC/93PlTDa69PAwsUlDXhb/TRMjl/WwsNz
        DRguzV7H0H92joHTS0/SoO+rBj0Ehx5nwfyNR0bw915j4Zb3NgvRPk829Ize3ALewboc6Dh5
        LgciPw7mQHRxPgd+H/FvhcblK1sh9GQ0FyYenMmDK981F8DqqfZC6Qa+olmpTEoqk3MF5DKd
        vPN/ylxT468zuNF2pTFzgGwuee/jel/y4cvRqx+8u3Pli8BMRmtZcMO/5v3dd4883/hXraeE
        DhVX7XyMplbv2Rdr9kx1csY/WgcK718am9vtm/7MPKz3uE/s/XsyZUdJtDb6NlX354DG2546
        Gck+dO/9Ld0fcQU/HP3t2qmbM+4db7k6jx/41tp0azCSvpFVihY+/wWFQ+T/A3Fq90ZCBAAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>

    Implement atomic helper check and allocate memory necessary for
    lut and clu tables

Signed-off-by: Harsha M M <harsha.manjulamallikarjun@in.bosch.com>

      - Resolved checkpatch errors
      - Resolved merge conflicts according to latest version
Signed-off-by: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c | 58 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h |  3 +-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index 864fb94..a00b7a7 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -622,6 +622,63 @@ static void rcar_du_crtc_stop(struct rcar_du_crtc *rcrtc)
  * CRTC Functions
  */
 
+static bool rcar_du_crtc_is_ctm_updated(struct drm_crtc *crtc,
+					struct drm_crtc_state *state)
+{
+	return (state->color_mgmt_changed && state->ctm &&
+		crtc->state->ctm &&
+		(crtc->state->ctm->base.id != state->ctm->base.id));
+}
+
+static bool rcar_du_crtc_is_gamma_updated(struct drm_crtc *crtc,
+					  struct drm_crtc_state *state)
+{
+	return (state->color_mgmt_changed && state->gamma_lut &&
+		crtc->state->gamma_lut &&
+		(crtc->state->gamma_lut->base.id != state->gamma_lut->base.id));
+}
+
+static int rcar_du_crtc_cmm_atomic_check(struct drm_crtc *crtc,
+					 struct drm_crtc_state *state)
+{
+	int ret = 0;
+	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
+
+	/*Check gamma update and allocate memory*/
+	if (rcar_du_crtc_is_gamma_updated(crtc, state) &&
+	    !rcrtc->lut_handle) {
+		ret = rcar_du_cmm_lut_valid((crtc->state->gamma_lut->length /
+					     sizeof(struct drm_color_lut)));
+		if (ret >= 0) {
+			rcrtc->lut_handle =
+				rcar_du_cmm_alloc_lut(rcrtc->cmm_handle);
+			if (!rcrtc->lut_handle)
+				ret = -ENOMEM;
+		}
+	}
+
+	/*Check update of ctm and allocate memory*/
+	if (ret >= 0 && rcar_du_crtc_is_ctm_updated(crtc, state) &&
+	    !rcrtc->clu_handle) {
+		rcrtc->clu_handle = rcar_du_cmm_alloc_clu(rcrtc->cmm_handle);
+		if (!rcrtc->clu_handle) {
+			if (!rcrtc->lut_handle) {
+				rcar_du_cmm_free_lut(rcrtc->lut_handle);
+				rcrtc->lut_handle = NULL;
+			}
+			ret = -ENOMEM;
+		}
+	}
+
+	return ret;
+}
+
+static int rcar_du_crtc_atomic_check(struct drm_crtc *crtc,
+				     struct drm_crtc_state *state)
+{
+	return rcar_du_crtc_cmm_atomic_check(crtc, state);
+}
+
 static void rcar_du_crtc_atomic_enable(struct drm_crtc *crtc,
 				       struct drm_crtc_state *old_state)
 {
@@ -708,6 +765,7 @@ static const struct drm_crtc_helper_funcs crtc_helper_funcs = {
 	.atomic_flush = rcar_du_crtc_atomic_flush,
 	.atomic_enable = rcar_du_crtc_atomic_enable,
 	.atomic_disable = rcar_du_crtc_atomic_disable,
+	.atomic_check = rcar_du_crtc_atomic_check,
 };
 
 static struct drm_crtc_state *
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
index 5b85de4..b79080e 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
@@ -70,7 +70,8 @@ struct rcar_du_crtc {
 	int lvds_ch;
 
 	void *cmm_handle;
-
+	void *lut_handle;
+	void *clu_handle;
 };
 
 #define to_rcar_crtc(c)	container_of(c, struct rcar_du_crtc, crtc)
-- 
2.7.4

