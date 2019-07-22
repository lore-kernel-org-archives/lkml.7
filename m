Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A96C76196
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 03:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3717821953
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 03:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqPXqG/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbfGVDNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 23:13:12 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39499 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfGVDNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 23:13:12 -0400
Received: by mail-io1-f65.google.com with SMTP id f4so70770176ioh.6;
        Sun, 21 Jul 2019 20:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7nLJ3KhNlJhRRaXlyF42twki4b3rKtuNTKBPyNlE3IQ=;
        b=jqPXqG/oPAGlVy92Sm9qnxD+OvIzZqFK5eI5gg2EDcOH+fuIgBpRB3K+O0TVYQ9BUs
         f0ZAPiqWdLDOPmgiMCL/esg6SNd1n7RWeM4qY5CrHnpCAHQg10/UjMBpwpuEWB5gOEhh
         h8yfJW67AIj3gAJAdRaj9vxjdowL1kYOy82T9vuSsBsmGeT2uh5aDh7egYxp1+kSrXqX
         sInjrHwlgAo70nXuCe/5RKlbNuUOAmBZkePRiahz3SKXFGVrhPRlx3GdwOj4QtFbQy8H
         6MgI7Y/uPERUg6gmQg0ddE/lsYI16gGqbMeLcmvFCj1zUr77zjoAavCDZEhGiMJAxiWu
         Ed5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7nLJ3KhNlJhRRaXlyF42twki4b3rKtuNTKBPyNlE3IQ=;
        b=gJ6uJCEV4wwXYP1sb6SYPhmh8MPGSPZIxmliB3ojnoR/YA/qXPSfimjotyO7qYBkQu
         krz0o7Ql8O4Iq4Pd1Z920b0hBOPrEWCmnyDIEaLgJkJE5kx1D+bBo5q+9sKQ6BVWf12p
         zNERbtEmw2cHh6QdY/ksWfVqYJdDIkfl2v5H+H6l/KWZ2UnOApPyuFlX2MpHr1vLZ0dN
         4bd1G0rsZDYM4/Z83CRvtqHxPG1ZVldVGwu6kSsf2sA5s/7l4hGjiHHwXk9BgOVRyAU9
         GMAKj2jIU7eloZTmjJm+tds0U7bI/4A1pnarNfuOdMdo41HQ7iNFMWql8O5lHf/jrnkE
         9ilw==
X-Gm-Message-State: APjAAAV0+HIJ8ll2MzynAM2U4emUQbe9j6gXbvLl5KNlDV6VaI1/Q/Hh
        YpD264NBXPbVBA5Plp5S6Xo=
X-Google-Smtp-Source: APXvYqx4gv53O6eTeHDOY1PKbA2BRqMTgy2yzBJlA/ATL/NszLULz/MF+bvCTd4ZGVSB638JAjyW+g==
X-Received: by 2002:a5d:9c46:: with SMTP id 6mr2898495iof.6.1563765191710;
        Sun, 21 Jul 2019 20:13:11 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id v13sm32107611ioq.13.2019.07.21.20.13.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 20:13:11 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     dvhart@infradead.org, andy@infradead.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     bjorn@helgaas.com, rjw@rjwysocki.net, skunberg.kelsey@gmail.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] platform: x86: Remove acpi_has_method() call in wmi.c
Date:   Sun, 21 Jul 2019 21:11:58 -0600
Message-Id: <20190722031158.70311-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_has_method() is unnecessary within __query_block() and should be
removed to avoid extra work.

wc_status is initialized to AE_ERROR before the acpi_has_method() call.
acpi_has_method() and acpi_execute_simple_method() failing due to the
method not existing will result in the same outcome from __query_block().

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/platform/x86/wmi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 784cea8572c2..59e9aa0f9643 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -340,9 +340,7 @@ static acpi_status __query_block(struct wmi_block *wblock, u8 instance,
 		 * expensive, but have no corresponding WCxx method. So we
 		 * should not fail if this happens.
 		 */
-		if (acpi_has_method(handle, wc_method))
-			wc_status = acpi_execute_simple_method(handle,
-								wc_method, 1);
+		wc_status = acpi_execute_simple_method(handle, wc_method, 1);
 	}
 
 	strcpy(method, "WQ");
-- 
2.20.1

