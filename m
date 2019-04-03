Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBFCC10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2252084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=in.bosch.com header.i=@in.bosch.com header.b="M2jU7Og1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfDCN0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:26:03 -0400
Received: from de-deferred1.bosch-org.com ([139.15.180.216]:41966 "EHLO
        de-deferred1.bosch-org.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726396AbfDCNZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:25:46 -0400
Received: from de-out1.bosch-org.com (unknown [139.15.180.215])
        by si0vms0224.rbdmz01.com (Postfix) with ESMTPS id 44Z65n1lNKz2Ds;
        Wed,  3 Apr 2019 15:15:57 +0200 (CEST)
Received: from fe0vm1650.rbesz01.com (unknown [139.15.230.188])
        by si0vms0216.rbdmz01.com (Postfix) with ESMTPS id 44Z65l46hPz1XLG70;
        Wed,  3 Apr 2019 15:15:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=in.bosch.com;
        s=2015-01-21; t=1554297355;
        bh=5JmXTCA8402bhLcSZ4Bm03a+Df0e1eFcN7hmyjl8vSI=; l=10;
        h=From:From:Reply-To:Sender;
        b=M2jU7Og1ZG8Gdo5PJ/y7h07M7tj3Rlvhi92DMIejYLlRT63V2aryyraRz11473yCg
         5PG9nf7n+zm5uOtZU4pFqCI5J25T2KtP60g3t9MTGEiIRgXHKBW3M9ZBRWBsCtV722
         RbbTnH5zK0iP+pVbiySB7o6cT+ZsmSeSLwQzLX/w=
Received: from si0vm4642.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1650.rbesz01.com (Postfix) with ESMTPS id 44Z65l3pzdz1Cj;
        Wed,  3 Apr 2019 15:15:55 +0200 (CEST)
X-AuditID: 0a3aad12-be3ff70000006e39-60-5ca4b20b87e7
Received: from fe0vm1652.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by si0vm4642.rbesz01.com (SMG Outbound) with SMTP id E5.3D.28217.B02B4AC5; Wed,  3 Apr 2019 15:15:55 +0200 (CEST)
Received: from SI-HUB2000.de.bosch.com (si-hub2000.de.bosch.com [10.4.103.108])
        by fe0vm1652.rbesz01.com (Postfix) with ESMTPS id 44Z65l29NyzVv5;
        Wed,  3 Apr 2019 15:15:55 +0200 (CEST)
Received: from localhost.localdomain (10.47.103.88) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Wed, 3 Apr 2019
 15:15:53 +0200
From:   <VenkataRajesh.Kalakodima@in.bosch.com>
To:     <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC:     kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>,
        Harsha M M <harsha.manjulamallikarjun@in.bosch.com>
Subject: [PATCH 5/8] drm: rcar-du: Implement interfaces to set clu and lut using drm data structures
Date:   Wed, 3 Apr 2019 18:44:41 +0530
Message-ID: <1554297284-14009-6-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
References: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.103.88]
X-Brightmail-Tracker: H4sIAAAAAAAAA21SbUwTZxzvc3dtj9Ibx0Hhv4Jku5moMzhERjpnzJLtg9tiJEs0hnRZD3vS
        ur6wXsuE+ULcFlmhKHHZZqdUBBNngElhKkwlNDpXJQzrhjZBS5GRwhasbGbMaPRuBdsP+/Y8
        v9fnfjkSZ/qVWtJsc/IOG2dhFSpCtbZzSWG6v11fdPki6HyXhuW6Xx/cU+juN96R6270H1Ho
        fpiexd6Qb4g0XME2/OUvKMPKVeuMvMVczTteWW9QmRoueImq6Y07IxemsDo0td6N0kigS+DI
        L5cJN1KRDP0NBpG503jich7B5MgQlrj8iaBn/HO5ZFHQhTDQ3a2UiGz6OwQNs2cxicDpXeA5
        1K6Uzlm0EfyN58VckiTopRCa3SjBFL0ZJs48ViSqCyA8/AUundPoLeD7efI/nBE1vvk5eUKf
        CcHDk0QiHmAwFsOlSKBfgL5WxUFEe1NU3hTVMYSdQhrBXFRtLSktKV7lqOCF2qLVq7bZrX6U
        mJM5h7pHtwcQTSJWTV0/3K5n5Fy1UGMNoFdJjNVQpXtE6LkKu7HGxAmmDxwuCy+wWip/5B09
        k/UMFlwVVrMgmO22AAISZ7OpoQPH9Axl5GpqeYc9YQugPJJgc6lKcpOeoSs5J/8hz1fxjkX2
        dZJkgcruFgszHXwlv3O72eJcpNklFJLJZExOKpNai5FpAbSGVIvdmBRBCVWcVTBXLtifT9iZ
        RTRpvYreJAf/iR7FGcJmt/HaXKpM8tOS0uSyPXuBNp+S/d6iZzQpRDJlBt1E4oZZ1OPvRbNa
        /GuT3UDlSXNlLoBJU3Gb6KHj2dAzsQWCY7then8dAu/1FgQt5x4geOT/FIMvI1EM4rGf5HB/
        sF4Bsc+uKiDU71VCJHwmDToiB9RwY+ahGuInPRT0zlyhwHdrnoLY/L4MaJm/mQH/eo5mQl8w
        xMCTtqBGlAxpoLkrpIGBr8MacHvuaKCprSkHet1dOeD9Y18ufHVqIhfGGm/lwdhIKH9GnBUT
        Z9W5fNKsTs75P7MuoMlv09aht47PfRvbvPbi1mjBu8teNDwcd+lal1bv7agKD/dG40rD3a35
        60aNhrsrrpWX3espdaf3lIfff+30o7/r9wY7Px612vp+/OQl1a6PNvVFdwh4K9l0Qra7uXm8
        sKPj7YFOg2UyIx6OCqb3hoj9x9NH6j3LbtcOT+05WFbctfzQb232lTaWEEzc6pdxh8A9BZg+
        VqFNBAAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>

