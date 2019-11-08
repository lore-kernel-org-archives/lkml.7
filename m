Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D62C17440
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 23:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174DA215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 23:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLXL7KbN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfKHXiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 18:38:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33016 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKHXiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 18:38:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id a17so7677047wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 15:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+UKZTvPDWmsHFC7K6+7vln2Krr8NV+4r5IwFH4/g7iA=;
        b=SLXL7KbNgDVWhIt3g0CLKrweVuiQ2tecOMwO8rpkUBsBovmz2I8ATstZ1uqNx4rblY
         hQigefWrU//HnYrpiiAO22weqURFrH1sh3YkIGX0i9zpUpjydHkHqjojHrTBh0STRuno
         dgr0iglDwlLQZX+EEtmXT/6ros3pGxxWdH2bg/160JXeMLoyUUbyUt02e9D4Gqc63ttv
         zAjf+1AzUXbp/0XeFajdpDl1EzpEYEOjZnS1nxhP3Ra809Q2Inqfl0lZwZ/OFcytivrA
         M8Sv4/5gTCIlA3lYWu6uf8s0orsr3yg4oXP2jEj0Ub5RsJFquHQzYKLyPycTCaME45sf
         tiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+UKZTvPDWmsHFC7K6+7vln2Krr8NV+4r5IwFH4/g7iA=;
        b=IlkNF1ZhThEPIBl4Hf4al8rS2+Z9WakuzuvqyspixQTbci2N3Z9Af3dShDsWA5fWEP
         NjHwYslZ/90UuEWimaBMsd7Di2CHSVwFl2OmLKd4U+kRnLB6cCeImcbP8efJMFdksI+1
         RgKC9wnW9ADPRiJQV9IlZWzPENvOnVu9/6h2NJnYAimVBY/QkswXf4wiswz2fvh7yNii
         +cUPTPKm0XL6kBOoR0RIk1EXxppaejkv3mLvq4JAeEfo1zFJ0D60NPQTLbU/n2XV07Zp
         LVZs+Zz4ok6Bbzd4d5kxyLCSEP/iOi1yFZir1VfKaNrvmYB4xVtrQSyz7UyT+g4PFM8g
         6aTA==
X-Gm-Message-State: APjAAAWGvArBYBA0jZdDDFK9cC0i+gyMIMy6w/t5Cw7UGfCqnzq0zr8P
        vfFmkBEk5n5WAJzAIZbxEw==
X-Google-Smtp-Source: APXvYqzd6juKIlk88s6VVET1mp/VJ/opCbhwxL9kotGmWN5WNnELx+KCZuoqjKq8WrcMme3AAc79qQ==
X-Received: by 2002:a1c:808d:: with SMTP id b135mr9989900wmd.175.1573256328772;
        Fri, 08 Nov 2019 15:38:48 -0800 (PST)
Received: from ninjahub.org.net ([94.119.64.34])
        by smtp.googlemail.com with ESMTPSA id t24sm11852431wra.55.2019.11.08.15.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 15:38:48 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jerome.pouiller@silabs.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, Boqun.Feng@microsoft.com,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH] staging: wfx: add gcc extension __force cast
Date:   Fri,  8 Nov 2019 23:38:37 +0000
Message-Id: <20191108233837.33378-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gcc extension __force and __le32 cast to fix warning issued by Sparse tool."warning: cast to restricted __le32"

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/wfx/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/debug.c b/drivers/staging/wfx/debug.c
index 0a9ca109039c..aa7b2dd691b9 100644
--- a/drivers/staging/wfx/debug.c
+++ b/drivers/staging/wfx/debug.c
@@ -72,7 +72,7 @@ static int wfx_counters_show(struct seq_file *seq, void *v)
 		return -EIO;
 
 #define PUT_COUNTER(name) \
-	seq_printf(seq, "%24s %d\n", #name ":", le32_to_cpu(counters.count_##name))
+	seq_printf(seq, "%24s %d\n", #name ":", le32_to_cpu((__force __le32)(counters.count_##name)))
 
 	PUT_COUNTER(tx_packets);
 	PUT_COUNTER(tx_multicast_frames);
-- 
2.23.0

