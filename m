Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6E2C32753
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5141C205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lOTjuMKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfHMOxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:53:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34261 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729823AbfHMOxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:53:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id x18so5377609ljh.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uM5KDFBP871ZVZqzWYkX79IOsRBnc0vP++SbwrF+Law=;
        b=lOTjuMKuogK2dDNGkv6MO919RAbUY00BlTXLsyO1rzOFS+Apt+WBodqxpT+0086IYG
         SSlBrHz2Tj/86KNmiTs3/KU2GFFjKZ29gE3a8XQxN3QsfDsNOJt4hJvAmu59gKgIgWLR
         TrLphF65L+tx5db9fW1QGc+8ZK1L5gdKv6+807vMgpsbWlzp09xtOMOImOUCVhVuKsoF
         vmZj2Emf2Yx0CuaHO+hYT/n1uikCAMqd1Ob2U/ovXzdU2/5P/HdKm2XWDSLwSQR8J0Zb
         x5NEZyaSBVDmGVFLXSlTj5/DJv37gx41xseNhpFQreufCTvtq/eun22Svt7xiD2LJamY
         PbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uM5KDFBP871ZVZqzWYkX79IOsRBnc0vP++SbwrF+Law=;
        b=jJl3yUCwjaKRIH84nFJ+flRL96wsY7/6cRF4dkG043CJkQhDe/ehDX1+nn1U0bu0YM
         VX+fsWqqiM21UPlsuCyBQseaLMNQtHYQSTZehimBJcTr7zdFrUEJwVJfzPoXm/NUfNIa
         z15q0hT2VCbMylmimvaHEyBr2hlMbqb5r6hPBZ1VwsxH54dU4ZYjEC5D7t4kjhh9GfSD
         ul57m2GfxCpBQy3cupYFXWoEYWYWROXceQ8aQFRpdvmkezrJnuOjrCZOV1+OfYyrLusf
         uXZVf6AHSXWq4hfwO8zUEDNXWdAcAJYvHg/sLznJZ0jhi1ekG1o+Ewuz9b9EnBNEOswA
         6F4w==
X-Gm-Message-State: APjAAAVUihwMej3R/Blu9im53yCIz4jDSRTN0GWMRTE73Gi/L2lXgfP0
        /8Jxc7NBbCm33FSVgB8x3iiK3g==
X-Google-Smtp-Source: APXvYqzkAR8ST/yzHWAfYqK+jlbWYzAkxaU374oYI2vKawAL3JL6BOFTUAj2CBJA1+CV7edQ5A7NVg==
X-Received: by 2002:a2e:12c8:: with SMTP id 69mr21630688ljs.189.1565708029352;
        Tue, 13 Aug 2019 07:53:49 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r68sm19628100lff.52.2019.08.13.07.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 07:53:48 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, evgreen@chromium.org
Cc:     daidavid1@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        dianders@chromium.org, seansw@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v4 2/3] interconnect: Add pre_aggregate() callback
Date:   Tue, 13 Aug 2019 17:53:40 +0300
Message-Id: <20190813145341.28530-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190813145341.28530-1-georgi.djakov@linaro.org>
References: <20190813145341.28530-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce an optional callback in interconnect provider drivers. It can be
used for implementing actions, that need to be executed before the actual
aggregation of the bandwidth requests has started.

The benefit of this for now is that it will significantly simplify the code
in provider drivers.

Suggested-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c           | 3 +++
 include/linux/interconnect-provider.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 251354bb7fdc..7b971228df38 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -205,6 +205,9 @@ static int aggregate_requests(struct icc_node *node)
 	node->avg_bw = 0;
 	node->peak_bw = 0;
 
+	if (p->pre_aggregate)
+		p->pre_aggregate(node);
+
 	hlist_for_each_entry(r, &node->req_list, req_node)
 		p->aggregate(node, r->tag, r->avg_bw, r->peak_bw,
 			     &node->avg_bw, &node->peak_bw);
diff --git a/include/linux/interconnect-provider.h b/include/linux/interconnect-provider.h
index 4ee19fd41568..b16f9effa555 100644
--- a/include/linux/interconnect-provider.h
+++ b/include/linux/interconnect-provider.h
@@ -36,6 +36,8 @@ struct icc_node *of_icc_xlate_onecell(struct of_phandle_args *spec,
  * @nodes: internal list of the interconnect provider nodes
  * @set: pointer to device specific set operation function
  * @aggregate: pointer to device specific aggregate operation function
+ * @pre_aggregate: pointer to device specific function that is called
+ *		   before the aggregation begins (optional)
  * @xlate: provider-specific callback for mapping nodes from phandle arguments
  * @dev: the device this interconnect provider belongs to
  * @users: count of active users
@@ -47,6 +49,7 @@ struct icc_provider {
 	int (*set)(struct icc_node *src, struct icc_node *dst);
 	int (*aggregate)(struct icc_node *node, u32 tag, u32 avg_bw,
 			 u32 peak_bw, u32 *agg_avg, u32 *agg_peak);
+	void (*pre_aggregate)(struct icc_node *node);
 	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
 	struct device		*dev;
 	int			users;
