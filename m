Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60461C48BDA
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 21:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3816F2085A
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 21:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eng.ucsd.edu header.i=@eng.ucsd.edu header.b="QBXdetEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfGFViv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 17:38:51 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35084 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfGFViu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 17:38:50 -0400
Received: by mail-lf1-f68.google.com with SMTP id p197so8421950lfa.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2019 14:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eng.ucsd.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DuOAz4hI1m2Eoq4BKu5qv1f4XbKgapdVxFndOFJhe6o=;
        b=QBXdetEEpDaQgyKLsnLHWzmH1wldyzKyMqgVaGRkXUH7b2DUVhfwIGklzwY5EyGuGd
         p0jX2hj6wplRBkrUvKGhHzBQmfS/DGh6kcZ2mVieoj/1XZ04CejtWhD7pn/cSKQR37Cc
         UA3W4LhliS5DpwBmJdMq3piFIlMccXkj9miRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DuOAz4hI1m2Eoq4BKu5qv1f4XbKgapdVxFndOFJhe6o=;
        b=NjbWP4+czn6Yy2eOT9Iw4TOiC2i8tZdw69AalIHOLxehYMHlP7N0wZ8evJPv3qNroH
         vaKOv/Pbi+c+8liNYw8yYTjxxbfFDEhe3WU/bwK4jfU7pdoFeQzBSSisRs8zQI7SahA5
         j7SbtF90dRacwmRogcmJuypzbUOL7ufmokbqlkJJHOjDM6xy7n6fRYtlXQMxbGNSP3YE
         cIyVPZ5dr0Enin8psZ77GUspJ1aNAWwhyMxr5GY4O6pIA6DewdrK0i4mhXRkuqrtP03d
         IzQgcCoP8KZFp2QWm92nX3IRx6danzRuxSceaywsFJcwQIfmJa+MqZbpIoV4pcMhJwxv
         +GlQ==
X-Gm-Message-State: APjAAAXsSpBpstPW0dz1bvd059DC/yOFLUBGAjrfM6wjlhAd6aueh5Kp
        vDKl8NoisIscLLa6VDrxZoAULg==
X-Google-Smtp-Source: APXvYqw2mCxi+OdS68ITvrMO+wzb5K1SYQRv2FpmzKWs4N8eOtOcBKONNRQqxrUEs+Ta2YigyP36LA==
X-Received: by 2002:a19:490d:: with SMTP id w13mr4907625lfa.58.1562449128132;
        Sat, 06 Jul 2019 14:38:48 -0700 (PDT)
Received: from luke-XPS-13.home (77-255-206-190.adsl.inetia.pl. [77.255.206.190])
        by smtp.gmail.com with ESMTPSA id j3sm1322449lfp.34.2019.07.06.14.38.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Jul 2019 14:38:47 -0700 (PDT)
From:   Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
X-Google-Original-From: Luke Nowakowski-Krijger <lnowakow@neg.ucsd.edu>
To:     linux-kernel-mentees@lists.linuxfoundation.org
Cc:     Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>,
        pbonzini@redhat.com, rkrcmar@redhat.com, corbet@lwn.net,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Documentation: virtual: Add toctree hooks
Date:   Sat,  6 Jul 2019 14:38:13 -0700
Message-Id: <ef1edb15bd6a6ef87abf4fef7636cd9213450e3c.1562448500.git.lnowakow@eng.ucsd.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1562448500.git.lnowakow@eng.ucsd.edu>
References: <cover.1562448500.git.lnowakow@eng.ucsd.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>

Added toctree hooks for indexing. Hooks added only for newly added files
or already existing files. 

The hook for the top of the tree will be added in a later patch series
when a few more substantial changes have been added. 

Signed-off-by: Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
---
 Documentation/virtual/index.rst     | 18 ++++++++++++++++++
 Documentation/virtual/kvm/index.rst | 12 ++++++++++++
 2 files changed, 30 insertions(+)
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
index 000000000000..ada224a511fe
--- /dev/null
+++ b/Documentation/virtual/kvm/index.rst
@@ -0,0 +1,12 @@
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
+   vcpu-requests
-- 
2.20.1

