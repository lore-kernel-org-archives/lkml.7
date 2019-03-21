Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBCEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE1BC2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 14:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZRX4XRSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbfCUOAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 10:00:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32827 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbfCUOAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 10:00:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id b12so4287293pgk.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 07:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JgtWdTWVjfeKR1PN/KvKupfZGywfb4JTp1dgED59nGs=;
        b=ZRX4XRSYbPI8so0NuF+gTK2ZV70Fk49z4391/fChIH2T9jv9kbUI6WsBTaNhK6PZhy
         FCYJFumSM1v8Av5Fhvq+d7EH9P2RUVe4z4xAiA1OPb+UJbzitZW4U5B5pa5Fn4YUsZMa
         WgJNelMlEX/4cpf13Y5phivvw1PrFR/GJ8OGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JgtWdTWVjfeKR1PN/KvKupfZGywfb4JTp1dgED59nGs=;
        b=HF6qclydgTp25FCzZFTLl5kCH3fg33zR7bbg3PpGjTVe9g8QYTeECw4qmP0ppsvmZU
         RNiFESEijsTjELFzMSjHmYJg61FO3m31Psat5m0/EFALb7b2Zg13MRI6PhmBRzGWXXy3
         pYG/cALTExbh4Z9kmHeXaAuDHkJ0mMdHwXof7liTId7rxR7jpG0u6HTqgSm2JEEEhWEf
         EEr4wsS20r7ZjBKHvIvhrzZAXtjTTzlOcsPcVUey3SUmV0p5EFRBJnKAaShq56eJlkWs
         PCd5+KScXkcZvxELKZQyzuHPi0QzbQrl3Xojkcphqpg/V9t8BuaLfCynbPx5oI8TOI6l
         K4YQ==
X-Gm-Message-State: APjAAAVilZRPHVD6K/PqzOahPkLGuszu/5JT7VnL4tK5sZ3gCV7oo9fc
        EcxX55kim4SbVtD7dwHPrIvv7Q==
X-Google-Smtp-Source: APXvYqwb7UIUPqGyhpq7jSNuZ+q1L8fYioAxtNYZpyppKx9HJzYzAJgd/VhQoqYeJCv6h+w6pYJRiQ==
X-Received: by 2002:a63:124c:: with SMTP id 12mr3430720pgs.86.1553176820755;
        Thu, 21 Mar 2019 07:00:20 -0700 (PDT)
Received: from localhost.localdomain ([49.206.202.234])
        by smtp.gmail.com with ESMTPSA id i126sm7985158pfc.101.2019.03.21.07.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 07:00:19 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Ryan Pannell <ryan@osukl.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        devicetree@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 1/4] dt-bindings: Add vendor prefix for novatek
Date:   Thu, 21 Mar 2019 19:29:52 +0530
Message-Id: <20190321135955.25661-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190321135955.25661-1-jagan@amarulasolutions.com>
References: <20190321135955.25661-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for novatek.

Novatek Microelectronics Corp. is a leading fabless chip design
company specializing in the design, development and sales of a
wide range of display driver ICs & SoC solutions.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index e32d460408dc..caa7dbae750b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -281,6 +281,7 @@ nintendo	Nintendo
 nlt	NLT Technologies, Ltd.
 nokia	Nokia
 nordic	Nordic Semiconductor
+novatek	Novatek Microelectronics Corp.
 novtech NovTech, Inc.
 nutsboard	NutsBoard
 nuvoton	Nuvoton Technology Corporation
-- 
2.18.0.321.gffc6fa0e3

