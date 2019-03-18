Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1766C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51442171F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 23:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="jZ/8eiz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfCRXoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 19:44:22 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:53734 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfCRXoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 19:44:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id D8BF0B00
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 23:44:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vdgVfx0LlJ07 for <linux-kernel@vger.kernel.org>;
        Mon, 18 Mar 2019 18:44:19 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 9FDE59CD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 18:44:19 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id l10so14683730iob.22
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 16:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=F2FAGzd00ReBQkcP1l7B6aUssU0YUzUEzx4/Xf6FlDg=;
        b=jZ/8eiz9KYQkUWH27K07uDD7lWXKjFs4vgUF/ZqE98652EMg0XJSvtBd/oOd6eqvLa
         AlgNNtSWN/hkfKsgr1qYL6PLQLYe1YMLcpICP7MWl0s/huXl7mfDEL7AJjkQOuBJg9nK
         Kx3INsHVbLRz+fAyesrBGk0aucb3shW8wtU+BLjn2Ynh1s5anRIQbM0g89dAcbLFkc6n
         WtbmI1RIF49lDdZSIIMTa99bl3b5KqUfmV6w+ZtZ3vyxWuIG3hwh8+iMkDutbGvPvDyV
         LuUbUP835GaMaY3Tz8aXr4ucaHMiYd9Xaz9QNtj82FHPcfWuJdHOBtqcszqbN4RqlU6w
         +5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=F2FAGzd00ReBQkcP1l7B6aUssU0YUzUEzx4/Xf6FlDg=;
        b=ra67tAURyPPviN/XRI4iOUVbQzlsQT9vXhTl2Kye14lvimP5e60AShdifgP3PPWPQi
         rLcJX5S+9NPk0tH1ulsTjz+W1HpqG0ZBzXlwYJ5VyU0ji9mlwzPmmSt3WK4NKkN1fhYR
         sVbKN8OxPOCuo+1l65m9VH8dh6hZQf+C5bJpOrx8riGmPlDgYtT/AR6xucMpUlcSW1Df
         7rIM5mS/AFovOlX/kraaCbyXT8U3oSVZij+l6pAMSPnlKCO28TrN5HnVerWO4F4qH8U1
         Az/Ps+AXFIzZ0JSO/LGFfFcF4OS19I/nhGVLBRNFkzFS2E1p92ogsMd8QxTUwK8Vzgoz
         794w==
X-Gm-Message-State: APjAAAWA48yERYvvBCH5+RMxyDZ7rBLy6mKnlQyWJ7D48jWOpTnkaV/x
        U1lZf2SDYwiU9qnZY5/z/4HDoffT7ZfNxB53dINyhCBLIovprab1cFP74pMZTtrFM6WAmb18W+g
        Tlb1Zp4jK3PMi3O0RjS6egMGsEFmT
X-Received: by 2002:a5e:a51a:: with SMTP id 26mr13915079iog.254.1552952659273;
        Mon, 18 Mar 2019 16:44:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy40CXHEnlwrDpEJ0GSg/hDBx6F+qDHMlnIsggzMRPtyldxGsxpmdgGQB1mtOYK/4qXvDRNUg==
X-Received: by 2002:a5e:a51a:: with SMTP id 26mr13915068iog.254.1552952659078;
        Mon, 18 Mar 2019 16:44:19 -0700 (PDT)
Received: from lenovo-1.hsd1.mn.comcast.net (c-73-242-25-233.hsd1.mn.comcast.net. [73.242.25.233])
        by smtp.googlemail.com with ESMTPSA id e18sm442623itc.20.2019.03.18.16.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 16:44:18 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] serial: max310x: Fix to avoid potential NULL pointer dereference
Date:   Mon, 18 Mar 2019 18:44:14 -0500
Message-Id: <20190318234414.10402-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_match_device can return a NULL pointer when matching device is not
found. This patch avoids a scenario causing NULL pointer derefernce.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/tty/serial/max310x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index f5bdde405627..450ba6d7996c 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1415,6 +1415,8 @@ static int max310x_spi_probe(struct spi_device *spi)
 	if (spi->dev.of_node) {
 		const struct of_device_id *of_id =
 			of_match_device(max310x_dt_ids, &spi->dev);
+		if (!of_id)
+			return -ENODEV;
 
 		devtype = (struct max310x_devtype *)of_id->data;
 	} else {
-- 
2.17.1

