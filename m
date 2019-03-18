Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55985C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E082173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ESlQByLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfCRXvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:51:04 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:59188 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbfCRXvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:51:03 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id DB14B57A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 23:51:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zZk3zqQNHM0V for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 18:51:01 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id AAFAA6EB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 18:51:01 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id b16so10717820iot.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 16:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Jgwycnzkt+6yQIl51mnMpkPhrLUiyGfoF5WlF//cSPw=;
        b=ESlQByLm0zPOeDkCoWJU7mtCcGFiFxEkhGl0e9AkXThe6rgs9yqEzE2d/GueWLWAzn
         Sel5ZgNmjeVtrIatxkIIjYt8OW4xgH6e9OectTEApl/yLXsYjaISyVmcOMKFPfaZKpgc
         uRDTylMF/g8jYw74jOItnVtmDXZ+eLenXci/Xg7Xotb59GlKTqgMk6vEnuT5/+N1pwB3
         vj4IMkfzYjHrYBNV2d9VOyGbuTL5YAG+TC8WE/1HQ5Q/FWbSYpFUY9LbS5i5GxkXJ0SL
         y8uBc1Cd0clRpZt7VqjYPkkOlPajwI1DwmBetpmItmLQBqKM1Zi9SPU2lpbELn5OafAt
         Mzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jgwycnzkt+6yQIl51mnMpkPhrLUiyGfoF5WlF//cSPw=;
        b=skHqEfcJt2V3yQWkc37bfJZLFUvAe9I2fyr0VNP0+EciSld5yAj7XQgyCjICmaIt3O
         5S1mVZCY1V4/9SHzBrLSDU/bIUOkOQiZlN9+pI/SaPM7oPOZwn2K88AgXCJGDWlxFLr7
         WhTEnIT1vMngKICwk8RzzFxkEe2gF90f1KYYlOODk0STX5l0xz2XAoVoU8thTBa8AAFj
         r3ykd/LM7C31teNkUQFnKJsrSyIPHeIT77xPuI41XGLKEWK6sVVyEFiKrciyAL4vZUEz
         WxxScmjDoSGpb/4qiIV3FLKbcoXUxoR8+V7k/x2X1QMwB2kthO4NcBWZswwqojCvKCC0
         Dcgw==
X-Gm-Message-State: APjAAAUdwIJbYXPx0EA17pLc9WvayU0G9kO4c48bNKnIT7ygfsYpVy0X
        +cE0hVhMHYVEGtK2c/nbJqJ+MalTewDyYSS8DxoxH3PwZ6QvJbbpe7WY8pD9f+OWhCjb+259BAj
        gDF1us0Ji9IcwgDiGKIweMPhhEPFa
X-Received: by 2002:a6b:4910:: with SMTP id u16mr7899998iob.150.1552953061326;
        Mon, 18 Mar 2019 16:51:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxAmL9mGPihGHG03wWkvaJrJBgKN+gSgSac4yOoUetCv3s3Y9H9duc6Ramcz5c6VoSz9ORqtw==
X-Received: by 2002:a6b:4910:: with SMTP id u16mr7899984iob.150.1552953061161;
        Mon, 18 Mar 2019 16:51:01 -0700 (PDT)
Received: from lenovo-1.hsd1.mn.comcast.net (c-73-242-25-233.hsd1.mn.comcast.net. [73.242.25.233])
        by smtp.googlemail.com with ESMTPSA id g2sm5087932iom.7.2019.03.18.16.51.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 16:51:00 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] serial: mvebu-uart: Fix to avoid a potential NULL pointer dereference
Date:   Mon, 18 Mar 2019 18:50:56 -0500
Message-Id: <20190318235056.10736-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_match_device on failure to find a matching device can return a NULL
pointer. The patch checks for such a scenrio and passes the error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/tty/serial/mvebu-uart.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 231f751d1ef4..7e7b1559fa36 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -810,6 +810,9 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (!match)
+		return -ENODEV;
+
 	/* Assume that all UART ports have a DT alias or none has */
 	id = of_alias_get_id(pdev->dev.of_node, "serial");
 	if (!pdev->dev.of_node || id < 0)
-- 
2.17.1