Impelement interfaces in cmm to set clu and lut tables using standard
drm data structures as input.

Signed-off-by: Harsha M M <harsha.manjulamallikarjun@in.bosch.com>

      - Resolved checkpatch errors
      - Resolved merge conflicts according to latest version

Signed-off-by: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_cmm.c  | 256 +++++++++++++++++++++++++++++++--
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h |  11 ++
 2 files changed, 254 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_cmm.c b/drivers/gpu/drm/rcar-du/rcar_du_cmm.c
index 7983039..af4668f 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_cmm.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_cmm.c
@@ -114,6 +114,8 @@ struct rcar_du_cmm_pending_event {
 	struct drm_gem_object *gem_obj;
 	struct rcar_du_cmm *du_cmm;
 	struct rcar_du_cmm_file_priv *fpriv;
+	unsigned int *lut_buf;
+	unsigned int *clu_buf;
 };
 
 struct cmm_module_t {
@@ -238,14 +240,6 @@ static long long diff_timevals(struct timeval *start, struct timeval *end)
 }
 #endif
 
-static void du_cmm_clk(struct rcar_du_cmm *du_cmm, bool on)
-{
-	if (on)
-		clk_prepare_enable(du_cmm->clock);
-	else
-		clk_disable_unprepare(du_cmm->clock);
-}
-
 static void rcar_du_cmm_queue_lut_update(struct rcar_du_cmm_pending_event *p)
 {
 	mutex_lock(&cmm_event_lock);
@@ -284,6 +278,223 @@ static void rcar_du_cmm_queue_clu_update(struct rcar_du_cmm_pending_event *p)
 	drm_crtc_vblank_get(&p->du_cmm->rcrtc->crtc);
 }
 
