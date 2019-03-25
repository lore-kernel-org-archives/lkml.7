Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36AFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F234206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i+RZtfwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbfCYWKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:10:08 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:36011 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730599AbfCYWKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:10:06 -0400
Received: by mail-ot1-f74.google.com with SMTP id i4so7325411otf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ygaOrSdGppBoGAldn3hUkJE8lcWsQcCZCWtpw82yF68=;
        b=i+RZtfwaKLR130wCLRb0HRymzdLNQBWhz+srVgbkCp9K8LknbtrDAqydUBeEgC5PYu
         fnT3mEAivXx9uic+ygjbI3e5pxjK1yV/0DcAuNdWX9OPgA6g6gO9YbexTjTND6xoxCFf
         zr+Kp0VN5iTtYFaLXddfDrhpjuz5OGaWd+luD86y0OZt0+BmMPy90A72xF102YLr3S9C
         FWNjkgqE/opaoDSRU6COJmi3j4Bsvaf4Zm7Cv1CU5n2uDHBIL0dnftmouTyuQCLZOnPV
         HpaEeKMZ3XXG7u7ehSia+ZDkEtj0nyzYCPhlmGR9E2S5yToBdfc6Bfkj749OaiJmWGqX
         V5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ygaOrSdGppBoGAldn3hUkJE8lcWsQcCZCWtpw82yF68=;
        b=C0CuV0uLu/4b0LbZ1bdn95vo07xuTMN2WiFg/w0pxfEvX416jbosFh1I9JvuOPk3sA
         9RTz4dE1n8i3l55F0O7avTFfoq9H88Gw/d7aM6UM/FQbq/y1DyZIAtunZEuOQhKnW9vj
         c4G0IAE03iFAj0RYRWmRmzP5RkH3ifJgMC5j5om6Xly97CjzHbz3g9oNxwvf9BYvdsMy
         uQXqR2xvP1xDTP9YCbm481lLS7O1MMGHX+VtPHm7iFkvOPZrnk+7r0vkJbZjxBV512K3
         +x2Xh7o9wtMy+omxUz+ZwII6YIygYYKUQDRkET/NXk4y1qnXbW7VLzsgTDUfXP0oz3Ae
         qWaQ==
X-Gm-Message-State: APjAAAURYLvNLlQY7V1DRTlqIwMaUVszIubLJ4P+xHxUoemKUiPB2AFd
        puHYRg/ptt2ykRUSdac8PkZjiUoAY6SMUuEUs/aXIQ==
X-Google-Smtp-Source: APXvYqxWRxJS0tYMf4ijmDG93Tsc3sg3PK4wbeYvffPhJv83p8zt89FWps1s8R7sAC0k7avkHGTndLwNZWuBzSLisWNS9g==
X-Received: by 2002:aca:c3cc:: with SMTP id t195mr12721683oif.151.1553551805976;
 Mon, 25 Mar 2019 15:10:05 -0700 (PDT)
Date:   Mon, 25 Mar 2019 15:09:30 -0700
In-Reply-To: <20190325220954.29054-1-matthewgarrett@google.com>
Message-Id: <20190325220954.29054-4-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 03/27] Restrict /dev/{mem,kmem,port} when the kernel is locked down
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <matthewgarrett@google.com>, x86@kernel.org
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

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
Cc: x86@kernel.org
---
 drivers/char/mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index b08dc50f9f26..0a2f2e75d5f4 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -786,6 +786,8 @@ static loff_t memory_lseek(struct file *file, loff_t offset, int orig)
 
 static int open_port(struct inode *inode, struct file *filp)
 {
+	if (kernel_is_locked_down("/dev/mem,kmem,port"))
+		return -EPERM;
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
 }
 
-- 
2.21.0.392.gf8f6787159e-goog

