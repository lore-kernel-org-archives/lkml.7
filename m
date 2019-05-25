Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5645CC46470
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309C820879
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 17:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etKFg2BX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfEYRbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 13:31:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39341 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEYRbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 13:31:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id g9so5407093plm.6;
        Sat, 25 May 2019 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Y05SJz+nKCd/5pTWtJwGNN6+L5QhriQ7JFBupAf8lG8=;
        b=etKFg2BXOQjDNjVMdVNyTRT1PQ2DcRzUcuf6UCFfaRO1EfERfkzGMxIAN/45osz2vP
         siYKaV2oQxD/oLAnJj3sPkW9yy9U+9WisMKnDm1oaP5znT6v41Zul7TWUQDbh4IWxeOc
         MYsxY5PYS3uH+D7hsW9xTjLcYg0UgpVB+7+EeJ2KANFIXK9qAxVK7qUzNpEjx0wx5u8Y
         RkvTqz1DIF1S8YqGVFltn3XGC1bxeAEFyT7HnZWHr/zegsA1tpMWhcgMEh9B/TtBDeRU
         JRNXZPevsxquCFmXRHHm0Orv/3gUUM0PrMbFPc0W8Y8V+k0cnKtoNEC0RkCuYS+nWLBg
         g5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Y05SJz+nKCd/5pTWtJwGNN6+L5QhriQ7JFBupAf8lG8=;
        b=Mbus+DJggkgOdlQ453u0XpR5mS0qQ+bz8BLHiKsouy0baHno6ql5JxfLAHFX23UPDA
         EJks9ZNtgkPUCQXZnii/2gWkMZT9ow55uteBx2/hBzYMEnd2aTqGydq+QG3qWrSYwtoq
         sBJCXobhVA7ABWEBUVW0I4/ulrcgUxT3BUkIUVxpNt8HRhT5BILH11YQncU6MWy1RPe0
         iePbiRGlXpqppa7n5bdxqunq83AzD4DOR3ngGmWDjof/NNFypRJJy1/cFF6VYsVbxHPq
         +HlbIsUFgoPAbxCGYUbvdzbiaLfbA6zL0M2eI9YyONXB+uDNzD1L4t1ufmkV988yaBTX
         MZLg==
X-Gm-Message-State: APjAAAX3coqxew5TXtkjBZ/6wC6zR0GcJJzo8PGti4y/yJQ8OEas7Cbi
        d+fQ/PDp3caNanZEMXpx76E=
X-Google-Smtp-Source: APXvYqyZTH3xSs44IoltA9WjPzjz5jUnM2latfHMBlgbxq0TG+nSaLJvodUUseieU0+qtaYd3lrsWA==
X-Received: by 2002:a17:902:70c7:: with SMTP id l7mr27271071plt.47.1558805512032;
        Sat, 25 May 2019 10:31:52 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id u6sm6677881pfa.1.2019.05.25.10.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 10:31:51 -0700 (PDT)
Date:   Sat, 25 May 2019 23:01:47 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: ftdi-elan: fix possible condition with no effect (if ==
 else)
Message-ID: <20190525173147.GA20418@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix  below warning reported by coccicheck

./drivers/usb/misc/ftdi-elan.c:2026:11-13: WARNING: possible condition
with no effect (if == else)

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/usb/misc/ftdi-elan.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/usb/misc/ftdi-elan.c b/drivers/usb/misc/ftdi-elan.c
index 257efac..cdee3af 100644
--- a/drivers/usb/misc/ftdi-elan.c
+++ b/drivers/usb/misc/ftdi-elan.c
@@ -2023,13 +2023,6 @@ static int ftdi_elan_synchronize(struct usb_ftdi *ftdi)
 						goto read;
 					} else
 						goto reset;
-				} else if (s1 == 0x31 && s2 == 0x60) {
-					if (read_stop-- > 0) {
-						goto read;
-					} else {
-						dev_err(&ftdi->udev->dev, "retry limit reached\n");
-						continue;
-					}
 				} else {
 					if (read_stop-- > 0) {
 						goto read;
-- 
2.7.4

