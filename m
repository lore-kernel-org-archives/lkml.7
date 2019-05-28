Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38111C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 05:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1164C208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 05:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AadNY3xF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfE1F5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 01:57:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41915 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbfE1F5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 01:57:45 -0400
Received: by mail-pl1-f193.google.com with SMTP id d14so2329139pls.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 22:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GqYVB277WEFaDrjqHl9u9gzan9xp6pYbuiY2CwT3+wA=;
        b=AadNY3xF3iC0+GIj+AEcn/1/ebmF5bRb4x1ra9pHFJ24l47TmWvTXmPE7BrP8SspLO
         SgbojQcgijYA22qNoy/MhFCU4A2X+iyJdfyLFYTbao2CqYB4Ilo+6qs6fee9BcslVD93
         myeKCwSC+QF2PDXzcx/2qaV9jofGKwHdNF+D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GqYVB277WEFaDrjqHl9u9gzan9xp6pYbuiY2CwT3+wA=;
        b=LlHcantl/bJslupbFI/8WTez3+qjsSOd0ddZNbU6mT6UEaTZzGudhgN3vKt0hXcyt6
         DiRgQQLz2+bRjDpKLkd+XhkaaR3oobbxLN+qzxB2Gq/nt8SPdJUzQABCYe47Wmyjr3br
         m6hSPNX/88f2upCdjjQH+Z+oZoaDsGuVPkeUczJbqB9hnJIwRtXhKJICQQSecSz10JMs
         85ELcbhECXMXp+8hODVmzfUtvvWO8AGMQ9u3Ix3z6wYXaeV9dNRf/w3fKkT4jG4SGQ0w
         DO7mxkJHdsJePlYV+aKuvbUSzD0VOvNUq3pKe7DYbV7z3WXEo9qbxsRaRmoK6HJVnJy1
         xzSg==
X-Gm-Message-State: APjAAAWjV4Wrksnj7a2wPZB/yaQawndy28WzTB3Vka9OFGokp4tRq8m4
        AG7/74aEUztRzgF3Qf5l5YfEW5CHN3Y=
X-Google-Smtp-Source: APXvYqxIBAI0HKWcz4VbpCo99CLIBzk+Qjzv17nOkj2dGauUT7BgjmEXMM+WYYbthMzYg7QjlTOctg==
X-Received: by 2002:a17:902:bf08:: with SMTP id bi8mr20531914plb.206.1559023064671;
        Mon, 27 May 2019 22:57:44 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:4:4:9712:8cf1:d0f:7d33])
        by smtp.gmail.com with ESMTPSA id w1sm13950551pfg.51.2019.05.27.22.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 22:57:44 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [RFCv1 12/12] media: mtk-vcodec: enable MT8183 decoder
Date:   Tue, 28 May 2019 14:56:35 +0900
Message-Id: <20190528055635.12109-13-acourbot@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
In-Reply-To: <20190528055635.12109-1-acourbot@chromium.org>
References: <20190528055635.12109-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfei Dong <yunfei.dong@mediatek.com>

Now that all the supporting blocks are present, enable decoder for
MT8183.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Co-developed-by: Alexandre Courbot <acourbot@chromium.org>
Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
[acourbot: refactor, cleanup and split]

Change-Id: I5696b186fae16f12b97745247331732beb1192e2
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
index 8be0c04f7e81..60dd312500a4 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
@@ -401,6 +401,10 @@ static const struct of_device_id mtk_vcodec_match[] = {
 		.compatible = "mediatek,mt8173-vcodec-dec",
 		.data = &mtk_frame_8173_pdata,
 	},
+	{
+		.compatible = "mediatek,mt8183-vcodec-dec",
+		.data = &mtk_req_8183_pdata,
+	},
 	{},
 };
 
-- 
2.22.0.rc1.257.g3120a18244-goog

