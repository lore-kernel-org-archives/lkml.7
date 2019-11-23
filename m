Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6FFC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 23:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1D320659
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 23:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="S+TW1nKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfKWXiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 18:38:55 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46191 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfKWXiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 18:38:55 -0500
Received: by mail-io1-f65.google.com with SMTP id i11so12058117iol.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 15:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=56zdBpxlclR0g1LjYAS1+32bVAGecBlra1y4WDc61ak=;
        b=S+TW1nKxE5gRiH0TPfNeT4yyprYSSApYNNurctsEcBCQsSqmNsRfTZlHBzYmsw7E0S
         QRk1VUsNgB8IeBSzwrihAhPgW4go96mZ7mQaDI6+T7nrCClTTycN7QJW5xPZ0cYem5hF
         1kALf0BBRfROJIb/sh4xSnXUkxSx3/qgo+P2MDl2Z/DxPS6B/1HYM5ajQEYq6b1vJPH7
         7xEg3fDb1D0d/lz6nDInR50lI2UDeGOJQOtlBQpbuYq7gbzSJaAiH68w1gI4dB5CM0bq
         qPuMTuyDLS+2WGo/S3Fq0uAUKvoVrka0cHKSiALFAZBkIS9hqNdSrs9o6NKDHff1aQ0U
         TBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=56zdBpxlclR0g1LjYAS1+32bVAGecBlra1y4WDc61ak=;
        b=A0W9kQbcm/rOVUFk5xSw6TJUTFhy6G+3xnSagkdzXTl18yBQn3hCUCZOgrwM2Wgobk
         jqkaNxjaR/vODpA+HNQOGDpAn0jpT3yYdXDIq5Iq9n+oHcHfCVw3xDz5cSpdkU7RkIeh
         PpPahzk1eiEn8SFHZgclHQ64t2XJhl4ptR7v8WxOg+VaWvxxYFlAzrpFoKoKYdqvdoBl
         7Vs6prxq4kqKhiXpS5FvywD9zfykb38Y3mYr0C1UfC5WvR9T9h4bOTyKsZc5e4I7hOHy
         gD5rZGWaZ0Wq8U+XhZeQdBLJxgI27f7PXejUl8xL0a2SDFwcekC7kQM3tes+Hmb3VwRl
         muPA==
X-Gm-Message-State: APjAAAX/AgYrfkei/p/h2/ImeoKf57+C+VDd4cHttUJG44Hv0wPY5hq0
        AYKauCspzU6RwDQSWfIEM2Xiww==
X-Google-Smtp-Source: APXvYqwlp/VBmKTfbXYnwdw6P2u/JqwD2uFYCVpGOeBQfXAbCAE1DRvFvX7L5V0UpSEy3wwjtI/t8A==
X-Received: by 2002:a5e:d602:: with SMTP id w2mr16471010iom.94.1574552333070;
        Sat, 23 Nov 2019 15:38:53 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id j18sm696555ili.84.2019.11.23.15.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 15:38:52 -0800 (PST)
Date:   Sat, 23 Nov 2019 15:38:50 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Matthew Wilcox <willy@infradead.org>
cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, krste@berkeley.edu,
        waterman@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: riscv: add patch acceptance guidelines
In-Reply-To: <20191123035827.GZ20752@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.21.9999.1911231536300.14532@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1911221842200.14532@viisi.sifive.com> <20191123035827.GZ20752@bombadil.infradead.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Fri, 22 Nov 2019, Matthew Wilcox wrote:

> On Fri, Nov 22, 2019 at 06:44:39PM -0800, Paul Walmsley wrote:
> >  Documentation/riscv/patch-acceptance.rst | 32 ++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >  create mode 100644 Documentation/riscv/patch-acceptance.rst
> 
> Should this be linked into the toctree somewhere so it's findable
> on kernel.org?  Maybe add a line to Documentation/process/index.rst
> to include ../riscv/patch-acceptance.rst?

Does this updated patch contain what you had in mind?


- Paul

From: Paul Walmsley <paul.walmsley@sifive.com>
Date: Fri, 22 Nov 2019 18:33:28 -0800
Subject: [PATCH] Documentation: riscv: add patch acceptance guidelines

Formalize, in kernel documentation, the patch acceptance policy for
arch/riscv.  In summary, it states that as maintainers, we plan to
only accept patches for new modules or extensions that have been
frozen or ratified by the RISC-V Foundation.

We've been following these guidelines for the past few months.  In the
meantime, we've received quite a bit of feedback that it would be
helpful to have these guidelines formally documented.

Based on a suggestion from Matthew Wilcox, we also add a link to this
file to Documentation/process/index.rst, to make this document easier
to find.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Krste Asanovic <krste@berkeley.edu>
Cc: Andrew Waterman <waterman@eecs.berkeley.edu>
Cc: Matthew Wilcox <willy@infradead.org>
---
 Documentation/process/index.rst          |  1 +
 Documentation/riscv/index.rst            |  1 +
 Documentation/riscv/patch-acceptance.rst | 32 ++++++++++++++++++++++++
 3 files changed, 34 insertions(+)
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
index 000000000000..2e658353b53c
--- /dev/null
+++ b/Documentation/riscv/patch-acceptance.rst
@@ -0,0 +1,32 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================================================
+arch/riscv maintenance and the RISC-V specifications
+====================================================
+
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
+Therefore, as maintainers, we'll only accept patches for new modules
+or extensions if the specifications for those modules or extensions
+are listed as being "Frozen" or "Ratified" by the RISC-V Foundation.
+(Developers may, of course, maintain their own Linux kernel trees that
+contain code for any draft extensions that they wish.)
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

