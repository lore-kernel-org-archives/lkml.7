Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B91C43215
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 00:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB23F20719
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 00:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VT21x1jc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKXA74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 19:59:56 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37777 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbfKXA7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 19:59:55 -0500
Received: by mail-io1-f65.google.com with SMTP id k24so1570641ioc.4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 16:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=qAmHrIF6xrd+Ev/ZPd2jpsaSN5NNND47POTTXZp6Ekg=;
        b=VT21x1jcllGEam/V7V5IvqPFqhNL9nRAD0tgo62hVEU/bjvap3+gtELTd7j/68MaxL
         EsJdV4roOUC0eeUSTGyC4TCRuezGVILOXS/XV7GjY3KBfnDcnqJAtOEgQJbaI/6V030S
         4IZ7I+MrSWwqtIJaXtW4D3/0p9ul7reCG7gJvrvOy7edBhad1Qnlo3YQIaY4rCUZp+ih
         rcA6Z/4MzTIWB538pv/YwM/yjqENHYafnJsi4q1jYx0SMDK5JEIamLEL20yO7g9sXunN
         0aDmzhzLjjHc/oqMHNBf6cMGCXQ0WGAzAI3ycNP3OUNtN80iNmLU41HNxVR4VrFgT/oA
         iVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=qAmHrIF6xrd+Ev/ZPd2jpsaSN5NNND47POTTXZp6Ekg=;
        b=Bmf9Ku2Wxdrtu24T6dwebznV9+7ezKNZsujOZ/FZxruocAPCimnz2YXNbQN/oLLLLd
         Drb9DZQdaegIIsZc/kFD4PlYoifwl4w6QiNRbykX+VJnTPJXdmHkygngbwJMN9SdccG3
         dx6VgldoUuRhHWcUWwP44H5zCByzXfKdFjaKaeVuHQHKd+5JDX2qLf64JzvLTvSjz1tw
         Z/CUdFcXd3JX5vfZ2vCwiWjC5A9SMdeS3g+3L3+lvr+3/w2eePmZCLz8fX+FAUIcaViQ
         3FClayBNXMAwuYjmjeKrukg33K/kdtFCF7hopK1WJGMZ3AWt2OA/KCDK/u0vzQ9TyI6q
         QhZQ==
X-Gm-Message-State: APjAAAUxDYCS+6H9TtovkFWD6cB0OCdkubpnBmD2X3mxxSRWT1IK421V
        TpjGiYqOC72015/bUoasW5D6YQ==
X-Google-Smtp-Source: APXvYqxWFVccHTUrwWRlgAFEb+PyLPIHXb8aV2R7KgIElNIZV9rCXV4NJYcvrFQNcFuhtpdS9M+w6A==
X-Received: by 2002:a6b:9302:: with SMTP id v2mr11426097iod.12.1574557192848;
        Sat, 23 Nov 2019 16:59:52 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id h16sm642955iog.27.2019.11.23.16.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 16:59:51 -0800 (PST)
Date:   Sat, 23 Nov 2019 16:59:49 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-riscv@lists.infradead.org, corbet@lwn.net
cc:     palmer@dabbelt.com, aou@eecs.berkeley.edu, krste@berkeley.edu,
        waterman@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, willy@infradead.org,
        dan.j.williams@intel.com
Subject: [PATCH v2] Documentation: riscv: add patch acceptance guidelines
Message-ID: <alpine.DEB.2.21.9999.1911231655360.490@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formalize, in kernel documentation, the patch acceptance policy for
arch/riscv.  In summary, it states that as maintainers, we plan to
only accept patches for new modules or extensions that have been
frozen or ratified by the RISC-V Foundation.

We've been following these guidelines for the past few months.  In the
meantime, we've received quite a bit of feedback that it would be
helpful to have these guidelines formally documented.

Based on a suggestion from Matthew Wilcox, we also add a link to this
file to Documentation/process/index.rst, to make this document easier
to find.  The format of this document has also been changed to align
to the format outlined in the maintainer entry profiles, in accordance
with comments Jon Corbet and Dan Williams.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Krste Asanovic <krste@berkeley.edu>
Cc: Andrew Waterman <waterman@eecs.berkeley.edu>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
---
Hi Jon, could you ack this if you're happy with it so we can merge it 
through the arch/riscv tree?  Otherwise, if you would like to take it 
instead, please just let us know.  - Paul

 Documentation/process/index.rst          |  1 +
 Documentation/riscv/index.rst            |  1 +
 Documentation/riscv/patch-acceptance.rst | 35 ++++++++++++++++++++++++
 3 files changed, 37 insertions(+)
 create mode 100644 Documentation/riscv/patch-acceptance.rst

diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index e2c9ffc682c5..9b8394eacea6 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -58,6 +58,7 @@ lack of a better place.
    magic-number
    volatile-considered-harmful
    clang-format
+   ../riscv/patch-acceptance
 
 .. only::  subproject and html
 
diff --git a/Documentation/riscv/index.rst b/Documentation/riscv/index.rst
index 215fd3c1f2d5..fa33bffd8992 100644
--- a/Documentation/riscv/index.rst
+++ b/Documentation/riscv/index.rst
@@ -7,6 +7,7 @@ RISC-V architecture
 
     boot-image-header
     pmu
+    patch-acceptance
 
 .. only::  subproject and html
 
diff --git a/Documentation/riscv/patch-acceptance.rst b/Documentation/riscv/patch-acceptance.rst
new file mode 100644
index 000000000000..dfe0ac5624fb
--- /dev/null
+++ b/Documentation/riscv/patch-acceptance.rst
@@ -0,0 +1,35 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+arch/riscv maintenance guidelines for developers
+================================================
+
+Overview
+--------
+The RISC-V instruction set architecture is developed in the open:
+in-progress drafts are available for all to review and to experiment
+with implementations.  New module or extension drafts can change
+during the development process - sometimes in ways that are
+incompatible with previous drafts.  This flexibility can present a
+challenge for RISC-V Linux maintenance.  Linux maintainers disapprove
+of churn, and the Linux development process prefers well-reviewed and
+tested code over experimental code.  We wish to extend these same
+principles to the RISC-V-related code that will be accepted for
+inclusion in the kernel.
+
+Submit Checklist Addendum
+-------------------------
+We'll only accept patches for new modules or extensions if the
+specifications for those modules or extensions are listed as being
+"Frozen" or "Ratified" by the RISC-V Foundation.  (Developers may, of
+course, maintain their own Linux kernel trees that contain code for
+any draft extensions that they wish.)
+
+Additionally, the RISC-V specification allows implementors to create
+their own custom extensions.  These custom extensions aren't required
+to go through any review or ratification process by the RISC-V
+Foundation.  To avoid the maintenance complexity and potential
+performance impact of adding kernel code for implementor-specific
+RISC-V extensions, we'll only to accept patches for extensions that
+have been officially frozen or ratified by the RISC-V Foundation.
+(Implementors, may, of course, maintain their own Linux kernel trees
+containing code for any custom extensions that they wish.)
-- 
2.24.0.rc0

