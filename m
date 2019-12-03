Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFDBC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4892068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qtec.com header.i=@qtec.com header.b="g2a64BKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfLCPMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:12:14 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:33070 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfLCPMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 10:12:13 -0500
Received: by mail-lf1-f54.google.com with SMTP id n25so3306271lfl.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 07:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rV/L1vsLVQFxpCjXm88i46dKl0c4TvqiL9DsGNMtloM=;
        b=g2a64BKjv0E9pz4IB6v4VoyS1s4Su/CqbYHrFLAfz5oPvTFJa2zq+i2qZ1tIlRosnW
         s3jOZ88IyB5aPW6YZsAEL9DC4RLEH1F0sFdzIYEks/hmtEDke4Eq8qmwNmBg3qYgp50u
         ncOsjbykeADInZ6HGwi0JK+MqFgX0sf/EqJUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rV/L1vsLVQFxpCjXm88i46dKl0c4TvqiL9DsGNMtloM=;
        b=uj2UB7oWa7iUGlrjYPlPrNbSImCzC0RKZeH9f7CU75iba8lTh4518tGQDx5Z9taSVg
         /U3ZescBDhurRoqQd7hTzGyhHsj9ZMRoVs37UxOic/fSQipKsqRpwnh296GB0C/D8IbV
         dWMoLTV9YPDx9QIjUSNYzm2YatBcHstA5hKfkvLTv5h6tISdMqDFLPDV6e5T5NwRcvdO
         QSFjSamAC7EQbLHcGhs9bpknD1bWoh6a8lLZwsdISSzXvh0zLdCDaST2WqrzDF14XK3Y
         qWJrPnDdQgWb1K0/6eYoZHAp3ZWd6AmCVZbUjgIjByepGj+sKCbZIdf+lJznVrFBRTpV
         hiLg==
X-Gm-Message-State: APjAAAUqxf71mtKXWoly16FblzK20wH98nQ2ClGe1ui8t944KkoeZeJG
        Nqh09/hXuIC3z1E5hnTblVVAnQ==
X-Google-Smtp-Source: APXvYqz89um+ISOlOlGXStsbb5tyQs1jR9o1vkozrfloHO+C1GcWjAQEhjACJPu9zzW2ZN3Mzk3CyQ==
X-Received: by 2002:a19:4906:: with SMTP id w6mr3021490lfa.168.1575385932028;
        Tue, 03 Dec 2019 07:12:12 -0800 (PST)
Received: from turia.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id q186sm1544537ljq.30.2019.12.03.07.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 07:12:11 -0800 (PST)
From:   Daniel Gomez <daniel@qtec.com>
Cc:     daniel@qtec.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: v4l2: Fix fourcc names for BAYER12P
Date:   Tue,  3 Dec 2019 16:12:00 +0100
Message-Id: <20191203151202.18081-1-daniel@qtec.com>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix documentation fourcc names for the 12-bit packed Bayer formats.

Signed-off-by: Daniel Gomez <daniel@qtec.com>
---
 Documentation/media/uapi/v4l/pixfmt-srggb12p.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/media/uapi/v4l/pixfmt-srggb12p.rst b/Documentation/media/uapi/v4l/pixfmt-srggb12p.rst
index 960851275f23..7060a4ffad08 100644
--- a/Documentation/media/uapi/v4l/pixfmt-srggb12p.rst
+++ b/Documentation/media/uapi/v4l/pixfmt-srggb12p.rst
@@ -13,7 +13,7 @@
 .. _v4l2-pix-fmt-sgrbg12p:
 
 *******************************************************************************************************************************
-V4L2_PIX_FMT_SRGGB12P ('pRAA'), V4L2_PIX_FMT_SGRBG12P ('pgAA'), V4L2_PIX_FMT_SGBRG12P ('pGAA'), V4L2_PIX_FMT_SBGGR12P ('pBAA'),
+V4L2_PIX_FMT_SRGGB12P ('pBCC'), V4L2_PIX_FMT_SGRBG12P ('pgCC'), V4L2_PIX_FMT_SGBRG12P ('pGCC'), V4L2_PIX_FMT_SBGGR12P ('pBCC'),
 *******************************************************************************************************************************
 
 
-- 
2.24.0.rc1

