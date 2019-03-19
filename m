Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B8FC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5814213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 00:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="UlWp7EZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfCSA0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 20:26:38 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:48636 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfCSA0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 20:26:37 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 2F63EB48
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 00:26:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2WjJw4m20J6l for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 19:26:36 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 06E51A87
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:26:35 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id z131so16090012itb.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 17:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=OKcCKs/xYcl9Epux1dC9Bd1VY22SUBZOx1LoJhQbK3k=;
        b=UlWp7EZKS7XwukfjHxGwZZdb5MOb7pTJZw8mDpSJ/Qzpvbu9hVou2VAktM61X1rsZy
         j7r5lfj4vhLs8ydaxA9ao63rzvSL3xK/FsSDNr0vg4vDjnjiQ74d+ATkL8loVDiNqeBq
         bJczM8mw9xlgKGK1/THi/XLJ8uAbrHcraGdWtsm2bxnQ4SUrDe0OlEf/BqFw2L+x5zP0
         yNb0t2/zjIwlz8AszSNqDB7QJaLcezbfANSaj75jHsE9Ae/ZS1q+Q0CZPNAzVvS+HdmY
         CBB0E9ZqvyP3SROaQni/SMqqyEaTYcAszw3zVI+xA8VMreamjexXJyerlY8lN3JgnaFa
         YeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OKcCKs/xYcl9Epux1dC9Bd1VY22SUBZOx1LoJhQbK3k=;
        b=cD3g3ncW+WISg8q4FoAgHudoQl+hf2tfHdHPfHE53EExUpRT44dGKvmE7NOSm/Q4Dm
         OBJmBxsTu89L9JfGjInwYITS13cP/NQd4oORIB7D0t1Y5Hfh+7Xd83hQr9o7IMwySKrS
         SGJ5uoQ1cXStXtyIunOCft/9815BjSOGh0Py8y589JsaQDh4gr3eZUYwVB2pHJUmIAFc
         dA2vRKenMmqU9GosMNwtLsyQPwQ6lQ6tJeN2hYv0TuEIUqn2cWz94D8U0oR3zN2Oszeb
         5KaTeMGXqKAFLpGgkE2OhkLQ6hSYn51knR/tPxiGhn3xUwdZiTZ+QY8x0MvI/yhlvS72
         RNUA==
X-Gm-Message-State: APjAAAXahkk3nNFYPiudR/cV5liAN7ijh+wtAXTcEqYDMQLDd7U5R+X+
        LW0hMVjZaUuzqvilb75bJILT2z+7R4vc4myAOKeFkfGJ/b0951XPd9cb6C8wsr6mlEbfGAM83mw
        z9cg1Gn134lQsnuUaX6kyIw58nHuW
X-Received: by 2002:a24:2946:: with SMTP id p67mr1028402itp.114.1552955195621;
        Mon, 18 Mar 2019 17:26:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzcAY+bv3B/ximDoBnh912vC+9939t8Yge1Igs9QzN6ckUxBuMwE+bGjexclZOwRD266Ayxqg==
X-Received: by 2002:a24:2946:: with SMTP id p67mr1028395itp.114.1552955195419;
        Mon, 18 Mar 2019 17:26:35 -0700 (PDT)
Received: from lenovo-1.hsd1.mn.comcast.net (c-73-242-25-233.hsd1.mn.comcast.net. [73.242.25.233])
        by smtp.googlemail.com with ESMTPSA id w6sm4729538iom.22.2019.03.18.17.26.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 17:26:34 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Will Deacon <will.deacon@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Fix to avoid potential NULL pointer dereference
Date:   Mon, 18 Mar 2019 19:26:30 -0500
Message-Id: <20190319002630.12485-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In gen_pci_probe, of_match_node can return a NULL pointer in case of
failure. The patch avoids a NULL pointer dereference in such a scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/pci/controller/pci-host-generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
index dea3ec7592a2..85f473f50e96 100644
--- a/drivers/pci/controller/pci-host-generic.c
+++ b/drivers/pci/controller/pci-host-generic.c
@@ -83,6 +83,8 @@ static int gen_pci_probe(struct platform_device *pdev)
 	struct pci_ecam_ops *ops;
 
 	of_id = of_match_node(gen_pci_of_match, pdev->dev.of_node);
+	if (!of_id)
+		return -ENXIO;
 	ops = (struct pci_ecam_ops *)of_id->data;
 
 	return pci_host_common_probe(pdev, ops);
-- 
2.17.1

