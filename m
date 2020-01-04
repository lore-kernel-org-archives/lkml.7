Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F69C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 01:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA5721835
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 01:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DdTUmNJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgADBkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 20:40:16 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:45699 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgADBkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 20:40:15 -0500
Received: by mail-il1-f193.google.com with SMTP id p8so38069009iln.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 17:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=p+aEtGvZStTHC748i1i28Ty2kT6MGPJhRV1hrUdmKEg=;
        b=DdTUmNJNzy5afvjihoYOCyO8r92df2ViburJnJy+i8JQzvGeGwuYuInZsZynms5w7M
         u4BeFPjaAt/57JdqjiFc8k1ZkpaG1SpFN4KVxND46xBwj5s7+jUPaY4XlsGkM3rDStMx
         d8eP9f8837MDgHrMuU/hgWrUXXnyinuAxf6Jm62LRLjnp+vY/PogtuD1kT3RmyXTvA3i
         NX9R2S0KpgFEeMCQJJ9rXewTw6Vc2TTQFmh8uEKG87ga/G/npvR2umS5+GDyM70Uy+aj
         V3uhNgAo+Tr804pt70xnQWcKADWgcVn6w8prGzwp3ppQeMUUOuWhnfbHrf4hMVDftC+W
         RffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=p+aEtGvZStTHC748i1i28Ty2kT6MGPJhRV1hrUdmKEg=;
        b=WvXcA1QOOktG2TvUtRFNXQu4OSxrt4JcLlKPrcRx4iou53OOnGi+iQIbfgwA5/gpZD
         T996uQiOmCbU9+mhu4IhZqa+GI2a76TDlTm6XgCMIKgx7am2vqpOlk/qtbltof01UKFt
         8I7ZEcwXEOy2b+4TRasin2M38HUSqEpl9CyXf/8p5Ugw1P/XaS5x44TRhAyJGLsMlDP7
         RHzxNNM3L5DxgornBLFNfEbWvFB3J2dg4iQy9DF9anzJca/CPV5JhAAG1Dq2yMCZG1hi
         U3g+962U3xNbVUyhYNDA+b3cXvAgWea0Qu3MSlnhi14ZrXsWYU+9jwSp3GjtHYHdM5XL
         bjWQ==
X-Gm-Message-State: APjAAAU1fRzFFZMQvpfRNA48Y6m/o2SffuZnE2Z6m8zS6MoheOaBJ7gw
        BBdw9YMFLe3ZuSbffufhn1lY9Q==
X-Google-Smtp-Source: APXvYqyMp321Ylu46R8IUF7IaH1YMOc8pagfSw6DeM7bdnF1DglzSua5LidZ/hkqj5YhWwxjpD8KYA==
X-Received: by 2002:a92:1553:: with SMTP id v80mr80196819ilk.49.1578102014700;
        Fri, 03 Jan 2020 17:40:14 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id z15sm21439290ill.20.2020.01.03.17.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 17:40:14 -0800 (PST)
Date:   Fri, 3 Jan 2020 17:40:12 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-riscv@lists.infradead.org, corbet@lwn.net
cc:     palmer@dabbelt.com, aou@eecs.berkeley.edu, krste@berkeley.edu,
        waterman@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, willy@infradead.org,
        dan.j.williams@intel.com
Subject: [PATCH v3] Documentation: riscv: add patch acceptance guidelines
Message-ID: <alpine.DEB.2.21.9999.2001031738380.283180@viisi.sifive.com>
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
with comments from Jon Corbet and Dan Williams.

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
Queued for v5.5-rc through the arch/riscv tree.

 Documentation/process/index.rst          |  1 +
 Documentation/riscv/index.rst            |  1 +
 Documentation/riscv/patch-acceptance.rst | 35 ++++++++++++++++++++++++
 MAINTAINERS                              |  1 +
 4 files changed, 38 insertions(+)
 create mode 100644 Documentation/riscv/patch-acceptance.rst

diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index 21aa7d5358e6..6399d92f0b21 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -60,6 +60,7 @@ lack of a better place.
    volatile-considered-harmful
    botching-up-ioctls
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
diff --git a/MAINTAINERS b/MAINTAINERS
index e09bd92a1e44..2987d1e16d20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14119,6 +14119,7 @@ M:	Paul Walmsley <paul.walmsley@sifive.com>
 M:	Palmer Dabbelt <palmer@dabbelt.com>
 M:	Albert Ou <aou@eecs.berkeley.edu>
 L:	linux-riscv@lists.infradead.org
+P:	Documentation/riscv/patch-acceptance.rst
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
 S:	Supported
 F:	arch/riscv/
-- 
2.24.0

