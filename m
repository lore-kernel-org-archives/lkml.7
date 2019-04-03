Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56074C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20ED521872
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=in.bosch.com header.i=@in.bosch.com header.b="C6U+4ig9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfDCNZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:25:48 -0400
Received: from de-deferred2.bosch-org.com ([139.15.180.217]:46226 "EHLO
        de-deferred2.bosch-org.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbfDCNZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:25:42 -0400
X-Greylist: delayed 590 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Apr 2019 09:25:39 EDT
Received: from de-out1.bosch-org.com (unknown [139.15.180.215])
        by fe0vms0193.rbdmz01.com (Postfix) with ESMTPS id 44Z65l3CvMz1rb;
        Wed,  3 Apr 2019 15:15:55 +0200 (CEST)
Received: from fe0vm1650.rbesz01.com (unknown [139.15.230.188])
        by si0vms0216.rbdmz01.com (Postfix) with ESMTPS id 44Z65j5SmHz1XLG78;
        Wed,  3 Apr 2019 15:15:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=in.bosch.com;
        s=2015-01-21; t=1554297353;
        bh=5JmXTCA8402bhLcSZ4Bm03a+Df0e1eFcN7hmyjl8vSI=; l=10;
        h=From:From:Reply-To:Sender;
        b=C6U+4ig9Ag3M8aIOEaX8p3mPVvZt9bLkdnmEFGOnF9EjeUrHyxLS9SQA0slyp4a6t
         jM82o2sm5jjQiozHRP4jes9xwHYTf9BXozVKeig1Jy6E92CYlSdBM9AujaCX++RU/t
         Mbzm9oi8Qh+5QE84Dxar9m9PacWtOvT+wpgw9LFU=
Received: from fe0vm1741.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1650.rbesz01.com (Postfix) with ESMTPS id 44Z65j53Jjz1Ct;
        Wed,  3 Apr 2019 15:15:53 +0200 (CEST)
X-AuditID: 0a3aad15-c71ff70000001b94-1a-5ca4b209b20b
Received: from fe0vm1652.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm1741.rbesz01.com (SMG Outbound) with SMTP id 91.A7.07060.902B4AC5; Wed,  3 Apr 2019 15:15:53 +0200 (CEST)
Received: from SI-HUB2000.de.bosch.com (si-hub2000.de.bosch.com [10.4.103.108])
        by fe0vm1652.rbesz01.com (Postfix) with ESMTPS id 44Z65j3gKvzVv7;
        Wed,  3 Apr 2019 15:15:53 +0200 (CEST)
Received: from localhost.localdomain (10.47.103.88) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Wed, 3 Apr 2019
 15:15:51 +0200
From:   <VenkataRajesh.Kalakodima@in.bosch.com>
To:     <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC:     kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>,
        Harsha M M <harsha.manjulamallikarjun@in.bosch.com>
Subject: [PATCH 4/8] drm: rcar-du: Refactor the code with new functions
Date:   Wed, 3 Apr 2019 18:44:40 +0530
Message-ID: <1554297284-14009-5-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
References: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.103.88]
X-Brightmail-Tracker: H4sIAAAAAAAAA21Sa0xTZxjmO71wWjnzcCjzXQXmTjBLzOioq9KI8fbDGX4ocZEtpiiHcaAN
        bSE9bQN4SZfIDGCVWDUbYmGmghqm0A2sKMganeUSN4VFIUQdwyjEotycJDN6DgXbH/v3fs/l
        e77vyYuLqEvRStxgtrIWM2OkpXKxfN3PiSkyr0eXOn55pbbu5h2JdmD2hVQ7eeShRNvfXivV
        to5NYJsk2x5V3ca2TXuTMrHd8vV5rNFgZy2fb8iR6385Xi4pHlla8vL3QZED3SIqEY4DqYHO
        8zmVSIZT5A8YVJaLKpGcn68j+Oc/BxY6PEfQ/OuoVFBJyRS40dISLRAK8gKCqokrmECIyP3g
        dHmihTmO/BI6W/+dx8VkMrh6ZuZngtwFrSNN8xogk2DwToVImGVkFtQFQgEUr6l7PSUJ6WOh
        +8dRceh+gN+ePROFXr0Crv4krUZkTYSqJkJVj7CLKD6fTbWb1GkatcqSy3JlqWrVt0UmLwq1
        Ge9DL8fy/YjEER1DuE55dJSEsXOlJj9ag2N0PLH2IA99kFuUV6pnOP1ei83IcrSSSPgzQ0fF
        vYc5W67JwHGGIrMfAS6iFUTfsXodReQxpWWspShk86PluJheRhTgO3QUWcBY2UKWLWYti2w6
        jtNAKFr4wFgLW8CW5BuM1kWaTiRQVFQU9WEkExmL4TI/+gKP4bMx4QqCK2ZMnKFgwf5RyE4t
        omFrD0pTLiMyBQ8psHqb+X2qMoGIeuLWUfERRNg5jh4gvrc44s1l3hzDL2o4D4jlQkWxC2DY
        tNrDe8gmCQSaS2HssAOB2zeL4Oa1UxJ4NNgmg4GKtiXQNO2kwHXyqQK8PXMJMNHm/RhGhh2f
        gK/WTYO7/RYNd4/20+C717sSAo+n1TB391Ia/H1tKB0mpwY2wPSF9o0w3BLcCAMu32aYCc5t
        5lfWnQE1zqfb4cREcAec7Ti7E44GDmdB90yDDo4732SDd/JQDvQ97GLG+S4xvkutrU7o0spY
        /6fLBTT8OaUDHeiocL4lTAc3/VVYXfj4nOJF8u2s/G/2XByqrb7yZGirJrivK3F4/ZY/gp3Z
        p+mq5Krxeo9CZWg2vhWvKinO7k83lwS/03xdNvtqqkFlf92bdLV5r/Wzr4x+3+q+6N33s9Ia
        PSpVh6a8MdCtsduYdWfM91wnRo9M7vk+09lbP+b+lBZzeka9SmThmHcOimVFQQQAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>

   - Introduce new functions for queueing clu and lut events.
   - Functionality remains same, only some code is moved to
     new functions.