+static s64 rcar_du_cmm_multiply_coeff(unsigned int color, s64 coeff)
+{
+	s64 r_val;
+	bool is_neg = false;
+
+	if (coeff & BIT_ULL(63)) {
+		is_neg = true;
+		coeff &= ~BIT_ULL(63);
+	}
+
+	r_val = DIV_ROUND_CLOSEST(((s64)(color * coeff)), BIT_ULL(32));
+
+	if (is_neg)
+		return -r_val;
+
+	return r_val;
+}
+
+static unsigned int rcar_du_cmm_scalar_product(unsigned int r, unsigned int g,
+					       unsigned int b, s64 coeff1,
+					       s64 coeff2, s64 coeff3)
+{
+	s64 product;
+
+	product = rcar_du_cmm_multiply_coeff(r, coeff1)
+			+ rcar_du_cmm_multiply_coeff(g, coeff2)
+			+ rcar_du_cmm_multiply_coeff(b, coeff3);
+
+	return (unsigned int)clamp_val(product, 0, U8_MAX);
+}
+
+#ifdef DEBUG_PROCE_TIME
+static long long diff_timevals(struct timeval *start, struct timeval *end)
+{
+	return (end->tv_sec * 1000000LL + end->tv_usec) -
+		(start->tv_sec * 1000000LL + start->tv_usec);
+}
+#endif
+
+void *rcar_du_cmm_alloc_lut(void *cmm_handle)
+{
+	struct rcar_du_cmm_pending_event *p;
+
+	if (!cmm_handle)
+		return NULL;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return NULL;
+
+	p->gem_obj = NULL;
+	p->event = CMM_EVENT_LUT_DONE;
+	p->stat = QUE_STAT_PENDING;
+	p->callback_data = 0;
+	p->du_cmm = cmm_handle;
+	p->fpriv = NULL;
+	p->lut_buf = kmalloc(CMM_LUT_NUM * 4, GFP_KERNEL);
+	if (!p->lut_buf) {
+		kfree(p);
+		return NULL;
+	}
+
+	return p;
+}
+
+void rcar_du_cmm_free_lut(void *lut_handle)
+{
+	struct rcar_du_cmm_pending_event *p =
+			(struct rcar_du_cmm_pending_event *)lut_handle;
+
+	kfree(p->lut_buf);
+	kfree(p);
+}
+
+int rcar_du_cmm_lut_valid(unsigned int lut_length)
+{
+	return (lut_length == CMM_LUT_NUM) ? 0 : -EINVAL;
+}
+
+void rcar_du_cmm_update_lut_and_free(void *lut_handle,
+				     struct drm_color_lut *lut,
+				     unsigned int lut_length)
+{
+	struct rcar_du_cmm_pending_event *p =
+			(struct rcar_du_cmm_pending_event *)lut_handle;
+	unsigned int color;
+
+	if (!p)
+		return;
+
+	if (rcar_du_cmm_lut_valid(lut_length))
+		return;
+
+	/* Convert drm_color_lut to the format handled by hardware */
+	for (color = 0; color < lut_length; color++) {
+		p->lut_buf[color] = 0;
+		p->lut_buf[color] |= drm_color_lut_extract(lut[color].red, 8)
+					<< 16;
+		p->lut_buf[color] |= drm_color_lut_extract(lut[color].green, 8)
+					<< 8;
+		p->lut_buf[color] |= drm_color_lut_extract(lut[color].blue, 8);
+	}
+	rcar_du_cmm_queue_lut_update(p);
+}
+
+void *rcar_du_cmm_alloc_clu(void *cmm_handle)
+{
+	struct rcar_du_cmm_pending_event *p;
+
+	if (!cmm_handle)
+		return NULL;
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return NULL;
+
+	p->gem_obj = NULL;
+	p->event = CMM_EVENT_CLU_DONE;
+	p->stat = QUE_STAT_PENDING;
+	p->callback_data = 0;
+	p->du_cmm = cmm_handle;
+	p->fpriv = NULL;
+	p->clu_buf = kmalloc(CMM_CLU_NUM * 4, GFP_KERNEL);
+	if (!p->clu_buf) {
+		kfree(p);
+		return NULL;
+	}
+
+	return p;
+}
+
+void rcar_du_cmm_free_clu(void *clu_handle)
+{
+	struct rcar_du_cmm_pending_event *p =
+			(struct rcar_du_cmm_pending_event *)clu_handle;
+
+	kfree(p->clu_buf);
+	kfree(p);
+}
+
+void rcar_du_cmm_update_clu_and_free(void *clu_handle,
+				     struct drm_color_ctm *ctm)
+{
+	struct rcar_du_cmm_pending_event *p =
+			(struct rcar_du_cmm_pending_event *)clu_handle;
+	unsigned int r_loop;
+	unsigned int g_loop;
+	unsigned int b_loop;
+	unsigned int step_size;
+	unsigned int step_fraction;
+	unsigned int clu_index = 0;
+
+	if (!p)
+		return;
+
+	step_size = U8_MAX / (CMM_CLU_SAMPLES - 1);
+	step_fraction = U8_MAX % (CMM_CLU_SAMPLES - 1);
+
+	/*Update clu table*/
+	for (b_loop = 0; b_loop < CMM_CLU_SAMPLES; b_loop++) {
+		unsigned int b;
+
+		b = (b_loop * step_size) +
+		    DIV_ROUND_CLOSEST((b_loop * step_fraction),
+				      (CMM_CLU_SAMPLES - 1));
+
+		for (g_loop = 0; g_loop < CMM_CLU_SAMPLES; g_loop++) {
+			unsigned int g;
+
+			g = (g_loop * step_size) +
+			    DIV_ROUND_CLOSEST((g_loop * step_fraction),
+					      (CMM_CLU_SAMPLES - 1));
+
+			for (r_loop = 0; r_loop < CMM_CLU_SAMPLES; r_loop++) {
+				unsigned int r;
+				unsigned int r_val;
+				unsigned int g_val;
+				unsigned int b_val;
+
+				r = (r_loop * step_size) +
+				    DIV_ROUND_CLOSEST((r_loop * step_fraction),
+						      (CMM_CLU_SAMPLES - 1));
+
+				p->clu_buf[clu_index] = 0;
+
+				r_val =	rcar_du_cmm_scalar_product
+						(r, g, b,
+						 ctm->matrix[0], ctm->matrix[1],
+						 ctm->matrix[2]);
+
+				g_val =	rcar_du_cmm_scalar_product
+						(r, g, b,
+						 ctm->matrix[3], ctm->matrix[4],
+						 ctm->matrix[5]);
+
+				b_val =	rcar_du_cmm_scalar_product
+						(r, g, b,
+						 ctm->matrix[6], ctm->matrix[7],
+						 ctm->matrix[8]);
+
+				p->clu_buf[clu_index++] = (r_val << 16) |
+							  (g_val << 8) | b_val;
+			}
+		}
+	}
+
+	rcar_du_cmm_queue_clu_update(p);
+}
+
+static void du_cmm_clk(struct rcar_du_cmm *du_cmm, bool on)
+{
+	if (on)
+		clk_prepare_enable(du_cmm->clock);
+	else
+		clk_disable_unprepare(du_cmm->clock);
+}
+
 int rcar_du_cmm_start_stop(struct rcar_du_crtc *rcrtc, bool on)
 {
 	struct rcar_du_cmm *du_cmm = rcrtc->cmm_handle;
@@ -424,8 +635,16 @@ static inline void _event_done_locked(struct rcar_du_cmm_pending_event *p)
 		list_add_tail(&p->link, cmm_done_list(p->du_cmm, p->fpriv));
 		wake_up_interruptible(&p->fpriv->event_wait);
 	} else {
-		/* link deleted by rcar_du_cmm_postclose */
-		kfree(p);
+		/* link deleted by rcar_du_cmm_postclose
+		 * OR it could also be due to set of ctm and gamma
+		 * properties through drm APIs.
+		 */
+		if (p->event == CMM_EVENT_LUT_DONE)
+			rcar_du_cmm_free_lut(p);
+		else if (p->event == CMM_EVENT_CLU_DONE)
+			rcar_du_cmm_free_clu(p);
+		else
+			kfree(p);
 	}
 }
 
