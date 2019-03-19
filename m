Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA58EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D3C20872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 01:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="bc9ReCT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfCSBZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 21:25:31 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:50742 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfCSBZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 21:25:30 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4A431B2A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 01:25:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7H91jsLsAKv1 for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 20:25:29 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 1967F9A7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 20:25:29 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id a9so14957860iol.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 18:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=e81gva8RESvZVXCF6/lhVsiNVnyDaMCLqN30BEvMok0=;
        b=bc9ReCT2szDHK/qH+HhSl21bSi4oneKTL8L1Q0f0R2BrC/B0nWlKQWxEJmAdnlAE93
         pvw3aD+uzA37/wDC7wpOC272FjozztyTrBgarhtpJ0i7vkjbgl74jjPbGKhts91Wukq+
         3IvKlPUHN0EYCyxeCM3Z3fdfWEhugxC+rY3WCUj3Z8tD9CtN4W5+Lg+tdo1qWObwxKrQ
         b3WTrvBEjHh9muTostb6wOdVanAdYKLAxNvDNvDFDAP+fexuJqLrRBc8pAKjUrh2rvna
         Qu77UMmP2GObH81CLrOLO70x+eHIvJFwkkg6t756wnNtIFHpHq0m4RFQnDhT475VsQOz
         th2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e81gva8RESvZVXCF6/lhVsiNVnyDaMCLqN30BEvMok0=;
        b=t8hFLI73as/Sa7ixB5Kqsbwm2HmsYUAgNnfigsFBKz7r9ald7SdJC6j+6Uzlr0psog
         FD0JdzwkIlbLTyU7yNPY4ljsS69+QInO0tqxIrbXbpSrqQ145HvW/G7bJRliB5oMZLIe
         Skporoz3aQdGlQLzimqh1IqZudyJpt3sjVZ9g6RKZ5p1nzWQdDlPfUL7qbEbfDSaQDXF
         mKBr5S3w0yWdYVBwcMG6So3Nw8bWETs23/kXJkaGPVUO1oMuAJNG+aAILbUfUC5XlEfC
         le3ipm+EbPeQC/abmoj8IzdhLCSe6cGrM29K9RS0AXjjcQD7Ih2FNvMVAlbGKecBgYth
         va+A==
X-Gm-Message-State: APjAAAWlw/Xb1ZwNGu4tQ9Y7TrrPJyNgGwPG2l+8kvJlkZkdqAgX52JB
        v0WP21BDJQoGWbsytKqtyv7spKMWjPoNxr4RBbDoRL6Kg1xq9Qt2CzTsBUuquP00ssh12zSbxLH
        IslIhzNNYo4IhA95qzjA9zB7l77kb
X-Received: by 2002:a05:660c:88f:: with SMTP id o15mr1145457itk.46.1552958728423;
        Mon, 18 Mar 2019 18:25:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw6gPvP7Bi4ldqqqpa8ypua7Eq4q3LRqj4mYGODFSvLbvHeeNulD1IlJzSppObbLDKy/ivxRg==
X-Received: by 2002:a05:660c:88f:: with SMTP id o15mr1145447itk.46.1552958728240;
        Mon, 18 Mar 2019 18:25:28 -0700 (PDT)
Received: from lenovo-1.hsd1.mn.comcast.net (c-73-242-25-233.hsd1.mn.comcast.net. [73.242.25.233])
        by smtp.googlemail.com with ESMTPSA id g194sm1080038itc.31.2019.03.18.18.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 18:25:27 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] slimbus: ngd: Fix to avoid potential NULL pointer dereference
Date:   Mon, 18 Mar 2019 20:25:23 -0500
Message-Id: <20190319012523.14644-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In of_qcom_slim_ngd_register, of_match_node may fail and return a NULL
pointer. This patch avoids such a scenario leading to NULL pointer
dereference.

Fixes: 458a445deb9c ("slimbus: ngd: Fix build error on x86")
Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 71f094c9ec68..9cc7256028c9 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1332,6 +1332,8 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 	u32 id;
 
 	match = of_match_node(qcom_slim_ngd_dt_match, parent->of_node);
+	if (!match)
+		return -ENXIO;
 	data = match->data;
 	for_each_available_child_of_node(parent->of_node, node) {
 		if (of_property_read_u32(node, "reg", &id))
-- 
2.17.1

