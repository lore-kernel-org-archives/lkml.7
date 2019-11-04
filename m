Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C98CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8644220869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5MCpg1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbfKDSTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:19:21 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38185 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfKDSTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:19:19 -0500
Received: by mail-wr1-f66.google.com with SMTP id v9so18269604wrq.5;
        Mon, 04 Nov 2019 10:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jqFW9T9RJ/ISderEtopGklmK4C6dkJo0rJ+OS3iJ73A=;
        b=S5MCpg1L8b02V2z2ICSzdNKGmQ287S0OI3azyhOeH6NEuNYcUmDfTvy8dfZkDKKtV7
         6HwpPPVECl2f+lB9SorKs/8nY0afZF7Z1vNzj6uiQ6Bc11yzW47MtDomJtuxZjRJ/Wst
         +wkD00OOYujOwOLm7utUPIS8AjYgaqSy8uPfXaUss5tgWa283uxe8UEA8+OqGtNmMfa/
         /AlNzr88OEBqTq3dJalHF0lJ1jA5kQm8jlrYjotT+FUGgWHDcBHPjwSEU7z/KD9B9FRR
         R8w1ScpR3Tpav87C/2blQukhmXn/Axet/nGj61F7XgohAtfWIKNHtd4H5Lu6sf1z9zJF
         jYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jqFW9T9RJ/ISderEtopGklmK4C6dkJo0rJ+OS3iJ73A=;
        b=JvOszIk0YqTghKxc4iNgLwosVDOcuAEnrxcLhOm1XFi2mKlNQKY6VKgpJkbJagKSnE
         kc2FnlzWZWL/pbN3iXYfivWUNroFu2LgY8/2HQr/PR6cdE6bNk2VjNUfSDJ9U+7zyfZ2
         XAtuBxyiuhKqUafFhx54gUiqMoCYBFfPb3XzkztSp6fOqglUbtyELGbfgHOwnj6QzBo5
         bNkbjXV9Ed6ETxELdW4HmX3e/MZDcVpwi3KcBxP0icJfxxwl+12jPHlRF84pWj+GQPxj
         HuERlEbbfq2gjb2P/v3YYVSaNyOsSk+Q7KuGUUtSDUKYsgNM7dtR5viZ7j7J0IQRxBlh
         bKdA==
X-Gm-Message-State: APjAAAVZpXsZxrjfJKLj6tESBKCwggPL/Wa6f+BM632uhbxjW1dWGLCj
        Orf6lcfd5fug/nrAeSo1gWI=
X-Google-Smtp-Source: APXvYqwon4ik4HW0JxMQygfcZEahSfXgMdF7oXGavgz6ks/vmPmxJ9ruyVfcUYUmW8Vsk/bDiENHzg==
X-Received: by 2002:adf:f607:: with SMTP id t7mr3189673wrp.390.1572891557087;
        Mon, 04 Nov 2019 10:19:17 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w8sm23127580wrr.44.2019.11.04.10.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 10:19:16 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] dt-bindings: reset: Fix brcmstb-reset example
Date:   Mon,  4 Nov 2019 10:15:01 -0800
Message-Id: <20191104181502.15679-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104181502.15679-1-f.fainelli@gmail.com>
References: <20191104181502.15679-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reset controller has a #reset-cells value of 1, so we should see a
phandle plus a register identifier, fix the example.

Fixes: 0807caf647dd ("dt-bindings: reset: Add document for Broadcom STB reset controller")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt b/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
index 6e5341b4f891..ee59409640f2 100644
--- a/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
+++ b/Documentation/devicetree/bindings/reset/brcm,brcmstb-reset.txt
@@ -22,6 +22,6 @@ Example:
 	};
 
 	&ethernet_switch {
-		resets = <&reset>;
+		resets = <&reset 26>;
 		reset-names = "switch";
 	};
-- 
2.17.1

