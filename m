Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFA5C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B9F218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 06:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="l3fPATFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfCOGbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 02:31:47 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:49654 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbfCOGbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 02:31:46 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 5FF0DCA6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:31:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M_5-XTDxW7Nl for <linux-kernel@vger.kernel.org>;
        Fri, 15 Mar 2019 01:31:45 -0500 (CDT)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 2C328A7E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 01:31:45 -0500 (CDT)
Received: by mail-it1-f199.google.com with SMTP id j127so6895778itj.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 23:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RScIh5HilcI0s6YdRvi01yt2VTjLLnx7lLlGiP4k7Uk=;
        b=l3fPATFAaPxQTxi8y7dBUtMT5IgF4dSZ1HhaH6DbrCbcsZcOWhxAjauFci8BRZfPy8
         tW7A5nqREeqp2Bkez8sG4zBXG2LtbWwAh5lqLvtp91uQRRAreiNMUpyJlaAHu3sXrSdJ
         OQZE4whciBByNO792wHceoLitp5nS1pPPBjVqWwGqIKgRAkvcMlhUQRb9tfT3fPsQu85
         DATdWzSEdjKfxNtUtFjfoASvAZll0uBdNqaapi/lL7FCZaTHP0rWr5u7A0mFa1IXpZej
         odC3+1bGbUCd/P06XsvAnKCdiN9JFI3e6gVcu8yI1l1d2WCpBMnot21Hdr270CH3o9bg
         vi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RScIh5HilcI0s6YdRvi01yt2VTjLLnx7lLlGiP4k7Uk=;
        b=GVWfX9fGssK+soX65pSVebk+8tvlChf7fQ74upJ9j41l0+UQ1Xmc9gW+H1H2rYxyC6
         e1I9mvX3YEKFyM1J9KdQJUg7UqHy6znYqZF9zrkagi+H29Q0IfZk2s1ndwl42/sLf7pf
         OwYfjf2t+fNUkwBgQ8EGEG1Jizv8HXnd68LeLP6NMmNzB1wAfAm8qJZ/4uDDCLG+vx1A
         fsmChhIuRfJJy683Z5+14/lZQxwIkhvHiMcnp/nQza1ns6U6m7MxPeA6ibWClX37+C3T
         uUFFCY11YlT6CLt3L23RCvWS7FoEXcQBM/ehj/+U9ZjoCD2oWC+1GH5iEtcpMig29NpB
         giOw==
X-Gm-Message-State: APjAAAVZ2vr5KK+FOjrfMih3hxPjs9PjMxmDJzNE9Sjy+gC09Lqh0enl
        OW9Z8+IAFbSrjbIbLnkKiAjxzAYSfLhtujUe2CXbb62DruRIZiDUvTxwsvdYcUqVPtDxO9rH7NJ
        xEvRbhAiatcF+53wQDlcJd3GLKLcJ
X-Received: by 2002:a24:f709:: with SMTP id x9mr950050ith.149.1552631504798;
        Thu, 14 Mar 2019 23:31:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyYbfLq/bkTe0v1XFFFT7Rowt+De+mVH+2YC8KzN3mrFj0W/vVX3RUhGEOSjm/mhccB6ImHIA==
X-Received: by 2002:a24:f709:: with SMTP id x9mr950041ith.149.1552631504558;
        Thu, 14 Mar 2019 23:31:44 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id 197sm661341itz.24.2019.03.14.23.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 23:31:43 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: nbd: fix a missing check for nla_nest_start
Date:   Fri, 15 Mar 2019 01:31:38 -0500
Message-Id: <20190315063138.17666-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nla_nest_start may fail and thus deserves a check.

The fix inserts such a check and exits gracefully in case it
fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/block/nbd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 7c9a949e876b..810c8c20b142 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2099,6 +2099,10 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	dev_list = nla_nest_start(reply, NBD_ATTR_DEVICE_LIST);
+	if (!dev_list) {
+		nlmsg_free(reply);
+		goto out;
+	}
 	if (index == -1) {
 		ret = idr_for_each(&nbd_index_idr, &status_cb, reply);
 		if (ret) {
-- 
2.17.1

