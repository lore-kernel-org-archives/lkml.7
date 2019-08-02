Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B16BC19759
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E26206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 01:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY09FB3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732097AbfHBBqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 21:46:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36761 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731827AbfHBBqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 21:46:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so33000998plt.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 18:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RdectgfrxPnoPm3S0YOxCABzXoqfRDNzFQDiE47h5Vs=;
        b=TY09FB3oduRwswYsXlYBN0hfEOMZHFs67R2ix0H5rE97soa1j1YHKiUNwyGO44M/iy
         71RT+aJ+oTzpdw0MwKYvn838kra3RTwW/eVouela+oW6XdLugu8NldyRHn2jobIy9+sw
         uEXhwwG/CSZu+Vl38cCE9vKx9mW7ALXIlbJsRSNOiia1rlqm6z7cjst19uwYaxDOFQeP
         yL/PUuRJ1PK4xPW4SZ8OvgF3Y26kOO5vfzh3dwqduAFc0+/fhC4nGRQmB5TOuTz0U2c/
         0JzVNwo9IAVDqP8B48B5HpUQTieRFKYP7ANZUWv0E+DOfyIi3bPRZgrvOd3FoWszir5B
         v5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RdectgfrxPnoPm3S0YOxCABzXoqfRDNzFQDiE47h5Vs=;
        b=Frx5ETomP0Cml5L3bV0nDhPDPwi32ZSZ/kpVE6gCaUG7BN4cVG5b8lpxb1OfrciapY
         pRA6s7QojVXwPCZUAVfGEwT+V1bzP0DHulcbH/ZIcir+9RzpS0Q/tS3Hd27Ra+xHO5UC
         ylhbeQx69goYnUGCqX+0Oq3SHF79CYmsMQtGWekQFZ7V7gR3znZpeP/P9UxHGkTZJPyB
         k4hvgaHBvcRI1z9l6ilQ3B5WOyI5eE08nO71Iup60SA9pje/hT6iizIvYE+vYoOO4sAO
         FPZ7Gi09w9hrP8AjbGaRWhkg07dI3j4AtlObVdoBBd3eAHZXThdTh5ioGYd5nActIbC8
         v41w==
X-Gm-Message-State: APjAAAVOF2B3zhZeGwZE0YubgDU9tgUIXk08g6pCKP5izv41o/iT/nEs
        sPk1GrCzqHUr2cgKhZ5brLI=
X-Google-Smtp-Source: APXvYqz6v2LAs+vWsP5Ju77kwgKl89h9PYXGlo3CLDM3qT09S/MYoeAP/LE5J4NH3n4L///VC5y3Uw==
X-Received: by 2002:a17:902:324:: with SMTP id 33mr125126557pld.340.1564710408379;
        Thu, 01 Aug 2019 18:46:48 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id 5sm6703488pgh.93.2019.08.01.18.46.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 18:46:47 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2 01/10] dma: debug: Replace strncmp with str_has_prefix
Date:   Fri,  2 Aug 2019 09:46:43 +0800
Message-Id: <20190802014643.8681-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strncmp(str, const, len) is error-prone because len
is easy to have typo.
The example is the hard-coded len has counting error
or sizeof(const) forgets - 1.
So we prefer using newly introduced str_has_prefix
to substitute such strncmp.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Revise the description.

 kernel/dma/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 099002d84f46..0f9e1aba3e1a 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -970,7 +970,7 @@ static __init int dma_debug_cmdline(char *str)
 	if (!str)
 		return -EINVAL;
 
-	if (strncmp(str, "off", 3) == 0) {
+	if (str_has_prefix(str, "off")) {
 		pr_info("debugging disabled on kernel command line\n");
 		global_disable = true;
 	}
-- 
2.20.1

