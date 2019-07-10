Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793E7C74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B9C208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eng.ucsd.edu header.i=@eng.ucsd.edu header.b="UUzVeCXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfGJPbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:31:50 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43872 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbfGJPbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:31:41 -0400
Received: by mail-lf1-f68.google.com with SMTP id c19so1905847lfm.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 08:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eng.ucsd.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iaKa3sSy2TMJewprEBabjIU4mKVmcxPtQBjA4QDbmn0=;
        b=UUzVeCXTViOeS329ulCFq+Hz43TUVXtDWlWrCHNGfGXF3mlN4g7U3i42I7j+vqjga3
         l3MGHSL71cjlI5wcM9ZbWkTGQrgF2eOGsDBvdIdNh+HE4oxSzYNz8U0ldOgdcEGv5k2v
         wqdOsIcf3eCSbyTwe/UGRVNsb/5OFLGQTbX4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iaKa3sSy2TMJewprEBabjIU4mKVmcxPtQBjA4QDbmn0=;
        b=iHgYbSCbH8UeSIoQ9zJ1tU5CRHP2JD0c6xahtUzombvjPb4sQnAaEq9Jf60MMOFa0Z
         qucEzeE73fkedjlCI20WIbwcnCE9W4cz9PECsL8Bc8gDjFQ3WmacqfiLKGBzPYuDfuEY
         zvt82UY+t5TW+5XTTomWe2qWz0Fxz/2q20K6j7gJkuGv/GKJISzvc0weKdhJ/w2xnBet
         LKTb9aLv1UbIAnY3y7AmOs0V/y0KanmZcqIHe0PXOT+iAtgSns1Q+IRMf+ygrc+Btc31
         KHoVINzH/eswwxWJZTNUE5YPVCIpLFq1g8IwE8wfOAPZSGBg1sUwefRwLY19WO092FrA
         KhWw==
X-Gm-Message-State: APjAAAWvrZQdiNW0Q2RsSPGmt04E3KL5dntLVy1jVY/qXj91rsOHzEkF
        pL97TJQVd9MX2X/k2hfHqp31Ng==
X-Google-Smtp-Source: APXvYqye8Vs3VVDTfx2ic4t433ZNvo5KeS/BLYowQ8YqT568ojQnM+RFldGQEiyEYzmEvpN4l6RS4Q==
X-Received: by 2002:ac2:495e:: with SMTP id o30mr15233962lfi.140.1562772699900;
        Wed, 10 Jul 2019 08:31:39 -0700 (PDT)
Received: from luke-XPS-13.home (159-205-76-204.adsl.inetia.pl. [159.205.76.204])
        by smtp.gmail.com with ESMTPSA id o17sm517208ljg.71.2019.07.10.08.31.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 08:31:39 -0700 (PDT)
From:   Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
X-Google-Original-From: Luke Nowakowski-Krijger <lnowakow@neg.ucsd.edu>
To:     linux-kernel-mentees@lists.linuxfoundation.org
Cc:     Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>,
        pbonzini@redhat.com, rkrcmar@redhat.com, corbet@lwn.net,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] Documentation: virtual: Add toctree hooks
Date:   Wed, 10 Jul 2019 08:30:54 -0700
Message-Id: <20190710153054.29564-4-lnowakow@neg.ucsd.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710153054.29564-1-lnowakow@neg.ucsd.edu>
References: <20190710153054.29564-1-lnowakow@neg.ucsd.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>

Added toctree hooks for indexing. Hooks added only for newly added
files.

The hook for the top of the tree will be added in a later patch series
when a few more substantial changes have been added.

Signed-off-by: Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
---
 Changes since v3:
 none
 Changes since v2:
 - Removed vcpu-request from hooks that was added in v1
 Changes since v1:
 + Added index.rst file in virtual directory
 + Added index.rst file in virtual/kvm directory

 Documentation/virtual/index.rst     | 18 ++++++++++++++++++
 Documentation/virtual/kvm/index.rst | 11 +++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 Documentation/virtual/index.rst
 create mode 100644 Documentation/virtual/kvm/index.rst

diff --git a/Documentation/virtual/index.rst b/Documentation/virtual/index.rst
new file mode 100644
index 000000000000..19c9fa2266f4
--- /dev/null
+++ b/Documentation/virtual/index.rst
@@ -0,0 +1,18 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+Linux Virtual Documentation
+===========================
+
+.. toctree::
+   :maxdepth: 2
+
+   kvm/index
+   paravirt_ops
+
+.. only:: html and subproject
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/virtual/kvm/index.rst b/Documentation/virtual/kvm/index.rst
new file mode 100644
index 000000000000..0b206a06f5be
--- /dev/null
+++ b/Documentation/virtual/kvm/index.rst
@@ -0,0 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===
+KVM
+===
+
+.. toctree::
+   :maxdepth: 2
+
+   amd-memory-encryption
+   cpuid
-- 
2.20.1

