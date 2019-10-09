Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350F4ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC3221721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570618153;
	bh=IfM4sXsvKneSTjzc9pG1+JjgAAbQBdAGhjrDFZmRyxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OxpH2cPRuOwWDk8U+dEBdH4ljLfb2uEdwA4WL7I8gucDTivwipMksPjmP+IzhdKx6
	 JPatbRNWhPYn6XKCV3GY2yJeuFDwgCgflAHRHrcld5ww9Pd+4pJ2IHdKBmDKx+LFf+
	 LLFnqz/duqZOi7h80OjdPOFcw4J4fewZ90/YBF9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbfJIKtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:49:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32827 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730936AbfJIKtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:49:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id a22so2015033ljd.0;
        Wed, 09 Oct 2019 03:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ysqjawGWGxhBElqwciD5mCdMVjymryIh3Vgfdb6+Ybk=;
        b=Ky4pkrfsT56P7zj+dT/LonYWtFW3qiZLR3t9kS5t6E5KVAbxQrYSanNNBq8tOd+Wsn
         QGOdEJTDm3Epo2BzlZtYCIhPGaVQy0f4fq4wce1Z7TPVngFMbgv5JQcD547TkuNfpL2V
         Ib35DNfnW/qdAHIvZNMxbR36C4MT6XjQ9nYsVW1/0G1CLhLpZEYG8eQnepCGt3K6NSyW
         x+LLW7ecK2n+VebtZXV7Br/v6ZU2T+jKn4Ay70RiUM4T0PEDgfZBVHP6tlFgp1QOVF4N
         ZSTEUpOkDD0i4AXwOsP+Kcrj1kocDKgcQK8SGuxl/3tI8gZ1aJrHdIVxCzTAPyH6PvH3
         vpAA==
X-Gm-Message-State: APjAAAWrW+Wu1hM+mHE2pVt3mdgdxBXRL2VqFIc1KipaJWzpxq1t+dOD
        pUZB3VYQjzgcAhqaMakV7BfcYU9G
X-Google-Smtp-Source: APXvYqxR7CFmMBUEG7pNzCeUKgPWwONBSYUrHcPPm9rFSyUklLhkzYPOXveucArAshfDN8NlssTqMQ==
X-Received: by 2002:a2e:9d06:: with SMTP id t6mr1889394lji.253.1570618142306;
        Wed, 09 Oct 2019 03:49:02 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id c4sm377448lfm.4.2019.10.09.03.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 03:49:00 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@xi.terra>)
        id 1iI9Wl-0001Z6-9y; Wed, 09 Oct 2019 12:49:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 6/6] USB: iowarrior: use pr_err()
Date:   Wed,  9 Oct 2019 12:48:46 +0200
Message-Id: <20191009104846.5925-7-johan@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009104846.5925-1-johan@kernel.org>
References: <20191009104846.5925-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the one remaining printk with pr_err().

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/misc/iowarrior.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index ad29ef51e53f..dce44fbf031f 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -587,7 +587,7 @@ static int iowarrior_open(struct inode *inode, struct file *file)
 
 	interface = usb_find_interface(&iowarrior_driver, subminor);
 	if (!interface) {
-		printk(KERN_ERR "%s - error, can't find device for minor %d\n",
+		pr_err("%s - error, can't find device for minor %d\n",
 		       __func__, subminor);
 		return -ENODEV;
 	}
-- 
2.23.0

