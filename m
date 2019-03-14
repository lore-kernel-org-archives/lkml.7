Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC93C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7547E217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="kULQ0Wtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfCNHd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:33:28 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:57442 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfCNHd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 03:33:27 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 2E8A8B7A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:33:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cY7qR5K8Rvrl for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 02:33:26 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id EA19EC4C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 02:33:25 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id v12so3895570itv.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 00:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2KdFAd7hIIoInlHZ9K0V/3XCy5cD+1K+fdIT5yyXtd8=;
        b=kULQ0WtzP73Vvqdf9QfDwv9Y+au4RDVoy9vcVFKYCbVju58YxY8XNzrHEee1sjYFqt
         atl2MVPEtK/MUetfOcE7LOOScNsZzVwVpJyTvzPLaC1BmjV6zEiJs/ZU4wROvsnWiWOl
         gL5NIsSP11xu+6j6eJy6RlnPm2ulANUD9wQpIdL435NmA8bqiOzqUwtkzkRmF8Hi2/YD
         xQN22QY5CZ+27czwr+FC1WqgFgCsv8W1dcIxORdLg9ebhVvRSOiuB5utWs3LEVka4wF9
         nADZKgxE8UsMwjhQz928OACPkMfiM5no1H9GAOZu0lEQ3sPYfDjqsQH0zxA+heD4fu5l
         RYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2KdFAd7hIIoInlHZ9K0V/3XCy5cD+1K+fdIT5yyXtd8=;
        b=QOgae+Wvms5lwTzQ5CO0R7MRZOLWdwDVOfk+x0+Ia8PC+OJuaG++I0mOSL7zozvyM5
         8BmUeVsJmKZ4XF1ruGIQhCX6NZ3GvWOobvGUp90F/m7fLZAU6HKC2Yij0hOsmMMIS4lc
         HBmip8ISnoJGjCiesobBDXBKeMpcLf91YOePiZfARzAjSKirImeGaL7re6+4XA78Jf1S
         1rvxqABzXFv0T1LzdF6aGrdCGADnjo1b7r4xxfJB4LuErwrdqMdmqiUnfGFLGJfk74/6
         v9YR2kKHI5h2L3FIaEin/yajdCSkWV+ONKLxkNl3fJsedlcTX4iA2lizBqZ9tzPOd5Y6
         yNiQ==
X-Gm-Message-State: APjAAAXfZ+dgIeLQAA3XUTYaYZAUhwPv5Rerm8MVn/Uy9sJVlzkRAVlx
        o37J2XJcVd6cL1SqG8ftmaidTz6S7K1ijuFYBfcC06knNjTKYY2Vjkpq00yKIvQN6wkkOsmi8wn
        QgI/ncsUwQ8x2B2ghSeRto5jIBmN0
X-Received: by 2002:a05:660c:fcd:: with SMTP id m13mr1358831itn.77.1552548805526;
        Thu, 14 Mar 2019 00:33:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqypa2fyX0AVw20mZGED1IerN1dmBKtxViLlhgnyyUBZASgB39ubfjPHAiN9ExxhX1NgCpDHKQ==
X-Received: by 2002:a05:660c:fcd:: with SMTP id m13mr1358823itn.77.1552548805320;
        Thu, 14 Mar 2019 00:33:25 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id n6sm907151itc.0.2019.03.14.00.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 00:33:24 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: fix potential NULL pointer dereferences
Date:   Thu, 14 Mar 2019 02:33:17 -0500
Message-Id: <20190314073319.23209-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case ioremap fails, the fix releases resources and returns
-ENOMEM to avoid NULL pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/video/fbdev/imsttfb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 5d9670daf60e..2e321d73b3a5 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1515,6 +1515,11 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	info->fix.smem_start = addr;
 	info->screen_base = (__u8 *)ioremap(addr, par->ramdac == IBM ?
 					    0x400000 : 0x800000);
+	if (!info->screen_base) {
+		release_mem_region(addr, size);
+		framebuffer_release(info);
+		return -ENOMEM;
+	}
 	info->fix.mmio_start = addr + 0x800000;
 	par->dc_regs = ioremap(addr + 0x800000, 0x1000);
 	par->cmap_regs_phys = addr + 0x840000;
-- 
2.17.1

