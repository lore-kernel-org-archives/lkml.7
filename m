Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E2DC7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 09:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F67F20659
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 09:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTEaCpTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfG1Jaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 05:30:55 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42758 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfG1Jaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 05:30:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so26509116pff.9;
        Sun, 28 Jul 2019 02:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=//Jv33RApRdIWivr1AaSMY9thwcYsKbzUTeGOkJOzyI=;
        b=NTEaCpTgsZ0te86AUZoP0nnvyjTvQc0/KvHjecVxvocYcOYJ83oX6MCdwdkB/rvB8A
         SxNz6AmXGP6oepbH2oDHyuiMBZk17zuJXfUiag0LMwQIdEB66i5MdY4u8F1BRGNMnlSX
         JrAh6IHeBnVrp6aHS+vmlazBI4giiS1rlTbDYRwoG+CNbmFRl/7XcN+r9C9Ssbe00q2N
         SDQ3AnZaDjqx6ZMbNGUnOriwkSe7IriQ6uOokkyNTkflRL/wnsedzi8m0MB36vgh2FR3
         ZPts2N7W4tbloJy90k7nv+C/6c8rOK1X4uCXzG++FXTxcw+zU40JFEL7v7msGHhyCzoS
         65vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=//Jv33RApRdIWivr1AaSMY9thwcYsKbzUTeGOkJOzyI=;
        b=V8cqlvvk4livn0c7fI56xsBP/4ZbaWdGKFpcnAwClJLGXGoD5evSzEgP1PABOHsynH
         /+gAA2tIjNx5UXZ1RF2PeQW9cg7UfR3PCqXuLbLn6vefgDS5nYG8jVTEMQfOiEv01R9z
         Q8oyZOG0H+JD/m/tJRrcK+rc8r5RQfU7hq0ecGBRIn0q3BKuezx1iWl69IUlg/gooROG
         aO9e2a1lELRtzkIGmfd8OYYQTZMWOXPhaMpx0ZcvcDuKmvjsEqUO2rrNp/MXYxKGd1HB
         iGhgCmLVsQTf8ov+KiSBFSxOpzpgEdvXX59YimnJniSgh8zTBxFI+fAaf8dSkOg3SNkw
         9Qbg==
X-Gm-Message-State: APjAAAXFDxqr9gfDejQ8fGNl70RaiFuwU7N7zJEsXRdOu6vvrQ9pYcXe
        QZdWDugQtBKxmvR0rltGxvohnYus
X-Google-Smtp-Source: APXvYqwtHBxanejvuCajsmepJw3LJ8U832BCDyyTf8jeauRfoT9SOc2S1gkbFd0NksYLH+ExYBduwA==
X-Received: by 2002:a62:640c:: with SMTP id y12mr30320972pfb.166.1564306252054;
        Sun, 28 Jul 2019 02:30:52 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com. [147.11.224.80])
        by smtp.gmail.com with ESMTPSA id s20sm66237380pfe.169.2019.07.28.02.30.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 28 Jul 2019 02:30:51 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] dt-bindings: pci: pci-msi: Correct the unit-address of the pci node name
Date:   Sun, 28 Jul 2019 02:30:19 -0700
Message-Id: <1564306219-17439-2-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1564306219-17439-1-git-send-email-bmeng.cn@gmail.com>
References: <1564306219-17439-1-git-send-email-bmeng.cn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unit-address must match the first address specified in the
reg property of the node.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
---

 Documentation/devicetree/bindings/pci/pci-msi.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-msi.txt b/Documentation/devicetree/bindings/pci/pci-msi.txt
index 9b3cc81..b73d839 100644
--- a/Documentation/devicetree/bindings/pci/pci-msi.txt
+++ b/Documentation/devicetree/bindings/pci/pci-msi.txt
@@ -201,7 +201,7 @@ Example (5)
 		#msi-cells = <1>;
 	};
 
-	pci: pci@c {
+	pci: pci@f {
 		reg = <0xf 0x1>;
 		compatible = "vendor,pcie-root-complex";
 		device_type = "pci";
-- 
2.7.4

