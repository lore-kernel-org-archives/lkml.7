Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34596C43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFFF20820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="o8BDOgkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfFJURh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:17:37 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36078 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbfFJURg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:17:36 -0400
Received: by mail-vs1-f67.google.com with SMTP id l20so6383604vsp.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 13:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+KFBFAnU1kNLS5/DKe/r6zwMtKjfn/DnI3zFYfYxNlc=;
        b=o8BDOgklNuALK2PUSerrywtUap632G7138gs/frChasanKKOl727v44LmNUOBio7So
         hdrVPvS784jp0pyoDtoL8Jho0cg96LMHO+0VhXhBM3XdmPfUz6kTMchwa94ln1EoMjP1
         9L2UMKNzUlEKp2FDdy5vvhnn8Rryx97cRHaGnhOxMVNBOcyw2KkTXXkOmx4Cf6ct97T+
         LzSkRkJ2ZHCu1CSK6cxYB34HjFceVlB4jfBmJvEA/HOR3vMFQ9L41t48044/cM3UWAIq
         gXWNZTAWtM2PIITzMq5+YJoBWFUTm6vGLY7LrU39t6KJmmaxbL9F+HemvOh8jmleLYWG
         nLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+KFBFAnU1kNLS5/DKe/r6zwMtKjfn/DnI3zFYfYxNlc=;
        b=n1W7lpvHJUvoBYkqGHeYbatFdX9ohhGjU+yV3WBx/UyQasYW3vYkH0QOnJpd17Ryok
         rR+gXPJuv1Euxf37FiPlk7infF8D8bpqF6o+nhmP9Y+cR+P47g/Y3WIlxoS+TvIU+9gK
         FRrJheeVygRf0kH2D+PxZAxX0jXEEGCHkTGEr1yThGYkZlb7dufvo1+4TVSMf6Bi1swv
         CNuBqgnqXRGHFcMcCEna2Dgbh0+CvOAHNthHoCa2KSPyCt6dtt1C9TgKE2U9/l+C2vGl
         vyYobnqOiOzHHeMlNbenA5YPcJ4u8vFpsr+k+i68o6B4ftV421ET5JwQYcjk8HcmyAcW
         xDpg==
X-Gm-Message-State: APjAAAV28V+9lDe5+b6+XG61H9MDRJVvZn8u76CfiQwLsxSDrLJ9ruhG
        fDdXqZWF2tFnXmWxyL0ijMUUMg==
X-Google-Smtp-Source: APXvYqyc9Xcrbu4ikQqdVtLIBBUsdOaz/oDlfNrCxwZpzobjTDrXPdwH9mgLx3VFD0zRlRtaDiBQGg==
X-Received: by 2002:a67:ed8b:: with SMTP id d11mr37836572vsp.35.1560197855728;
        Mon, 10 Jun 2019 13:17:35 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g26sm2188267ual.10.2019.06.10.13.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 13:17:35 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     rjw@rjwysocki.net, lenb@kernel.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [RESEND PATCH] acpi/osl: fix a W=1 kernel-doc warning
Date:   Mon, 10 Jun 2019 16:17:14 -0400
Message-Id: <1560197834-31551-1-git-send-email-cai@lca.pw>
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

