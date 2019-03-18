Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB01C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 01:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A48320857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 01:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJNmu8kW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbfCRBQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 21:16:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39843 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfCRBQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 21:16:46 -0400
Received: by mail-qt1-f196.google.com with SMTP id t28so16185927qte.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 18:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MYBHbQHfnFsRrMTGM8lI6msXpBupamOJkZyRMPepkCM=;
        b=hJNmu8kWjYs3IXDvcMpWVK4KaEi1FBMhj/Zo+/J9bzww4teewDKjAeq0bldnSQMw2/
         jima8qSvvC6dikaJQ9ANNj+6+p9EHGOxvDWRtQ3KT8WQAleSX5UMkvTRIkeJqXEGqXp3
         8m+ZKhY2jPfscqIuGRlOPk/PRTb4JNS5jn6PXFkG6O60H83KcERxl+2o/f1IVTZIKjOj
         2UKvDOWEl6mPV6Qglo1roegqegmOnEaDGtOAiOqgBSqiS3wMX5icopyeek7ybOJbtWKb
         UbtuX3gy3wqEfxwznBHBOO5YhIIy3lwiuFarb1CLm4WkgmvpBg4tKYClz8Xqc1zTdo+3
         xY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MYBHbQHfnFsRrMTGM8lI6msXpBupamOJkZyRMPepkCM=;
        b=WlgrHm3vFzqmrtJtvbXmb+D0v7dr2bQeoLOWsvUe+xtOXWpXW3ycTpmNLTmFUXHJB7
         B0z8SFn9OEChz2oQ9/uOj7kCwLJJ3SjsUCMnmkWEjHf5vrRwl7uOsTLbAXpqypFYOn10
         IPlljlZ8yVLAU4+nu6P0NBUekm65APqLJO4Zg7ZnsN6yZWWU9dj/HLXUFntDgNPP8E3v
         GR+usYwJEchaAaQks85laFgQ616eGJQwT/RdDFmaavmdQh7u1w/5ioQqIHRiSwVY67Uh
         z5a5SEVKmDDvw/oyddNkXCLbuOnPN3h6nHuGwjdondGFI3XQYAUXXGwnU/79Bu44oLJe
         yqMA==
X-Gm-Message-State: APjAAAXYTl5UErHB1Zl5Z0r2IsddC+iLRdDW2KjMLgsx3c3ZNX6aCMVE
        BKHhATGRGv+dHpALlV9p7S5gjxuz
X-Google-Smtp-Source: APXvYqyAnLCET531fMbBS8sLQ6yGFxHniw65GzZKlopqyrI2o1R1uA0FassdNMk8/h2SDBJhEIuogg==
X-Received: by 2002:a0c:c58d:: with SMTP id a13mr10902381qvj.175.1552871805286;
        Sun, 17 Mar 2019 18:16:45 -0700 (PDT)
Received: from localhost.localdomain ([190.19.63.64])
        by smtp.gmail.com with ESMTPSA id x29sm5564245qtm.74.2019.03.17.18.16.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 18:16:44 -0700 (PDT)
From:   Ignacio Losiggio <iglosiggio@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Ignacio Losiggio <iglosiggio@gmail.com>,
        Ignacio Losiggio <iglosiggio@dc.uba.ar>
Subject: [PATCH v2 2/2] staging: gdm724x: Do not break expressions
Date:   Sun, 17 Mar 2019 22:15:36 -0300
Message-Id: <20190318011534.7400-2-iglosiggio@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318011534.7400-1-iglosiggio@gmail.com>
References: <20190318011534.7400-1-iglosiggio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the entire expression can be shown in the same line breaking it
makes it more difficult to read.

Signed-off-by: Ignacio Losiggio <iglosiggio@dc.uba.ar>
---
 drivers/staging/gdm724x/gdm_mux.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_mux.c b/drivers/staging/gdm724x/gdm_mux.c
index fa8585ea1572..ca934dc04d82 100644
--- a/drivers/staging/gdm724x/gdm_mux.c
+++ b/drivers/staging/gdm724x/gdm_mux.c
@@ -164,8 +164,7 @@ static int up_to_host(struct mux_rx *r)
 
 		total_len = ALIGN(MUX_HEADER_SIZE + payload_size, 4);
 
-		if (len - packet_size_sum <
-			total_len) {
+		if (len - packet_size_sum < total_len) {
 			pr_err("invalid payload : %d %d %04x\n",
 			       payload_size, len, packet_type);
 			break;
@@ -368,8 +367,8 @@ static int gdm_mux_send(void *priv_dev, void *data, int len, int tty_index,
 	mux_header->packet_type = __cpu_to_le16(packet_type[tty_index]);
 
 	memcpy(t->buf + MUX_HEADER_SIZE, data, len);
-	memset(t->buf + MUX_HEADER_SIZE + len, 0, total_len - MUX_HEADER_SIZE -
-	       len);
+	memset(t->buf + MUX_HEADER_SIZE + len, 0,
+	       total_len - MUX_HEADER_SIZE - len);
 
 	t->len = total_len;
 	t->callback = cb;
-- 
2.21.0

