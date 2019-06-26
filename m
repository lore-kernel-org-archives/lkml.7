Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97382C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC9D208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="e5QEQhKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfFZVXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:23:24 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40332 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfFZVXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:23:23 -0400
Received: by mail-io1-f66.google.com with SMTP id n5so6520ioc.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 14:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=XgHVVh1iwQlYOWPtBpGRVOxMwDek9WmdQZnI0nvo5lI=;
        b=e5QEQhKBazNUkOTeeik1glbub3qI5Xxx4Y0LUQhAdOVNdgtYFqR0SH8KhrjwxNH1e7
         qnX/OyYz+qiUuX7+JvN6Am7S7S2D8kj8wMQcVTu7hbpqBFnUoX4Si758pnyTJUeNXGby
         aQOeSsO9o1G3iz1qfVCY6QH+g4pHkbsRcQQ2lfR0fFgEAM9BoAI54AnQoGHgr0dnFx/9
         cITyW4elC4WQrR/hYc1uGeWJ/6cbdFhzTI75w/TKN8JmPXnQgb8XLNnhKONy9nMoVwXK
         5T3avA7/bwF7n3rqZNNQhVNT6v8RV4BOASCXu9+kcKs2N+MrMB+9Re4wq0f+Y/pY7ZPb
         hmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=XgHVVh1iwQlYOWPtBpGRVOxMwDek9WmdQZnI0nvo5lI=;
        b=O6ZIdkXA+337NvBwp0lctYnRPhMEIGkXc3zdoLO905qJFPIU9aPru29bnCgjXVHGDM
         JfjqHkYnmodPv/kdpTjxj9Tyq23SW5N5Yn+y1QufmnKOb8NuIfx73FwDbBauE7c79+To
         o345kBgQe0Uf/9u1XmF8CwBOjqFno7m1RNQRcohNqPS8a2A2JzEL5me01sxnlp110Tz0
         orKvIOJ7ESwUTqSXeynH6dMzh/lp8Wf5bVnLYzR/5sOZV9ZhviFuY8Ic0rar8pw+cQoy
         EWm4KQka5uRDsFLycJ52jAJIpHjrkbQjS5eIUNJhZx7i4SOOiV6Pu8GKOznLbjStyvkV
         dHBw==
X-Gm-Message-State: APjAAAXm/GuxqdV/WEfHBYwPPEq1IbWfae7dEjk0L3upEper1nNfBtYj
        erICJctmth5FyQlGn4XrkfZUyQ==
X-Google-Smtp-Source: APXvYqw+ux+dOgT6Py/okDOcg4PhOLYcdrOTgEAK7EFsrAfTu0dYtrYWNmFKFatZQ46wQ6kdXTnCYQ==
X-Received: by 2002:a6b:e00b:: with SMTP id z11mr322758iog.27.1561584203005;
        Wed, 26 Jun 2019 14:23:23 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id b8sm302011ioj.16.2019.06.26.14.23.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 14:23:22 -0700 (PDT)
Date:   Wed, 26 Jun 2019 14:23:21 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Rob Herring <robh@kernel.org>
cc:     linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: riscv: resolve 'make dt_binding_check'
 warnings
In-Reply-To: <CAL_Jsq+r08p7ZSt=2XMfR5eZna26wKvG6j-7aBa2Cxbbg6hCHw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1906261421170.23534@viisi.sifive.com>
References: <alpine.DEB.2.21.9999.1906260829030.21507@viisi.sifive.com> <CAL_JsqJs6MtvmuyAknsUxQymbmoV=G+=JfS1PQj9kNHV7fjC9g@mail.gmail.com> <alpine.DEB.2.21.9999.1906261325290.23534@viisi.sifive.com>
 <CAL_Jsq+r08p7ZSt=2XMfR5eZna26wKvG6j-7aBa2Cxbbg6hCHw@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019, Rob Herring wrote:

> Sorry, I guess the indentation change threw me off...
> 
> For fixing the dtc warnings:
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks, I've queued the following patch for v5.2-rc.

Will address the schema-related issues in separate patches.


- Paul


From: Paul Walmsley <paul.walmsley@sifive.com>
Date: Wed, 26 Jun 2019 08:19:29 -0700
Subject: [PATCH] dt-bindings: riscv: resolve 'make dt_binding_check' warnings

Rob pointed out that one of the examples in the RISC-V 'cpus' YAML
schema results in warnings from 'make dt_binding_check'.  Fix these.

While here, make the whitespace in the second example consistent
with the first example.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Rob Herring <robh@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org> # for fixing the dtc warnings
---
 .../devicetree/bindings/riscv/cpus.yaml       | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 27f02ec4bb45..f97a4ecd7b91 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -152,17 +152,19 @@ examples:
   - |
     // Example 2: Spike ISA Simulator with 1 Hart
     cpus {
-            cpu@0 {
-                    device_type = "cpu";
-                    reg = <0>;
-                    compatible = "riscv";
-                    riscv,isa = "rv64imafdc";
-                    mmu-type = "riscv,sv48";
-                    interrupt-controller {
-                            #interrupt-cells = <1>;
-                            interrupt-controller;
-                            compatible = "riscv,cpu-intc";
-                    };
-            };
+        #address-cells = <1>;
+        #size-cells = <0>;
+        cpu@0 {
+                device_type = "cpu";
+                reg = <0>;
+                compatible = "riscv";
+                riscv,isa = "rv64imafdc";
+                mmu-type = "riscv,sv48";
+                interrupt-controller {
+                        #interrupt-cells = <1>;
+                        interrupt-controller;
+                        compatible = "riscv,cpu-intc";
+                };
+        };
     };
 ...
-- 
2.20.1