Signed-off-by: Harsha M M <harsha.manjulamallikarjun@in.bosch.com>

      - Resolved checkpatch errors
      - Resolved merge conflicts according to latest version

Signed-off-by: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>
---
 drivers/gpu/drm/rcar-du/rcar_du_cmm.c | 38 +++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_du_cmm.c b/drivers/gpu/drm/rcar-du/rcar_du_cmm.c
index d380dd9..7983039 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_cmm.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_cmm.c
@@ -246,6 +246,44 @@ static void du_cmm_clk(struct rcar_du_cmm *du_cmm, bool on)
 		clk_disable_unprepare(du_cmm->clock);
 }
 
+static void rcar_du_cmm_queue_lut_update(struct rcar_du_cmm_pending_event *p)
+{
+	mutex_lock(&cmm_event_lock);
+
+	list_add_tail(&p->link, &p->du_cmm->lut.list);
+
+	if (p->fpriv)
+		list_add_tail(&p->fpriv_link, &p->fpriv->list);
+
+	event_prev_cancel_locked(&p->du_cmm->lut);
+
+	if (p->du_cmm->direct)
+		queue_work(p->du_cmm->workqueue, &p->du_cmm->work);
+
+	mutex_unlock(&cmm_event_lock);
+
+	drm_crtc_vblank_get(&p->du_cmm->rcrtc->crtc);
+}
+
+static void rcar_du_cmm_queue_clu_update(struct rcar_du_cmm_pending_event *p)
+{
+	mutex_lock(&cmm_event_lock);
+
+	list_add_tail(&p->link, &p->du_cmm->clu.list);
+
+	if (p->fpriv)
+		list_add_tail(&p->fpriv_link, &p->fpriv->list);
+
+	event_prev_cancel_locked(&p->du_cmm->clu);
+
+	if (p->du_cmm->direct)
+		queue_work(p->du_cmm->workqueue, &p->du_cmm->work);
+
+	mutex_unlock(&cmm_event_lock);
+
+	drm_crtc_vblank_get(&p->du_cmm->rcrtc->crtc);
+}
+
 int rcar_du_cmm_start_stop(struct rcar_du_crtc *rcrtc, bool on)
 {
 	struct rcar_du_cmm *du_cmm = rcrtc->cmm_handle;
-- 
2.7.4

