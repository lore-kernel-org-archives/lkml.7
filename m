Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8EDCA9ECF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E2B821855
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 00:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCR+ereu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfKBAm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 20:42:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35640 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfKBAm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 20:42:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id l10so11201680wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 17:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OebC6aVMcC2jE8zsuehSJZa7VRGYhUzWUik+Vnx7pS0=;
        b=dCR+ereuD8LxHOyd/DrOqk/4Z2UB/vmMo0sE+MIaxM/mXEyDlA6z99rafM+yvWIIvb
         utCF/mHGnwXbD3D2HJrGCzYFRnfTQCPu04oHH22mvdlrXAsXznVSoLE2n40cyu6Eprq2
         6mfG5aLjYHbp5CCPCnreKLYvtUsuRselKHa20RKzWYssSTMd1aTt0Faj/ITpt2rYEOk7
         CczhUgohsEf83N9OYkykkhv1d8jLf7DgUyueJwYurSpAdA/lcVjEsy6QkE4FZW0I3TKA
         DqzKPJMAktIjESZTZ9nHKgSh/h8OqgD7tBezlt5w9hQNsg7ZQz7F4+z04WP4dqaHbKgM
         eBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OebC6aVMcC2jE8zsuehSJZa7VRGYhUzWUik+Vnx7pS0=;
        b=hgRAjLNHrFPKxcoXuCg2QvJTqmVpAlJQ2gZ7kr66yldWzm6oR4JTiUJnk7BaXytnQO
         5WSnvFYCX1asvH0yaxkbYA6WSM3sWj3j51RhV6nWmgIojqeU56ASsmJAhNQFEGQeX9lT
         QYrtkQN1s9pGMsOlnsbfJRK5O7H9iQlg5RYDlpvzbFxQIk4yw5GrP4if0zmkS7E1XJBw
         Qlhd6iV6Ntk3VlI0JymZ66/HEJrB+ew6cbK4RKfoph2YtKSWkV1F30r3NDrNC6b+equ+
         Jo9RvManvVwrHw5dhZezFMyyEjsY9Rar9waoNoa6ljvpQoTXfSXQoT4zl44Wrs0F2Rlg
         opSQ==
X-Gm-Message-State: APjAAAW/VeaHig9gCO4KapaWobbkUss7v+n+io8bmioSr40uPBFYm21A
        ImTZnMLRLotyP6SPvGJ2Mg==
X-Google-Smtp-Source: APXvYqxsPeqTU5bA5Ce+J+KH23f7s/LwxT+2sDzXy6ocZsRTFxy5mYbSwBt9IPd/HRptGG90B4VN3g==
X-Received: by 2002:adf:e944:: with SMTP id m4mr13514286wrn.49.1572655343846;
        Fri, 01 Nov 2019 17:42:23 -0700 (PDT)
Received: from ninjahub.lan (79-73-36-243.dynamic.dsl.as9105.com. [79.73.36.243])
        by smtp.googlemail.com with ESMTPSA id d202sm8667642wmd.47.2019.11.01.17.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 17:42:23 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     julia.lawall@lip6.fr, gregkh@linuxfoundation.org,
        m.tretter@pengutronix.de, linux-kernel@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH] staging: allegreo-dvt: fix warning of comparison of 0/1 to bool
Date:   Sat,  2 Nov 2019 00:42:13 +0000
Message-Id: <20191102004213.24909-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning of comparison of 0/1 to bool variable.
Warning reported by coccinelle tool.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/staging/media/allegro-dvt/nal-h264.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/allegro-dvt/nal-h264.c b/drivers/staging/media/allegro-dvt/nal-h264.c
index 4e14b77851e1..bd48b8883572 100644
--- a/drivers/staging/media/allegro-dvt/nal-h264.c
+++ b/drivers/staging/media/allegro-dvt/nal-h264.c
@@ -235,7 +235,7 @@ static inline int rbsp_write_bit(struct rbsp *rbsp, bool value)
 
 	rbsp->pos++;
 
-	if (value == 1 ||
+	if (value ||
 	    (rbsp->num_consecutive_zeros < 7 && (rbsp->pos % 8 == 0))) {
 		rbsp->num_consecutive_zeros = 0;
 	} else {
-- 
2.21.0

