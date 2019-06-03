Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10B1C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 20:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98A126E93
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 20:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="EHU5AK+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfFCU2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 16:28:54 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41010 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfFCU2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 16:28:53 -0400
Received: by mail-qt1-f196.google.com with SMTP id s57so3960779qte.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 13:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+KFBFAnU1kNLS5/DKe/r6zwMtKjfn/DnI3zFYfYxNlc=;
        b=EHU5AK+Mj4qB5AL0E/JcoWO3o2cvb7UDAagbWP93F6gd9CE1lBLezG4yQsZYIPaS+V
         Wn9RpyQTGwzMLyh8hwvkDLrpRa+t/w51hbLVk4UfRTMFZ0sX4fSYH8EvMgZ7RTguxaxP
         jRuEv1fBp76DSqLQisjvbdgA1TV2HgMvbvGlIrVHwLg2jFGOJuxOslmXxmk8ADXlo1Gr
         B5HM7/M+TELtie0dDrM2syZO//4NzDIJancg+Vnc5LC7xW7kGR8iygtW0whg94eX8NrG
         +jwMCSIROkXipjWdfUExtXt7YQ8ZzpP9RN6SLACKuDdsUpf+mAWv967wXR62TjV+IZVW
         5LsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+KFBFAnU1kNLS5/DKe/r6zwMtKjfn/DnI3zFYfYxNlc=;
        b=QBkfzTaBmJoJuYWujoWjXTfQBs8lkZJ8O6F4XjLoXAXXjJF1IObi2abCDjkoxbgjxv
         yk9PUcsvjjgQMliRLafA/Q8PdzzVz91geNBztOw8+70nvwKvt3NdFDY1F/PwVFlOgQPf
         csnDBycQs0W2ZUVaLQM6JSqlsRRYp9u3LqIZbMEmw47j9Q+xJQ7joYCUIXmyLESvzLcY
         o2f715BMO5ToIDZIepmuQwe8kXxefrrAW8+qxuIIgq9BfH+7k2i9mfZkWjl78iVAXv7H
         6x/lVphPusq9TQI05aP4VR7ToC5YaG5VGQ+ZDm3eMbSKKvTt9yHjWNM1Ea3dToj7Y8K5
         DNsA==
X-Gm-Message-State: APjAAAXTe4XGdV2rPzLJGZ5tSEin2mhAO5vS3rTLg3bqaMujdJysIx0T
        Sr0P4UK4i6D2ZuFJoVU2sa+1qzprvDM=
X-Google-Smtp-Source: APXvYqxjN3irkpRozi2atJyefD1tbFlAgV1wX/NN8oMIDX/KEd/3kvHqEeBXE9FRLWN+X/Vq78i54Q==
X-Received: by 2002:ac8:21bc:: with SMTP id 57mr24334342qty.73.1559593732486;
        Mon, 03 Jun 2019 13:28:52 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s35sm9488675qth.79.2019.06.03.13.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 13:28:51 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] acpi/osl: fix a W=1 kernel-doc warning
Date:   Mon,  3 Jun 2019 16:28:35 -0400
Message-Id: <1559593715-29599-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It appears that kernel-doc does not understand the return type *__ref,

drivers/acpi/osl.c:306: warning: cannot understand function prototype:
'void __iomem *__ref acpi_os_map_iomem(acpi_physical_address phys,
acpi_size size)

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/acpi/osl.c     | 4 ++--
 include/acpi/acpi_io.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index cc7507091dec..9c0edf2fc0dd 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -301,8 +301,8 @@ static void acpi_unmap(acpi_physical_address pg_off, void __iomem *vaddr)
  * During early init (when acpi_permanent_mmap has not been set yet) this
  * routine simply calls __acpi_map_table() to get the job done.
  */
-void __iomem *__ref
-acpi_os_map_iomem(acpi_physical_address phys, acpi_size size)
+void __iomem __ref
+*acpi_os_map_iomem(acpi_physical_address phys, acpi_size size)
 {
 	struct acpi_ioremap *map;
 	void __iomem *virt;
diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
index d0633fc1fc15..12d8bd333fe7 100644
--- a/include/acpi/acpi_io.h
+++ b/include/acpi/acpi_io.h
@@ -16,8 +16,8 @@ static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
 
 extern bool acpi_permanent_mmap;
 
-void __iomem *__ref
-acpi_os_map_iomem(acpi_physical_address phys, acpi_size size);
+void __iomem __ref
+*acpi_os_map_iomem(acpi_physical_address phys, acpi_size size);
 void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size);
 void __iomem *acpi_os_get_iomem(acpi_physical_address phys, unsigned int size);
 
-- 
1.8.3.1

