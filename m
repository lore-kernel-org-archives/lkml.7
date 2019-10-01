Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67211ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C63821D79
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZqBzbSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfJAWtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 18:49:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39904 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbfJAWtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 18:49:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id e1so5218519pgj.6;
        Tue, 01 Oct 2019 15:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z1Pess6DXDrIJ6QuvI+LdyiByRaqVj94CLs3+lzmJ5o=;
        b=EZqBzbSqJ/oiCi2BVeW+i30dhgCEgolAMnyF4Jnp4AtgxNO/51bosS3wuQjEtMZlGz
         wS/D32oNkR7kHV56Vpwwcz6+q65xTgdhnc6+qrmVK/Oj81txfdmuG56SXqiEVuGBPMN2
         FiQW6lsPDeAm3TLoa7qn35pOjssjsXlhpqR7+4BXJPFhVGwN+fzAmWZmoVKLAuOnbMqx
         bRxz0I2CarEp1/gASvpVEG9AIJWK08K7lWdrHBBemvHolyOprHtml+YXNSuz0egk3YUl
         w+n7QdP0bhnJo7buR1GTF+o/57Aamdoy7k2wOJXkYVbS62JxIO0WAWcv7y88zKPqg9tm
         FqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z1Pess6DXDrIJ6QuvI+LdyiByRaqVj94CLs3+lzmJ5o=;
        b=uI+iFEUxSoASd6koMmAAeZzIGMxHh6trcdW3XUyRrRi0BJVU4anmByxkfJVVUEZSBx
         d0Jj/BPGi4z/nvY+aqmYbJvxba3a2UiWNSz4zUVtlGe1wEehJxJIi7444XFu1wKp6S+s
         Czf2wSeACHFci/mxxZxVS1tL8v68Ym12Ldq1Ni0qfU6aXVBN9IXB8qT3NoihciLOgPDQ
         2HF2NNmaCdSRtv6OpqwJAIeOZUV+JQqSgPzovG2St4E5Sxkd6UMbYXGTCfzjlQVIl65F
         RcUO++yoFAhVeBrCKER+ADh3UAkIDFOXYOmVqizqxfamtxnjTno4MqFMZd1F99e1fIPc
         CvWA==
X-Gm-Message-State: APjAAAVk8aEXvQqaM2L+aulRw+pQiZCC2vR7VVRC/VYKqI5Kwr670YqF
        e3EMw2c8tQJ7q1U6+v/IuSCJixm4
X-Google-Smtp-Source: APXvYqx5ANUNN4OOVi4A++zUe4iTxYkufULDuB9G0Tf8zSYfbwZHhRr1PXjXyoHGYlb+DE5jYyIhgQ==
X-Received: by 2002:a63:314b:: with SMTP id x72mr276125pgx.350.1569970140554;
        Tue, 01 Oct 2019 15:49:00 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c128sm20913506pfc.166.2019.10.01.15.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 15:48:59 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2835
        ARM ARCHITECTURE)
Subject: [PATCH 4/7] dt-bindings: interrupt-controller: Add brcm,bcm7211-l1-intc binding
Date:   Tue,  1 Oct 2019 15:48:39 -0700
Message-Id: <20191001224842.9382-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001224842.9382-1-f.fainelli@gmail.com>
References: <20191001224842.9382-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM7211 uses a very similar root interrupt controller than what exists on
BCM2836, define a specific compatible string to key off specific
behavior.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt    | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt
index 8ced1696c325..13bef028d6ad 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt
@@ -7,7 +7,9 @@ controller.
 
 Required properties:
 
-- compatible:	 	Should be "brcm,bcm2836-l1-intc"
+- compatible:	 	Should be one of
+			"brcm,bcm2836-l1-intc"
+			"brcm,bcm7211-l1-intc"
 - reg:			Specifies base physical address and size of the
 			  registers
 - interrupt-controller:	Identifies the node as an interrupt controller
-- 
2.17.1

