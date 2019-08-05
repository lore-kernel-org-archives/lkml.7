Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8B4C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B303220B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B2Lhpbtr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbfHEPdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:33:37 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40496 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729337AbfHEPdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:33:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id m8so46061969lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 08:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MdJeprxlisYG8Xt385Sz+mmujOJvqAOkUH6DNb4w/D8=;
        b=B2Lhpbtr1RQ+61200Fmk9bx9MyVKDvEMyZ7/Sucu6j8pxDoI6avpjSje0laQDjRMYV
         VF1coVJgpdXAY89hZ2klNoOHN5jbuSkKkEmziApzwKR9b0+4dGSYq+0pML4qwwRoUkeZ
         cQAC6UiilaOZXiDSN8vOKYohnFIEwxtIr8QoKrzI/QGeD0IDaiDyhjah1Bch2ZDfLW/B
         tzhY0eJNcGYZFAD2KDbPILqRB7p2tkqIWuIhpwgCn16/EarR3t/SwJoTY01wVUePos+h
         1gX+EYq+wSM41n4sorJgO18a39v/T/lkZscOxu1KTm6dHMly2jmTSyg21btav+M/Gj+I
         TfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MdJeprxlisYG8Xt385Sz+mmujOJvqAOkUH6DNb4w/D8=;
        b=go+NLJBR7xIL7O9hR7aHSKX5af0QBUbPoqgiYjwN+6jURd/jcLURfPwYcAJRP+dnL8
         mjZVUHXqUx4cdeiShJ2l3Qj4bZkseOKSOGFWlCOcyTOAULPLZfEdgKjkjSpRdBBteJQE
         6oTknPUEfvP/u+GyfNC/gyV/B34NnN/+kBmInpVmmI8PQUyz+Cby4Z0++XFC42fCyDSE
         7D1ALUGQVLMQa7LTslXpjo0gZFw7u00iGOBFGK+6nTCjhO+SKruKpJFuZX4u/oLSyh/2
         yWQ2ZOe7EJRADjtlziOozP25CbaB/tx/xjYbWnnqhgzcuR8dTUnsN2GkgyLCqY5NV2Lp
         DmLw==
X-Gm-Message-State: APjAAAWuGUOosL6ndIrMWo9t35y2fkZ63yR4SbPfVa6Y48UwfGh9Kqne
        l1DVlkFAkNADpn82GNJB1FLnlw==
X-Google-Smtp-Source: APXvYqztjooZSce4zqpF9/gHXvgtQ0+44a+NSVLzEfRyM2p2N1elaBB8l4bVhR8hOcA4WY6jJHvlGw==
X-Received: by 2002:a2e:534a:: with SMTP id t10mr39316085ljd.109.1565019215224;
        Mon, 05 Aug 2019 08:33:35 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a15sm14969312lfl.44.2019.08.05.08.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Aug 2019 08:33:34 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org
Cc:     vincent.guittot@linaro.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, dianders@chromium.org,
        seansw@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH] interconnect: Add pre_aggregate() callback
Date:   Mon,  5 Aug 2019 18:33:32 +0300
Message-Id: <20190805153332.10047-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <752aca6f-4f69-301d-81ef-ff29bc25b614@linaro.org>
References: <752aca6f-4f69-301d-81ef-ff29bc25b614@linaro.org>
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
index 4ee19fd41568..fd42bd19302d 100644
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
+	int (*pre_aggregate)(struct icc_node *node);
 	struct icc_node* (*xlate)(struct of_phandle_args *spec, void *data);
 	struct device		*dev;
 	int			users;
