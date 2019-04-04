Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C94EC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D4B2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vgoJjG5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfDDAdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:33:06 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:33563 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfDDAdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:33:02 -0400
Received: by mail-ot1-f74.google.com with SMTP id j20so310994otr.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J/O8uCPgOG3C0ZxSZ9IB3rxgWx3qFX62jDUsj+e+998=;
        b=vgoJjG5q4rtz+YnW7QFxLtkKiNTEeMeN2Jjo6dB4tHhzh6J5rd4VqgVpPMdWxBOhIR
         xyxgHLpoCQRKK9bD+fTPnwzNly08uJah2vgFVECpeRaNEybKY3nkN+XdxeHQVV50rw2N
         O4m1zdBrrDmBC+oemCKnUk8eacn9Cr5CQJyd91MzGsXy+U9bXfWBhWMB9LecvN8p7tZU
         uAhUZWA0D2ckedngDJl5Z3fPF+16NsGiIxhMZTwvIsUtrlXCH4hz9dLACPqX4sWzyrPz
         YkaoDhWXZ0STqfBy9o7EmDFqhNTSR1PavNe2qPxre0g3gQq+nyXfZx081omUpnKA+3qx
         Ecrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J/O8uCPgOG3C0ZxSZ9IB3rxgWx3qFX62jDUsj+e+998=;
        b=XM5OHpGMps67gU3GpnYDZY6y/Xy//9xQmCivBZJIVQx+gAvxurDImjTA2MqDvOE+j1
         /Fh1x/DILykeC3qtQOX4001m/XSQBjYvG9vmV04P14jK8ZIpfYlESjcT7v+weUngoBSJ
         OKfAUbR06jc365EC9azLZi5tjnOSVGIuW34P7NY9ttbfqMKElqHzhYBUJJWT/yiyS/Xj
         J5M4UhfCVaUYR+D657pWIajNjP1sYoo1WD2klRGIVIQnHhulmFR47DUnp0ksW40vTia1
         DdsfqdjGMV1mEtd1lLom+6dqX2HmxgerC3G1dEu1JdehZLzj4MSyKM3ZC+YBMVvqlTeD
         6wZw==
X-Gm-Message-State: APjAAAXx5ac3YrjFvPebKqA9Dkp6tSwY1BAyDgW7pfnzibqm0BTj/j8P
        uEPk+PQC2tHjuph7Iok/CBsS3ApGSnM8gNVR1+HvmQ==
X-Google-Smtp-Source: APXvYqxwmhrnvEJcj7E2iS2cbzk7GQPN170VkzubbRKgbmqhvLMPo5PrIol/99FDA/eiKump/mAIdOuL8AnIFtr/II/xuw==
X-Received: by 2002:aca:6c53:: with SMTP id h80mr331384oic.11.1554337982282;
 Wed, 03 Apr 2019 17:33:02 -0700 (PDT)
Date:   Wed,  3 Apr 2019 17:32:25 -0700
In-Reply-To: <20190404003249.14356-1-matthewgarrett@google.com>
Message-Id: <20190404003249.14356-4-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190404003249.14356-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH V32 03/27] Restrict /dev/{mem,kmem,port} when the kernel is
 locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-api@vger.kernel.org, luto@kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <mjg59@srcf.ucam.org>

Allowing users to read and write to core kernel memory makes it possible
for the kernel to be subverted, avoiding module loading restrictions, and
also to steal cryptographic information.

Disallow /dev/mem and /dev/kmem from being opened this when the kernel has
been locked down to prevent this.

Also disallow /dev/port from being opened to prevent raw ioport access and
thus DMA from being used to accomplish the same thing.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: x86@kernel.org
---
 drivers/char/mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index b08dc50f9f26..67b85939b1bd 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -786,6 +786,8 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 
 static int open_port(struct inode *inode, struct file *filp)
 {
+	if (kernel_is_locked_down("/dev/mem,kmem,port", LOCKDOWN_INTEGRITY))
+		return -EPERM;
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
 
-- 
2.21.0.392.gf8f6787159e-goog

