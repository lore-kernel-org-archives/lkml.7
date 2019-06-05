Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8073C28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B4320866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="lgnxW6WD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfFEUrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:47:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39138 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfFEUrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:47:02 -0400
Received: by mail-qt1-f196.google.com with SMTP id i34so150847qta.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 13:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pnFDbu7dJL/T4wcolooEMmx0LXIPFQNRhEfaysUvNBs=;
        b=lgnxW6WDgo9OgeTZtYGhPaZKQERQRHNAceLcMWfBpeHl/YDylUCiVNyAt5t5ISX0bP
         32XXXKxxYHqZ40o/wtii3bLLD/2mcAkYWP6t+nVpw2r0QK6pOeksdlfmqe2RQ/QXGg/W
         K8Y5Z+tMieBZ1/41UVLlLUIDVlRXQcAd8nyXT5OdiP80XcD6VUtdiFR/mjMDyQYHWo40
         zCfm2SzgI2GEEawqub5HMd4OGuR3efeKwmeidgK5HAvPPX1TyaRX5KGXua7Pwkg42Wsx
         LtsFmyg9IhkFhJyLCv62YfE6qtU9eRCg9Sdp02XNSHvaO6qpAsH0qOOwHi4ijnhCYSIQ
         DBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pnFDbu7dJL/T4wcolooEMmx0LXIPFQNRhEfaysUvNBs=;
        b=ZaZy4eWL9c9uDwp1qvTIc+d96Xii7jS8h1Wp9iyMJpMj7oK+oR0hhlpK8is/1ju8Uz
         h/I/KqyiJezGFNMlbV736uXSsKMwOEJOV6U7YMAm+HJBATYpjmQ7Coo0+6Eo2aPTRUHt
         7EbYPuLnpTDkrmcvsEfo6i76bb0FhhH3/FqdK5NnsHv9tIqNvbEthUYZapbAM2vAsyld
         nJRiOLbSZ2T8minQVTbOSJv2BILYtV5mJU+9a2RDFdGUrX6lBKweuVDRSJ3wxloDQ028
         gph8bf+hVoitnzNGju0xVWmCi70e1Pq6/3+v3XYIlw1AqBKkBjKjSIJuVKjel43QWwVS
         Mynw==
X-Gm-Message-State: APjAAAWS4GL2dd6ah9gS6TJwxnKJ5A5Wk2yn0FYQiLz6wHI0X5xCWkke
        Trbu9MhAAG2n/2d/UsEYOMjvWw==
X-Google-Smtp-Source: APXvYqzs4H4AfOMtcePSi562KDEoJqI6zcLd6dh+tfb04CyiY/ymhHP+GPy7/iHlyBpcNYtMz5KBag==
X-Received: by 2002:ac8:644:: with SMTP id e4mr28852202qth.173.1559767620945;
        Wed, 05 Jun 2019 13:47:00 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id e5sm10388470qkg.81.2019.06.05.13.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 13:47:00 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au
Cc:     ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com,
        benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] powerpc/eeh_cache: fix a W=1 kernel-doc warning
Date:   Wed,  5 Jun 2019 16:46:19 -0400
Message-Id: <1559767579-7151-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark "/**" is reserved for kernel-doc comments, so
it will generate a warning with "make W=1".

arch/powerpc/kernel/eeh_cache.c:37: warning: cannot understand function
prototype: 'struct pci_io_addr_range

Since this is not a kernel-doc for the struct below, but rather an
overview of this source eeh_cache.c, just use the free-form comments
kernel-doc syntax instead.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/kernel/eeh_cache.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index 320472373122..05ffd32b3416 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -18,6 +18,8 @@
 
 
 /**
+ * DOC: Overview
+ *
  * The pci address cache subsystem.  This subsystem places
  * PCI device address resources into a red-black tree, sorted
  * according to the address range, so that given only an i/o
@@ -34,6 +36,7 @@
  * than any hash algo I could think of for this problem, even
  * with the penalty of slow pointer chases for d-cache misses).
  */
+
 struct pci_io_addr_range {
 	struct rb_node rb_node;
 	resource_size_t addr_lo;
-- 
1.8.3.1

