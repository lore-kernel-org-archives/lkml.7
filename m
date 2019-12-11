Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271E0C2D0CB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF48A21556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Umx9+Upz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfLKTqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:46:53 -0500
Received: from mail-ua1-f74.google.com ([209.85.222.74]:54554 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbfLKTqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:46:51 -0500
Received: by mail-ua1-f74.google.com with SMTP id x2so6485818uaj.21
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 11:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eThurwhGsm2B6q3iIMHM88H1qXnCFgfSyZ1R5IN3D8Q=;
        b=Umx9+Upz6YY6XIihuoQd5zSRR25JpUE9443iw0slpTRt9rNrW/QtJnrqTveFBBtjJu
         2JH4MKsLoac9Cd2LcAoXkBqLPsZlRurSsea3TqpFF1YcgKgM46PKOFk15t4RttfJzw7Z
         3WRf8UtSA8Cah1PzwrHkcXbW3XZuz32fyOKGdfbg7u+y00MScxn6dR9QwQTCKTbfPfDw
         7PZBlKQxhxQxVe5kgqyq6eGry8rcdQPjRGEdXzIUzwxr54P9t/0U4NXLP6nViYUJoh61
         Xt9Gj3hlTbCPYMCcmN21UifbHrNWP0kWauzhxKpIAla7DlfZwJxBIAisTHiAbjaf0SSB
         ubyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eThurwhGsm2B6q3iIMHM88H1qXnCFgfSyZ1R5IN3D8Q=;
        b=dfXQFM3rJXVhTckozJK4GdqyWiJ76G022biRAqM6gVALqd+ZRFTkMtHQZwgaRM/yx2
         XMFXSXHTm3h21WZwMp97S/Qj7B1riZI+8p0AaVRgHP7DcynAiyBAezlOhDZ/wbNRxP2R
         m4iR0g9Fkjjo4IJ4jYVxe3mzs5ejYHnqK9fEPZlKFr099pSbagpVKgdRO4t2QD6zgm1O
         m3EEwUILEoG7rjSV1HcJHtqAhEHBCM/TvqvRV8pOZfNaY7SJIXlhu1OO0SEI+CEmt4x8
         LX0szLEYTGqUDoheJzgHxp2lgVSPMSiGFO2jg0L2jYSYdDUlj9gpHcHAMldAF//Cfw05
         JQ2w==
X-Gm-Message-State: APjAAAUz8mypNtjHbO+YUffn+Y5iEBcFxJBwzCFpcI6ksE/mWWtPbK4a
        Tk7tU+2ERLeT+VBBwnILiRLh/FAr
X-Google-Smtp-Source: APXvYqz9saMrD1OROuGMjFvRuK1d962ToYdHGinwknsX48BtwzWvboUzDxn9EnEBlb28+/SXokSHbbsr
X-Received: by 2002:ac5:c99c:: with SMTP id e28mr5314125vkm.52.1576093609782;
 Wed, 11 Dec 2019 11:46:49 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:46:06 -0500
In-Reply-To: <20191211194606.87940-1-brho@google.com>
Message-Id: <20191211194606.87940-4-brho@google.com>
Mime-Version: 1.0
References: <20191211194606.87940-1-brho@google.com>
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH 3/3] iommu/vt-d: skip invalid RMRR entries
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

The VT-d docs specify requirements for the RMRR entries base and end
(called 'Limit' in the docs) addresses.

This commit will cause the DMAR processing to skip any RMRR entries
that do not meet these requirements with the expectation that firmware
is giving us junk.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 drivers/iommu/intel-iommu.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f7e09244c9e4..11322fefb883 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4307,6 +4307,18 @@ static void __init init_iommu_pm_ops(void)
 static inline void init_iommu_pm_ops(void) {}
 #endif	/* CONFIG_PM */
 
+static int rmrr_validity_check(struct acpi_dmar_reserved_memory *rmrr)
+{
+	if ((rmrr->base_address & PAGE_MASK) ||
+	    (rmrr->end_address <= rmrr->base_address) ||
+	    ((rmrr->end_address - rmrr->base_address + 1) & PAGE_MASK)) {
+		pr_err(FW_BUG "Broken RMRR base: %#018Lx end: %#018Lx\n",
+		       rmrr->base_address, rmrr->end_address);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
 {
 	struct acpi_dmar_reserved_memory *rmrr;
@@ -4314,7 +4326,7 @@ int __init dmar_parse_one_rmrr(struct acpi_dmar_header *header, void *arg)
 	int ret;
 
 	rmrr = (struct acpi_dmar_reserved_memory *)header;
-	ret = arch_rmrr_sanity_check(rmrr);
+	ret = rmrr_validity_check(rmrr) || arch_rmrr_sanity_check(rmrr);
 	if (ret)
 		return 0;
 
-- 
2.24.0.525.g8f36a354ae-goog