@@ -479,7 +698,8 @@ event_pop_locked(struct cmm_module_t *module)
 
 	p->stat = QUE_STAT_ACTIVE;
 	list_del(&p->link); /* delete from du_cmm->[lut|clu|hgo].list */
-	list_add_tail(&p->link, &p->fpriv->active_list);
+	if (p->fpriv)
+		list_add_tail(&p->link, &p->fpriv->active_list);
 	cmm_vblank_put(p);
 
 	return p;
@@ -605,7 +825,11 @@ static int lut_set(struct rcar_du_cmm *du_cmm,
 		return -EINVAL;
 	}
 
-	lut_buf = gem_to_vaddr(stat->p->gem_obj);
+	if (stat->p->gem_obj)
+		lut_buf = gem_to_vaddr(stat->p->gem_obj);
+	else
+		lut_buf = stat->p->lut_buf;
+
 	for (i = 0; i < CMM_LUT_NUM; i++)
 		rcar_du_cmm_write(du_cmm, lut_base + i * 4, lut_buf[i]);
 
@@ -723,7 +947,11 @@ static int clu_set(struct rcar_du_cmm *du_cmm,
 		return -EINVAL;
 	}
 
-	clu_buf = gem_to_vaddr(stat->p->gem_obj);
+	if (stat->p->gem_obj)
+		clu_buf = gem_to_vaddr(stat->p->gem_obj);
+	else
+		clu_buf = stat->p->clu_buf;
+
 	rcar_du_cmm_write(du_cmm, addr_reg, 0);
 	for (i = 0; i < CMM_CLU_NUM; i++)
 		rcar_du_cmm_write(du_cmm, data_reg, clu_buf[i]);
