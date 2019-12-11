Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31923C00454
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082DB21556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRKfFcdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfLKTq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:46:57 -0500
Received: from mail-yw1-f73.google.com ([209.85.161.73]:42066 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729219AbfLKTqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:46:46 -0500
Received: by mail-yw1-f73.google.com with SMTP id l5so7291084ywf.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 11:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BhTHWYgCSRQtEgCb1BylwBRcg/1kvg/B2oRKXg+gQaY=;
        b=NRKfFcdG6A4G5+sdQcP18SbNkmh1K5xiATWt/eiHVv9xZBDxllX9SQzVn3rHMvyDMI
         h9ijXt1EyeVoQLowMSJ9qHQonptwYiDR999p8WI/NbxSmfeEW560BMDGtqnLrnI0sPwj
         dWO7Lb+b7vDByHnu80y56OMFS74unO9AiAeKUqJ0vSMzRPrDoX+2vxJIOkcF4czGQIVk
         cs//fejmn//AmRtVHtYQQZZD42rXDK7Sqh0V/aOx1dkYN6ZoOTEovpRoD5TTApC9HbHt
         AGb60H2zF8iTMLIMtdGA3symGnVQ2NmGN3sJvM3wzsuq/ygQd1XoNRh29TwLP/ySIf+N
         HvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BhTHWYgCSRQtEgCb1BylwBRcg/1kvg/B2oRKXg+gQaY=;
        b=uGmy2rwUQs166UpREeoRIvqUE6COthJGaplT6YtPezeynByN/aPVioTM8lckQTcA3S
         PA0oz2jfKpmI+aPYHGmH4ftlcZKMDvj4j/X/SzpDxWMdNl9GgUDnQ05dDRb3KIM2AgqV
         hGBBt1/CLGeI7Smm1M36wgyFqB/NeYBx4PXsnrhCMd1FkRqNxdmBTbGvT6zaXEqC4noa
         vXE+lwmvu6rMauNG5g1qGG9FePPyf7bJeMhhNTKdQO1ZIWjZ3KQ8IAOW+QTf4COBTW6/
         OlRw/4wQN/tSAoSthyCrBhIfK8GHMJBb4SNt9/cMIUUkt/RdQJDA22XI3hEnkaVhWyHo
         UkiA==
X-Gm-Message-State: APjAAAUJkGIdgNSyVrNpVhPIpFmDIFqi4c0uj10yAl9bh6xHH0X97b2D
        19ugquI98Z/UiYjh7u3spda+Hq+v
X-Google-Smtp-Source: APXvYqx33A6l+F0JL5LmhA7761ThPciJW7aU6oekLpGrNCPEgTSjL2GCjb/RsgaRNTGpE4W3vmLLvwV3
X-Received: by 2002:a81:2441:: with SMTP id k62mr1238554ywk.214.1576093605695;
 Wed, 11 Dec 2019 11:46:45 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:46:05 -0500
In-Reply-To: <20191211194606.87940-1-brho@google.com>
Message-Id: <20191211194606.87940-3-brho@google.com>
Mime-Version: 1.0
References: <20191211194606.87940-1-brho@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH 2/3] iommu/vt-d: treat unmapped RMRR entries as sane
From:   Barret Rhoden <brho@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Yian Chen <yian.chen@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RMRR sanity check is to confirm that the memory pointed to by the
RMRR entry is not used by the kernel.  e820 RESERVED memory will not be
used.  However, there are ranges of physical memory that are not covered
by the e820 table at all.  The kernel will not use this memory, either.

This commit expands the sanity check to treat memory that is not in any
e820 entry as safe.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 arch/x86/include/asm/iommu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/iommu.h b/arch/x86/include/asm/iommu.h
index bf1ed2ddc74b..7e9f0c2f975f 100644
--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -20,6 +20,8 @@ arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
 
 	if (e820__mapped_all(start, end, E820_TYPE_RESERVED))
 		return 0;
+	if (!e820__mapped_any(start, end, 0))
+		return 0;
 
 	pr_err(FW_BUG "No firmware reserved region can cover this RMRR [%#018Lx-%#018Lx], contact BIOS vendor for fixes\n",
 	       start, end - 1);
-- 
2.24.0.525.g8f36a354ae-goog

