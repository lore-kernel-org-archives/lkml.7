Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1214C43141
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797872073F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 08:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a0QKsNgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfKZIMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 03:12:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41919 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfKZIMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 03:12:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id t8so7714269plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 00:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVaWy603oUgN7+ym76FRzfbBXkNuYdOb34CAh09at2g=;
        b=a0QKsNgAc0xhS1/HHSJku1+HZeTfFPMvtF2f6lL5szloz0xAIxkqqEILxPghyrnmpE
         bPfJg604nTsvXgVrhbRcbvQP7F+Z9/Z61dIxwUWfL2UF7ZUpgbT+RjoGfVS2WWs/Fdy6
         Qcf9dLC8DvMmc7idmOKs5mazZZDzwnfJf5K34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DVaWy603oUgN7+ym76FRzfbBXkNuYdOb34CAh09at2g=;
        b=faQFU2aAaqkf849I22YszyW9AsRPwo5nkn8bA6ykzgk08IL74jQt1VP/EdlCyPhxbL
         mbNH42uJ4Z9h2px08J+DOHGpQGhPqge0LPSkN6NPTglA/rCsDC6xhHo/QT1EuoZ/vekm
         QsOzEkk8WQP+ROAeu8AgdVZdkRNE8MHWQtaDtYIWTnegAJ0X9sAC1/rOUlAFsi/cnd5c
         zStKp+GOGzwgDyfNBrMKSW+k98bowJD/KIsMknsb+U7LozMXhFCg/dicxrQWpkhXfrS0
         7UHBegaKOKVtF3w+IcANZiZQGpYgNiJVHaJQjRz234uKqGmfGI9yB/FbuagTQ3NY4EXk
         8Q6A==
X-Gm-Message-State: APjAAAWrLlZIoyKLTdMfPFY6yaJ8RuGTyewli/6OnZkJ9440QO11obU/
        iNy1HZtFAcH4a6/4VZ+fimwFng==
X-Google-Smtp-Source: APXvYqzlUZ+9C7m7m5CpGUh162E018hPpl0WMdqaQkDUtVNy6LA8Zmg7oNWA8oecjNRNy+qUNu4sNA==
X-Received: by 2002:a17:90a:d152:: with SMTP id t18mr5073904pjw.119.1574755949910;
        Tue, 26 Nov 2019 00:12:29 -0800 (PST)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:93d9:de4d:e834:3086])
        by smtp.gmail.com with ESMTPSA id z23sm11061487pgj.43.2019.11.26.00.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 00:12:29 -0800 (PST)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH] media: videobuf2-core: fix dprintk level
Date:   Tue, 26 Nov 2019 17:12:17 +0900
Message-Id: <20191126081217.197762-1-acourbot@chromium.org>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This dprintk is supposed to be informational, not an error. Set it to
the same level as the other messages related to memory allocations so
the kernel log does not get filled by messages during normal operation.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 4489744fbbd9..f53f77c62afc 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -393,7 +393,7 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
 		}
 	}
 
-	dprintk(1, "allocated %d buffers, %d plane(s) each\n",
+	dprintk(3, "allocated %d buffers, %d plane(s) each\n",
 			buffer, num_planes);
 
 	return buffer;
-- 
2.24.0.432.g9d3f5f5b63-goog

