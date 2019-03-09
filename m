Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC23C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D346207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 03:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="MFgu4YhM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfCIDuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 22:50:35 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:60574 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfCIDuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 22:50:35 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id F35E4C66
        for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2019 03:50:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EP9NqimBykNA for <linux-kernel@vger.kernel.org>;
        Fri,  8 Mar 2019 21:50:33 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id C4B23B28
        for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2019 21:50:33 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id i4so13770868itb.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 19:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+zIdVLaNQ7nclvicP3p+h3XB1JxprdsDsd4w6dLypVk=;
        b=MFgu4YhMYXmTpoGR+KtRVRfUjY2pE4l4qyyoGn0p/uGBZmdHwHPr7+hujpYyoBzvdb
         A1pk1JLbAZr+7q9YI/VKk+/VhonQmk4Rsd6IZV1GjNh/F1RK3ylul4EyivMMgpnuI76Y
         +OgYRBGOAzAWvRroKQrW2KmQiS4SiImY6MTfUqo1Ht1xnbV5end0J49HaOOsPsi5l1Kc
         d/dwac8H3Fs+vSDDjYXGLxvDAV9M7aZ0U+uc3reUXIBWA1mR9XINVyNZxu3HqvjdT5nZ
         FJS0Ae7DZqP0mMyRFcuXpNX+sN/gY2UkdV5i1VQpfZCZBWByI6I3I5bUdYid6K4W6rPf
         V+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+zIdVLaNQ7nclvicP3p+h3XB1JxprdsDsd4w6dLypVk=;
        b=UTVe+VNiVZzKQzHR1/McSPztlVJeJun0GK7M7zBDQmOEW68tgEzSlnm3Gk00ljrTPI
         vi49sKWE3p9GoAr084AfEP/fCAcMq6KGA7X9cAR3QAZFU+JNkqOYzblevwcQwb5w97wa
         xXw74Eu94Ws+3UN7KGS36qIirXIE/DoMKgOL8wLlGOiDTUrLdXJbqo0Ixitt5oPWw6iw
         MZB92MVab7HsZr313CuXMvpAorjWPylilutNjHwQnh2B1HRiBFWKNE+pDmj7LPvYnSiP
         yK1F3A7CkRwQ2OGqdA73WXvvVBkwxh5oeM3bfNM89iZi5JwFb0ru3YYBfLLNQxNWEela
         V3bQ==
X-Gm-Message-State: APjAAAX+fcEwsFD4QGpLfTnnw3JTcBDZXDUDxoo7OLwVL8Tt4cGAdwWU
        Fo3joOL0zgUlMyB//DITObKKCzndjxGwafbSoefJaQxXOOeohzk/16c6BAihyZcjWJ9Lr1kuxGl
        1+cViXLV+JSW1UyBwguYJVtxH4qZ2
X-Received: by 2002:a24:ad5f:: with SMTP id a31mr11225537itj.65.1552103433402;
        Fri, 08 Mar 2019 19:50:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqyzyGIFX0JSpA/wODLeGVzUmseSpxGx5AuuW/xRnD1rKC1+2hQvLKhmCfipnWqSEo+BH+lMJg==
X-Received: by 2002:a24:ad5f:: with SMTP id a31mr11225531itj.65.1552103433149;
        Fri, 08 Mar 2019 19:50:33 -0800 (PST)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id r19sm3969728ioa.35.2019.03.08.19.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 19:50:32 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] char: hpet: fix a missing check of ioremap
Date:   Fri,  8 Mar 2019 21:50:24 -0600
Message-Id: <20190309035024.31298-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if ioremap fails, and if so, return AE_ERROR.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/char/hpet.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index d0ad85900b79..3a1e6b3ccd10 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -973,6 +973,8 @@ static acpi_status hpet_resources(struct acpi_resource *res, void *data)
 	if (ACPI_SUCCESS(status)) {
 		hdp->hd_phys_address = addr.address.minimum;
 		hdp->hd_address = ioremap(addr.address.minimum, addr.address.address_length);
+		if (!hdp->hd_address)
+			return AE_ERROR;
 
 		if (hpet_is_known(hdp)) {
 			iounmap(hdp->hd_address);
-- 
2.17.1

