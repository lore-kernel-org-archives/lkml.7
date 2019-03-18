Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C39C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F3B206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="EUxQKtzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfCRXYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:24:41 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:44352 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbfCRXYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:24:41 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id D87809B2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 23:24:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9aHCr0T5_4Pp for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 18:24:39 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id A723EB0D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 18:24:39 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id n15so14845883ioc.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 16:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sMF2XBREPoNW4R62O/UDuiSQwKK53VQtrd6/htMc0i4=;
        b=EUxQKtzJtTvMC2CcfOaaYR7VnXDGZMFcrn/FndD6w/JV5UUss1jdQA+e/idqyrawfS
         Jl1NbPGlNE/ILePFpNL0o2qBcsi323QjdNU+Py/H7HAQc0bfL2s86bdJPpX/W/K2VhDH
         LYRhzSPZcg2RMebbkP7f0MWSsuP1VNn2i0BgcIwgzLtvXIR7vxG/IZvLt1zo3yS7ionm
         DZJ/rHBSZmAfXMaM1fir3p59FOFUSsFOVnqdnm4Djqp9ERLcnUincNkIrGm+XDgzIIYG
         Ctl16dFPCJxgXDPB2iLTg04y/C5etiOzWrVp955jkdm4xuOx15Qmn/nA0egEl8Tb9K6b
         OOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sMF2XBREPoNW4R62O/UDuiSQwKK53VQtrd6/htMc0i4=;
        b=gKmDdqMxeec5cMA/wFNCed2nlKir7K8EFflpTBfb7MmZVygNC4b1Mzh2i6RsbvUNFR
         kRamcNyr+QwkFCHMQzjvNuvHm83cBY9IfE1snuPtlzSvmvlmNCd5X+UrkGX00ONsHxfc
         ngZLQDxNLD8awNQiP8oS2urgpjXaZlZ9Jo7w+jjJjwY03zwPTAjYUeh2lboAsJ3fqLC4
         +5Q6G53QfmJKs0oIUSlfuw9VmvPzgIOKjDCRaRjW3F0TV+f5EiJLn2bOTW2P1VdkdQMz
         fJ7LivFShvlh26UDeia/nhVUnC+Qt/+ssh9UcmZJDb+H+skwQ8DBGprj0QDkjcdpf6Qm
         LCLg==
X-Gm-Message-State: APjAAAVgMlmFjrqAOmTG81sSQJFhXye3DxVQAfbgmU6UIKcLmgDJC6FR
        WWEaWigbUJatL7iX4vWLlqHqMfTZIkhVm/1flxIPEVdoGT3hzu4izHCCytX4HQWPNckBWVcXh6g
        K9hf2YhIDrp1fYjMt9PEzKJSyf/K9
X-Received: by 2002:a24:1c4d:: with SMTP id c74mr883795itc.36.1552951479302;
        Mon, 18 Mar 2019 16:24:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwHnWCKYIJAf8vueMaIosqP2i4VqtXIxqhy5W7HIftxVOZW4+tB88vhVlHdi2q1mU9f4Ws/wg==
X-Received: by 2002:a24:1c4d:: with SMTP id c74mr883787itc.36.1552951479104;
        Mon, 18 Mar 2019 16:24:39 -0700 (PDT)
Received: from lenovo-1.hsd1.mn.comcast.net (c-73-242-25-233.hsd1.mn.comcast.net. [73.242.25.233])
        by smtp.googlemail.com with ESMTPSA id a16sm432099itc.27.2019.03.18.16.24.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 16:24:38 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Stefan Agner <stefan@agner.ch>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: vf610: Fix to check for NULL pointer dereference
Date:   Mon, 18 Mar 2019 18:24:34 -0500
Message-Id: <20190318232434.9246-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_match_device can return NULL if there is no matching device is found.
The patch avoids a potential NULL pointer dereference by checking for the
return value and passing the error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/mtd/nand/raw/vf610_nfc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index a662ca1970e5..946abbb275c3 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -850,6 +850,8 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 	}
 
 	of_id = of_match_device(vf610_nfc_dt_ids, &pdev->dev);
+	if (!of_id)
+		return -ENODEV;
 	nfc->variant = (enum vf610_nfc_variant)of_id->data;
 
 	for_each_available_child_of_node(nfc->dev->of_node, child) {
-- 
2.17.1

