Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C089C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 02:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3673C20707
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 02:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aBHRxzwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfKWCon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 21:44:43 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:45979 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfKWCom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 21:44:42 -0500
Received: by mail-il1-f196.google.com with SMTP id o18so8999734ils.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 18:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=7g/Y3wR5gVZOwog74zMjqNNgFW5KdBsIY/ptyys6DJE=;
        b=aBHRxzwcxFQNrfM9pZLRT4ER5wxGCxmHVr4QWLCAj0lXXyLePykza3DWEfRn2xTjtb
         DbzrSsje9VHZpAfkiZBKWJ6rg2zn+5ujIq3RxemUuIzVN832GWoXfPeJj/JePleSXGZW
         BwzmjDsqiWOyYwXaQuTbSNok8IL/qPFuHXHeJQ3UiEgOd4h7iWn3zarnNLQwgTw92RSV
         hC2069cqB57RCKP3Z8vg7rw5QIYdXwMhWIxSuznScJCJWoS9y0eE+FzU0UKZXq5Tk94Z
         1dTUEgBLtqwoRIgKcmEKpru0HVAPe0Q3x73efiQ+7Wkbpkvo25iYguHhLGem8et3HB5E
         H1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=7g/Y3wR5gVZOwog74zMjqNNgFW5KdBsIY/ptyys6DJE=;
        b=jH+dawPwKXF+cnZhGH0yc3twkdmJDBAH+xAAmzfwPDt4tc2PIVMBKT/Ym06s6jNPy9
         CllfoO3QZlZaNZ9LUE5zqgiJfizhY4my6/1Mo+9FRhIk71blApWfFPO8l3DfQWo2LtJ3
         mSPVrVBS+1a6iTQJuNOXpztvguaZW+qXad7QW/TSG3PKkEtHLlYHqMc5Wsr2czSnzQOv
         jJN6NSAX/pzNA1JLgCZSNR+3TxTdXAJLqnItGT5FilzaDiitKLMZuAUmC96cXTEWBdwJ
         rEyoDXSoBtDUbEaF+5n2oks3mXd6YCBXu2UY4f/2+kLf4RwWtIV+qMoNci0n1j/yIBqu
         kEaQ==
X-Gm-Message-State: APjAAAVbNxWA/3dfM5j21SG30Ms8kMP/6wHQq6eLvXT3KeptmlFRURmb
        vW03K7exTFt4xNofIy7XMy/o3g==
X-Google-Smtp-Source: APXvYqx+rLljVRhSTLXDzWQSdfPi1a0ZZ07AY/mQyuSP3TF8FbIDJWJeh1aiWBGMfCOa4b4vzbLGMw==
X-Received: by 2002:a02:94e9:: with SMTP id x96mr2440290jah.68.1574477081696;
        Fri, 22 Nov 2019 18:44:41 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id l63sm2783843ioa.19.2019.11.22.18.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 18:44:41 -0800 (PST)
Date:   Fri, 22 Nov 2019 18:44:39 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-riscv@lists.infradead.org
cc:     palmer@dabbelt.com, aou@eecs.berkeley.edu, krste@berkeley.edu,
        waterman@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: riscv: add patch acceptance guidelines
Message-ID: <alpine.DEB.2.21.9999.1911221842200.14532@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Formalize, in kernel documentation, the patch acceptance policy for 
arch/riscv.  In summary, it states that as maintainers, we plan to only 
accept patches for new modules or extensions that have been frozen or 
ratified by the RISC-V Foundation.

We've been following these guidelines for the past few months.  In the
meantime, we've received quite a bit of feedback that it would be
helpful to have these guidelines formally documented.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Krste Asanovic <krste@berkeley.edu>
Cc: Andrew Waterman <waterman@eecs.berkeley.edu>
---
 Documentation/riscv/patch-acceptance.rst | 32 ++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/riscv/patch-acceptance.rst

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

