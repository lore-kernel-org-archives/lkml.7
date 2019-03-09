Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88A4C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 05:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57A320868
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 05:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="oD4V7bnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfCIFjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 00:39:44 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:60084 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfCIFjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 00:39:43 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 14A11CF8
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 05:39:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id azuSvgrjRYts for <linux-kernel@vger.kernel.org>;
        Fri,  8 Mar 2019 23:39:41 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id D2DC7CE7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 23:39:41 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id h3so13937383itb.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 21:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DQEP0Ecrj0S52jv+NCt0UhJGFEyXuw7IK/qEbjIGKCA=;
        b=oD4V7bnmUpUERlGamgt01MtaUmezofUy+swDi3wcOj+jFzoM3HqY+n0JhreC3OU7td
         ZEIZX3sCs8QIwhKZedWitdJUKHJImX5FvVghEPzDYjYXqj8dBzUEguxbs+Nrrxv8hmc0
         /Fo/imU0P0e8FfKBdvGQ2FI18a1uvGb4qxkOW2e2YkAIVvvkcMAWLowzUVShokpkucg8
         WrX5FYMzsf69lCVRYSIwb9ZK974xZ995PDYnAy2tayQMZw28dJESN7uKndXLNXUZcSMz
         z8y8pgDOBoCM+HjTG3GaD9anZ3zxkh+G6nmKRV21x4ITVAYtKJJiksKnVZGgoWOaVrom
         vvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DQEP0Ecrj0S52jv+NCt0UhJGFEyXuw7IK/qEbjIGKCA=;
        b=nlAImYzl0OrjeAMvkx0y/JvHoqu3D8W9OaNn5avV/yopvUX7/HaHJSk0/ScpaGOzGY
         cp8Eu/OEw7Jpcw0NSMuso7AqTSNAWJNatbKZMd/3p2U4yboPVLmL7W0dm9igLqMf1t8h
         WDqz8mFPZ5tVa0wXhjUMuTuxBXLBKPgtrXKNbgRo2EpL1VTo4zdCn0gWb975eLfuO0Qq
         qqKkGMu8lRFtSEi5TXmnSm6Sik9jI8A0UkYG8EJozqPLiucmbdAHTkNdb/Q5+b9ktkPL
         47bQUsqPJ23sBem398iJaWrxg8oop53e7KbiJw0zf1PXltW2xeb5GeQ8A3D3+TVE8Zlw
         tREA==
X-Gm-Message-State: APjAAAUqZyraiQzKMU+2M83HG9HD1mMourkeQ/bwHCSxqFmtLZq4ChRe
        1zr1eKEeqQQtyElc+fUUgbZuY/3LbW6g1Irfq4VDpq0W8h0uB4cW5JJD8yxqxPwYzkpfwKkbu8z
        KJns/FaQU96im7dbn58x+GhlTKJMo
X-Received: by 2002:a5e:8c0b:: with SMTP id n11mr4156684ioj.265.1552109981464;
        Fri, 08 Mar 2019 21:39:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqyckxRdIscGyNkbAWu6qHOffxv446t+588Mk+zAZ1TO1WHTZx7FQ2Cj4gqJl5vNxgxJv1o/Tg==
X-Received: by 2002:a5e:8c0b:: with SMTP id n11mr4156681ioj.265.1552109981239;
        Fri, 08 Mar 2019 21:39:41 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id b20sm4063706ioj.12.2019.03.08.21.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 21:39:40 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] input: pm8xxx-vibrator: fix a potential NULL pointer dereference
Date:   Fri,  8 Mar 2019 23:39:21 -0600
Message-Id: <20190309053922.22212-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of_device_get_match_data fails to find the matched data,
returns -ENODEV

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/input/misc/pm8xxx-vibrator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 7dd1c1fbe42a..740e59c11808 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -196,6 +196,8 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
 	vib->vib_input_dev = input_dev;
 
 	regs = of_device_get_match_data(&pdev->dev);
+	if (unlikely(!regs))
+		return -ENODEV;
 
 	/* operate in manual mode */
 	error = regmap_read(vib->regmap, regs->drv_addr, &val);
-- 
2.17.1

