Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F56C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D232073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eng.ucsd.edu header.i=@eng.ucsd.edu header.b="PUJkz0FB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfGIUIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 16:08:22 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35282 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729607AbfGIUIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 16:08:21 -0400
Received: by mail-lf1-f66.google.com with SMTP id p197so14275468lfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 13:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eng.ucsd.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nPhFlUg160YIM5+wm6v8cRWOklVUq1HxImS3+DfzTd0=;
        b=PUJkz0FBCQCSz7JsKk1v6RISYYb4uLBoN78kFvm+Iw2/PL2u3QbrMWBzJ5WcH35ASg
         PtcuiBqmuUQWk1966XcAi4amWzqXC9cE4jqn58nlqZtkcOKraYiVlCt4RZM3A2nCe3Of
         cypMt4nQ84B7R7rFT2pbAToU1gO9HIOXBtetk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nPhFlUg160YIM5+wm6v8cRWOklVUq1HxImS3+DfzTd0=;
        b=AJ4gzo/+5etMrx3JCjl4CSMmz1WB+4trH7W+A8PHyP53hf/tcMGpzkBIRAH9fHZusW
         liEhzQaT32QuCEm5Uty3h7IBL5kdwb7p8EtYHEDiwwqE9tY+/swnXZT5mOfsL4jDIEue
         uraKclxXD64zK39oGxJ9SYkEObVJGhxSIETB2N3CE2tyUSPFJ8zBPzh2FZcvplXv+1Sl
         j71KrHYrlEgXLlnvEGBv53P/dDWNiTP7ysXSUWZivK5j1z9G4Ivx66YsIF1HyOs5hvWX
         J0zMBgV+Gv26Ml2lMF5raZ4xYfSpTjQWbQdIPtG0kP9U2emuvCw6WC42ELtz60Ur9sqB
         8cog==
X-Gm-Message-State: APjAAAWNXUBe5E+dO17lq2tzicHlcTNHpDTgFsg7KJWbgRd1HAA+8Vha
        Bon9mYX3rof1nlyZLu/GG5khRQ==
X-Google-Smtp-Source: APXvYqzNSk+qmgC/RcZPrqM4OfhOxlepPwzhf81+ba0k0BKPTZvqF+t+RraLwhsiS85v4y43wTqFMg==
X-Received: by 2002:ac2:5336:: with SMTP id f22mr12185607lfh.180.1562702898776;
        Tue, 09 Jul 2019 13:08:18 -0700 (PDT)
Received: from luke-XPS-13.home (159-205-76-204.adsl.inetia.pl. [159.205.76.204])
        by smtp.gmail.com with ESMTPSA id f1sm4489ljk.86.2019.07.09.13.08.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 13:08:18 -0700 (PDT)
From:   Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
X-Google-Original-From: Luke Nowakowski-Krijger <lnowakow@neg.ucsd.edu>
To:     linux-kernel-mentees@lists.linuxfoundation.org
Cc:     Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>,
        pbonzini@redhat.com, rkrcmar@redhat.com, corbet@lwn.net,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] Documentation: virtual: Add toctree hooks
Date:   Tue,  9 Jul 2019 13:07:21 -0700
Message-Id: <20190709200721.16991-4-lnowakow@neg.ucsd.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190709200721.16991-1-lnowakow@neg.ucsd.edu>
References: <20190709200721.16991-1-lnowakow@neg.ucsd.edu>
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