@@ -1222,6 +1450,8 @@ int rcar_du_cmm_init(struct rcar_du_crtc *rcrtc)
 
 	rcrtc->cmm_handle = du_cmm;
 
+	drm_crtc_enable_color_mgmt(&rcrtc->crtc, 0, true, CMM_LUT_NUM);
+
 	dev_info(rcdu->dev, "DU%d use CMM(%s buffer)\n",
 		 rcrtc->index, du_cmm->dbuf ? "Double" : "Single");
 
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
index 74e0a22..5b85de4 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.h
@@ -115,6 +115,17 @@ void rcar_du_cmm_postclose(struct drm_device *dev, struct drm_file *file_priv);
 int rcar_du_cmm_start_stop(struct rcar_du_crtc *rcrtc, bool on);
 void rcar_du_cmm_kick(struct rcar_du_crtc *rcrtc);
 
+void *rcar_du_cmm_alloc_lut(void *cmm_handle);
+void rcar_du_cmm_free_lut(void *lut_handle);
+int rcar_du_cmm_lut_valid(unsigned int lut_length);
+void rcar_du_cmm_update_lut_and_free(void *lut_handle,
+				     struct drm_color_lut *lut,
+				     unsigned int lut_length);
+
+void *rcar_du_cmm_alloc_clu(void *cmm_handle);
+void rcar_du_cmm_free_clu(void *clu_handle);
+void rcar_du_cmm_update_clu_and_free(void *clu_handle,
+				     struct drm_color_ctm *ctm);
 #ifdef CONFIG_PM_SLEEP
 int rcar_du_cmm_pm_suspend(struct rcar_du_crtc *rcrtc);
 int rcar_du_cmm_pm_resume(struct rcar_du_crtc *rcrtc);
-- 
2.7.4

