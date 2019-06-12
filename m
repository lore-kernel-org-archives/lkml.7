Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECD2C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC482080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cj+kgVvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbfFLIP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:15:57 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43672 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfFLIP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:15:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id j29so11346003lfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 01:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2qc0nv++ogxD/fVe1o7jhZAYVkwJMAt6qDg76e6F2/I=;
        b=cj+kgVvf4js2JFhPQnoZZn6kDBqQbBEjXpTJqKyElA40Sc0hD8k86b6bvQXrfo3Izf
         lKZb9SDuXC+VP9hLRUbbU4Qb5jlW7PPZBKg1t8wQpPxQwZWX8Rr+50TW/nNkkPE3GXFl
         2YpPVNPRJBWdRePwfs+UsHEL9F4i0MKZtnvBUlTyZ30v7oWvnZmKPd7/R9eA0oCOFQ6N
         1xgWgrfWL4ec1adbkG+fLIYxhHHtdy0GSgZD0pUWCpauWH+oKXf85OL7zAPPdMbuUjsX
         /vfAGAdJvyUnJli1vuzvfRrs+ssobSJQTpILvHb9kw/BveAfFew0+2R3E30doQ+YVrkd
         WEHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2qc0nv++ogxD/fVe1o7jhZAYVkwJMAt6qDg76e6F2/I=;
        b=Z8n9dl3mDOO1gPyslysUVFPdM+UltfWqkTuqkFA2KAjrTFY23GowJyc4k3obJMkeZT
         mxJdpIqnS5JpK2guxh0PZXtgp52kacXfBJIZjpQFxLWW+YhokYLX/MsIzloZwWUnsfS6
         BEYnMK5BmTQlc4RabIukzpLlBCZL+EjuHBYDPwfmg+1Pk1oP2CzxgmbI/UnzHFoZFXVM
         PzpS3QEEAcNO7lELnaJk49FgIJBdjN/p6gw4vghY6/tyTtxY2/nUJnTmIdDH5EHN57XC
         O9JAUcWWCCuNauTvGZQAHDUsnhCr+ewFA1SLIZxJPuS0HUihQsFH0uJnfoBZxUHELH+s
         +ZTg==
X-Gm-Message-State: APjAAAUMIqCqFh/dSeCWfZphLfxQiRRJeGw2a1RbEd5P1ziaPJL0lov+
        0Ktnor65MTbRzuYS/SOg5WzzeoSll607Gw==
X-Google-Smtp-Source: APXvYqzksCYlTlYuYtnz2FY/MHGMyOOTRXflfdL5X4G+rMVcF1T1+JRvyDF0NKbtoWEywxrpHTOBEw==
X-Received: by 2002:a19:dc0d:: with SMTP id t13mr16801840lfg.152.1560327354568;
        Wed, 12 Jun 2019 01:15:54 -0700 (PDT)
Received: from localhost (c-1c3670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.28])
        by smtp.gmail.com with ESMTPSA id 80sm2965455lfz.56.2019.06.12.01.15.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 01:15:53 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     p.zabel@pengutronix.de, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2 3/3] drivers: media: coda: fix warning same module names
Date:   Wed, 12 Jun 2019 10:15:50 +0200
Message-Id: <20190612081550.2255-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with CONFIG_VIDEO_CODA and CONFIG_CODA_FS enabled as
loadable modules, we see the following warning:

warning: same module names found:
  fs/coda/coda.ko
  drivers/media/platform/coda/coda.ko

Rework so media/platform/coda is named coda-vpu. Leaving CODA_FS as is
since that's a well known module.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/media/platform/coda/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/coda/Makefile b/drivers/media/platform/coda/Makefile
index 54e9a73a92ab..5fd5efa35159 100644
--- a/drivers/media/platform/coda/Makefile
+++ b/drivers/media/platform/coda/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-coda-objs := coda-common.o coda-bit.o coda-gdi.o coda-h264.o coda-mpeg2.o coda-mpeg4.o coda-jpeg.o
+coda-vpu-objs := coda-common.o coda-bit.o coda-gdi.o coda-h264.o coda-mpeg2.o coda-mpeg4.o coda-jpeg.o
 
-obj-$(CONFIG_VIDEO_CODA) += coda.o
+obj-$(CONFIG_VIDEO_CODA) += coda-vpu.o
 obj-$(CONFIG_VIDEO_IMX_VDOA) += imx-vdoa.o
-- 
2.20.1

