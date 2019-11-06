Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBA7C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B14217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 18:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxrOEeJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbfKFSI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 13:08:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37581 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfKFSI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 13:08:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id q130so4544945wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 10:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=cVA3ojoMayojArPu9Gh/2YoITHbex8XdUTujKyZfWtY=;
        b=WxrOEeJz+7OuD/TKj7FwbneNc2D5nUN7+ILNR6kXTNqCJAlZZg7mGVk8ji8MLzoo8m
         O2Gfdyox2urQt8gd8bX4+W6QNvlVBZl22E9e9tooGm4I+ECEgv6DVvgt/tpGlY9AxHqO
         dS1qXlFt/it6MRK3J2C3JUkFKtgwH3WM8tkpuJZFnRvVyeSzho7QW1OKf/zewwJDzJ+J
         FlfqcyjOVHjpsFhw2vzk0vyiLIYKVZqPLOyBFkbesivIh0IiGd/WdaCi2syrBkgA3d8V
         nVSozlfmTQxH0wusPHtJ0QAflZh60hRfB5HoCHluD3r+DEtH5zHMsU83R3BJi9e+y4Gq
         Fo9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cVA3ojoMayojArPu9Gh/2YoITHbex8XdUTujKyZfWtY=;
        b=blamfcxkn1THHVq6XN4JD9GRoQuJ1cDCNwAHsniZIJp+H4WB0mm+wF2kRiXgQq2Q3q
         EFCuah6YvNvsTfSrOWfX+qsDt3KauPOwnhSHtwvBgHWpYOzI2bT7Pr7ALV+g79yZI8Vp
         OB+Ku/VKYNeyb4vq2m1neQFcMd0ebN2/WA1IpcCRdUIb9wC0a1pzdqP1ZiNg6ftVnCr7
         De08y4CfH3IFH+rSlMm7XUZYpvHX/2IwwHyrZR9ohUDOvHrtAgThI5grevqmTjfxF9dc
         6gsd1TYq8v/XbGELVvNXjf9b5/TpnDaemQL9g5YNrmG8ypkCq3oaKt1ZMRtsBAGGMAk1
         uGiQ==
X-Gm-Message-State: APjAAAV/GgPF7pa3zJRSrMPvcV7gpUMuw+D+dNXpg4yjp6zJ7i/I9ug5
        LrsyHnSVnDCWPx+n5nW+v24=
X-Google-Smtp-Source: APXvYqxSMF2eRPwTv0eQ5FKW3RFBRiVRV9vq8rjV/hurZAuYWjnOeFlYWCnmNHiMS7zOT0YsnfncmA==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr3876039wmg.45.1573063704533;
        Wed, 06 Nov 2019 10:08:24 -0800 (PST)
Received: from hwsrv-485799.hostwindsdns.com ([2a0d:7c40:3000:11f::2])
        by smtp.gmail.com with ESMTPSA id g5sm3494080wma.43.2019.11.06.10.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 10:08:23 -0800 (PST)
Date:   Wed, 6 Nov 2019 18:08:21 +0000
From:   Valery Ivanov <ivalery111@gmail.com>
To:     rspringer@google.com, toddpoynor@google.com, benchan@chromium.org
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gasket: gasket_ioctl: Remove unnecessary
 line-breaks in funtion signature
Message-ID: <20191106180821.GA19385@hwsrv-485799.hostwindsdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	This patch fix the function signature for trace_gasket_ioctl_page_table_data
	to avoid the checkpatch.pl warning:

		CHECK: Lines should not end with a '('

Signed-off-by: Valery Ivanov <ivalery111@gmail.com>
---
 drivers/staging/gasket/gasket_ioctl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index 240f9bb..55cb6b1 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -54,9 +54,10 @@ static int gasket_read_page_table_size(struct gasket_dev *gasket_dev,
 	ibuf.size = gasket_page_table_num_entries(
 		gasket_dev->page_table[ibuf.page_table_index]);
 
-	trace_gasket_ioctl_page_table_data(
-		ibuf.page_table_index, ibuf.size, ibuf.host_address,
-		ibuf.device_address);
+	trace_gasket_ioctl_page_table_data(ibuf.page_table_index,
+					   ibuf.size,
+					   ibuf.host_address,
+					   ibuf.device_address);
 
 	if (copy_to_user(argp, &ibuf, sizeof(ibuf)))
 		return -EFAULT;
-- 
1.8.3.1

