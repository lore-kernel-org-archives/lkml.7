Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946ECCA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 04:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576B4208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 04:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdIA7qYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfKAESe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 00:18:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45929 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfKAESe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 00:18:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id q13so8454814wrs.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 21:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NGhlTP8oZ8XipxhHTj4eiIdTcdXbzg8PKGeLDXhalyY=;
        b=EdIA7qYjj9Zrt774dt0oiZlMSGvi26KO8YGtd8OncH3ftqlG3sDO7XXs3ZBmrOkdzY
         GhK2zQWsc/CevxKkQHy7w6etZdItRLpoqxbTO85PYop92kE31u+VCn9R5PU99TJ733fS
         HyNQmDhCOXd8ingVeTEfdm3cwW6B83MZsSzGSiWhctbM3eCbsNeb/OeESSt32yBv7o5f
         fOB2cNYRpQvr62F1yXZ/ydjq+lK2huhe6m9zTL++5lvjmgypI+hFfEiyrO4eAjfrWiKq
         GJ3gNdNOGPinrt3NCiS5mIRf/laE2m3t09If/VTVQ0tQD2MpOvEBY4fm/RjYSxhumfta
         T+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NGhlTP8oZ8XipxhHTj4eiIdTcdXbzg8PKGeLDXhalyY=;
        b=JzVdx9HE3xIlqi7Y4ZmqSc3DK4dUGjhzTFc1fHYrqJRuyAYvKRZGMhZLCxtzAVTo9y
         3V6s/D/dUc9AD4xhob2+6N6gRXi3KrM8uHPYpZAtjOXbz6yacNj7jvuXugDEqcyTW8KP
         gp8Qek70Tpa5YD07zFaHhUJO14SPhWGuxwXtEh/g7gtwdlJr1lVQQUZQ7kUtobCPQUAC
         Ar7GpzO/fLYsKe6SdaEffnbF1SuWG2RLf4B1Hb7R4hGysB4Qlz79cXXR+QjP4dJbcBUQ
         j7CGujalsTB2B/HDQRsv/+WvcIqWpvaI7HAHolHSDQoonx8xoqD0LIKXoWQVBKUoXZEo
         BsGw==
X-Gm-Message-State: APjAAAXWEaJM72JBut72rPbjDS/3RZLGPUVUxzkuzWvWhDkKbi/Wpw2q
        cXbbbu5pN5HiACFDvtVmgZg=
X-Google-Smtp-Source: APXvYqwltumjagUsai+cQa/vVBU2gQPEaUNhz0/YGjLbZNJV6oODNZWhklfyejFkF987nzfWojq+Eg==
X-Received: by 2002:a05:6000:12cd:: with SMTP id l13mr8822750wrx.181.1572581912624;
        Thu, 31 Oct 2019 21:18:32 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u187sm5743536wme.15.2019.10.31.21.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 21:18:32 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] reset: brcmstb: Fix resource checks
Date:   Thu, 31 Oct 2019 21:18:21 -0700
Message-Id: <20191101041821.30931-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of IS_ALIGNED() is incorrect, the typical resource we pass looks
like this: start: 0x8404318, size: 0x30. When using IS_ALIGNED() we will
get the following 0x8404318 & (0x18 - 1) = 0x10 which is definitively
not equal to 0, same goes with the size.

Replace this with an appropriate check on the start address and the
resource size to be a multiple of SW_INIT_BANK_SIZE.

Fixes: 77750bc089e4 ("reset: Add Broadcom STB SW_INIT reset controller driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- simply check that the resource size is at least SW_INIT_BANK_SIZE

 drivers/reset/reset-brcmstb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-brcmstb.c b/drivers/reset/reset-brcmstb.c
index a608f445dad6..208a87aaee53 100644
--- a/drivers/reset/reset-brcmstb.c
+++ b/drivers/reset/reset-brcmstb.c
@@ -91,8 +91,8 @@ static int brcmstb_reset_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!IS_ALIGNED(res->start, SW_INIT_BANK_SIZE) ||
-	    !IS_ALIGNED(resource_size(res), SW_INIT_BANK_SIZE)) {
+	if ((res->start & SW_INIT_BANK_SIZE) != SW_INIT_BANK_SIZE ||
+	    !DIV_ROUND_DOWN_ULL(resource_size(res), SW_INIT_BANK_SIZE)) {
 		dev_err(kdev, "incorrect register range\n");
 		return -EINVAL;
 	}
-- 
2.17.1

