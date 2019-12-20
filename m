Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76DEC2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF8220716
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 16:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Opyl8zrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfLTQiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 11:38:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39162 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfLTQiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 11:38:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id 20so9756146wmj.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 08:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kvxa0Xnr9nkcLaOalM1HckZFWjf459g2PFBnyA+1Iv4=;
        b=Opyl8zrWxfG0T2eYgPBCYlAFhLgCFaTHdUTXn2LxdfuGNDC2GdzYXG1yF19O38Us6K
         1AsYjkhAk42CChTlLYqNfHgAu+vSGaZm0yPEMw66FdJ2Yz0PmpKEAS0U5+gwOogm8goU
         gPyZz+CLK0axB1A5WOPgA4tUa9IVt+ZxzhvvPKdxDGaiCUUMTl92dldhdPb79bYd+Q2R
         ZjECpnvcx+cGrskEDW5EZ3HGjA7Do9m7fGzKCc8bL1CUgXZg5I61E14M3pAyNWlObYjj
         4GQbyEq8NZBsuetsHAzqEVKR1RS4z8kEJ1rgAeZ+wI4ac6Gy4QXgGGrQ1aooDe55ympf
         Wn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kvxa0Xnr9nkcLaOalM1HckZFWjf459g2PFBnyA+1Iv4=;
        b=LtPwDbhqXg6jbQdr2sRbSuxY+upmalTffKSMf1kz1AmCRSc51Z4qWOxGJVm12PSE5f
         zzQ+dfDRoDDJKYdZ7yLaUgaoDrPNi1C84U5MYaiFlZO7vloJSG0fjy2/FgXGBsUzP78n
         hfzYoJuuaPxQdjiTrZ4mrHv5swCp9qNUCszjgB0RTAwS2+Dj2iqXHh5J0eQpQnQLaWpd
         QJZMeSqEnb816Nsx5xEdXYRzuaUYopaapaghUfDkkBGWKksWkV3zTzBKPyeZWETw30jr
         NU5OabkxgHY+fwWloBHPzMiovEyTRPTbrjqZHtnJe6nrXZTpmcYqJy+E1gPE7maiE6qE
         p9qg==
X-Gm-Message-State: APjAAAWhu1sTHxfCzR/YKTmSZ9TpG7zz4wKBSghLwkmukGvHZHwSdltp
        1yA9vcMQGV39wS4hw+QXiHgg0A==
X-Google-Smtp-Source: APXvYqxjax6hqfjHaodsvksvLvuP0wGDpdHU8lOPkcx5J9+yf6G8YILWdnEjGCWoHy1btGBX/sLMSw==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr18453304wmc.78.1576859929814;
        Fri, 20 Dec 2019 08:38:49 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id g23sm10225807wmk.14.2019.12.20.08.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Dec 2019 08:38:49 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: Print the tag in the debugfs summary
Date:   Fri, 20 Dec 2019 18:38:46 +0200
Message-Id: <20191220163846.6485-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we can have a tag associated with the path. Add this information
to the interconnect_summary file, as the current information in debugfs
is incomplete.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 1867fad56c0f..ae80fbea5d2d 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -34,7 +34,7 @@ static void icc_summary_show_one(struct seq_file *s, struct icc_node *n)
 	if (!n)
 		return;
 
-	seq_printf(s, "%-30s %12u %12u\n",
+	seq_printf(s, "%-42s %12u %12u\n",
 		   n->name, n->avg_bw, n->peak_bw);
 }
 
@@ -42,8 +42,8 @@ static int icc_summary_show(struct seq_file *s, void *data)
 {
 	struct icc_provider *provider;
 
-	seq_puts(s, " node                                   avg         peak\n");
-	seq_puts(s, "--------------------------------------------------------\n");
+	seq_puts(s, " node                                  tag          avg         peak\n");
+	seq_puts(s, "--------------------------------------------------------------------\n");
 
 	mutex_lock(&icc_lock);
 
@@ -58,8 +58,8 @@ static int icc_summary_show(struct seq_file *s, void *data)
 				if (!r->dev)
 					continue;
 
-				seq_printf(s, "    %-26s %12u %12u\n",
-					   dev_name(r->dev), r->avg_bw,
+				seq_printf(s, "  %-27s %12u %12u %12u\n",
+					   dev_name(r->dev), r->tag, r->avg_bw,
 					   r->peak_bw);
 			}
 		}
