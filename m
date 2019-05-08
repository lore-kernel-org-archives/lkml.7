Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4BFC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E33C21019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AirRevee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfEHIX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:23:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42578 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfEHIX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:23:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so9708181pgh.9;
        Wed, 08 May 2019 01:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RzkERkWpjm0WKlrnqjyOqPq649NuvXA8Dfzb8RC5Ut4=;
        b=AirRevee5YLPTty2QNwEMQ+LJU42DuxFAM9DtEhlJHEDgyTILTdoM5/gbXnIrF/7I/
         ofgjP8bI026t7K+vE9WpPfMb51DdEvJc1REHZuX0svIwVzlyBw+zHlkYbcMX1rHItTtJ
         sI2gEbgLOZNJhyxYVLMC7bPs6G4ye0Hfwxwx6Apw/JkDahtqoqda5Vcczza9y7yu94cg
         0FB5lkVXy5yirqxf+0lXli4MyQA8dWIQ776plqbriPXZsHiNDJnHwBsnh1AG29fhenQT
         FAfBU+1NTTAOCZlyWv5MYxuz4lnQ08nk7X8a8tQAnnIRUrlcSqqVkPN3Yp8rkBJ1doFl
         m3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RzkERkWpjm0WKlrnqjyOqPq649NuvXA8Dfzb8RC5Ut4=;
        b=quV33lxvlpZuGEN1S4SyrkCJmAYFOA0ry6iwEnltVXzp6Y6/JixzUvoeu5maIkhqmD
         dN41Mqnlna684F1KWoON5FjUzE9TT56+nnskBEgStHDi0n1q6uPAQ1gLDcFemPcdueMG
         zTSi/SSxFrYi4jVgja7ZtRwec5lNvvOxhDIl92rGH0Q/Wfno1rTph8mjWvE4MtXXmYBC
         Z0zB5i1H3DdhJ7yowoojaHrBEQX3MDDK7jenGFOjYXg7Jk5rJVNFqQ9PqJajE68TSqhW
         ko/CjXc4H3lw4erf+wRBlUlpiT0sAeXqhI+mYX0JSN9TL6FpqeSkMXWU4LlC0Xe/IPzz
         a9vQ==
X-Gm-Message-State: APjAAAUNZx+woYbA7Iy+b8jyFIrClIAjPBD4vdRHpktAMqaEXrtxZbJ8
        EAprZWj5K6Xvj348sgP+gc4bhZgGao06gKqb
X-Google-Smtp-Source: APXvYqwsQ31v6YGC76c0//s+OixhZFpzPGg8cba6UY/yCr7gVsokbpfW4P1QY4J0xTtF+Gcgem5VoA==
X-Received: by 2002:a63:ea0c:: with SMTP id c12mr8215049pgi.375.1557303805817;
        Wed, 08 May 2019 01:23:25 -0700 (PDT)
Received: from hjy-HP-Notebook ([2408:84e1:e1:11f1:d099:a352:1690:3163])
        by smtp.gmail.com with ESMTPSA id g24sm24565424pfi.126.2019.05.08.01.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 01:23:25 -0700 (PDT)
Date:   Wed, 8 May 2019 16:23:19 +0800
From:   JingYi Hou <houjingyi647@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix double fetch in wmi_ioctl.
Message-ID: <20190508082319.GA8817@hjy-HP-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a double fetch problem in function wmi_ioctl.
After second fetch overwrite the length to avoid this.
buf->length is not used now,but it may in the future.
It is good to get it fixed up.

Signed-off-by: JingYi Hou <houjingyi647@gmail.com>
---
 drivers/platform/x86/wmi.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 7b26b6ccf1a0..628b9730b4d7 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -823,6 +823,7 @@ static long wmi_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	struct wmi_ioctl_buffer *buf = NULL;
 	struct wmi_driver *wdriver = NULL;
 	int ret;
+	__u64 length;
 
 	if (_IOC_TYPE(cmd) != WMI_IOC)
 		return -ENOTTY;
@@ -833,24 +834,24 @@ static long wmi_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	mutex_lock(&wblock->char_mutex);
 	buf = wblock->handler_data;
-	if (get_user(buf->length, &input->length)) {
+	if (get_user(length, &input->length)) {
 		dev_dbg(&wblock->dev.dev, "Read length from user failed\n");
 		ret = -EFAULT;
 		goto out_ioctl;
 	}
 	/* if it's too small, abort */
-	if (buf->length < wblock->req_buf_size) {
+	if (length < wblock->req_buf_size) {
 		dev_err(&wblock->dev.dev,
 			"Buffer %lld too small, need at least %lld\n",
-			buf->length, wblock->req_buf_size);
+			length, wblock->req_buf_size);
 		ret = -EINVAL;
 		goto out_ioctl;
 	}
 	/* if it's too big, warn, driver will only use what is needed */
-	if (buf->length > wblock->req_buf_size)
+	if (length > wblock->req_buf_size)
 		dev_warn(&wblock->dev.dev,
 			"Buffer %lld is bigger than required %lld\n",
-			buf->length, wblock->req_buf_size);
+			length, wblock->req_buf_size);
 
 	/* copy the structure from userspace */
 	if (copy_from_user(buf, input, wblock->req_buf_size)) {
@@ -860,6 +861,9 @@ static long wmi_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		goto out_ioctl;
 	}
 
+	/* Override length in case it is changed between two userspace fetches */
+	buf->length = length;
+
 	/* let the driver do any filtering and do the call */
 	wdriver = container_of(wblock->dev.dev.driver,
 			       struct wmi_driver, driver);
-- 
2.20.1

