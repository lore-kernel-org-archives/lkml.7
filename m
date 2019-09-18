Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE3AC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85E921920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FqHH+Zoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbfIRRVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:21:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40717 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbfIRRVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:21:22 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so219365pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 10:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4LdTXDWq3Uv3L2zd/NR5TCqm7My244nHQo+ObnVgt58=;
        b=FqHH+Zoiq7lEG9/x/GOxUNp3JykuQnt4TdgW49TajHQUWWepwS/HhcutIkbTc4TJAE
         4AbCZ075/oyErat+7EzcRPMlsw1Tuq9+zLj1jiNvm389RDdDz4BbUTjHMYxbPadBeIZd
         AfR111JYfHvEOUFNCxRc/7NN+KyNPcw+NrlNkitfevmCkybcHhr2WyKWdy+/J5Y1xEmJ
         YXOY/2Fv3axFRAGi7dDcS61Kn2TdKu0obx78TJWYSkFLNgkRUdQTZALdXujWzPCdwZxh
         8gtu1fggCs8ry8ZHBOmL1OBKnHT0DeyHLfNo2xrbWmSNpmpBpNvQAWqNPcCc0rRu1qrO
         xA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4LdTXDWq3Uv3L2zd/NR5TCqm7My244nHQo+ObnVgt58=;
        b=fQx70NjqQJ/bFQlj53HXX7y6hpxqTr4ZzerJqUsJJZNI0I02v8VU2AIA2XYzHRfE0v
         SDX5IjwNl0FlrruydOVelIjySbdb5F/hHQgfI4RlgbmBDfBTPxatLQY0i4y1FZFEbeXk
         vg4/t33G3e/Gnz0RRuxDCWyS7BQNKSgfH2GYsCFLb0lU5/DvOqD1nJbCrJB3F5DfA0/Z
         79QRu2YDcw9zmxonm/VCph8axft5AbFGOQZMKDmhf4pQ4smrzi06iDGSMP8Ly+yBNmTq
         YovZovvxRYvZDwyiLfxrgFqMniArx8vLGkEQRDn4VQ5aTpy78Y65qvaTx7U204hhUznN
         no6A==
X-Gm-Message-State: APjAAAWqygR8NRnVBcF8k5484rI2VGEHNEcIC7tjC6qzJ+j+d4Q+iuFA
        KJ75ePY+3hcPVuczp1aXs0vRY7DPF2E=
X-Google-Smtp-Source: APXvYqwNoFVjaPm3eL6jMcaK8G2c8PabKi7HOM0JHnfEaNT+uqzgU9EB16AZzHifjaoL4rpVj6VvPw==
X-Received: by 2002:a62:ed17:: with SMTP id u23mr5387020pfh.147.1568827281215;
        Wed, 18 Sep 2019 10:21:21 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g5sm6977032pfh.133.2019.09.18.10.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 10:21:20 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] net: qrtr: Stop rx_worker before freeing node
Date:   Wed, 18 Sep 2019 10:21:17 -0700
Message-Id: <20190918172117.4116-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the endpoint is unregistered there might still be work pending to
handle incoming messages, which will result in a use after free
scenario. The plan is to remove the rx_worker, but until then (and for
stable@) ensure that the work is stopped before the node is freed.

Fixes: bdabad3e363d ("net: Add Qualcomm IPC router")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 net/qrtr/qrtr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
index 6c8b0f6d28f9..88f98f27ad88 100644
--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -150,6 +150,7 @@ static void __qrtr_node_release(struct kref *kref)
 	list_del(&node->item);
 	mutex_unlock(&qrtr_node_lock);
 
+	cancel_work_sync(&node->work);
 	skb_queue_purge(&node->rx_queue);
 	kfree(node);
 }
-- 
2.18.0

